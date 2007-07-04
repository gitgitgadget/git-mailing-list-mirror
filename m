From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: fix for "gitk <ambiguous-name> --"
Date: Wed, 04 Jul 2007 09:58:03 -0700
Message-ID: <7v1wfohzs4.fsf@assigned-by-dhcp.cox.net>
References: <20070703202301.GA24071@informatik.uni-freiburg.de>
	<Pine.LNX.4.64.0707032248570.4071@racer.site>
	<alpine.LFD.0.98.0707031514160.9434@woody.linux-foundation.org>
	<Pine.LNX.4.64.0707032353330.4071@racer.site>
	<18059.31237.286280.566140@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Uwe Kleine-K?nig <ukleinek@informatik.uni-freiburg.de>,
	git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Jul 04 18:58:12 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I68B8-0004rG-W2
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 18:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754460AbXGDQ6I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 12:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753089AbXGDQ6H
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 12:58:07 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:46020 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958AbXGDQ6G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 12:58:06 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070704165805.YORL1257.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Wed, 4 Jul 2007 12:58:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KUy31X00e1kojtg0000000; Wed, 04 Jul 2007 12:58:04 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51625>

Paul Mackerras <paulus@samba.org> writes:

> Junio: there seems to be an inconsistency between git rev-list and git
> rev-parse here.  If a name is both a filename and a ref, git rev-list
> will give a fatal error but git rev-parse will take it as a ref.

	$ rev-parse --no-revs --no-flags gitk -- gitk
	$ rev-parse --no-revs --no-flags -- gitk

should give you the path "gitk", while

	$ rev-parse --revs-only --no-flags gitk -- gitk
	$ rev-parse --revs-only --no-flags gitk --

should give you the revision (i.e. branch name) "gitk", I think.

But it is not well defined what it should do upon

	$ rev-parse --no-flags gitk
	$ rev-parse gitk

Currently they treat "gitk" as a ref.  On the other hand, as you
said:

	$ rev-list gitk

would error out without leading or traiing -- to disambiguate.

So you are right that they behave differently.

It might be an improvement to make rev-parse require leading or
trailing -- in such a case, but I haven't thought through the
ramifications of such a change.  Quite a lot of existing users
expect "rev-parse foo" to favor a ref "foo" over a file "foo"
and give its object name.
