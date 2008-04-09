From: Teemu Likonen <tlikonen@iki.fi>
Subject: Friendly refspecs (Was: Re: git annoyances)
Date: Wed, 9 Apr 2008 23:08:36 +0300
Message-ID: <20080409200836.GA19248@mithlond>
References: <20080409101428.GA2637@elte.hu> <20080409145758.GB20874@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 09 22:09:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjgc6-00082c-Ca
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 22:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754451AbYDIUIu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 16:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754292AbYDIUIu
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 16:08:50 -0400
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:41041 "EHLO
	pne-smtpout4-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752452AbYDIUIt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Apr 2008 16:08:49 -0400
Received: from mithlond (80.220.180.181) by pne-smtpout4-sn1.fre.skanova.net (7.3.129)
        id 47A7970A003ACCF4; Wed, 9 Apr 2008 22:08:37 +0200
Received: from dtw by mithlond with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1Jjgay-0005Hy-Aj; Wed, 09 Apr 2008 23:08:36 +0300
Mail-Followup-To: Jeff King <peff@peff.net>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080409145758.GB20874@sigill.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79129>

Jeff King wrote (2008-04-09 10:57 -0400):

>   git-fetch <options> <repository> <refspec>

I have found this refs/heads/*:refs/remotes/* stuff quite confusing, but
I'm starting to understand them. I know my way with them but still they
seem quite unnecessary hackerish. Pull and push work pretty nicely
without knowing about any refs/* stuff; they can be operated with simple
branch names. Fetch is another story. Some ideas:

  $ git fetch <URL>

would be equivalent to

  $ git fetch <URL> +refs/heads/*:refs/remotes/<name>/*

In other words, fetch all the branches from remote repo and store them
locally as remote tracking branches to <name>/ hieararchy. The <name> is
the last component taken from the <URL> (maybe "origin" if it can't be
detected). 

Currently "git fetch <URL>" does not seem to do anything useful for
non-git-hackers. It seems to fetch objects but not create any branches
referring to them. As a comparison, let's configure a remote and run
similar fetch command without any refspecs explicitly named:

  $ git remote add <name> <URL>
  $ git fetch <name>

Now this fetch really creates all the branches (as defined in
remote.<name>.fetch) which is nice and the way Git currently works.

So would it be any good if "git fetch <URL>" without refpecs would use
+refs/heads/*:refs/remotes/<name>/* ? In any case the current behaviour
seems quite unfriendly.

Some more ideas for simple refspecs:

  $ git fetch <URL|name> <branch>

would be equivalent to

  $ git fetch <URL|name> +refs/heads/<branch>:refs/remotes/<name>/<branch>

Again the same behaviour with <URL> and configured remote <name>. In the
<URL> case the <name> is the last component of the <URL>.

  $ git fetch <URL|name> <Rbranch>:<Lbranch>

would be equivalent to

  $ git fetch <URL|name> +refs/heads/<Rbranch>:refs/remotes/<Lbranch>

Note that by giving the destination branch (the right side of colon) the
new remote tracking branch would be created directly to the
refs/remotes/ hierarchy, not to refs/remotes/<name>/ hierarchy like in
previous examples. This lets user a bit more control as she decided to
give <Lbranch> explicitly. User may want to give refspec
master:<name>/master to have new branch created as
refs/remotes/<name>/master.

With above example commands it is not possible to fetch remote branches
and store refs locally to refs/heads/ hierarchy. For this it would
either need another step - "git branch my-branch <name>/master" - or use
the long refspec form with fetch:
+refs/heads/master:refs/heads/my-branch .

Does this sound any good?
