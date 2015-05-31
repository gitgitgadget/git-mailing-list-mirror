From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/WIP 5/8] am: detect mbox patches
Date: Sun, 31 May 2015 13:16:28 -0400
Message-ID: <CAPig+cQc6mgfXB3nz01xu8QArPv7zNOVXwb+WskBn1z2RyJCYQ@mail.gmail.com>
References: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
	<1432733618-25629-6-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 31 19:17:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yz6rA-0001jp-11
	for gcvg-git-2@plane.gmane.org; Sun, 31 May 2015 19:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754889AbbEaRQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 13:16:31 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36762 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754968AbbEaRQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 13:16:28 -0400
Received: by igbpi8 with SMTP id pi8so46067679igb.1
        for <git@vger.kernel.org>; Sun, 31 May 2015 10:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=9HQ+1/E1pmdsMi8SVVWbtzfS3zVvM182Vkuky51urKc=;
        b=lAuDruI8jrrXZWWAE/cSx/DlcqLBSVt3DEegvFg8echbN1rHVL1ZewQ6G5iIXRUYkz
         1Rz0GqQpVLqlX0gBSMe/5br/T7VepYZJ/F5wwgfEqQky/bNQOaHqZSD7eRj4kN2WEVvW
         DhF1x+D/AT+WwgyUo/h9o9PC6im8q5K2x6kXAqqrPdIzEfRASRZt6eP/pvuSXJDg/+an
         7cMaDNQOraUFgaW1ZnPzoeXhIn3Obbld+VDd93PJV90mUG+1WCTmYR1EZjWdvewc1L+q
         7aYXi5vW/7bYRYkm0P/6OW4TTPHhECuygQpjjSFCXXBWoNy3di2ryD5UTxkClnuhdxr9
         SckA==
X-Received: by 10.42.166.200 with SMTP id p8mr17140752icy.25.1433092588148;
 Sun, 31 May 2015 10:16:28 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sun, 31 May 2015 10:16:28 -0700 (PDT)
In-Reply-To: <1432733618-25629-6-git-send-email-pyokagan@gmail.com>
X-Google-Sender-Auth: BcJOtu1bLOd2vDN_F8FWQ_jcsts
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270333>

On Wed, May 27, 2015 at 9:33 AM, Paul Tan <pyokagan@gmail.com> wrote:
> Since 15ced75 (git-am foreign patch support: autodetect some patch
> formats, 2009-05-27), git-am.sh is able to autodetect mbox, stgit and
> mercurial patches through heuristics.
>
> Re-implement support for autodetecting mbox/maildir files.

A few minor comments below...

> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
> diff --git a/builtin/am.c b/builtin/am.c
> index 9c7b058..d589ec5 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -108,6 +108,97 @@ static void am_destroy(const struct am_state *state)
>         strbuf_release(&sb);
>  }
>
> +/*
> + * Returns 1 if the file looks like a piece of email a-la RFC2822, 0 otherwise.
> + * We check this by grabbing all the non-indented lines and seeing if they look
> + * like they begin with valid header field names.
> + */
> +static int is_email(const char *filename)
> +{
> +       struct strbuf sb = STRBUF_INIT;
> +       FILE *fp = xfopen(filename, "r");
> +       int ret = 1;
> +
> +       while (!strbuf_getline(&sb, fp, '\n')) {
> +               const char *x;
> +
> +               strbuf_rtrim(&sb);
> +
> +               if (!sb.len)
> +                       break; /* End of header */
> +
> +               /* Ignore indented folded lines */
> +               if (*sb.buf == '\t' || *sb.buf == ' ')
> +                       continue;
> +
> +               /* It's a header if it matches the regexp "^[!-9;-~]+:" */
> +               for (x = sb.buf; *x; x++) {
> +                       if (('!' <= *x && *x <= '9') || (';' <= *x && *x <= '~'))
> +                               continue;
> +                       if (*x == ':' && x != sb.buf)
> +                               break;
> +                       ret = 0;
> +                       goto fail;
> +               }
> +       }
> +
> +fail:

It's a bit odd seeing a label named "fail" through which both the
successful and failing cases flow. Upon seeing it, I had expected to
find a "return 1" somewhere above for the successful case. Perhaps a
name such as "done" would be clearer.

> +       fclose(fp);
> +       strbuf_release(&sb);
> +       return ret;
> +}
> +
> +/**
> + * Attempts to detect the patch_format of the patches contained in `paths`,
> + * returning the PATCH_FORMAT_* enum value. Returns PATCH_FORMAT_UNKNOWN if
> + * detection fails.
> + */
> +static int detect_patch_format(struct string_list *paths)
> +{
> +       enum patch_format ret = PATCH_FORMAT_UNKNOWN;
> +       struct strbuf l1 = STRBUF_INIT;
> +       struct strbuf l2 = STRBUF_INIT;
> +       struct strbuf l3 = STRBUF_INIT;
> +       FILE *fp;
> +
> +       /*
> +        * We default to mbox format if input is from stdin and for directories
> +        */
> +       if (!paths->nr || !strcmp(paths->items->string, "-") ||
> +           is_directory(paths->items->string)) {
> +               strbuf_release(&l1);
> +               strbuf_release(&l2);
> +               strbuf_release(&l3);
> +               return PATCH_FORMAT_MBOX;

A couple observations:

Some people will argue that these strbuf_release() calls are pointless
since the strbufs haven't been used yet, thus should be dropped. (I
don't care strongly.)

Perhaps this case could be a bit less noisy if coded like this:

    if (... || ...) {
        ret = PATCH_FORMAT_MBOX;
        goto done;
    }

with a corresponding "done" label added before the strbuf_release()
calls near the bottom of the function.

> +       }
> +
> +       /*
> +        * Otherwise, check the first few 3 lines of the first patch, starting

Either: s/few 3/few/ or s/few 3/3/

> +        * from the first non-blank line, to try to detect its format.
> +        */
> +       fp = xfopen(paths->items->string, "r");
> +       while (!strbuf_getline(&l1, fp, '\n')) {
> +               strbuf_trim(&l1);
> +               if (l1.len)
> +                       break;
> +       }
> +       strbuf_getline(&l2, fp, '\n');
> +       strbuf_trim(&l2);
> +       strbuf_getline(&l3, fp, '\n');
> +       strbuf_trim(&l3);
> +       fclose(fp);
> +
> +       if (starts_with(l1.buf, "From ") || starts_with(l1.buf, "From: "))
> +               ret = PATCH_FORMAT_MBOX;
> +       else if (l1.len && l2.len && l3.len && is_email(paths->items->string))
> +               ret = PATCH_FORMAT_MBOX;
> +
> +       strbuf_release(&l1);
> +       strbuf_release(&l2);
> +       strbuf_release(&l3);
> +       return ret;
> +}
> +
>  /**
>   * Splits out individual patches from `paths`, where each path is either a mbox
>   * file or a Maildir. Return 0 on success, -1 on failure.
> @@ -162,6 +253,14 @@ static int split_patches(struct am_state *state, enum patch_format patch_format,
>  static void am_setup(struct am_state *state, enum patch_format patch_format,
>                 struct string_list *paths)
>  {
> +       if (!patch_format)
> +               patch_format = detect_patch_format(paths);
> +
> +       if (!patch_format) {
> +               fprintf_ln(stderr, _("Patch format detection failed."));
> +               exit(128);
> +       }
> +
>         if (mkdir(state->dir.buf, 0777) < 0 && errno != EEXIST)
>                 die_errno(_("failed to create directory '%s'"), state->dir.buf);
>
> --
> 2.1.4
