From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: multiple-commit cherry-pick?
Date: Fri, 14 Nov 2008 08:11:41 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0811140800540.3468@nehalem.linux-foundation.org>
References: <buoiqr18tdk.fsf@dhapc248.dev.necel.com> <20081106213711.GA4334@blimp.localdomain> <alpine.LFD.2.00.0811061925300.3451@nehalem.linux-foundation.org> <7vskq4gmf5.fsf@gitster.siamese.dyndns.org> <20081107071231.GA4063@blimp.localdomain>
 <alpine.LFD.2.00.0811071004170.3468@nehalem.linux-foundation.org> <20081109102528.GA5463@blimp.localdomain> <alpine.DEB.1.00.0811102054470.30769@pacific.mpi-cbg.de> <81b0412b0811101224gcffc958o6dbfcdc45e022874@mail.gmail.com> <alpine.DEB.1.00.0811102230330.30769@pacific.mpi-cbg.de>
 <20081114050822.GA23963@foursquare.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Chris Frey <cdfrey@foursquare.net>
X-From: git-owner@vger.kernel.org Fri Nov 14 17:13:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L11IZ-0001Xd-UG
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 17:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbYKNQMR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 11:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbYKNQMR
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 11:12:17 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46756 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751040AbYKNQMQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Nov 2008 11:12:16 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAEGBhc4006793
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Nov 2008 08:11:44 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mAEGBfaF000612;
	Fri, 14 Nov 2008 08:11:42 -0800
In-Reply-To: <20081114050822.GA23963@foursquare.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.432 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100984>



On Fri, 14 Nov 2008, Chris Frey wrote:
> 
> Would it be possible to add "range" support to a subset of commands by
> using a git-range wrapper?

It would be better to just extend the SHA-1 arithmetic. We could do it, no 
problem. It's just a SMOP.

For example, right now the arithmetic is entirely "flat", with no 
precedence, no nesting, nothing but a single level of set operations. We 
could extend it to be hierarchical.

So we _could_ do something like

	git log {a..b} {c..d ^e}

and just declare that { $args } is a self-contained "subset", and 
effectively becomes the same thing as "$(git rev-list $args)" but with 
magic no-walking semantics (ie all walking is done only _within_ the { }, 
not between different groups.

You literally _can_ do it right now that way:

	git log --no-walk $(git rev-list HEAD~5..HEAD~3) $(git rev-list HEAD~1..)

actually works, but that will hit argument size limits on many platforms 
really quickly.

So we could make a '{ }' in the argument space basically do a SHA1 
expansion of the range inside, and imply --no-walk. It's _not_ entirely 
trivial, because we'd need to handle the fact that object flags are 
sticky, and clear them in between invocations of multiple ranges, but it's 
not _fundmanetally_ difficult. It's just that somebody would need to do 
it.

		Linus
