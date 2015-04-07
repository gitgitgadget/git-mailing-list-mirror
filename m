From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 2/4] cat-file: teach cat-file a '--literally' option
Date: Tue, 7 Apr 2015 16:49:09 -0400
Message-ID: <CAPig+cQ_EQYmP14+g=ozi1eiGUqkrVN3gX-J4zshLpqL20iRcA@mail.gmail.com>
References: <551F7984.5070902@gmail.com>
	<1428126244-19115-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 22:49:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfaQu-0002A0-GG
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 22:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625AbbDGUtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 16:49:12 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:33496 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620AbbDGUtL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 16:49:11 -0400
Received: by layy10 with SMTP id y10so51572359lay.0
        for <git@vger.kernel.org>; Tue, 07 Apr 2015 13:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=0occWxfgBHWewyWp9po252vL3oY1vSA3fBDLdixvdBw=;
        b=icMmn6e9uK8Rx0MSAL2D4v08Nint/pmxJVWmQpczHUG2y49WFVtFZs0EnRQ4ye1exA
         cm9hnljP9mfMnQUr8U/2zF1WTO7ln2sgWSw+dbBJlyUBLx3AEL98IM5+dCxqKatUWUYO
         bgIW/XJgnxffD9w3E1dJy+g2U11UidhOAXyca5kaCCIlyHT886obsLjy7IH3m1ZQBtel
         GAXaDhh+iA8lu5+gFpq1xgRYwTKOESPiLmxayMLttRwvm9qiNV6nyz8iJAPOT/8llUZ0
         uYX9VfoI1ocaOxfFA+nQX/mIyMXjBBe2vfyMRLEzpSjkHJq6L21mTxKXY9PQyDp9BR33
         BlQg==
X-Received: by 10.152.170.136 with SMTP id am8mr15227933lac.102.1428439749173;
 Tue, 07 Apr 2015 13:49:09 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Tue, 7 Apr 2015 13:49:09 -0700 (PDT)
In-Reply-To: <1428126244-19115-1-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: wTgg_42kjI3fHobCjoct2Vt4Xwk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266940>

On Sat, Apr 4, 2015 at 1:44 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Currently 'git cat-file' throws an error while trying to
> print the type or size of a broken/corrupt object which is
> created using 'git hash-object --literally'. This is
> because these objects are usually of unknown types.

This focus of this explanation is off-the-mark. The fact that such
objects can be created by 'hash-object --literally' is tangental to
the real purpose of the new 'cat-file --literally' option, which is
that it can help with diagnosing broken/corrupt objects encountered
in-the-wild.

Even mentioning 'hash-object --literally' here may be misleading and
confusing since its purpose it to intentionally create broken objects
for stress-testing git itself. I'd probably drop the reference
altogether, but if you insist upon mentioning 'hash-object
--literally', perhaps make it a very minor parenthetical comment at
the end of the commit message saying that 'cat-file --literally' was
inspired by its hash-object counterpart, or some such.

More below.

> Teach git cat-file a '--literally' option where it prints
> the type or size of a broken/corrupt object without throwing
> an error.
>
> Modify '-t' and '-s' options to call sha1_object_info_extended()
> directly to support the '--literally' option.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index df99df4..91ceae0 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -9,13 +9,20 @@
>  #include "userdiff.h"
>  #include "streaming.h"
>
> -static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
> +static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
> +                       int literally)
>  {
>         unsigned char sha1[20];
>         enum object_type type;
>         char *buf;
>         unsigned long size;
>         struct object_context obj_context;
> +       struct object_info oi = {NULL};
> +       struct strbuf sb = STRBUF_INIT;
> +       unsigned flags = LOOKUP_REPLACE_OBJECT;
> +
> +       if (literally)
> +               flags |= LOOKUP_LITERALLY;
>
>         if (get_sha1_with_context(obj_name, 0, sha1, &obj_context))
>                 die("Not a valid object name %s", obj_name);
> @@ -23,16 +30,24 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
>         buf = NULL;
>         switch (opt) {
>         case 't':
> -               type = sha1_object_info(sha1, NULL);
> -               if (type > 0) {
> -                       printf("%s\n", typename(type));
> +               oi.typep = &type;
> +               oi.typename = &sb;

These two lines are common to the -t and -s cases. Would it make sense
to instead move them to just after 'oi' and 'sb' are declared? However
(see below)...

> +               if (sha1_object_info_extended(sha1, &oi, flags) < 0)
> +                       die("git cat-file: could not get object info");
> +               if (type >= 0 && sb.len) {
> +                       printf("%s\n", sb.buf);
> +                       strbuf_release(&sb);

Here you release the strbuf...

>                         return 0;
>                 }
>                 break;
>
>         case 's':
> -               type = sha1_object_info(sha1, &size);
> -               if (type > 0) {
> +               oi.typep = &type;
> +               oi.typename = &sb;

Why do you need to collect 'typename' for the -s case?
sha1_object_info_extended() promises that 'type' will be zero in the
--literally case for unknown types, so checking 'sb.len' in the
conditional below doesn't buy you anything, does it?

In fact, it's not even clear why you need to collect 'type' in the -s
case? The return value of sha1_object_info_extended() already tells
you whether or not the 'size' was retrieved successfully (--literally
or not).

> +               oi.sizep = &size;
> +               if (sha1_object_info_extended(sha1, &oi, flags) < 0)
> +                       die("git cat-file: could not get object info");
> +               if (type >= 0 && sb.len) {
>                         printf("%lu\n", size);

But here you do not release the strbuf.

>                         return 0;
>                 }
> @@ -369,6 +385,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>                 OPT_SET_INT('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
>                 OPT_SET_INT(0, "textconv", &opt,
>                             N_("for blob objects, run textconv on object's content"), 'c'),
> +               OPT_BOOL( 0, "literally", &literally,
> +                         N_("get information about corrupt objects for debugging Git")),

This option neither "gets information" nor is it for debugging Git.
Rather, it's useful for diagnosing broken/corrupt objects in
combination with other options. Perhaps rephrase something like this:

    "allow -s and -t to work with broken/corrupt objects"

>                 { OPTION_CALLBACK, 0, "batch", &batch, "format",
>                         N_("show info and content of objects fed from the standard input"),
>                         PARSE_OPT_OPTARG, batch_option_callback },
