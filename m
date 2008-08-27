From: Karl Chen <quarl@cs.berkeley.edu>
Subject: Re: [PATCH] be paranoid about closed stdin/stdout/stderr
Date: Tue, 26 Aug 2008 20:05:35 -0700
Message-ID: <quack.20080826T2005.lthzlmz2m4g@roar.cs.berkeley.edu>
References: <quack.20080825T0128.lthr68djy70@roar.cs.berkeley.edu>
	<48B28CF8.2060306@viscovery.net> <48B29C52.8040901@gnu.org>
	<E1KXawS-0001gg-Ty@fencepost.gnu.org> <48B2AFC2.20901@viscovery.net>
	<7vbpzgb94q.fsf@gitster.siamese.dyndns.org>
	<E1KXsL9-0004ef-Co@fencepost.gnu.org> <48B3A948.3080800@viscovery.net>
	<7vsksrad7o.fsf@gitster.siamese.dyndns.org> <48B44C61.2020206@gnu.org>
	<7vabez2yac.fsf@gitster.siamese.dyndns.org>
	<7v3akr2xa3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 05:06:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYBMs-0003WI-Kj
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 05:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbYH0DFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 23:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752606AbYH0DFl
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 23:05:41 -0400
Received: from roar.CS.Berkeley.EDU ([128.32.36.242]:42952 "EHLO
	roar.quarl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752584AbYH0DFk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 23:05:40 -0400
Received: by roar.quarl.org (Postfix, from userid 18378)
	id EBB2634599; Tue, 26 Aug 2008 20:05:35 -0700 (PDT)
X-Quack-Archive: 1
In-Reply-To: <7v3akr2xa3.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Tue\, 26 Aug 2008 16\:04\:36 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93847>

>>>>> On 2008-08-26 16:04 PDT, Junio C Hamano writes:

    Junio> I think

    Junio> 	$ git fetch 0<&-

    Junio> from the command line is a mere user stupidity.

    Junio> On the other hand, if a cron/at job that contains "git
    Junio> fetch" is launched in an environment with fd#0 (or #1
    Junio> or #2 for that matter) closed, it would certainly be
    Junio> problematic.  It can easily be worked around by
    Junio> redirecting file descriptors appropriately in the
    Junio> script that is launched, though.

I agree command-line 'git fetch 0<&-' is silly.  The example I
gave was minimized to show the symptom.  I ran across this with a
more complicated cron-ish setup that closes stdin.  I actually had
to look up the shell syntax for closing file descriptors.

Yes, I can work around this issue with sh -c 'git fetch
0</dev/null', and maybe it shouldn't close(0) in the first place.
But I don't see the harm in being safe.  It's one less potential
surprise for users.  This is the first program I've encountered
that broke due to stdin being closed, and it took debugging to
figure out that was the reason.

Re security, it's actually a good idea to be safe early on if it
could ever become an issue.  I keep /etc on my systems in version
control, and I've worked in production environments where some
users have access only via version control commands.
