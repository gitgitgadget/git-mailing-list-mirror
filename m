From: Sam Vilain <sam@vilain.net>
Subject: Re: [SoC RFC] libsvn-fs-git: A git backend for the subversion filesystem
Date: Thu, 20 Mar 2008 17:31:57 +1300
Message-ID: <47E1E8BD.7000209@vilain.net>
References: <3e8340490803182108y40a9aec2q8e5bcb78b907bbb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bryan Donlan <bdonlan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 05:30:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcCPi-0004pP-0h
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 05:30:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbYCTE3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 00:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751177AbYCTE3P
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 00:29:15 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:52325 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751070AbYCTE3O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 00:29:14 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 514EC21C944; Thu, 20 Mar 2008 17:29:12 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.7-deb
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id 3938721C923;
	Thu, 20 Mar 2008 17:29:07 +1300 (NZDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <3e8340490803182108y40a9aec2q8e5bcb78b907bbb5@mail.gmail.com>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77623>

Bryan Donlan wrote:

> Here are some tentative milestones:
> * Read-only access from SVN to the master branch (no trunk/ etc layout)
>   = Conversion of git commit information into svn revprops
>   = git mode/.gitignore -> svn property conversion here?

This seems like a large milestone.  Can you break this up any more?

For instance, your design notes on storing the necessary mapping
information are good.  How about a separate milestone of having a test
suite for the library functions you make for accessing that information.

I would be tempted to check the protocol -
http://svn.collab.net/repos/svn/trunk/subversion/libsvn_ra_svn/protocol
- and make milestones for each request type that the protocol allows
for.  Perhaps there is a more relevant list that you can find, such as
groups of tests in the back-end test suite that ships with Subversion.
Even taking the list of svn sub-commands, and deciding which fit into
each category would be a good enhancement.

> * Read-write access from SVN to the master branch
>   = Map svn usernames to git full name/email according to a configuration map
>     - how should git commits with names unknown to svn be handled? Just pass
>       them through, spaces and <@> as well?

Meh.  Just ignore them, and set revprops with all of the git committer
information.

>   = Bidirectional svn:execute and svn:ignore conversion.
>   = Copyfrom and file property information needs to be recorded
>   = Test importing a largish repository (without converting merge information)
>     to git (the svn toplevel stuff would be left as-is in the git tree)
>   = Consider developing git-svn-fs on a git-svn-fs repository itself for
>     testing purposes

An honourable notion, but I'd steer away from worrying about
self-hosting, if it is irrelevant to the task at hand.  Focus more on a
finding a good test suite to check you supported all the operations.
Eg, can the test suite bundled with the Subversion project run against
your back-end?

> * Standard toplevel SVN layout (trunk/ tags/ branches/)
>   = SVN branch creation might come a bit later
>   = Test importing a largish repository with tags and branches carried across
>     (might not efficiently support copy-from information)
> * Merge information annotation (git->svn)
>   = Try to guess the copy source for a new tag or branch - and for merges

I don't like this word "guess".  It might be dangerous to not
deterministically or repeatably answer a request.  If any random
decisions were made, or information derived based on things that might
change, then it should be stored in your mapping information branch.  In
this instance, we didn't 'guess', we decided.

> * Merge information annotation (svn->git)
> * Import of a largish repository with svk or similar merge information into git,
>   and vice versa (eg, exporting git.git with merge tracking as a subversion
>   repo)

Whew!  That's a lot of big milestones, but it's your summer ... :)

I think the merging thing is a nice-to-have, and doing it would just
prove that you can use the metadata that you have collected well.

One thing I like about your approach is that the tracking branch itself
could be replicated, leaving an audit of what happened.

> === Interfaces ===
> 
> As mentioned before, this driver will plug into the existing subversion stack
> as a filesystem driver. This immediately allows access using any of subversion's
> access methods (direct filesystem access, mod_dav_svn, svnserve).
> 
> On the git side I intend to use libgit for all git repository access. If I find
> it lacking a necessary feature, I will attempt to add the missing interfaces
> to libgit if at all feasable.

AFAIK the interface for libgit is not yet finalized, so bear in mind the
application will possibly need porting work for each release.

Sam.
