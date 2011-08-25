From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: [PATCH] vcs-svn: fix broken test 'keep content, but change mode'
Date: Thu, 25 Aug 2011 22:08:26 +0600
Message-ID: <CA+gfSn8a7kjbQFP0A2BHfro8MOhpY-TxDr5Fr+=0qtD9O62GPA@mail.gmail.com>
References: <1314288124-16969-1-git-send-email-divanorama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>,
	David Barr <davidbarr@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 18:08:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwcTp-0004ay-B5
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 18:08:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752620Ab1HYQI2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Aug 2011 12:08:28 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:49578 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747Ab1HYQI1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Aug 2011 12:08:27 -0400
Received: by qwk3 with SMTP id 3so1404380qwk.19
        for <git@vger.kernel.org>; Thu, 25 Aug 2011 09:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Fcvitpw2h53X58xLUvYlz1SI0eoUQJXkJZuNrkkBJ4s=;
        b=nC0OZav0jOsdLiuQqlgEIk1YW+Q0NuxcPP7Ee09luryKbn+wWXdhAAzkhU8WcH3KQV
         vY/df5CChaLf4TuSEexcmNpDp0y0JqAZVxSMpo929ofEuESbpuy/PSdfccPlH0AIetW2
         nFAEa2y5pOlOFZSdL85pVLvnVrR9BAEG+XpCg=
Received: by 10.229.63.218 with SMTP id c26mr752920qci.75.1314288506765; Thu,
 25 Aug 2011 09:08:26 -0700 (PDT)
Received: by 10.229.31.203 with HTTP; Thu, 25 Aug 2011 09:08:26 -0700 (PDT)
In-Reply-To: <1314288124-16969-1-git-send-email-divanorama@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180087>

correct David's email (on first attempt I've accidentally used the old
one, taken from some git history)

On Thu, Aug 25, 2011 at 10:02 PM, Dmitry Ivankov <divanorama@gmail.com>=
 wrote:
> svn symlinks are files with "link destination" content and a
> "svn:special=3D*" property set. These are imported as blobs with
> "destination" content and S_IFLNK mode. When svn copy a file without
> altering it's content(but maybe altering it's mode), we reuse the blo=
b
> object thus loosing or not adding the "link " prefix.
>
> But we take possible prefix into account when applying svn deltas. An=
d
> this is the only place we ask fast-import for original blob. So prete=
nd
> that we want to apply a zero delta to resolve the issue.
>
> There is some overhead due to using a temporary file to store such a =
small
> blob. But hopefully such node change is too rare to care.
>
> Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
> ---
> This could be done better if we just read the cat-blob to memory, add=
ed or
> removed the "link " prefix and wrote it to the stream, because the li=
nk
> destination should be a tiny string. But on the other hand it'd blow =
up
> if for some reason it's huge.
>
> And taking into account that changing file mode from/to link without =
a
> content change should be extremely rare anyway, I think it's ok.
>
> Maybe it is redundant to add svndiff0_identity function to just cat b=
lob
> to a temporary file. The excuse is that svndiff.c is the only user of=
 this
