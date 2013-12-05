From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 05/28] Make the sender advertise shallow commits to the receiver
Date: Thu,  5 Dec 2013 20:02:32 +0700
Message-ID: <1386248575-10206-6-git-send-email-pclouds@gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
 <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 05 13:58:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoYW3-0001U2-Si
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 13:58:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756270Ab3LEM6s convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 07:58:48 -0500
Received: from mail-pb0-f53.google.com ([209.85.160.53]:35900 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756056Ab3LEM6q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 07:58:46 -0500
Received: by mail-pb0-f53.google.com with SMTP id ma3so25709185pbc.40
        for <git@vger.kernel.org>; Thu, 05 Dec 2013 04:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=IA3TQf4RvlPVPI9NDdfnaVjaLOb0JXC11GWz4Virt3s=;
        b=u2EIEinuQK/Be00cFFzkV4jNYVK0cXPjBWVm/QFKfIVfngHnvPyABlhLGuxBKjMiOH
         64ZNE9hkGmcGUuvMf7KtTMBpTqTE36daKAeFUf2vVkYldR5/YVtZ56U45lDlXyvSwrB/
         okabOlIWSQ5022/EtEgz2uhRXZgo6JeyRCTXBYf5eiTyAHGn5B8GQguAY1XzSQrTS56y
         2LIHI24dFlQYk0boGjbvO3S63PUuDd/9VU2J9h+LxT47CK8DvUgxhxOuthVPL/+r4e6a
         oy6H3jbarTxOKIkamTs9iGjNTz74rvuOKap+8MJCb2JlE5PN3LBqwypCZhlFYi2RP6Lv
         X6ew==
X-Received: by 10.66.188.203 with SMTP id gc11mr87044739pac.63.1386248326559;
        Thu, 05 Dec 2013 04:58:46 -0800 (PST)
Received: from lanh ([115.73.194.163])
        by mx.google.com with ESMTPSA id ql10sm144583661pbc.44.2013.12.05.04.58.43
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Dec 2013 04:58:45 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Thu, 05 Dec 2013 20:03:30 +0700
X-Mailer: git-send-email 1.8.5.1.25.g8667982
In-Reply-To: <1386248575-10206-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238861>

If either receive-pack or upload-pack is called on a shallow
repository, shallow commits (*) will be sent after the ref
advertisement (but before the packet flush), so that the receiver has
the full "shape" of the sender's commit graph. This will be needed for
the receiver to update its .git/shallow if necessary.

This breaks the protocol for all clients trying to push to a shallow
repo, or fetch from one. Which is basically the same end result as
today's "is_repository_shallow() && die()" in receive-pack and
upload-pack. New clients will be made aware of shallow upstream and
can make use of this information.

The sender must send all shallow commits that are sent in the
following pack. It may send more shallow commits than necessary.

upload-pack for example may choose to advertise no shallow commits if
it knows in advance that the pack it's going to send contains no
shallow commits. But upload-pack is the server, so we choose the
cheaper way, send full .git/shallow and let the client deal with it.

Smart HTTP is not affected by this patch. Shallow support on
smart-http comes later separately.

(*) A shallow commit is a commit that terminates the revision
    walker. It is usually put in .git/shallow in order to keep the
    revision walker from going out of bound because there is no
    guarantee that objects behind this commit is available.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/technical/pack-protocol.txt |  3 +++
 builtin/receive-pack.c                    |  4 +++-
 commit.h                                  |  1 +
 shallow.c                                 | 15 +++++++++++++++
 upload-pack.c                             |  6 ++++--
 5 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/=
technical/pack-protocol.txt
index b898e97..eb8edd1 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -161,6 +161,7 @@ MUST peel the ref if it's an annotated tag.
=20
 ----
   advertised-refs  =3D  (no-refs / list-of-refs)
+		      *shallow
 		      flush-pkt
=20
   no-refs          =3D  PKT-LINE(zero-id SP "capabilities^{}"
@@ -174,6 +175,8 @@ MUST peel the ref if it's an annotated tag.
   other-tip        =3D  obj-id SP refname LF
   other-peeled     =3D  obj-id SP refname "^{}" LF
=20
+  shallow          =3D  PKT-LINE("shallow" SP obj-id)
+
   capability-list  =3D  capability *(SP capability)
   capability       =3D  1*(LC_ALPHA / DIGIT / "-" / "_")
   LC_ALPHA         =3D  %x61-7A
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 67ce1ef..cc8c34f 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -178,6 +178,8 @@ static void write_head_info(void)
 	if (!sent_capabilities)
 		show_ref("capabilities^{}", null_sha1);
=20
+	advertise_shallow_grafts(1);
+
 	/* EOF */
 	packet_flush(1);
 }
@@ -998,7 +1000,7 @@ int cmd_receive_pack(int argc, const char **argv, =
const char *prefix)
 	if (!enter_repo(dir, 0))
 		die("'%s' does not appear to be a git repository", dir);
=20
-	if (is_repository_shallow())
+	if (is_repository_shallow() && stateless_rpc)
 		die("attempt to push into a shallow repository");
=20
 	git_config(receive_pack_config, NULL);
diff --git a/commit.h b/commit.h
index bd841f4..a879526 100644
--- a/commit.h
+++ b/commit.h
@@ -205,6 +205,7 @@ extern int write_shallow_commits(struct strbuf *out=
, int use_pack_protocol);
 extern void setup_alternate_shallow(struct lock_file *shallow_lock,
 				    const char **alternate_shallow_file);
 extern char *setup_temporary_shallow(void);
+extern void advertise_shallow_grafts(int);
=20
 int is_descendant_of(struct commit *, struct commit_list *);
 int in_merge_bases(struct commit *, struct commit *);
diff --git a/shallow.c b/shallow.c
index cdf37d6..9552512 100644
--- a/shallow.c
+++ b/shallow.c
@@ -220,3 +220,18 @@ void setup_alternate_shallow(struct lock_file *sha=
llow_lock,
 		*alternate_shallow_file =3D "";
 	strbuf_release(&sb);
 }
+
+static int advertise_shallow_grafts_cb(const struct commit_graft *graf=
t, void *cb)
+{
+	int fd =3D *(int*)cb;
+	if (graft->nr_parent =3D=3D -1)
+		packet_write(fd, "shallow %s\n", sha1_to_hex(graft->sha1));
+	return 0;
+}
+
+void advertise_shallow_grafts(int fd)
+{
+	if (!is_repository_shallow())
+		return;
+	for_each_commit_graft(advertise_shallow_grafts_cb, &fd);
+}
diff --git a/upload-pack.c b/upload-pack.c
index c989a73..38b2a29 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -758,6 +758,7 @@ static void upload_pack(void)
 		reset_timeout();
 		head_ref_namespaced(send_ref, &symref);
 		for_each_namespaced_ref(send_ref, &symref);
+		advertise_shallow_grafts(1);
 		packet_flush(1);
 	} else {
 		head_ref_namespaced(mark_our_ref, NULL);
@@ -835,8 +836,9 @@ int main(int argc, char **argv)
=20
 	if (!enter_repo(dir, strict))
 		die("'%s' does not appear to be a git repository", dir);
-	if (is_repository_shallow())
-		die("attempt to fetch/clone from a shallow repository");
+	if (is_repository_shallow() && stateless_rpc)
+		die("attempt to push into a shallow repository");
+
 	git_config(upload_pack_config, NULL);
 	upload_pack();
 	return 0;
--=20
1.8.5.1.25.g8667982
