From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-bundle: fix pack generation.
Date: Wed, 07 Mar 2007 15:32:11 -0800
Message-ID: <7vfy8geikk.fsf@assigned-by-dhcp.cox.net>
References: <45ECEB40.4000907@gmail.com>
	<7vejo2stlw.fsf@assigned-by-dhcp.cox.net> <45EE1242.8080405@gmail.com>
	<7vhcsxkb8n.fsf@assigned-by-dhcp.cox.net> <45EE2ECA.60403@gmail.com>
	<Pine.LNX.4.63.0703070419410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45EE36A1.30001@gmail.com>
	<Pine.LNX.4.63.0703070504140.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<30e4a070703070834s3dd5bdd7x2e1639aa2979d1cf@mail.gmail.com>
	<Pine.LNX.4.63.0703072330200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mlevedahl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 08 00:32:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP5cQ-0002Fo-0j
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 00:32:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992742AbXCGXcP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 18:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992740AbXCGXcO
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 18:32:14 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:41616 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992734AbXCGXcN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 18:32:13 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070307233212.ESQG1226.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Mar 2007 18:32:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XzYB1W00j1kojtg0000000; Wed, 07 Mar 2007 18:32:12 -0500
In-Reply-To: <Pine.LNX.4.63.0703072330200.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 7 Mar 2007 23:35:06 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41704>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 7 Mar 2007, Mark Levedahl wrote:
>
>> On 3/6/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>> > 
>> > > git-bundle create test.bdl HEAD --since=1.day.ago ==>> pack with 
>> > > 1531 objects
>> > 
>> > Did you test with "--since=1.day.ago HEAD", i.e. with the correct 
>> > order? I know you'd like the options to be interminglable, but "HEAD" 
>> > really is not an option, but an argument.
>> 
>> Changing the order of arguments makes no difference, same result either 
>> way.
>
> We don't do thin packs. Should we? I guess that 
>
> 	$ git ls-tree -r HEAD | wc
>
> results in something close to 1500 in that repo. Which basically means 
> that the 1531 objects (including trees and the commit) sounds correct.

We should do thin packs, but 1500+ objects is a different story.

	rev-list --objects <revspec>

means "show me the revs and its objects".

	rev-list --max-count=<n> <revspec>

means "show me the revs and its objects, but stop at <n> revs".

On the other hand, 

	rev-list --objects ^<rev1> <rev2>

means something totally different.  "never show me what is
reachable from <rev1> but I am interested to see what are
reachable from <rev2>".

So it is natural that "rev-list --objects --max-count=1 HEAD"
shows the same set of tree and blob objects as "git-tar HEAD".
"show me the revs and its objects" does not say "but exclude
trees and blobs reachable from commits beyond the <n> revs
boundary," which is "rev-list --objects HEAD^..HEAD".

In other words, "rev-list -1 HEAD" and "rev-list HEAD^..HEAD"
are _different_.

We fixed (in 'next') the revision traversal so that --max-count
and --boundary interact correctly.  What's not fixed is that we
still use "rev-list --objects --max-*" given by the user, which
is not the semantics git-bundle wants.  We should rewrite the
revspec to drive pack-objects when generating the packfile part
of the bundle to do "<revs> --not <boundaries>" internally in
git-bundle.