> temporary file and the cat-blob response, so keep it there.
>
> The patch base is svn-fe branch at git://repo.or.cz/git/jrn.git
> Not backporting it to git master because vcs-svn stuff differs quite =
much
> around this change.
>
> =A0t/t9010-svn-fe.sh =A0 =A0 | =A0 =A02 +-
> =A0vcs-svn/fast_export.c | =A0 =A06 +++++-
> =A0vcs-svn/svndiff.c =A0 =A0 | =A0 17 +++++++++++++++++
> =A0vcs-svn/svndiff.h =A0 =A0 | =A0 =A01 +
> =A0vcs-svn/svndump.c =A0 =A0 | =A0 16 +++++++++++++++-
> =A05 files changed, 39 insertions(+), 3 deletions(-)
>
> diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
> index b7eed24..b6bdfeb 100755
> --- a/t/t9010-svn-fe.sh
> +++ b/t/t9010-svn-fe.sh
> @@ -413,7 +413,7 @@ test_expect_success PIPE 'action: add node withou=
t text' '
> =A0 =A0 =A0 =A0try_dump textless.dump must_fail
> =A0'
>
> -test_expect_failure PIPE 'change file mode but keep old content' '
> +test_expect_success PIPE 'change file mode but keep old content' '
> =A0 =A0 =A0 =A0reinit_git &&
> =A0 =A0 =A0 =A0cat >expect <<-\EOF &&
> =A0 =A0 =A0 =A0OBJID
> diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
> index 19d7c34..8c7295f 100644
> --- a/vcs-svn/fast_export.c
> +++ b/vcs-svn/fast_export.c
> @@ -209,7 +209,11 @@ static long apply_delta(off_t len, struct line_b=
uffer *input,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0preimage.max_off +=3D strlen("link ");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0check_preimage_overflow(preimage.max_o=
ff, 1);
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 if (svndiff0_apply(input, len, &preimage, out))
> +
> + =A0 =A0 =A0 if (!input) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (svndiff0_identity(&preimage, out))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("cannot cat blob");
> + =A0 =A0 =A0 } else if (svndiff0_apply(input, len, &preimage, out))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("cannot apply delta");
> =A0 =A0 =A0 =A0if (old_data) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Read the remainder of preimage and =
trailing newline. */
> diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
> index 9ee41bb..bf104db 100644
> --- a/vcs-svn/svndiff.c
> +++ b/vcs-svn/svndiff.c
> @@ -306,3 +306,20 @@ int svndiff0_apply(struct line_buffer *delta, of=
f_t delta_len,
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return 0;
> =A0}
> +int svndiff0_identity(struct sliding_view *preimage, FILE *postimage=
)
> +{
> + =A0 =A0 =A0 assert(preimage && postimage);
> + =A0 =A0 =A0 off_t pre_off =3D 0;
> +
> + =A0 =A0 =A0 while (pre_off !=3D preimage->max_off) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 size_t pre_len =3D 8192;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pre_off + pre_len > preimage->max_o=
ff)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pre_len =3D preimage->m=
ax_off - pre_off;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (move_window(preimage, pre_off, pre_=
len) ||
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_strbuf(&preimage-=
>buf, postimage))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pre_off +=3D pre_len;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> diff --git a/vcs-svn/svndiff.h b/vcs-svn/svndiff.h
> index 74eb464..5afa3f2 100644
> --- a/vcs-svn/svndiff.h
> +++ b/vcs-svn/svndiff.h
> @@ -6,5 +6,6 @@ struct sliding_view;
>
> =A0extern int svndiff0_apply(struct line_buffer *delta, off_t delta_l=
en,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct sliding_view *preimage, FILE *p=
ostimage);
> +extern int svndiff0_identity(struct sliding_view *preimage, FILE *po=
stimage);
>
> =A0#endif
> diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
> index b1f4161..1e7ed48 100644
> --- a/vcs-svn/svndump.c
> +++ b/vcs-svn/svndump.c
> @@ -285,7 +285,21 @@ static void handle_node(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* For the fast_export_* functions, NU=
LL means empty. */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0old_data =3D NULL;
> =A0 =A0 =A0 =A0if (!have_text) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 fast_export_modify(node_ctx.dst.buf, no=
de_ctx.type, old_data);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* This is clean content copy in svn,=
 but we alter the content
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* of symlinks (add/remove "link " pr=
efix used by svn). So when
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* mode changes from/to symlink speci=
fy (recreate) data inline.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (node_ctx.type !=3D old_mode && (old=
_mode =3D=3D REPO_MODE_LNK
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 || node_ctx.type =3D=3D REPO_MODE_LNK)) {
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fast_export_modify(node=
_ctx.dst.buf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 node_ctx.type, "inline");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fast_export_blob_delta(=
node_ctx.type, old_mode,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 old_data, 0, NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fast_export_modify(node=
_ctx.dst.buf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 node_ctx.type, old_data);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0if (!node_ctx.text_delta) {
> --
> 1.7.3.4
>
>
