From: Petr Baudis <pasky@suse.cz>
Subject: Re: New script: cg-clean
Date: Fri, 12 Aug 2005 01:29:26 +0200
Message-ID: <20050811232925.GK25280@pasky.ji.cz>
References: <1120862084.17812.6.camel@dv> <20050710154618.GF24249@pasky.ji.cz> <1123312443.17959.34.camel@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 12 01:30:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3MUX-0001m5-LC
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 01:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbVHKX3h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 19:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbVHKX3h
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 19:29:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:18443 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S1750950AbVHKX3h (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2005 19:29:37 -0400
Received: (qmail 3489 invoked by uid 2001); 11 Aug 2005 23:29:26 -0000
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1123312443.17959.34.camel@dv.roinet.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Aug 06, 2005 at 09:14:03AM CEST, I got a letter
where Pavel Roskin <proski@gnu.org> told me that...
> Hello, Petr!

Hello,

> Sorry for delay.

no problem, and sorry for another delay on my side too. :-)

> On Sun, 2005-07-10 at 17:46 +0200, Petr Baudis wrote:
> > (v) Semantically, I think it's quite close to cg-reset. What about
> > making it part of cg-reset instead of a separate command? I tend to be
> > careful about command inflation. (That's part of being careful about the
> > usability in general.) That's just an idea and possibly a bad one, what
> > do you think?
> 
> I understand your concern, but cg-reset does other things.  cg-reset
> changes the branch.  cg-clean allows to start the build from scratch
> without changing the branch.
> 
> It's not uncommon for me to revert patches one-by-one looking for the
> patch that breaks something.  I could make minor changes e.g for
> debugging or to fix breakage in certain revisions.  I would revert such
> by cg-clean before going to another revision.  cg-reset would be an
> overkill - it would move me to the latest release.
> 
> I can imagine that cg-reset would call cg-clean (optionally) to allow
> fresh start on the main branch.  The opposite would be wrong.

Yes, that makes sense.

> Here's the simplified cg-clean script.  Note that the "-d" option is not
> working with the current version of git of a bug in git-ls-files.  I can
> work it around by scanning all directories in bash, but I think it's
> easier to fix git (remove "continue" before DT_REG in ls-files.c).

Is that fixed already?

> Processing of .gitignore was taken from cg-status, and I don't really
> understand it.  But I think it's important to keep that code in sync.
> It could later go to cg-Xlib.

It became much simpler a short while later, thankfully. Judging from
your another patch, I suppose you are going to update this script
accordingly?

> Signed-off-by: Pavel Roskin <proski@gnu.org>
> 
> #!/usr/bin/env bash
> #
> # Clean unknown files from the working tree.
> # Copyright (c) Pavel Roskin, 2005
> #
> # Cleans file and directories that are not under version control.
> # When run without arguments, files ignored by cg-status and directories
> # are not removed.
> #
> # OPTIONS
> # -------
> # -d::
> #	Also clean directories.

Perhaps add "and their contents" to prevent bad surprises.

> #
> # -x::
> #	Also clean files ignored by cg-status, such as object files.
> 
> USAGE="cg-clean [-d] [-x]"
> 
> . ${COGITO_LIB}cg-Xlib
> 
> cleanexclude=
> cleandir=
> while optparse; do
> 	if optparse -d; then
> 		cleandir=1
> 	elif optparse -x; then
> 		cleanexclude=1
> 	else
> 		optfail
> 	fi
> done
> 
> # Good candidate for cg-Xlib
> # Put exclude options for git-ls-files to EXCLUDE
..snip..
> 
> git-update-cache --refresh > /dev/null
> 
> # Need to use temporary file so that changing IFS doesn't affect $EXCLUDE
> # expansion.
> filelist=$(mktemp -t gitlsfiles.XXXXXX)
> git-ls-files --others $EXCLUDE >"$filelist"
> save_IFS="$IFS"
> IFS=$'\n'
> for file in $(cat "$filelist"); do

Why can't you use git-ls-files | IFS=$'\n' while ?

> 	IFS="$save_IFS"
> 	if [ -d "$file" ]; then
> 		if [ "$cleandir" ]; then
> 			# Try really hard by changing permissions
> 			chmod -R 700 "$file"
> 			rm -rf "$file"
> 		fi

An error message would be in order otherwise, I guess.

> 		return

I suppose you mean continue? I'm not really sure what does return do
here, if it jumps out of the do block or what, and continue is nicely
explicit. :-)

> 	fi
> 	rm -f "$file"
> done
> 
> rm -f "$filelist"

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
