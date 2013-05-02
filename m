From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] sha1_name: reorganize get_sha1_basic()
Date: Wed, 1 May 2013 20:00:59 -0500
Message-ID: <CAMP44s0_9aXu0eZ0w_dkkoR4No3ZzKVsdzAb_E1wud-ZpOW6dg@mail.gmail.com>
References: <1367455791-30091-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 02 03:01:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXhtU-0001mG-3n
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 03:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582Ab3EBBBD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 21:01:03 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:34010 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab3EBBBB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 21:01:01 -0400
Received: by mail-wg0-f47.google.com with SMTP id e11so62326wgh.2
        for <git@vger.kernel.org>; Wed, 01 May 2013 18:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=EccW1vntOvs42Tq3HQr+D/FAppMUvG1BI5fSZP7BNC0=;
        b=tD5aBi4zGbEyg0vg8zzKkRf9UTgBX95Bz96yA15vM1IJ3P9Ac6MXJkUOCgpGhravDO
         tmPNtCuut7nBZ2Fum3kTQRfVZkrSWe3TUVaXyo1JkCVqT/FS+t85wVm0BvIlOkVeQlm8
         JC+jFPjyv1kI9tNCpyRd1sDuQkNvimQBUSWmHUOo8qRtPDCprqyBJ/UnKA/uHv3KFXm7
         zcsHyRYGIUYHtzflv7r6Jdrmk0nIgS+4ivD07fMEriaJAURMcEhL3UpT/iSxoLTKl8HU
         PeaJ9YboBmVk1e7JYig++RWB9t4IhM43QCEBJ9ZrL+S76GVq/GaxiL07Y5dW4ATSB4dJ
         +hKg==
X-Received: by 10.180.83.199 with SMTP id s7mr4917309wiy.19.1367456460019;
 Wed, 01 May 2013 18:01:00 -0700 (PDT)
Received: by 10.194.240.135 with HTTP; Wed, 1 May 2013 18:00:59 -0700 (PDT)
In-Reply-To: <1367455791-30091-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223172>

On Wed, May 1, 2013 at 7:49 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Through the years the functionality to handle @{-N} and @{u} has moved
> around the code, and as a result, code that once made sense, doesn't any
> more.
>
> There is no need to call this function recursively with the branch of
> @{-N} substituted because dwim_{ref,log} already replaces it.
>
> However, there's one corner-case where @{-N} resolves to a detached
> HEAD, in which case we wouldn't get any ref back.
>
> So we parse the nth-prior manually, and deal with it depending on
> weather it's a SHA-1, or a ref.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  sha1_name.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 3820f28..110afbb 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -431,6 +431,7 @@ static inline int upstream_mark(const char *string, int len)
>  }
>
>  static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned lookup_flags);
> +static int interpret_nth_prior_checkout(const char *name, struct strbuf *buf);
>
>  static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>  {
> @@ -438,6 +439,7 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>         char *real_ref = NULL;
>         int refs_found = 0;
>         int at, reflog_len;
> +       struct strbuf buf = STRBUF_INIT;
>
>         if (len == 40 && !get_sha1_hex(str, sha1))
>                 return 0;
> @@ -447,6 +449,9 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>         if (len && str[len-1] == '}') {
>                 for (at = len-2; at >= 0; at--) {
>                         if (str[at] == '@' && str[at+1] == '{') {
> +                               if (at == 0 && str[2] == '-')
> +                                       /* @{-N} syntax */
> +                                       continue;
>                                 if (!upstream_mark(str + at, len - at)) {
>                                         reflog_len = (len-1) - (at+2);
>                                         len = at;
> @@ -460,20 +465,19 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>         if (len && ambiguous_path(str, len))
>                 return -1;
>
> -       if (!len && reflog_len) {
> -               struct strbuf buf = STRBUF_INIT;
> -               int ret;
> -               /* try the @{-N} syntax for n-th checkout */
> -               ret = interpret_branch_name(str+at, &buf);
> -               if (ret > 0) {
> -                       /* substitute this branch name and restart */
> -                       return get_sha1_1(buf.buf, buf.len, sha1, 0);
> -               } else if (ret == 0) {
> -                       return -1;
> -               }
> +       if (interpret_nth_prior_checkout(str, &buf) > 0) {
> +               int detached;
> +
> +               detached = (buf.len == 40 && !get_sha1_hex(buf.buf, sha1));
> +               strbuf_release(&buf);
> +               if (detached)
> +                       return 0;
> +       }
> +
> +       if (!len && reflog_len)
>                 /* allow "@{...}" to mean the current branch reflog */
>                 refs_found = dwim_ref("HEAD", 4, sha1, &real_ref);
> -       } else if (reflog_len)
> +       else if (reflog_len)
>                 refs_found = dwim_log(str, len, sha1, &real_ref);
>         else
>                 refs_found = dwim_ref(str, len, sha1, &real_ref);
> --

This might make more sense:

--- a/sha1_name.c
+++ b/sha1_name.c
@@ -438,8 +438,7 @@ static int get_sha1_basic(const char *str, int
len, unsigned char *sha1)
        static const char *warn_msg = "refname '%.*s' is ambiguous.";
        char *real_ref = NULL;
        int refs_found = 0;
-       int at, reflog_len;
-       struct strbuf buf = STRBUF_INIT;
+       int at, reflog_len, nth_prior = 0;

        if (len == 40 && !get_sha1_hex(str, sha1))
                return 0;
@@ -449,9 +448,10 @@ static int get_sha1_basic(const char *str, int
len, unsigned char *sha1)
        if (len && str[len-1] == '}') {
                for (at = len-2; at >= 0; at--) {
                        if (str[at] == '@' && str[at+1] == '{') {
-                               if (at == 0 && str[2] == '-')
-                                       /* @{-N} syntax */
+                               if (at == 0 && str[2] == '-') {
+                                       nth_prior = 1;
                                        continue;
+                               }
                                if (!upstream_mark(str + at, len - at)) {
                                        reflog_len = (len-1) - (at+2);
                                        len = at;
@@ -465,9 +465,12 @@ static int get_sha1_basic(const char *str, int
len, unsigned char *sha1)
        if (len && ambiguous_path(str, len))
                return -1;

-       if (interpret_nth_prior_checkout(str, &buf) > 0) {
+       if (nth_prior) {
+               struct strbuf buf = STRBUF_INIT;
                int detached;

+               interpret_nth_prior_checkout(str, &buf);
+
                detached = (buf.len == 40 && !get_sha1_hex(buf.buf, sha1));
                strbuf_release(&buf);
                if (detached)

-- 
Felipe Contreras
