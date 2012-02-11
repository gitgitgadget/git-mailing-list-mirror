From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] tag: make list exclude !<pattern>
Date: Fri, 10 Feb 2012 19:06:57 -0800
Message-ID: <7vaa4qnk4u.fsf@alter.siamese.dyndns.org>
References: <20120210185516.GA4903@tgrennan-laptop>
 <1328926618-17167-1-git-send-email-tmgrennan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pclouds@gmail.com, git@vger.kernel.org, krh@redhat.com,
	jasampler@gmail.com
To: Tom Grennan <tmgrennan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 04:07:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw3Ir-0001Pi-Ov
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 04:07:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753645Ab2BKDHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 22:07:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49280 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753242Ab2BKDHC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 22:07:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6DB37D61;
	Fri, 10 Feb 2012 22:07:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g6VoxM7h8prjdkBrPhevodj8Ouw=; b=cMqNHv
	+FBG9eifz2ashxwhgho4Gskme+LabsSxo6dvz/5BScMzGDshyRKTW3UVDl3npKAm
	IXD/lyuZO118/EC/cCmwvBA5Bs7dCJbnWrAsqaaMs+c9vchYXy+4UNQFugEoXFnG
	OnKXRu0ptNhh+l08+itbAWbmojMk9rg0XP1FA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iAZdGGO9YKx25ZWzEPcxSSxy3tM2kvHv
	T8Il8bzfC5LNki3GIXRE5w+OiiP7yz4SV5vlBLvoadNpgqKe4n5KTwtcy1TEUp6R
	p1x+XZNb7nngwnWyNetyCn3RdWrmoea2pvB6Qc45QEb/8ApySZZJtGN9oBKwkRoJ
	Xl15hu3Fj14=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BE8097D60;
	Fri, 10 Feb 2012 22:07:00 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12B7B7D5D; Fri, 10 Feb 2012
 22:06:58 -0500 (EST)
In-Reply-To: <1328926618-17167-1-git-send-email-tmgrennan@gmail.com> (Tom
 Grennan's message of "Fri, 10 Feb 2012 18:16:54 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 76470008-545D-11E1-8E66-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190480>

Tom Grennan <tmgrennan@gmail.com> writes:

>>If we pursue this, it may be best to first add match_patterns() to ./refs.[ch]
>>then incrementally modify these builtin commands to use it.
>
> The following series implements !<pattern> with: git-tag, git-branch, and
> git-for-each-ref.
>
> This still requires Documentation and unit test updates but I think these are
> close to functionally complete.
>
>>>About the '!' for exclusion, maybe it's better to move from fnmatch()
>>>as matching machinery to pathspec. Then when git learns negative
>>>pathspec [1], we have this feature for free.
>>>
>>>[1] http://thread.gmane.org/gmane.comp.version-control.git/189645/focus=190072
>
> After looking at this some more, I don't understand the value of replacing
> libc:fnmatch().  Or are you just referring to '--exclude' instead of
> [!]<pattern> argument parsing?

I have not formed a firm opinion on Nguyen's idea to reuse pathspec
matching infrastructure for this purpose, so I wouldn't comment on that
part. It certainly looks attractive, as it allows users to learn one and
only one extended matching syntax, but at the same time, it has a risk to
mislead people to think that the namespace for refs is similar to that of
the filesystem paths, which I see as a mild downside.

In any case, I do not like the structure of this series. If it followed
our usual pattern, it would consist of patches in this order:

 - Patch 1 would extract match_pattern() from builtin/tag.c and introduce
   the new helper function refname_match_patterns() to refs.c.  It updates
   the call sites of match_pattern() in builtin/tag.c, match_patterns() in
   builtin/branch.c, and the implementation of grab_single_ref() in
   builtin/for-each-ref.c with a call to the new helper function.

   This step can and probably should be done as three sub-steps.  1a would
   move builtin/tag.c::match_pattern() to refs.::refname_match_patterns(),
   1b would use the new helper in builtin/branch.c and 1c would do the
   same for builtin/for-each-ref.c.

   It is important that this patch does so without introducing any new
   functionality to the new function over the old one. When done this way,
   there is no risk of introducing new bugs at 1a because it is purely a
   code movement and renaming; 1b could introduce a bug that changes
   semantics for bulitin/branch.c if its match_patterns() does things
   differently from match_pattern() lifted from builtin/tag.c, and if it
   is found out to be buggy, we can discard 1b without discarding 1a. Same
   for 1c, which I highly suspect will introduce regression without
   looking at the code (for-each-ref is prefix-match only), that can
   safely be discarded.

   This is to make it easier to ensure that the update does not introduce
   new bugs.

 - Patch 2 would then add the new functionality to the new helper. It
   would also adjust the documentation of the three end user facing
   commands to describe the fallout coming from this change, and adds new
   tests to make sure future changes will not break this new
   functionality.

That is, first refactor and clean-up without adding anything new, and then
build new stuff on solidified ground.

Do we allow a refname whose pathname component begins with '!', by the
way?  If we do, how does a user look for a tag whose name is "!xyzzy"?
"Naming your tag !xyzzy used to be allowed but it is now forbidden after
this patch" is not an acceptable answer---it is called a regression.  If
the negation operator were "^" or something that we explicitly forbid from
a refname, we wouldn't have such a problem.
