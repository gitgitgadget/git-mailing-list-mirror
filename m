From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suggestion: make --left-right work with --merge
Date: Thu, 28 Feb 2008 23:32:40 -0800
Message-ID: <7vprugdxpj.fsf@gitster.siamese.dyndns.org>
References: <18372.53155.854763.12637@cargo.ozlabs.ibm.com>
 <7v7igqyii9.fsf@gitster.siamese.dyndns.org>
 <18373.58839.636432.448970@cargo.ozlabs.ibm.com>
 <7v1w6yqaim.fsf@gitster.siamese.dyndns.org>
 <18374.39253.408961.634788@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Feb 29 08:33:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUzki-0002sE-Pq
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 08:33:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753356AbYB2Hc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 02:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753015AbYB2Hc5
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 02:32:57 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55993 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbYB2Hc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 02:32:56 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 329481235;
	Fri, 29 Feb 2008 02:32:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 41D9F1234; Fri, 29 Feb 2008 02:32:46 -0500 (EST)
In-Reply-To: <18374.39253.408961.634788@cargo.ozlabs.ibm.com> (Paul
 Mackerras's message of "Thu, 28 Feb 2008 22:21:57 +1100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75508>

Paul Mackerras <paulus@samba.org> writes:

> Junio C Hamano writes:
>
>> Yeah, the option list is not maintained well for the last few
>> years and needs to be updated.
>
> Ah.  OK.  I am currently using git rev-parse in the gitk dev branch to
> determine what starting commits git log will use, so that when the
> user does an update, I can construct a git log command that will stop
> when it gets to any of those previous starting points.  That way the
> second git log will only give me new stuff that has been added since
> the first git log.

Doesn't

	git rev-parse --revs-only --no-flags "$@" | grep '^[0-9a-f]'

give you what you want?

Interesting.

 * gitk has already done what the user asked once.  E.g. "git
   log next..master" to find out new trivially correct fixes
   that are already applied to 'master' and will be brought to
   'next' when I merge 'master' to 'next' next time;

 * The user does "git merge master" while on 'next', and tell
   gitk to "Update".

 * gitk is expected to re-run "git log next..master" (textually
   the same command line), but most part of the graph it already
   knows about.  You need a way to omit what you already know,
   so when you run the query for the first time you would want
   to remember the actual object names, so that you use them to
   tweak the query to "git log next..master --not <positive ones
   in the first round>" for the second query.

In the above example, the set of commits actually will shrink
('next' moves and you will exclude more than before upon
"Update").

If you are only interested in cases that the only positive end
grows (in the above example, the user adds commit to 'master'
instead of merging it into 'next'), then grabbing only the
positive ends (e.g. 'master' in 'next..master'), negate them and
append them to the original query would speed things up, but
obviously that would not work in the above example.

