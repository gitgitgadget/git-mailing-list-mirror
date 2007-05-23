From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Prevent megablobs from gunking up git packs
Date: Tue, 22 May 2007 17:28:33 -0700
Message-ID: <7v3b1o758u.fsf@assigned-by-dhcp.cox.net>
References: <46528A48.9050903@gmail.com> <f2uigr$ufj$1@sea.gmane.org>
	<56b7f5510705220959x1b37a4adk537cc0cba1a27530@mail.gmail.com>
	<200705230144.38290.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Dana How" <danahow@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 23 02:28:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqeiW-0007WA-IX
	for gcvg-git@gmane.org; Wed, 23 May 2007 02:28:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762081AbXEWA2g (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 20:28:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762196AbXEWA2g
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 20:28:36 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:52194 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761811AbXEWA2f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 20:28:35 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070523002834.GYJU22040.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 22 May 2007 20:28:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 2QUa1X00F1kojtg0000000; Tue, 22 May 2007 20:28:34 -0400
In-Reply-To: <200705230144.38290.jnareb@gmail.com> (Jakub Narebski's message
	of "Wed, 23 May 2007 01:44:37 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48135>

Jakub Narebski <jnareb@gmail.com> writes:

> No, I was thinking about separate _kept_ pack (so it would be not 
> repacked unless -f option is given) containing _only_ the large blobs.
> The only difference between this and your proposal is that megablobs
> would be in their mergablobs pack, but not loose.

I am not sure about the "unless -f option is given" part, but a
single .kept pack that contains only problematic blobs would be
an interesting experiment.

 (0) prepare object names of problematic blobs, in huge.txt, one
     object name per line;

 (1) prepare a single pack that has them:

     $ N=$(git-pack-object --depth=0 --window=0 pack <huge.txt)
     $ echo 'Huge blobs -- do not repack' >pack-$N.keep
     $ mv pack-$N.* .git/object/pack/.

 (2) repack the remainder, with the default depth/window:

     $ git repack -a -d
     $ git prune
