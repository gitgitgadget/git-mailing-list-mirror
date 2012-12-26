From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 2/2] log: add log.mailmap configuration option
Date: Wed, 26 Dec 2012 17:42:18 +0100
Message-ID: <CALWbr2zZ=SUns25RMXjV9NNh3vfGwpdDzTFbD=ytDUBJkhNp6w@mail.gmail.com>
References: <1356195512-4846-1-git-send-email-apelisse@gmail.com>
	<1356195512-4846-3-git-send-email-apelisse@gmail.com>
	<7v8v8ppf6f.fsf@alter.siamese.dyndns.org>
	<7vlickpz81.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 26 17:42:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tnu40-0006VU-1j
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 17:42:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753348Ab2LZQmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 11:42:21 -0500
Received: from mail-ee0-f47.google.com ([74.125.83.47]:35231 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819Ab2LZQmU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 11:42:20 -0500
Received: by mail-ee0-f47.google.com with SMTP id e51so4274545eek.20
        for <git@vger.kernel.org>; Wed, 26 Dec 2012 08:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iD/Z368BTxiJ0A4+Qn3dgVOXHL/QiFr9iZCA+KbPDLs=;
        b=dkLfVjUEMWznmWBXv/23jNBeNNx4phGY8k4gbqjFRu34yp+EajlJ0kBzW+HW5JKw0d
         xJN3iFvXJoSYbW510N2M43He8x6p9y7dGyRw+Mrealjll1RQbfP69pHFR3/h0KJpoIOI
         Zj3zRb9MhRhxNN509ySFbQu+88tYK7inwaT80LNE+nsxMLe+R2hfggTeTmn3mEJQCcxt
         4p5/Q327d/qfZJfNluC2x95VmUJswPC2uxLJ10GCjSLD4hgTHnqInqqCqdjVBUQK1+CC
         uRmYRhehfYSTC99nDBkyId7LZdoBA4LK3a/FPTnDw5Hdj4jXKVDkYaMY4o/kCvagmPeA
         Tp2w==
Received: by 10.14.206.197 with SMTP id l45mr71344303eeo.17.1356540138990;
 Wed, 26 Dec 2012 08:42:18 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Wed, 26 Dec 2012 08:42:18 -0800 (PST)
In-Reply-To: <7vlickpz81.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212141>

I was planning to send you a fix pretty close to that,

Thanks a lot Junio!

On Wed, Dec 26, 2012 at 5:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Antoine Pelisse <apelisse@gmail.com> writes:
>>
>>> I'm wondering if it would be needed to add a no-use-mailmap option to
>>> log command so that it can cancel this configuration option.
>>
>> The usual way for adding a new feature is to add a --enable-feature
>> long-option without any configuration variable to let users try it
>> out in the field, and then add the configuration to let it be
>> default for users who opt in.  The first step should also allow a
>> command line option to disable (which should come for free if you
>> use parse-options API correctly).
>
> It should be sufficient to squash something like this in.  Use the
> configured value, if available, to initialize the existing "mailmap"
> variable, which is in turn updated from the command line option with
> either --use-mailmap or --no-use-mailmap.  What is left in "mailmap"
> after the command line parsing returns is what the user told us to
> use.
>
> Thanks.
>
>  builtin/log.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index f6936ff..16e6520 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -31,7 +31,7 @@ static int default_abbrev_commit;
>  static int default_show_root = 1;
>  static int decoration_style;
>  static int decoration_given;
> -static int use_mailmap;
> +static int use_mailmap_config;
>  static const char *fmt_patch_subject_prefix = "PATCH";
>  static const char *fmt_pretty;
>
> @@ -107,6 +107,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>                 OPT_END()
>         };
>
> +       mailmap = use_mailmap_config;
>         argc = parse_options(argc, argv, prefix,
>                              builtin_log_options, builtin_log_usage,
>                              PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN |
> @@ -139,7 +140,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
>         if (source)
>                 rev->show_source = 1;
>
> -       if (mailmap || use_mailmap) {
> +       if (mailmap) {
>                 rev->mailmap = xcalloc(1, sizeof(struct string_list));
>                 read_mailmap(rev->mailmap, NULL);
>         }
> @@ -360,7 +361,7 @@ static int git_log_config(const char *var, const char *value, void *cb)
>         if (!prefixcmp(var, "color.decorate."))
>                 return parse_decorate_color_config(var, 15, value);
>         if (!strcmp(var, "log.mailmap")) {
> -               use_mailmap = git_config_bool(var, value);
> +               use_mailmap_config = git_config_bool(var, value);
>                 return 0;
>         }
>
