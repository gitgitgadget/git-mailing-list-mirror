From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Minor bug with help.autocorrect.
Date: Fri, 21 Aug 2015 15:13:38 -0700
Message-ID: <xmqqmvxk47e5.fsf@gitster.dls.corp.google.com>
References: <CA+cck7Ex4UO9BAzZ1kq5jw1vYqFb+mbzNQh-RvYAvK5v2T4G0g@mail.gmail.com>
	<xmqqsi7c7hc4.fsf@gitster.dls.corp.google.com>
	<20150821162347.GA4828@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tanay Abhra <tanayabh@gmail.com>,
	=?utf-8?Q?Bj=C3=B8rnar?= Snoksrud <snoksrud@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 22 00:13:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSuZG-0004CE-NE
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 00:13:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753421AbbHUWNm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 18:13:42 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33247 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753322AbbHUWNk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 18:13:40 -0400
Received: by pacgr6 with SMTP id gr6so2664665pac.0
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 15:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=93Eww9NBxSa748NEmxqDZxtCiQ9n7TAq9OrrC9QzvtQ=;
        b=G7ZtPekPxITGReYx9g3ATT/jg+3HbfYt8NEdVeRSQTXtCoaxCiwu1bqyZxaW5fi6Pu
         akVdpOBgv25vSZgQ1WBCsZOOchCbZARGd5tQw2r1cGbJKqVCq/7VDmP+CbgBGiI45moP
         VZ8rFBfAEfkQXEJ4jHRotZCkdIom4mHgg6uZgM7fg0ld4cL/c0Q6/3ue7HTUtnr6ht0a
         TN74GGq5y50rRVYXN3XnplcEUAYihc0Eg81CMcj+0Jo4XC7NZFjEVOfRoTuqKwkn/lFw
         39+0/RtzWx6pYKGvkHcS3NwRAqr0NCj849L/K5i1LJpv1kouJyqN7ZLJNNX8kIzATKJ3
         5i/A==
X-Received: by 10.68.113.37 with SMTP id iv5mr21624326pbb.104.1440195219930;
        Fri, 21 Aug 2015 15:13:39 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:4c7d:6904:6af7:82e1])
        by smtp.gmail.com with ESMTPSA id e6sm8933496pas.35.2015.08.21.15.13.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 21 Aug 2015 15:13:39 -0700 (PDT)
In-Reply-To: <20150821162347.GA4828@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 21 Aug 2015 12:23:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276338>

Jeff King <peff@peff.net> writes:

> I think the plan is:
>
>   1. squelch the warning message from the config code; even if we change
>      the config format to pager.*.command, we will have to support
>      pager.* for historical reasons.
>
>   2. introduce pager.*.command so that "git foo_bar" can use
>      pager.foo_bar.command.
>
> We should do (1) in the near-term. We do not have to do (2) at all (and
> people with funny command names are simply out of luck), but it would be
> nice in the long run.

That sounds sensible.

> The patch from Tanay in $gmane/263888 accomplishes (1), but there was a
> minor cleanup needed (checking the individual bit in "flags", rather
> than the whole variable). Here it is with that fix:

Thanks; let's take a look.  I have a suspicion that it "accomplishes"
a lot more than (1) and may be discarding useful errors.

> diff --git a/config.c b/config.c
> index 9fd275f..dd0cb52 100644
> --- a/config.c
> +++ b/config.c
> @@ -1314,7 +1314,7 @@ static struct config_set_element *configset_find_element(struct config_set *cs,
>  	 * `key` may come from the user, so normalize it before using it
>  	 * for querying entries from the hashmap.
>  	 */
> -	ret = git_config_parse_key(key, &normalized_key, NULL);
> +	ret = git_config_parse_key(key, &normalized_key, NULL, CONFIG_ERROR_QUIET);

Hmm, I am not sure if this is correct, or it is trying to do things
at too low a level.

configset_add_value() calls configset_find_element().

A NULL return from find_element() could be because parse_key()
errored out due to bad name, or the key genuinely did not exist in
the hashmap, and the caller cannot tell.  So add_value() can end up
adding a new <key,value> pair under a bogus key, which is not a new
problem, but what makes me cautious is that it happens silently with
the updated code.

In fact, git_configset_add_file() uses git_config_from_file() with
configset_add_value() as its callback function, and the error that
is squelched with this CONFIG_ERROR_QUIET would be the only thing
that tells the user that the config file being read is malformed.

Right now, "git config" does not seem to use the full configset API
so nobody would notice, but still...

I wonder if alias_lookup() and check_pager_config(), two functions
that *know* that the string they have, cmd, could be invalid and
unusable key to give to the config API, should be doing an extra
effort (e.g. call parse_key() with QUIET option and refrain from
calling git_config_get_value()).  It feels that for existing callers
of parse_key(), not passing QUIET would be the right thing to do.

Of course, I am OK if git_config_get_value() and friends took the
QUIET flag and and passed it all the way down to parse_key(); that
would be a much more correct approach to address this issue (these
two callers do not have to effectively call parse_key() twice that
way), but at the same time, that would be a lot more involved
change.
