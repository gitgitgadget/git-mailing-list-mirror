From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] [PATCH] commit.c: Replace starts_with() with skip_prefix()
Date: Tue, 4 Mar 2014 17:27:11 -0500
Message-ID: <CAPig+cR=9oonOdyOm3y2NpdLxh-sq5qQtSxmmN2dH7+UzRy-gA@mail.gmail.com>
References: <1393948445-24689-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 23:27:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKxo0-0006i6-Gv
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 23:27:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757412AbaCDW1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 17:27:16 -0500
Received: from mail-yh0-f48.google.com ([209.85.213.48]:55148 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756624AbaCDW1M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 17:27:12 -0500
Received: by mail-yh0-f48.google.com with SMTP id z6so201216yhz.21
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 14:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=g3kQDTculnqXLL65MNJHBQFJO5S+L7OG8XybGDSN+9Q=;
        b=oONwlF/TYHlaRNMIIwTEJs6QmoIlv++n9F9TtceYrCXSId+W0QDnyizlnzA7P3Fm00
         5xe5EPHGM4fg2xif9v7jCsnfHYffWhTYYRqRWa0FiKF81BVqfA46S6rKMJf/Rhuv3HUm
         VRVoNqnl09oMdcwTZMepQKcjatKnvWOUGM7af+P6t5dkjJA0fAldzgPJdJOgwH9UK1Ww
         rhcbhIHPYaMGK18H/yGf3/m1bL6JYylDh5wtLOxlwHwm501xdjq1n9lD2bQUJr9cNAGd
         fTGuH1ITsDMUkFTNCnqU7FVOzlgDjinwogv4KDBhnGwBgJ6LtWS90ARpYPiBTr3efVSe
         MxDw==
X-Received: by 10.236.128.170 with SMTP id f30mr2262308yhi.89.1393972031107;
 Tue, 04 Mar 2014 14:27:11 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Tue, 4 Mar 2014 14:27:11 -0800 (PST)
In-Reply-To: <1393948445-24689-1-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: t8bmTx-xN7m1p_4Sl77UWsmN66w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243399>

Thanks for the resend. Etiquette on this list is to cc: people who
commented on previous versions of the submission. As Tanay already
mentioned, use [PATCH vN] in the subject where N is the version number
of this attempt. The -v option of "git format-email" can help.

More below.

On Tue, Mar 4, 2014 at 10:54 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> In record_author_date() :
> Replace "buf + strlen(author )" by skip_prefix(), which is
> saved in a new "const char" variable "indent_line".
>
> In parse_signed_commit() :
> Replace "line + gpg_sig_header_len" by skip_prefix(), which
> is saved in a new "const char" variable "indent_line".
>
> In parse_gpg_output() :
> Replace "buf + strlen(sigcheck_gpg_status[i].check + 1)" by
> skip_prefix(), which is saved in already available
> variable "found".

It's not necessary to explain in prose what the patch itself already
states more concisely and precisely. All of this text should be
dropped from the commit message. Instead, explain the purpose of the
patch, the problem it solves, etc. Please read the "(2) Describe your
changes well" section of Documentation/SubmittingPatches to get an
idea of what sort of information to include in the commit message.

A better commit message should say something about how the affected
functions want to know not only if the string has a prefix, but also
the text following the prefix, and that skip_prefix() can provide both
pieces of information.

> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  commit.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index 6bf4fe0..71a03e3 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -553,6 +553,7 @@ static void record_author_date(struct author_date_slab *author_date,
>         struct ident_split ident;
>         char *date_end;
>         unsigned long date;
> +       const char *indent_line;

Strange variable name. The code in question splits apart a person's
identification string (name, email, etc.). It has nothing to do with
indentation.

>         if (!commit->buffer) {
>                 unsigned long size;
> @@ -562,18 +563,19 @@ static void record_author_date(struct author_date_slab *author_date,
>                         return;
>         }
>
> +       indent_line = skip_prefix(buf, "author ");
> +
>         for (buf = commit->buffer ? commit->buffer : buffer;
>              buf;
>              buf = line_end + 1) {
>                 line_end = strchrnul(buf, '\n');
> -               if (!starts_with(buf, "author ")) {
> +               if (!indent_line) {
>                         if (!line_end[0] || line_end[1] == '\n')
>                                 return; /* end of header */
>                         continue;
>                 }
> -               if (split_ident_line(&ident,
> -                                    buf + strlen("author "),
> -                                    line_end - (buf + strlen("author "))) ||
> +               if (split_ident_line(&ident, indent_line,
> +                                                        line_end - indent_line) ||

Indent the second line (using tabs plus possible spaces) so that it
lines up with the &ident in the line above. Be sure to set your editor
so tabs have width 8.

>                     !ident.date_begin || !ident.date_end)
>                         goto fail_exit; /* malformed "author" line */
>                 break;
> @@ -1098,6 +1100,7 @@ int parse_signed_commit(const unsigned char *sha1,
>         char *buffer = read_sha1_file(sha1, &type, &size);
>         int in_signature, saw_signature = -1;
>         char *line, *tail;
> +       const char *indent_line;
>
>         if (!buffer || type != OBJ_COMMIT)
>                 goto cleanup;
> @@ -1111,11 +1114,11 @@ int parse_signed_commit(const unsigned char *sha1,
>                 char *next = memchr(line, '\n', tail - line);
>
>                 next = next ? next + 1 : tail;
> +               indent_line = skip_prefix(line, gpg_sig_header);

Even stranger variable name for a GPG signature (which has nothing at
all to do with indentation).

>                 if (in_signature && line[0] == ' ')
>                         sig = line + 1;
> -               else if (starts_with(line, gpg_sig_header) &&
> -                        line[gpg_sig_header_len] == ' ')
> -                       sig = line + gpg_sig_header_len + 1;
> +               else if (indent_line && indent_line[1] == ' ')
> +                       sig = indent_line + 2;

Why is this adding 2 rather than 1?

>                 if (sig) {
>                         strbuf_add(signature, sig, next - sig);
>                         saw_signature = 1;
> @@ -1193,10 +1196,8 @@ static void parse_gpg_output(struct signature_check *sigc)
>         for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
>                 const char *found, *next;
>
> -               if (starts_with(buf, sigcheck_gpg_status[i].check + 1)) {
> -                       /* At the very beginning of the buffer */
> -                       found = buf + strlen(sigcheck_gpg_status[i].check + 1);
> -               } else {
> +               found = skip_prefix(buf, sigcheck_gpg_status[i].check +1);

Add a space after the plus sign.

> +               if(!found) {
>                         found = strstr(buf, sigcheck_gpg_status[i].check);

'found' is being computed again here, even though you already computed
it just above via skip_prefix(). This seems pretty wasteful.

>                         if (!found)
>                                 continue;
> --
> 1.9.0.138.g2de3478
>
> Hey Eric,
> As per your suggestion in the previous mail :
> http://article.gmane.org/gmane.comp.version-control.git/243316
> I have made necessary changes:
> 1. Better Naming of variables as per suggestion
> 2. Proper replacement of skip_prefix() over starts_with() .

Thanks for explaining the changes since the previous version and
providing a link. That's good etiquette.

As Tanay already mentioned in his review, place this commentary just
below the "---" line following your sign off. (You placed it below the
"--" line.)
