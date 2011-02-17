From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 2/2] git-p4: Improve branch support
Date: Thu, 17 Feb 2011 10:42:34 -0800
Message-ID: <20110217184234.GB20627@honk.padd.com>
References: <1297813789-3831-1-git-send-email-vitor.hda@gmail.com>
 <1297813789-3831-3-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 19:42:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq8oL-00050U-07
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 19:42:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752519Ab1BQSmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 13:42:36 -0500
Received: from honk.padd.com ([74.3.171.149]:34589 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699Ab1BQSmf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 13:42:35 -0500
Received: by honk.padd.com (Postfix, from userid 7770)
	id 7A5A820AB; Thu, 17 Feb 2011 10:42:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1297813789-3831-3-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167100>

vitor.hda@gmail.com wrote on Tue, 15 Feb 2011 23:49 +0000:
> Add new config option branchUser to allow filtering P4 branch list by user.
> Allow defining the branch list through branchList config option.
> Correct base branch directory detection to use '/' as the split character.

I've only been avoiding reading this one because I don't use
branches, and am having a hard time following what the point
of the change is.  Maybe someone else will notice that this is
a good change straightaway, and save you the bother of explaining
it to me.

The whole detectBranches option seems a bit spotty, given its
lack of documentation and numerous shady "## HACK" and "## FIXME"
comments.  So it certainly does appreciate your attention.

As far as I can tell, a branch is just a mapping between two
areas of the repo, and all you can do with one is to feed it
to "p4 integrate" instead of giving a single explicit src/dest.

> @@ -1272,7 +1277,13 @@ class P4Sync(Command):
>      def getBranchMapping(self):
>          lostAndFoundBranches = set()
>  
> -        for info in p4CmdList("branches"):
> +        user = gitConfig("git-p4.branchUser")
> +        if len(user) > 0:
> +            command = "branches -u %s" % user
> +        else:
> +            command = "branches"
> +
> +        for info in p4CmdList(command):

This part is for branches -u, to limit the auto-detected braches
to just those created by a given user.

> @@ -1305,6 +1316,12 @@ class P4Sync(Command):
>          for branch in lostAndFoundBranches:
>              self.knownBranches[branch] = branch
>  
> +        configBranches = gitConfigList("git-p4.branchList")
> +        for branch in configBranches:
> +            if branch:
> +                (source, destination) = branch.split(":")
> +                self.knownBranches[destination] = source
> +

This bit adds more branches, if you have put them in .git/config
separated by a :.  Presumably things that are directories in the
depot but do _not_ have a branch?  I don't get it.  What does
your depot look like and what do you stick in branchList?

>          branches = p4BranchesInGit(self.importIntoRemotes)
>          for branch in branches.keys():
> @@ -1626,12 +1643,14 @@ class P4Sync(Command):
>                      else:
>                          paths = []
>                          for (prev, cur) in zip(self.previousDepotPaths, depotPaths):
> -                            for i in range(0, min(len(cur), len(prev))):
> -                                if cur[i] <> prev[i]:
> +                            prev_list = prev.split("/")
> +                            cur_list = cur.split("/")
> +                            for i in range(0, min(len(cur_list), len(prev_list))):
> +                                if cur_list[i] <> prev_list[i]:
>                                      i = i - 1
>                                      break
>  
> -                            paths.append (cur[:i + 1])
> +                            paths.append ("/".join(cur_list[:i + 1]))

This was a bug?  I guess somehow this is adapting the existing
depot paths to include new ones that you discovered with "p4
branches".  And now you are comparing the path elements instead
of going a character at a time.  Maybe to catch //depot/ab vs
//depot/ac ?

In other words, add some comments or add something to the commit
text.  It is encouraged to split up a patch into the smallest
logical chenk if the changes are all independent.  Maybe these
three are related through the theme of auto-branch detection.

		-- Pete
