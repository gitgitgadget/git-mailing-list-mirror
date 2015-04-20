From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] "git pull" will regress between 'master' and 'pu'
Date: Mon, 20 Apr 2015 12:24:31 -0700
Message-ID: <xmqqiocqli1c.fsf@gitster.dls.corp.google.com>
References: <xmqqbnikoq0n.fsf@gitster.dls.corp.google.com>
	<20150419130745.GA20476@peff.net>
	<xmqqmw22lj7r.fsf@gitster.dls.corp.google.com>
	<20150420191041.GA14362@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 20 21:24:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkHJ9-0002Nh-DU
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 21:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbbDTTYf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 15:24:35 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51665 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750998AbbDTTYe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 15:24:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 49C9448BBC;
	Mon, 20 Apr 2015 15:24:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pU1d5/ga1t2rbHDZcf1hzzW8bqE=; b=IXvdpA
	SrpPx8M3cC0Ol3GrztSYHxY4sw3Bb7C9Y6Op6ZmAUPdFodGeRA9GJePfH0HwAnfp
	xac16N8DyNC+yAemkRqH1c6EfzTLsDIZKOXyHwKVuMr4LjFyyZUwOjLzt8G3a1an
	1o+x/phSoo+WONGAo+V8KXmlenbY/xvTIMmrg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dd1WA2/dL/74bl4focumrkIJn1c2pYH1
	6KhMgnBYZ89zDm/Rmwe67S1M+zRigVY5M4jibLCfX2hdzARE3qIBowuB2iTaWi7C
	ACNzaw/JrnvmtUc08pucANqAGnQWW7ZGZtOTIwYO8tkSM3MQwXIMJ2PfnPMyojs2
	22+6DazybDo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 423F848BBB;
	Mon, 20 Apr 2015 15:24:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BAA8948BB7;
	Mon, 20 Apr 2015 15:24:32 -0400 (EDT)
In-Reply-To: <20150420191041.GA14362@peff.net> (Jeff King's message of "Mon,
	20 Apr 2015 15:10:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DF6EAC18-E792-11E4-A4A4-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267490>

Jeff King <peff@peff.net> writes:

> On Mon, Apr 20, 2015 at 11:59:04AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > @@ -334,7 +333,7 @@ true)
>> >  	eval="git-merge $diffstat $no_commit $verify_signatures $edit $squash $no_ff $ff_only"
>> >  	eval="$eval $log_arg $strategy_args $merge_args $verbosity $progress"
>> >  	eval="$eval $gpg_sign_args"
>> > -	eval="$eval -m \"\$merge_name\" $merge_head"
>> > +	eval="$eval FETCH_HEAD"
>> >  	;;
>> >  esac
>> >  eval "exec $eval"
>> >
>> > as we seem to special-case the name FETCH_HEAD. It assumes that
>> > git-merge's parsing of FETCH_HEAD is the same as what we do in git-pull,
>> > but that seems safe.
>> 
>> Unfortunately, "git merge"'s parsing of FETCH_HEAD forgets that we
>> may be creating an Octopus.  Otherwise the above should work well.
>
> That sounds like a bug we should fix regardless.

But I am not sure how it should behave. "git fetch $there A B C"
followed by "git merge FETCH_HEAD" merges only A, and I do not know
if people have come to depend on this behaviour.

I suspect there may be larger fallout from such a change, namely,
what should "git log FETCH_HEAD" do?  Should it traverse the history
starting from all things that are not marked as not-for-merge, or
should it just say "git rev-parse FETCH_HEAD" and use only the first
one as the starting point?

I would argue that it would be more consistent with how we envision
the "git merge FETCH_HEAD" should work if "git log FETCH_HEAD"
traversed from all fetched HEAD for merging, but surely it is a huge
potential incompatibility.

For that matter, "git rev-parse FETCH_HEAD" and even get_sha1() should
yield all fetched HEAD for merging if we want to be consistent.  I
haven't thought this through yet but it does not look pretty.
