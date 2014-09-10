From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/6] Make sure fsck_commit_buffer() does not run out of
 the buffer
Date: Wed, 10 Sep 2014 16:45:27 -0400
Message-ID: <CAPig+cRtq6+nx+MN89g9hOFosvjPYMJbVJ7FBSzniqhu+_rMKA@mail.gmail.com>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
	<cover.1410356761.git.johannes.schindelin@gmx.de>
	<alpine.DEB.1.00.1409101552560.990@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 10 22:45:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRolg-0005qB-Je
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 22:45:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109AbaIJUp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 16:45:29 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:60227 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225AbaIJUp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 16:45:28 -0400
Received: by mail-yk0-f169.google.com with SMTP id 20so2117402yks.0
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 13:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=n6t1ifuCpv0vgWjSi3xvuaF3SzjPHVkDAeIm9m9sTS4=;
        b=h7LJGKsFpBmc165Thcw1C3EgE1/4nuLprDoNFSibYQrMY2aiNZI7/SgQCGnONmOZjE
         HjHKgc6Sp5YcUwIlvFmRnqd0o/EC0NqBcBxOyRtwGD4xydMzqWxXpSQOmfYK0BYXMtDR
         WsLbrS5lEDxc+48BPphbEM8uHjOBYnNY+Be+cVDVGv6wv4xVuG9J/ExB3bd1p8X237dv
         1JU9WwwKQJqa/0mVfOehhnRLLAvGtpSUg+wja21A7eh2FGT9ZvArMb7Wb6uidQLeZ8th
         IUGSD2X6LzvF4P/hRFB1gsTCHkTjGcB5yD6inkEJkWbEY+JIeWNreCgjG1JVsNvEMs3w
         GMCg==
X-Received: by 10.236.130.210 with SMTP id k58mr5184613yhi.102.1410381927538;
 Wed, 10 Sep 2014 13:45:27 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Wed, 10 Sep 2014 13:45:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.1409101552560.990@s15462909.onlinehome-server.info>
X-Google-Sender-Auth: vRDAHXU3li3n7Y3YSMXeXppirvE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256764>

On Wed, Sep 10, 2014 at 9:52 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> So far, we assumed that the buffer is NUL terminated, but this is not
> a safe assumption, now that we opened the fsck_object() API to pass a
> buffer directly.
>
> So let's make sure that there is at least an empty line in the buffer.
> That way, our checks would fail if the empty line was encountered
> prematurely, and consequently we can get away with the current string
> comparisons even with non-NUL-terminated buffers are passed to
> fsck_object().
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  fsck.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/fsck.c b/fsck.c
> index dd77628..9dd7d12 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -237,6 +237,26 @@ static int fsck_tree(struct tree *item, int strict, fsck_error error_func)
>         return retval;
>  }
>
> +static int require_end_of_header(const void *data, unsigned long size,
> +       struct object *obj, fsck_error error_func)
> +{
> +       const char *buffer = (const char *)data;
> +       int i;
> +
> +       for (i = 0; i < size; i++) {

Should 'i' have type 'unsigned long', rather than 'int', to be
consistent with the type of 'size'?

> +               switch (buffer[i]) {
> +               case '\0':
> +                       return error_func(obj, FSCK_ERROR,
> +                               "invalid message: NUL at offset %d", i);
> +               case '\n':
> +                       if (i + 1 < size && buffer[i + 1] == '\n')
> +                               return 0;
> +               }
> +       }
> +
> +       return error_func(obj, FSCK_ERROR, "invalid buffer: missing empty line");
> +}
> +
>  static int fsck_ident(const char **ident, struct object *obj, fsck_error error_func)
>  {
>         char *end;
> @@ -284,6 +304,9 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
>         unsigned parent_count, parent_line_count = 0;
>         int err;
>
> +       if (require_end_of_header(buffer, size, &commit->object, error_func))
> +               return -1;
> +
>         if (!skip_prefix(buffer, "tree ", &buffer))
>                 return error_func(&commit->object, FSCK_ERROR, "invalid format - expected 'tree' line");
>         if (get_sha1_hex(buffer, tree_sha1) || buffer[40] != '\n')
> --
> 2.0.0.rc3.9669.g840d1f9
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
