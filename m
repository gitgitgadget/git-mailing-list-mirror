From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v2] Limit file descriptors used by packs
Date: Mon, 28 Feb 2011 22:13:22 +0100
Message-ID: <AANLkTikpBSi9CDHBsThGyumJ0CLd2xP+wD18vr1NQr3J@mail.gmail.com>
References: <20110228204727.GB26052@spearce.org> <1298926359-26438-1-git-send-email-spearce@spearce.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 28 22:13:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuAPd-0005fO-4E
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 22:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755276Ab1B1VNo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Feb 2011 16:13:44 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:53375 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755259Ab1B1VNn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 16:13:43 -0500
Received: by bwz15 with SMTP id 15so4060369bwz.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 13:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=24LfQg8ulQ8bnCff+xltmRSrPLg/6K15Kx0EaLCU+aQ=;
        b=F2Vdey2PcmIRURleDuIoNc6zOOiuuOCzdg0xpejr7qOg3Elj3fnHUOVRsCVOwt/O87
         lZ/DjvZCOoAAH5DDBSPgA392A8GIj9/Xds60/rrEuunB0o/pspKvY1MmwxjP9UJV4v88
         nIVXgwCcVHXEAugAwPZsRf1sJbMOJZ0PBMMP4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=C2YEIr5hQs7VRxFZ76F25wBBHdlNkX2e43Ej67BEbOMBvLrFyo/vfPOXen/1s7w4F1
         h6NRhM0HYUC71nBGxqFrtzNPOm6CE+TRIPU2IG71jPCgMlxRCpssC4kZMqLZFTO3AsY9
         z2I2aG1/OCRFIC2XWpC3T0u34K1/Ox2J5qJ3o=
Received: by 10.205.23.208 with SMTP id rb16mr5218093bkb.130.1298927622213;
 Mon, 28 Feb 2011 13:13:42 -0800 (PST)
Received: by 10.204.122.9 with HTTP; Mon, 28 Feb 2011 13:13:22 -0800 (PST)
In-Reply-To: <1298926359-26438-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168146>

On Mon, Feb 28, 2011 at 9:52 PM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> Rather than using 'errno =3D=3D EMFILE' after a failed open() call
> to indicate the process is out of file descriptors and an LRU
> pack window should be closed, place a hard upper limit on the
> number of open packs based on the actual rlimit of the process.
>
> By using a hard upper limit that is below the rlimit of the current
> process it is not necessary to check for EMFILE on every single
> fd-allocating system call. =A0Instead reserving 25 file descriptors
> makes it safe to assume the system call won't fail due to being over
> the filedescriptor limit. =A0Here 25 is chosen as a WAG, but consider=
s
> 3 for stdin/stdout/stderr, and at least a few for other Git code
> to operate on temporary files. =A0An additional 20 is reserved as it
> is not known what the C library needs to perform other services on
> Git's behalf, such as nsswitch or name resolution.
>
> This fixes a case where running `git gc --auto` in a repository
> with more than 1024 packs (but an rlimit of 1024 open fds) fails
> due to the temporary output file not being able to allocate a
> file descriptor. =A0The output file is opened by pack-objects after
> object enumeration and delta compression are done, both of which
> have already opened all of the packs and fully populated the file
> descriptor table.
>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
> =A0sha1_file.c | =A0 43 ++++++++++++++++++++++++++++++-------------
> =A01 files changed, 30 insertions(+), 13 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index d949b35..7850c18 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -418,6 +418,8 @@ static unsigned int pack_used_ctr;
> =A0static unsigned int pack_mmap_calls;
> =A0static unsigned int peak_pack_open_windows;
> =A0static unsigned int pack_open_windows;
> +static unsigned int pack_open_fds;
> +static unsigned int pack_max_fds;
> =A0static size_t peak_pack_mapped;
> =A0static size_t pack_mapped;
> =A0struct packed_git *packed_git;
> @@ -597,6 +599,7 @@ static int unuse_one_window(struct packed_git *cu=
rrent, int keep_fd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lru_p->windows =3D lru=
_w->next;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!lru_p->windows &&=
 lru_p->pack_fd !=3D keep_fd) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0close(=
lru_p->pack_fd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pack_op=
en_fds--;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lru_p-=
>pack_fd =3D -1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -681,8 +684,10 @@ void free_pack_by_name(const char *pack_name)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (strcmp(pack_name, p->pack_name) =3D=
=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clear_delta_base_cache=
();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0close_pack_windows(p);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p->pack_fd !=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p->pack_fd !=3D -1)=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0close(=
p->pack_fd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pack_op=
en_fds--;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0close_pack_index(p);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free(p->bad_object_sha=
1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*pp =3D p->next;
> @@ -708,9 +713,29 @@ static int open_packed_git_1(struct packed_git *=
p)
> =A0 =A0 =A0 =A0if (!p->index_data && open_pack_index(p))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return error("packfile %s index unavai=
lable", p->pack_name);
>
> + =A0 =A0 =A0 if (!pack_max_fds) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct rlimit lim;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int max_fds;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (getrlimit(RLIMIT_NOFILE, &lim))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die_errno("cannot get R=
LIMIT_NOFILE");
> +

We don't have getrlimit on Windows :(

I guess something like should work, but untested. Limit of 2048 taken f=
rom MSDN:

http://msdn.microsoft.com/en-us/library/6e3b887c(v=3Dvs.71).aspx

---8<---

diff --git a/compat/mingw.h b/compat/mingw.h
index 9c00e75..9155ce3 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -234,6 +234,22 @@ int mingw_getpagesize(void);
 #define getpagesize mingw_getpagesize
 #endif

+struct rlimit {
+	unsigned int rlim_cur;
+};
+#define RLIMIT_NOFILE 0
+
+static inline int getrlimit(int resource, struct rlimit *rlp)
+{
+	if (resource !=3D RLIMIT_NOFILE) {
+		errno =3D EINVAL;
+		return -1;
+	}
+
+	rlp->rlim_cur =3D 2048;
+	return 0;
+}
+
 /* Use mingw_lstat() instead of lstat()/stat() and
  * mingw_fstat() instead of fstat() on Windows.
  */

---8<---
