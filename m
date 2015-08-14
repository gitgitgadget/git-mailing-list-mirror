From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 3/4] notes: add notes.mergestrategy option to select
 default strategy
Date: Fri, 14 Aug 2015 17:06:11 -0400
Message-ID: <CAPig+cTjQu2LRuR5cC+VSihVB00k-bjew3eCqA4Ee_tRuDK_=w@mail.gmail.com>
References: <1439585329-10542-1-git-send-email-jacob.e.keller@intel.com>
	<1439585329-10542-4-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 23:06:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQMB6-0006GS-Lh
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 23:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbbHNVGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 17:06:12 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:35310 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830AbbHNVGM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 17:06:12 -0400
Received: by ykbi184 with SMTP id i184so15415508ykb.2
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 14:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=fO/r4vN9HZuNEPBllGS6Qd1BfnOgvjamjO7GgVev2Yc=;
        b=VNzUv8RC0GJJ//RgXeTqvU2ctK7gWPeFtMHyiZhDb8T5mOe0BSgBLD78Ecvo8xK2DX
         uTMyOhuxFPmR3Gdo4FBFZzZvzLOXBwDilQia0A7xWQ1par0+DrQfvJadief19XK2+vTd
         Gq6fV32ysQ90SgismbQZGT0ShUun9OlTtu9GFHNG5QN85ysrFzCojNgS2Wm+GT2QtxL3
         IHxl7kQRKHK0lPoDCCSv133fubv7njkleruZ/EHpqER08pNFAHt7u0fo3XnftgGjqhum
         Dg1y5HXXvT2wgW9iQC9u5MEAaDrmiJpI5I0oulLY2XAzc79HuJUkBiaDz+rmUvYiJ085
         44Ag==
X-Received: by 10.170.81.133 with SMTP id x127mr47153447ykx.13.1439586371300;
 Fri, 14 Aug 2015 14:06:11 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Fri, 14 Aug 2015 14:06:11 -0700 (PDT)
In-Reply-To: <1439585329-10542-4-git-send-email-jacob.e.keller@intel.com>
X-Google-Sender-Auth: kkomfdT4Uo6SP1cpfE4qMpk9jEg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275954>

On Fri, Aug 14, 2015 at 4:48 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> Teach git-notes about "notes.mergestrategy" to select a general strategy
> for all notes merges. This enables a user to always get expected merge
> strategy such as "cat_sort_uniq" without having to pass the "-s" option
> manually.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 042348082709..d65134f89b40 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -738,6 +738,41 @@ static int merge_commit(struct notes_merge_options *o)
> +static int git_config_get_notes_strategy(const char *key,
> +                                        enum notes_merge_strategy *strategy)
> +{
> +       const char *value = NULL;
> +
> +       git_config_get_string_const(key, &value);
> +
> +       if (value) {
> +               if (parse_notes_strategy(value, strategy))
> +                       git_die_config(key, "unknown notes merge strategy '%s'", value);
> +               else
> +                       return 0;
> +       }
> +
> +       return 1;
> +}

Nice. This seems like a better (and more user-helpful) approach.

Instead of initializing value to NULL and ignoring the return value of
git_config_get_string_const(), would it instead make sense to respect
the return of git_config_get_string_const(), like this?

    const char *value;

    if (!git_config_get_string_const(key, &value)) {
        if (parse_notes_strategy(value, strategy))
            git_die_config(key, "unknown notes merge strategy '%s'", value);
        return 0;
    }
    return 1;

Or, the equivalent, but less indented:

    if (git_config_get_string_const(key, &value))
        return 1;
    if (parse_notes_strategy(value, strategy))
        git_die_config(key, "unknown notes merge strategy '%s'", value);
    return 0;
