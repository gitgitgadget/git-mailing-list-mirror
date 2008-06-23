From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 16:51:52 -0700
Message-ID: <7v8wwvg15z.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org>
 <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org>
 <20080623183358.GA28941@sigill.intra.peff.net>
 <alpine.LFD.1.10.0806231137070.2926@woody.linux-foundation.org>
 <alpine.LFD.1.10.0806231158340.2926@woody.linux-foundation.org>
 <20080623210935.GC13395@artemis.madism.org>
 <alpine.LFD.1.10.0806231425270.2926@woody.linux-foundation.org>
 <7v3an3hke8.fsf@gitster.siamese.dyndns.org>
 <20080623222404.GM13395@artemis.madism.org>
 <7vmylbg4ks.fsf@gitster.siamese.dyndns.org>
 <20080623233146.GP13395@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 01:53:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAvqS-0001Lx-5r
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 01:53:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbYFWXwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 19:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754574AbYFWXwJ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 19:52:09 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50266 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752518AbYFWXwI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 19:52:08 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9213C10E98;
	Mon, 23 Jun 2008 19:52:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 9B49710E94; Mon, 23 Jun 2008 19:52:00 -0400 (EDT)
In-Reply-To: <20080623233146.GP13395@artemis.madism.org> (Pierre Habouzit's
 message of "Tue, 24 Jun 2008 01:31:46 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 62D61B20-417F-11DD-A22C-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85955>

Pierre Habouzit <madcoder@debian.org> writes:

>   Unrelated but worth to note: many parse_options users just don't care
> about argv[0] and having it kept each time would rather be a pain for
> them (they would need to call argv++, argc-- themselves).

Not necessarily.  If they were parsing by hand, they were written to deal
with the fact that argv[0] is not the program argument (iow, they start
counting from one).  And before and after calling parse_options(), they
need to change that assumption anyway, because parse_options() makes
argv[0] disappear.

See for example these:

 * 5eee6b2 (Make builtin-reset.c use parse_options., 2008-03-04)
	The caller used to start counting from 1, after the conversion it
	has to count from 0.

 * 8320199 (Rewrite builtin-fetch option parsing to use parse_options()., 2007-12-04)
 * 3968658 (Make builtin-tag.c use parse_options., 2007-11-09)
	The caller used to say (i==argc) is "no param" case, now it has to
	say "!argc" is the equivalent condition.

I am not saying that forcing these callers to change their loop invariants
in order to use parse_options() was bad.  I am saying that your "would
rather be a pain for them" is a bogus argument --- they needed to pay that
price when converting to parse_options() that munges argv[0] anyway.

But this argv[0] munging exactly is why parse_options() hurts users who
want to cascade option parsing.

Didn't one of the recent series have an option to tell parse_options() to
start parsing from argv[0] (persumably because it got an argument array
from somebody who munges it to drop argv[0])?  I think it was merge-in-C
from Miklos, but the approach feels very much backwards.  The caller
should be (at least) able to choose to say KEEP_ARGV0 like one of your
patch does.
