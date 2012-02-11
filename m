From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [RFC/PATCH] tag: make list exclude !<pattern>
Date: Sat, 11 Feb 2012 11:47:19 -0800
Message-ID: <20120211194719.GE4903@tgrennan-laptop>
References: <20120210185516.GA4903@tgrennan-laptop>
 <1328926618-17167-1-git-send-email-tmgrennan@gmail.com>
 <7vaa4qnk4u.fsf@alter.siamese.dyndns.org>
 <7vy5s9n70x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pclouds@gmail.com, git@vger.kernel.org, jasampler@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 20:47:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwIv1-0007J7-8C
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 20:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754004Ab2BKTrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 14:47:25 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:34259 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842Ab2BKTrY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 14:47:24 -0500
Received: by vbjk17 with SMTP id k17so2408158vbj.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 11:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=VQ6Wh68MD+5ZWhaPklTqS2KTjlkB82yAC+Bas9RX4r8=;
        b=SKu6RoD0lPDK7Gvzz8eARSx68rFSDlI//H1n9/Vcqigj/4tT1I+hvfgK0QT1xBKrwZ
         jcqXIvqTEKkj/atAdK9FQ6EM9nos5jSDCMRwvEiDY74HNtjUqUQIV8ykTUz+Y2TybVH8
         2ydkWsVyv6T6Mz6LIYvCKenhwBqfNehOGdQWE=
Received: by 10.52.179.10 with SMTP id dc10mr4894416vdc.118.1328989643368;
        Sat, 11 Feb 2012 11:47:23 -0800 (PST)
Received: from localhost (c-98-207-169-74.hsd1.ca.comcast.net. [98.207.169.74])
        by mx.google.com with ESMTPS id s15sm6667978vdi.9.2012.02.11.11.47.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Feb 2012 11:47:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vy5s9n70x.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190533>

On Fri, Feb 10, 2012 at 11:50:06PM -0800, Junio C Hamano wrote:
>Junio C Hamano <gitster@pobox.com> writes:
>
>>    ... Same
>>    for 1c, which I highly suspect will introduce regression without
>>    looking at the code (for-each-ref is prefix-match only), ...

OK I'll study this further and run through t6300-for-each-ref.sh
I see it has a bunch of errors.
I think there are similar issues using match_pattern() with
show-branch and ls-remote.

Thanks,

>This part needs correction.  for-each-ref matches the command line
>arguments differently from branch --list and tag --list in two important
>ways.
>
> (1) It allows (not "only" which was a mistake in my earlier message)
>     prefix matching, e.g. "for-each-ref refs/heads/", in addition to
>     fnmatch(); and
>
> (2) The fnmatch() call is made with FNM_PATHMAME, which "branch --list"
>     and "tag --list" does not use.
>
>Strictly speaking, therefore, if you make all three commands to use the
>same matching logic, there is no way to avoid regression.  If you choose
>to use fnmatch() without FNM_PATHNAME, then for-each-ref suddenly starts
>matching wildcards across name hierarchy boundary '/' for a pattern that
>does not match today, e.g. "git for-each-ref 'refs/heads/*'" was a good
>way to grab only the integration branches while excluding individual topic
>branches such as refs/heads/tg/tag-points-at, but this technique can no
>longer be used for such a purpose, which is an unpleasant regression.
>
>I personally think that it was an annoying UI mistake that we let branch
>and tag call fnmatch without FNM_PATHNAME, but we cannot fix it lightly,
>either.  People who use hierchical branch names (e.g. maint-1.0/$topic,
>maint-2.0/$topic, and feature-2.0/$topic) may already be used to list all
>the topics on the maintenance tracks with "branch --list 'maint*'", and we
>need to keep "branch --list" and "tag --list" working as they expect.
>
>One possible way forward (now I am talking about a longer term solution)
>would be to introduce
>
>	refname_match_pattern(const char *refname,
>        		      const char **pattern,
>                              unsigned flags);
>
>where flags can tell the implementation if FNM_PATHNAME should be used,
>and if prefix matching should be attempted, so that the three commands
>share the single same matching function while still retaining their
>current behaviour in the initial round.  Inside the implementation, we
>would use good old fnmatch(), with or without FNM_PATHNAME, depending on
>the flags the caller passes.
>
>In a future versions, we may want to have "branch/tag --list" also ask for
>FNM_PATHNAME (this *is* a backward incompatible change, so it needs to be
>performed across major version boundary, with backward compatibility
>configurations, deprecation warnings and whole nine yards). Under the new
>match function, today's "branch --list 'maint*'" needs to be spelled as
>"branch --list 'maint*/*'" or something.  The prefix matching is probably
>safer to enable by default without causing big regression hassle if we
>limit the prefix match to only patterns that end with an explicit slash,
>as users already *know* today's "branch --list tg/" would not match
>anything (because the pattern does not even match a brahch 'tg', so it is
>unlikely they are using it and expecting only 'tg' to match), which means
>that is an unlikely input we can safely give new meaning to match anything
>under tg/ hierarchy.
>
