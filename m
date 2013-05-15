From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: Lines missing from git diff-tree -p -c output?
Date: Wed, 15 May 2013 20:17:34 +0200
Message-ID: <20130515181734.GT25742@login.drsnuggles.stderr.nl>
References: <20130515143508.GO25742@login.drsnuggles.stderr.nl>
 <7vhai4cgco.fsf@alter.siamese.dyndns.org>
 <20130515173312.GR25742@login.drsnuggles.stderr.nl>
 <7v4ne4cexm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 15 20:17:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcgGl-0003dB-NW
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 20:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933031Ab3EOSRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 14:17:40 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:44846 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933011Ab3EOSRj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 14:17:39 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1UcgGc-0006g1-Ll; Wed, 15 May 2013 20:17:35 +0200
Received: (nullmailer pid 25666 invoked by uid 1000);
	Wed, 15 May 2013 18:17:34 -0000
Mail-Followup-To: Matthijs Kooijman <matthijs@stdin.nl>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v4ne4cexm.fsf@alter.siamese.dyndns.org>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224437>

Hi Junio,

> Could you explain why you think it hides the real problem, and what
> kind of future enhancement may break it?
I think the differences is mostly in the locality of the fix. In my
proposed patch, the no_pre_delete flag is never set on an interesting
line because it is checked in the line before it. In your patch, it
never happens because the control flow guarantees the "context" lines
before each change must be uninteresting.

The net effect is of course identical, but I'm arguing that depending on
the control flow and some code a doze lines down is easier to break than
depending on a previous line.

Having said that: I'm not sure if the difference is significant enough
to convince me in either direction.



However, thinking about this a bit more (and getting sidetracked on a
completely separate issue/question), I wonder why the coalescing-hunks
code is there in the first place? e.g., why not leave out these lines?

	if (k < j + context) {
		/* k is interesting and [j,k) are not, but
		 * paint them interesting because the gap is small.
		 */
		while (j < k)
			sline[j++].flag |= mark;
		i = k;
		goto again;
	}

If the "context" lines before and after each group of changes are
painted interesting, then these lines in between will also be painted
interesting. Of course, this could cause some lines to be painted as
interesting twice and it needs my fix for the no_pre_delete thing, but
it would work just as well?

However, I can imagine that this code is present to prevent painting
lines twice, which would of course be a bit of a performance loss. But
if this really was the motivation, why is the first if not something
like:

	if (k <= j + 2 * context) {

Since IIUC, the current code can still paint a few context lines twice
when they are exacly "context" lines apart, once by the "paint before"
and one by the "paint after" code (which is also what happens in my bug
example, I think). The above should "fix" that as well (the first part
of the test suite hasn't complained so far).

Gr.

Matthijs
