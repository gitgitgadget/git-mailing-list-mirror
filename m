From: Finn Arne Gangstad <finnag@pvv.org>
Subject: RFC/RFH submodule handling in big setups
Date: Mon, 7 Jan 2008 11:23:27 +0100
Message-ID: <20080107102327.GA12427@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 07 11:24:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBp9G-0000Rt-Ve
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 11:24:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874AbYAGKX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 05:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754267AbYAGKX3
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 05:23:29 -0500
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:48111 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753008AbYAGKX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 05:23:28 -0500
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.60)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1JBp8h-0002JT-JC
	for git@vger.kernel.org; Mon, 07 Jan 2008 11:23:27 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69780>

We're trying to get git to work well with our vision of submodules,
and have to figure out how to make submodule fetching and pushing work
in a smooth way.

This is our situation (simplified):

          [product1]          [product2]  ...         (supermodules)
           /      \             /     \
    ... [foo]  [os-abstraction-lib] [log-merger] ...  (submodules)


A developer does a modification to the os-abstraction-lib, and a
modification to the log-merger that depends on the change in the
os-abstraction-lib. He wants this into product2, and doesn't know or
care about product1.  He doesn't know whether his modification is
acceptable or not, or whether his modification will go in before some
other modification.

He needs some way of pushing his modifications to a branch in the
supermodule (e.g. "change-131345"), without interfering with anyone
else.  The problem is where to push the sub-modules, they need to be
available for anyone who wants to get the "change-131345" branch of
the product2, but the modifications shouldn't show up anywhere else
(yet).  Here are solutions we have thought of so far:

1. push and fetch sha1s directly - this was sort of vetoed on this list.

2. each time you push a submodule, push it to a auto-generated
   tag (something like submodule-autogen-<sha1>), and use fetch -t
   when fetching the submodules

   Issue: Need to clean up these tags at some point, or there will be too
   many of them. There will be many ugly tags no matter what.

3. each time you push a submodule, do a merge ours to a
   "internal-submodule-tracking" branch, and push to that. Something
   like this in other words:

     git fetch origin internal-submodule-tracking
     git merge -s ours origin/internal-submodule-tracking
     git push origin internal-submodule-tracking
     git reset --hard HEAD^1

   Issue: feels wrong somehow?

4. Manually push all sub-modules to some new branch before pushing the
   super-module. This is what we'd rather avoid, but the developer
   should obviously have the option of doing this to some sub-modules
   if he wants to.

5. Secret option 5 - something we didn't think about

- Finn Arne
