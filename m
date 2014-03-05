From: karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2] commit.c: Replace starts_with() with skip_prefix()
Date: Wed, 5 Mar 2014 19:40:49 +0530
Message-ID: <CAOLa=ZT5fnnXzM6rCAj2eUBM+CSeLwSOveLzKoT8u7ekjHZvSw@mail.gmail.com>
References: <1394028372-29990-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 15:11:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLCXU-0005Ny-8n
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 15:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386AbaCEOLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 09:11:12 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:53665 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606AbaCEOLK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 09:11:10 -0500
Received: by mail-pa0-f41.google.com with SMTP id fa1so1143149pad.28
        for <git@vger.kernel.org>; Wed, 05 Mar 2014 06:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aaXxzvFuieAadblDogVXU12aXivxoIXeHBfJ/nqVBpo=;
        b=MSqEKIZgUJ8dZ6MjWHqHGxnl2t84iAmSKUl7VQzvWFavMYfcU9n+Zo1M1KpXNIwqrQ
         gCAR0PawMZKEc6c2TQnEm13PKUq5ekfvnycgi/Bi+aQ968bDXBOa1lg04Xr09Sfhrsp3
         SXEi+z+Vc6Scp9de9rJ7krfWvZXYYSSDyPTZESxvZKR9Bg2mcfcFfa10T9/QpSZtHg3A
         0Tvoy+Sf+gX0/hTOzzAw0fu7AgzuG54foT70tvMCll6T41PxeY0pllSU0q3CqGd7cuyn
         0wfLBCVFPm8onkymsKN4UozUCd+6yO944ty6fRjkfVK0GPCxhSNETypz82PRQRp2MVHW
         v57g==
X-Received: by 10.68.200.74 with SMTP id jq10mr4253024pbc.169.1394028669659;
 Wed, 05 Mar 2014 06:11:09 -0800 (PST)
Received: by 10.68.138.138 with HTTP; Wed, 5 Mar 2014 06:10:49 -0800 (PST)
In-Reply-To: <1394028372-29990-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243438>

Hey Eric,
Sorry about not cc'ing you again , still figuring out "git send-email".


On Wed, Mar 5, 2014 at 7:36 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Replaces all instances of starts_with() by skip_prefix(),
> which can not only be used to check presence of a prefix,
> but also used further on as it returns the string after the prefix,
> if the prefix is present.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>
> Hey Eric,
> Here are the changes i have made in this Patch v2:
> 1. Edited the variables names to fit their usage
> 2. set my emacs to indent 8 tabs, so proper indentation
> 3. fixed my error where i increased the value by 1 in parse_signed_commit().
> Thanks again for your patience.
>
> ---
>  commit.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/commit.c b/commit.c
> index 6bf4fe0..f006490 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -553,6 +553,7 @@ static void record_author_date(struct author_date_slab *author_date,
>         struct ident_split ident;
>         char *date_end;
>         unsigned long date;
> +       const char *buf_split;
>
>         if (!commit->buffer) {
>                 unsigned long size;
> @@ -562,18 +563,19 @@ static void record_author_date(struct author_date_slab *author_date,
>                         return;
>         }
>
> +       buf_split = skip_prefix(buf, "author ");
> +
>         for (buf = commit->buffer ? commit->buffer : buffer;
>              buf;
>              buf = line_end + 1) {
>                 line_end = strchrnul(buf, '\n');
> -               if (!starts_with(buf, "author ")) {
> +               if (!buf_split) {
>                         if (!line_end[0] || line_end[1] == '\n')
>                                 return; /* end of header */
>                         continue;
>                 }
> -               if (split_ident_line(&ident,
> -                                    buf + strlen("author "),
> -                                    line_end - (buf + strlen("author "))) ||
> +               if (split_ident_line(&ident, buf_split,
> +                                    line_end - buf_split) ||
>                     !ident.date_begin || !ident.date_end)
>                         goto fail_exit; /* malformed "author" line */
>                 break;
> @@ -1098,6 +1100,7 @@ int parse_signed_commit(const unsigned char *sha1,
>         char *buffer = read_sha1_file(sha1, &type, &size);
>         int in_signature, saw_signature = -1;
>         char *line, *tail;
> +       const char *line_split;
>
>         if (!buffer || type != OBJ_COMMIT)
>                 goto cleanup;
> @@ -1111,11 +1114,11 @@ int parse_signed_commit(const unsigned char *sha1,
>                 char *next = memchr(line, '\n', tail - line);
>
>                 next = next ? next + 1 : tail;
> +               line_split = skip_prefix(line, gpg_sig_header);
>                 if (in_signature && line[0] == ' ')
>                         sig = line + 1;
> -               else if (starts_with(line, gpg_sig_header) &&
> -                        line[gpg_sig_header_len] == ' ')
> -                       sig = line + gpg_sig_header_len + 1;
> +               else if (line_split && line_split[0] == ' ')
> +                       sig = line_split + 1;
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
> +               found = skip_prefix(buf, sigcheck_gpg_status[i].check + 1);
> +               if(!found) {
>                         found = strstr(buf, sigcheck_gpg_status[i].check);
>                         if (!found)
>                                 continue;
> --
> 1.9.0.138.g2de3478
>
