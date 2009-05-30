From: Nick Woolley <nickwoolley@yahoo.co.uk>
Subject: [RFC] git-cvs script
Date: Sat, 30 May 2009 14:41:39 +0100
Message-ID: <4A213793.3030205@yahoo.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 30 15:42:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAOp0-0006v9-R9
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 15:42:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbZE3Nla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2009 09:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758673AbZE3Nla
	(ORCPT <rfc822;git-outgoing>); Sat, 30 May 2009 09:41:30 -0400
Received: from udon.noodlefactory.co.uk ([80.68.88.167]:49664 "EHLO
	udon.noodlefactory.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631AbZE3Nl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2009 09:41:29 -0400
Received: from 87-194-154-6.bethere.co.uk ([87.194.154.6] helo=[192.168.0.101])
	by udon.noodlefactory.co.uk with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <nickwoolley@yahoo.co.uk>)
	id 1MAOoT-0005HQ-TP
	for git@vger.kernel.org; Sat, 30 May 2009 14:41:30 +0100
User-Agent: Thunderbird 2.0.0.21 (X11/20090318)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120351>

Hi,

I have script which wraps git-cvsimport and git-cvsexport, called "git-cvs".

The main aim of the script is to automate the steps for tracking a CVS
repository with the git-cvs* commands.

It's not currently as sophisticated as git-svn, it's undoubtably flawed and
isn't foolproof (e.g. exports to CVS of merged git histories can be
problematic), but I find it useful, because a lot of the nitty-gritty is done
for me.

I'd like to ask:

 - Is this at all useful to anyone else in it's current form?

 - Is there any prior art I should be aware of? (Presumably most people
   just roll their own scripts, like I have)

 - Bearing in mind that it's a work-in progress, are there any suggestions for
   improvement?


The script can be found in its current state here:

 http://github.com/wu-lee/git-cvs/


There's no installer, but the script is self-contained and just needs to be on
the execution $PATH (as well as git and cvs).

Given a CVS repository at $CVS_ROOT, tracking a module $CVS_MODULE can be done
like this:

 # Create a git repo
 git init

 # Initialise git-cvs's config file
 echo cvsroot=$CVS_ROOT      >.git-cvs
 echo cvsmodule=$CVS_MODULE >>.git-cvs

 # First pull gets cvs files using git-cvsimport
 # (optionally you can supply the option
 # --author-file <authormap> for pass-through
 # to git-cvsimport -A on subsequent invocations)
 git-cvs pull

 # hack hack...

 # Push the files back into CVS with git-cvsexportcommit
 # (This pushes the commits master..remotes/cvs/cvshead by default,
 # or cvsworking/NAME..remotes/cvs/NAME for each CVS branch NAME)
 git-cvs push

 # Pull the changes back into remote/cvs/cvshead and
 # (a messy part I've not found a way round yet) throw away our
 # locally merged commits
 git-cvs pull
 git reset --hard master

 # More hacking...

 # Repeat push/pull steps as needed


Some other points:

 - Changes in CVS get pulled back, including multiple branches.

 - An author-mapping file can be supplied as for cvs-import -A

 - The script creates local CVS working directories
   .git/git-cvs/cvscheckout/NAME, one for each CVS branch NAME.

 - Git's master branch tracks CVS's HEAD branch.

 - A git branch cvsworking/NAME is created to track each CVS branch NAME.

 - Edits in these branches get pushed back to the appropriate CVS branches.

 - Verbose subcommand output currently goes into .git/git-cvs/logs.

 - Invoking git-cvs with no parameters gets information about the options.

 - In an emergency, a list of commit ids can be supplied to git-cvs push.

 - Written in Perl, uses only core modules (tested with v5.8.8)

 - There is a small test suite in t/, run individually or with "prove/*.t"



Thanks,

Nick
