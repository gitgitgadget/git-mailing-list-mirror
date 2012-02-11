From: Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [RFC/PATCH] tag: make list exclude !<pattern>
Date: Sat, 11 Feb 2012 11:08:56 -0800
Message-ID: <20120211190856.GB4903@tgrennan-laptop>
References: <20120210185516.GA4903@tgrennan-laptop>
 <1328926618-17167-1-git-send-email-tmgrennan@gmail.com>
 <7vaa4qnk4u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pclouds@gmail.com, git@vger.kernel.org, jasampler@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 20:09:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwIJq-0003CH-Av
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 20:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754800Ab2BKTJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 14:09:05 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48662 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754728Ab2BKTJE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 14:09:04 -0500
Received: by vcge1 with SMTP id e1so2442319vcg.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 11:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GqQT4ab9dvZQhk3xQ/Tppp7IAp1XKxqjSrFwlp+UCPo=;
        b=sQT5P1x4Gj83xcMhdanYqQv1Ld9z62Mky+bE8ARrfH3CZpc4RTqNS45MfbQU7lA7yf
         ru/8ldrRDQooTTP8N3a7By6RZ5Do6kwvs82Fyi+eFXvIJHm33S5uWsbYkPMOcHvoBTWG
         KnAK0t5TCNrvkIXhAMvDQD+mOXicqAgn16AX8=
Received: by 10.52.29.17 with SMTP id f17mr4835904vdh.126.1328987341326;
        Sat, 11 Feb 2012 11:09:01 -0800 (PST)
Received: from localhost (c-98-207-169-74.hsd1.ca.comcast.net. [98.207.169.74])
        by mx.google.com with ESMTPS id fg5sm2032787vdc.13.2012.02.11.11.08.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 11 Feb 2012 11:09:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vaa4qnk4u.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190529>

On Fri, Feb 10, 2012 at 07:06:57PM -0800, Junio C Hamano wrote:
>Tom Grennan <tmgrennan@gmail.com> writes:
>
>>>If we pursue this, it may be best to first add match_patterns() to ./refs.[ch]
>>>then incrementally modify these builtin commands to use it.
>>
>> The following series implements !<pattern> with: git-tag, git-branch, and
>> git-for-each-ref.
>>
>> This still requires Documentation and unit test updates but I think these are
>> close to functionally complete.
>>
>>>>About the '!' for exclusion, maybe it's better to move from fnmatch()
>>>>as matching machinery to pathspec. Then when git learns negative
>>>>pathspec [1], we have this feature for free.
>>>>
>>>>[1] http://thread.gmane.org/gmane.comp.version-control.git/189645/focus=190072
>>
>> After looking at this some more, I don't understand the value of replacing
>> libc:fnmatch().  Or are you just referring to '--exclude' instead of
>> [!]<pattern> argument parsing?
>
>I have not formed a firm opinion on Nguyen's idea to reuse pathspec
>matching infrastructure for this purpose, so I wouldn't comment on that
>part. It certainly looks attractive, as it allows users to learn one and
>only one extended matching syntax, but at the same time, it has a risk to
>mislead people to think that the namespace for refs is similar to that of
>the filesystem paths, which I see as a mild downside.
>
>In any case, I do not like the structure of this series. If it followed
>our usual pattern, it would consist of patches in this order:
>
> - Patch 1 would extract match_pattern() from builtin/tag.c and introduce
>   the new helper function refname_match_patterns() to refs.c.  It updates
>   the call sites of match_pattern() in builtin/tag.c, match_patterns() in
>   builtin/branch.c, and the implementation of grab_single_ref() in
>   builtin/for-each-ref.c with a call to the new helper function.
>
>   This step can and probably should be done as three sub-steps.  1a would
>   move builtin/tag.c::match_pattern() to refs.::refname_match_patterns(),
>   1b would use the new helper in builtin/branch.c and 1c would do the
>   same for builtin/for-each-ref.c.
>
>   It is important that this patch does so without introducing any new
>   functionality to the new function over the old one. When done this way,
>   there is no risk of introducing new bugs at 1a because it is purely a
>   code movement and renaming; 1b could introduce a bug that changes
>   semantics for bulitin/branch.c if its match_patterns() does things
>   differently from match_pattern() lifted from builtin/tag.c, and if it
>   is found out to be buggy, we can discard 1b without discarding 1a. Same
>   for 1c, which I highly suspect will introduce regression without
>   looking at the code (for-each-ref is prefix-match only), that can
>   safely be discarded.
>
>   This is to make it easier to ensure that the update does not introduce
>   new bugs.
>
> - Patch 2 would then add the new functionality to the new helper. It
>   would also adjust the documentation of the three end user facing
>   commands to describe the fallout coming from this change, and adds new
>   tests to make sure future changes will not break this new
>   functionality.
>
>That is, first refactor and clean-up without adding anything new, and then
>build new stuff on solidified ground.

Nuts! I have the cart before the horse. I'll try to rearrange the series as
suggested by tomorrow. Thanks.

>Do we allow a refname whose pathname component begins with '!', by the
>way?  If we do, how does a user look for a tag whose name is "!xyzzy"?
>"Naming your tag !xyzzy used to be allowed but it is now forbidden after
>this patch" is not an acceptable answer---it is called a regression.  If
>the negation operator were "^" or something that we explicitly forbid from
>a refname, we wouldn't have such a problem.

Cool, as I recall, v7 or earlier /bin/sh also used "^" to preface
exclusion patterns. Another option is the bash extglob syntax of
!(pattern) although I'd prefer "^" b/c one wouldn't have to quote it
with bash:
  $ git branch --list ^pu

-- 
TomG
