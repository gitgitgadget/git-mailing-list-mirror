From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-bundle: Make thin packs
Date: Wed, 07 Mar 2007 18:02:04 -0800
Message-ID: <7v4powebmr.fsf@assigned-by-dhcp.cox.net>
References: <45ECEB40.4000907@gmail.com>
	<7vejo2stlw.fsf@assigned-by-dhcp.cox.net> <45EE1242.8080405@gmail.com>
	<7vhcsxkb8n.fsf@assigned-by-dhcp.cox.net> <45EE2ECA.60403@gmail.com>
	<Pine.LNX.4.63.0703070419410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45EE36A1.30001@gmail.com>
	<Pine.LNX.4.63.0703070504140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<30e4a070703070834s3dd5bdd7x2e1639aa2979d1cf@mail.gmail.com>
	<Pine.LNX.4.63.0703072330200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0703071516330.5963@woody.linux-foundation.org>
	<Pine.LNX.4.63.0703080121210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 08 03:02:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP7xR-0000JP-Sx
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 03:02:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbXCHCCJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 21:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751816AbXCHCCJ
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 21:02:09 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:44358 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751723AbXCHCCH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 21:02:07 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070308020206.WQMT748.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Mar 2007 21:02:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Y2241W0161kojtg0000000; Wed, 07 Mar 2007 21:02:05 -0500
In-Reply-To: <Pine.LNX.4.63.0703080121210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 8 Mar 2007 01:27:44 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41710>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This commit also changes behaviour slightly: since we now know early 
> enough if a specified ref is _not_ contained in the pack, we can avoid 
> putting that ref into the pack. So, we don't die() here, but warn() 
> instead, and skip that ref.

I am a bit worried about that part.  

If somebody says "bundle create foo.bdl --since=1.day maint" and
maint's tip hasn't changed for a month, we would end up having
no refs and no pack in the bundle with just a warning.

"bundle create foo.bdl -20 master next" does _not_ mean "20 revs
but at least have master and next tip", but it may surprise an
uninitiated to find out that running "bundle list foo.bdl" on
the resulting bundle did not talk about master at all.

I have a feeling that it would avoid confusion if we did not
even start the pack generation and die early when we find the
counting caused us not to include all the positive refs
specified on the command line.
