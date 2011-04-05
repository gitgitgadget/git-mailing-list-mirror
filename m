From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 4/4] builtin/show: do not prune by pathspec
Date: Tue, 05 Apr 2011 08:06:51 +0200
Message-ID: <4D9AB17B.70409@drmicha.warpmail.net>
References: <7vwrjfjdqr.fsf@alter.siamese.dyndns.org> <cover.1301649372.git.git@drmicha.warpmail.net> <6509d23c538dfabd4fac8870d29a69b1dd11a516.1301649372.git.git@drmicha.warpmail.net> <7v1v1h8z5k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?B?Tmd1eeG7hQ==?= =?UTF-8?B?biBUaMOhaSBOZ+G7jWMgRHV5?= 
	<pclouds@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 05 08:10:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6zTM-0001Q4-AQ
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 08:10:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221Ab1DEGK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 02:10:26 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:33533 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751150Ab1DEGKZ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Apr 2011 02:10:25 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 2DFE020D59;
	Tue,  5 Apr 2011 02:10:25 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 05 Apr 2011 02:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=j0Uy98fVy+jVYWEpaa4pzNZPNlE=; b=pl5Jate3CR2YZRH7B6ZMzMgcfPLmgjqxPEcp3J6SIDzPYtAkYnpCOXK8ULblt8sMc5HIVv6jFyRiOs34L8e265VGlRXIyitWZgv4kgGhMHpb6U1fUoLiuI88m+HdZZ8upFLGi1BRr52+8MHeMzpc4MBSIjcNx4BkzkOnGUf2Wfk=
X-Sasl-enc: BIIsSxkOOOErlkrEv2BwTNKIZBRtBvEs2jc5DLy1xm/J 1301983824
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 009CA443101;
	Tue,  5 Apr 2011 02:10:23 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7v1v1h8z5k.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170869>

Junio C Hamano venit, vidit, dixit 04.04.2011 23:49:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> diff --git a/builtin/log.c b/builtin/log.c
>> index 916019c..474a76d 100644
>> --- a/builtin/log.c
>> +++ b/builtin/log.c
>> @@ -420,6 +420,8 @@ int cmd_show(int argc, const char **argv, const char *prefix)
>>  	opt.def = "HEAD";
>>  	opt.tweak = show_rev_tweak_rev;
>>  	cmd_log_init(argc, argv, prefix, &rev, &opt);
>> +	if (rev.no_walk)
>> +		rev.prune = 0;
> 
> This is not your fault, but I am somewhat disgusted by the reason why
> 
>     $ git show master..next [ -- Documentation ]
> 
> works by "walking" the history.  It takes completely different codepath
> from "git log" with the same set of arguments.
> 
>  * first log_init() grabs '^master' and 'next' into the rev.pending object
>    array;
> 
>  * we pop '^master' first, make it the only object in the rev.pending
>    object array, and let cmd_log_walk() call prepare_revision_walk() on it
>    to limit the list.  Since we don't have any positive ref, we get
>    nothing;
> 
>  * then we pop 'next', make it again _the only_ object in the rev.pending
>    object array; prepare_revision_walk() on the same codepath now limits
>    the list to exclude what is reachable from 'master', only because we
>    have processed '^master'.
> 
> Yikes.  In other words, the reason the current code works is only by
> accident.

That is super ugly, yes.

> 
> This is a tangent, but we _might_ want to (perhaps at git 2.0) update the
> revision parsing machinery so that we can clear the object flags more
> easily and have
> 
>     $ git log A..B C..D [ -- pathspec ]
> 
> compute the union of (commits reachable from B but not from A) and
> (commits reachable from D but not from C).  I say we _might_ because we
> would still want to compute what the current code computes in some cases,
> and we may be able to express it as "^A ^C B D", but I am not sure if we
> want to go that route and end up with a general set operation (with unions
> and intersections, perhaps even using parentheses to express precedence).
> 
> More general set operation is certainly doable, and at that point it
> probably does not matter that we cannot stream the output as we are doing
> something complex (IOW, we would be revs->limited, giving up the latency),
> but I don't know if it is useful in the first place to support such
> general case.  Because the most complex set operations that I run every
> day is
> 
>     $ git log ^master $topic1 $topic2 $topic3... -- $pathspec
> 
> and I don't recall cases in which I wished A..B C..D showed commits
> within A..B that are reachable from C.
> 

We seem to promise that one should think in terms of sets, and this
breaks with "A..B" and "C...D" unless one always thinks of them in the
resolved form "^A B" and "^E C D" (with E=$(git merge-base C D)).

I also think that "A...B C" treats C as the right of that symmetric
range (because anything non-left we treat as right), and "A...B ^C"
probably interacts badly with --cherry-pick (though I haven't tried).

Also, "A...B C...D" would be a candidate for union. Lot's to do for
after 1.7.5...

Michael
