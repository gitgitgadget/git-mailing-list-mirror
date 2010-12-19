From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2 2/4] diff.c: implement a sanity check for word regexes
Date: Sun, 19 Dec 2010 02:59:44 +0100
Message-ID: <201012190259.45301.trast@student.ethz.ch>
References: <cover.1292688058.git.trast@student.ethz.ch> <ee3026bd997fc6d8508b8e5617e572f99c8bf3d6.1292688058.git.trast@student.ethz.ch> <7vvd2qg5jj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Scott Johnson <scottj75074@yahoo.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Matthijs Kooijman <matthijs@stdin.nl>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 19 02:59:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PU8Yy-0001Fb-Fj
	for gcvg-git-2@lo.gmane.org; Sun, 19 Dec 2010 02:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235Ab0LSB7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 20:59:47 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:8716 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932191Ab0LSB7q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 20:59:46 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sun, 19 Dec
 2010 02:59:39 +0100
Received: from pctrast.inf.ethz.ch (217.162.250.31) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sun, 19 Dec
 2010 02:59:45 +0100
User-Agent: KMail/1.13.5 (Linux/2.6.37-rc5-desktop; KDE/4.5.3; x86_64; ; )
In-Reply-To: <7vvd2qg5jj.fsf@alter.siamese.dyndns.org>
X-Originating-IP: [217.162.250.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163946>

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > * The word regex matches anything that is !isspace().
> >
> > * The word regex does not match '\n'.  (This case is not very harmful,
> >   but we used to silently cut off at the '\n' which may go against
> >   user expectations.)
> 
> How expensive to run this check twice, every time word_regex finds a
> match?

It runs the first bullet point for every non-match, and the second
bullet point for every match.  So it looks at every input character
exactly once.

> As this is about making sure that we got a sane regex from the user (or a
> builtin pattern), I wonder if we can make it not depend on the payload we
> are matching the regex against.  Then before using a word_regex that we
> have not checked, we check if that regex is sane, mark it checked, and do
> not have to do the check over and over again.

Algorithmically it should be easy once you have the finite state
automaton corresponding to the regex: just verify that for every
possible non-terminal state, there is a transition for every
!isspace() character to a state other than "fail to match" or "match
the empty string".

In the implementation, it might be doable if we switch to compat/regex
on all platforms, since we then have ready access to all internal
structures regcomp() creates, including the DFA.

I'll think about at least using compat/regex for a static check of all
*builtin* patterns, which would be superior to the brute force
approach in 4/4.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
