From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] log: use true parents for diff even when rewriting
Date: Tue, 23 Jul 2013 09:27:06 +0200
Message-ID: <87k3khpwhh.fsf@linux-k42r.v.cablecom.net>
References: <20130722090854.GA22222@pengutronix.de>
	<a598aec3e3c90de4d2c08e58ee0a4828edc80ac2.1374527806.git.trast@inf.ethz.ch>
	<7v61w2clli.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 23 09:27:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1X0A-0006Uo-NE
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jul 2013 09:27:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755185Ab3GWH1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jul 2013 03:27:13 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:32501 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754196Ab3GWH1L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jul 2013 03:27:11 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 23 Jul
 2013 09:27:05 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (217.235.0.128) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 23 Jul 2013 09:27:07 +0200
In-Reply-To: <7v61w2clli.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 22 Jul 2013 14:48:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [217.235.0.128]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231029>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> When using pathspec filtering in combination with diff-based log
>> output, parent simplification happens before the diff is computed.
>> The diff is therefore against the *simplified* parents.
>>
>> This works okay, arguably by accident, in the normal case: the pruned
>> commits did not affect the paths being filtered, so the diff against
>> the prune-result is the same as against the diff against the true
>> parents.
>>
>> However, --full-diff breaks this guarantee, and indeed gives pretty
>> spectacular results when comparing the output of
>>
>>   git log --graph --stat ...
>>   git log --graph --full-diff --stat ...
>>
>> (--graph internally kicks in parent simplification, much like
>> --parents).

Hmm, I stopped writing the message midway through.  There should be
another two paragraphs here about storing the original parent list on
the side for later use when showing the diff.

>> Perhaps like this.  It's getting a bit late, so I'm not sure if I'm
>> missing another user of the "true" parent list, but it does fix the
>> issue you reported.
>
> Conceptually I can see how this will change the history
> simplification in the vertical direction (skipping the ancestry
> chain and jumping directly to the closest grandparent that touched
> the specified path), but I am not sure how well this interacts with
> history simplification in the horizontal direciton (culling
> irrelevant side branches from the merge).

But isn't that similarly confusing for the user as Uwe's original
problem?  Suddenly we'd be showing a merge commit as an ordinary one,
simply because the merged history did not affect the filtered
pathspecs.  Thus we would show everything that has been merged on the
*other* files as a big diff.  Would that be useful?  It would certainly
be a big difference in how the commit is shown.

> I also have to wonder if we always want to incur this save-parents
> overhead, or we are better off limiting it to only when --full-diff
> is in effect.

I haven't quite convinced myself that it is 100% safe to use the
rewritten parents when --full-diff is not in effect...

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
