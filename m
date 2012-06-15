From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v7 0/5] git log -L, all new and shiny
Date: Fri, 15 Jun 2012 15:29:26 +0200
Message-ID: <8762as4sax.fsf@thomas.inf.ethz.ch>
References: <cover.1339063659.git.trast@student.ethz.ch>
	<7vlijpchm2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>,
	Bo Yang <struggleyb.nku@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 15:29:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfWal-0000CF-0O
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 15:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756788Ab2FON3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 09:29:30 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:13543 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756294Ab2FON33 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 09:29:29 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 15 Jun
 2012 15:29:26 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 15 Jun
 2012 15:29:26 +0200
In-Reply-To: <7vlijpchm2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 14 Jun 2012 21:40:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200052>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> I too thought it would never happen -- but then again this is still
>> not ready, I'm just trying to give it some exposure.
>> ...
>> There's also a longer-term wishlist hinted at in the commit message of
>> the main patch: the diff machinery currently makes no provisions for
>> chaining its various bells and whistles.
>
> I am not convinced that it is "diff machinery makes no provivsions"
> that is the problem. Isn't it coming from the way the series limits
> the output line range and reimplements its own output routine?

Well, in a very circular logic sense, yes: I reimplement the output
routine because that's the only way I could think of doing it right now :-)

However, notice that word-diff also reimplements its own output routine,
though it probably has a better standing since it is a different format.

>  - add a mechanism to pass the "interesting" line range and path
>    down to the callchain from xdi_diff_outf() to xdiff_outf();
>
>  - make one of these functions filter out (i.e. not call the
>    callback xdiff_emit_consume_fn) hunks that do not overlap with
>    the line range you are interested in (I would presume that they
>    would be a few new fields in xdemitconf_t structure); and
>
>  - while recording the corresponding line ranges in the other side
>    of the hunks that are output,

Hrm.

This would be the first backwards coupling between the revision-walk and
the diff generation parts, at least that I know of.  Normally the
revision walker just calls out to the (line-wise, not tree-based) diff
engine when it wants to show a commit.  Now suddenly the diff engine is
used (a lot, too) in simplifying the history.

Ideally we would want to reuse diffs that have already been generated,
as this is a very expensive process.  The current log -L implementation
manages to do this at the cost of reimplementing the diff output
routines instead.

You solve it instead by mandating that the diff engine itself updates
the "interesting" ranges, but that needs a lot of inside knowledge: like
in blame, we sometimes explore alternatives (e.g. for merges; or with
-M, though log -L in this version does not implement that feature).

So we would end up with redoing diffs, or a very tight coupling, that
IMHO just makes the mess worse.

Or am I missing something?

I instead have the vision that eventually diffs should be represented
internally as something like my pairs of struct range_set.  Then we
could run more passes on them as needed, and have a "common currency"
between all diff-related work.  Only the last one should then actually
output the diff.

That still doesn't properly account for the case where the data format
is no longer in terms of hunks (such as for word-diff, or the stat
formats), though.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
