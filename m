From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] Avoid loading commits twice in log with diffs
Date: Mon, 4 Mar 2013 10:58:54 +0100
Message-ID: <871ubvtrj5.fsf@pctrast.inf.ethz.ch>
References: <3193c96cf5b036a91bc78b508b8b30ac87ca0f21.1362218700.git.trast@student.ethz.ch>
	<7va9qlc690.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 04 10:59:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCSB2-0002qP-Pi
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 10:59:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757020Ab3CDJ66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Mar 2013 04:58:58 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:24730 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755831Ab3CDJ65 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Mar 2013 04:58:57 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 4 Mar
 2013 10:58:54 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 CAS21.d.ethz.ch (172.31.51.111) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 4 Mar 2013 10:58:54 +0100
In-Reply-To: <7va9qlc690.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 02 Mar 2013 23:06:03 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217395>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> Test                      with patch        before
>> --------------------------------------------------------------------
>> 4000.2: log --raw -3000   0.50(0.43+0.06)   0.54(0.46+0.06) +7.0%***
>> 4000.3: log -p -3000      2.34(2.20+0.13)   2.37(2.22+0.13) +1.2%
>> --------------------------------------------------------------------
>> Significance hints:  '.' 0.1  '*' 0.05  '**' 0.01  '***' 0.001
>
> It may be a silly question but what is a significance hint?

That's from my still-not-rerolled perf improvements series from, ahem,
ages ago:

  http://thread.gmane.org/gmane.comp.version-control.git/192884

I stole the idea from R (and in fact use R to compute it).  The ***
tells you that the probability of the 7% difference is attributable to
chance only with 0.1% probability, or in other words, it's highly likely
that the difference is *not* down to chance.  On the other hand, note
that the p4000.3 measurements do not show a significant difference
(significance hint is absent).

The statistical background: Assume that the two series of measurements
are drawn from two normal distributions (possibly with different
mean/variance).  Welch's t-test estimates the probability of the null
hypothesis that the two distributions in fact had the same mean.  If you
can reject the null hypothesis, you have essentially proven that there's
*some* difference in the timing runs.  (Hopefully for the better, and
hopefully _not_ caused just by CPU scaling or such.)

By the way, in the above test Jakub pointed me at the Dumbbench perl
module.  I've had a look at the ideas within, and I'll try to put some
sample rejection along their lines into perf-lib.  However, several
things make the module itself rather deserve the name.  Most
prominently, I can only get it to print timings to stdout in a fixed
format designed for human consumption.

>> --- a/log-tree.c
>> +++ b/log-tree.c
>> @@ -715,7 +715,7 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
>>  {
>>  	int showed_log;
>>  	struct commit_list *parents;
>> -	unsigned const char *sha1 = commit->object.sha1;
>> +	unsigned const char *sha1 = commit->tree->object.sha1;
>
> Overall I think this goes in the right direction and I can see why
> the changes in later two hunks are correct, but I am not sure if we
> can safely assume that the caller has parsed the incoming commit and
> we have a good commit->tree here already.
>
> Right now, this static function has a single call-site in a public
> function log_tree_commit(), whose existing callers may all pass an
> already parsed commit, but I feel somewhat uneasy to do the above
> without some mechanism in place (either parse it here or in the
> caller if unparsed, or document that log_tree_commit() must be
> called with a parsed commit and perhaps add an assert there) to
> ensure that the invariant is not broken in the future.

In that case I'll reroll with the parsing -- it will have about the same
cost as the assertion, since it'll just check ->object.parsed and
return.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
