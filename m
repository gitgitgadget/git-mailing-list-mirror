From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Questions about git-rev-parse
Date: Tue, 27 Feb 2007 19:19:54 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702271905200.12485@woody.linux-foundation.org>
References: <E1HMETh-0004BO-Lw@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 28 04:20:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMFMR-0005vw-W9
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 04:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbXB1DT4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 22:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbXB1DT4
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 22:19:56 -0500
Received: from smtp.osdl.org ([65.172.181.24]:36770 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750773AbXB1DTz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 22:19:55 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1S3JYhB029242
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Feb 2007 19:19:34 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1S3JXxh005169;
	Tue, 27 Feb 2007 19:19:34 -0800
In-Reply-To: <E1HMETh-0004BO-Lw@candygram.thunk.org>
X-Spam-Status: No, hits=-0.444 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40881>



On Tue, 27 Feb 2007, Theodore Ts'o wrote:
> 
> So I was looking at git-rev-parse trying to understand the man page, as
> I was trying to understand how various commands can accept lists (or
> ranges) of commits, and the man page raised a number of questions.
> First of all, the DESCRIPTION section doesn't quite parse as English:
> 
>        Many  git  porcelainish commands take mixture of flags (i.e. parameters
>        that  begin  with  a  dash  -)  and  parameters  meant  for  underlying
>        git-rev-list  command  they use internally and flags and parameters for
>        other commands they use as the downstream of git-rev-list. 
> 
> But, as best as I can gather that it's a helper function meant to do
> some basic options parsing for those git porcelain commands that expect
> to take a set of revision ID's.

Heh. This is totally due to hysterical raisins.

It literally used to be the case that "git-rev-parse" (the command) would 
be used to just parse the command line, and do three different things:

 - split "revision flags" from "command flags"

   For example, "--before=<date>" is a revision flag, but "-r" (for 
   "recursive") would be the command-specific flag for doing a diff.

   git-rev-parse was what knew about all the revision parsing flags (and 
   anything that wasn't a revision parsing flag was by definition a 
   subcommand flag). 

   It would also actually parse the date itself, and turn a human-readable 
   date like "--before=24.hours.ago" into a git-internal date as seconds 
   since the epoch - so no other git command would ever need to even know.

 - split pathnames from either revision flags _or_ command flags

 - do all the SHA1 arithmetic parsing for revision names, and split 
   revision names from pathnames and flags.

I think to really appreciate the whole scripting basis of very early git 
versions, do this:

	git show v0.99:git-diff-script

or look at the top few lines of the slightly more complex:

	git show v0.99.9:git-diff.sh

which starts out with:

	rev=$(git-rev-parse --revs-only --no-flags --sq "$@") || exit
	flags=$(git-rev-parse --no-revs --flags --sq "$@")
	files=$(git-rev-parse --no-revs --no-flags --sq "$@")

to parse out all the arguments using "git-rev-parse".

Now, all the argument parsing was made internal to all the common git 
programs, and there really is no reason to use git-rev-parse any more 
(unless you actually want to see the SHA1 of some revision expression), 
but some of the documentation seems to still be based on that old 
behaviour, where "git-rev-parse" was really a very integral part of 
parsing the git command line.

You can still see it: try something like

	git-rev-parse --since=24.hours.ago --default HEAD

and  you'll see how it parses the command line and turns it into a more 
primitive form ;)

> This raises some additional questions, though.  If the goal of this
> command is to parse out those options and arguments which are meant for
> git-rev-list, why does it translate tag names to SHA id's:
> 
> % git-rev-parse v1.5.0..v1.5.0.1
> dedb0faa48787839dbc47b7ca2507bda5924ec2c
> ^6db027ffe03210324939b3dd655c4223ca023b45
> 
> After all, git-rev-list can just as easily accept:

git-rev-list can accept it _now_, but originally, all the low-level 
plumbing commands took only the raw hex representations, and git-rev-parse 
was literally the thing that made it all "look" user-friendly.

Software archeology indeed..

		Linus
