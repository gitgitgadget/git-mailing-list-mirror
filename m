From: Keith Amidon <keith@nicira.com>
Subject: Re: How can a custom merge tool get access to file shell variables?
Date: Tue, 19 Aug 2008 11:32:31 -0700
Organization: Nicira Networks
Message-ID: <1219170751.12921.27.camel@kea-nicira-lt.nicira.com>
References: <1219169604.12921.17.camel@kea-nicira-lt.nicira.com>
	 <1219170004.12921.19.camel@kea-nicira-lt.nicira.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 20:34:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVW1U-00064M-9J
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 20:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbYHSScg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 14:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752593AbYHSScg
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 14:32:36 -0400
Received: from dime139.dizinc.com ([66.7.205.111]:55209 "EHLO
	dime139.dizinc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144AbYHSScf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 14:32:35 -0400
Received: from adsl-75-37-14-130.dsl.pltn13.sbcglobal.net ([75.37.14.130]:57689 helo=[192.168.1.16])
	by dime139.dizinc.com with esmtpsa (SSLv3:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <keith@nicira.com>)
	id 1KVW0N-0008OZ-12
	for git@vger.kernel.org; Tue, 19 Aug 2008 14:32:31 -0400
In-Reply-To: <1219170004.12921.19.camel@kea-nicira-lt.nicira.com>
X-Mailer: Evolution 2.22.2 
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - dime139.dizinc.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - nicira.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92894>

In case anyone is interested, the following does exactly what I want.
Hopefully this example will help someone else that wants to do something
similar avoid spending time on writing an unnecessary shell script
wrapper tool.

[mergetool "xxdiff-2way-ignorews"]
    cmd = xxdiff -w $REMOTE $LOCAL --merged-filename $MERGED
    trustExitCode = false

I think I was thrown off by the description of mergetool.<name>.cmd in
the git-config man page.  While on close reading it is definitely
correct, for me at least it seemed natural to assume that the invoked
command was supposed to get its information from the environment, not
that the command line itself could substitute from the environment.
Would an example such as the above in the man page might help direct
people toward the best way to do this?

           --- Keith

On Tue, 2008-08-19 at 11:20 -0700, Keith Amidon wrote:
> Please ignore this.  I was not effective enough in looking for an
> answer even though I did search the archives a bit before writing
> this.  The answer is here:
> 
> http://article.gmane.org/gmane.comp.version-control.git/82371/match=mergetool+export
> 
> I'm off to try a custom way of invoking xxdiff that does what I want. 
> 
> --- Keith
> 
> 
> On Tue, 2008-08-19 at 11:13 -0700, Keith Amidon wrote: 
> > I'm in a situation where I have to fairly regularly merge two different
> > trees where multiple files are being simultaneously edited in both trees
> > and whitespace in some of the files is different in both trees as well.
> > I would like to be able to use git mergetool to walk me through
> > resolving conflicts in merges.  My preferred graphical merge tool is
> > xxdiff but in 3-way mode it doesn't allow you to ignore whitespace while
> > doing the diff, only while displaying.  As a result, all these files
> > appear to have one giant diff and separating out what has really changed
> > is a giant pain.  Since my use-case is simple, I thought I would create
> > a custom mergetool as a shell script that invokes xxdiff in 2-way mode
> > and moves around files to get what I need.  I've pasted that script at
> > the end of the message.
> > 
> > I've added this script as custom mergetool as indicated in comments at
> > the top of the script, but it does not work.  It appears to me that the
> > problem is that the shell variables containing the required filenames
> > (BASE, LOCAL, REMOTE, MERGED) are not set.  Looking
> > at /usr/bin/git-mergetool, it appears that custom merge tools are called
> > without arguments in a subshell and those variables are not exported
> > anywhere so they are not in the environment of the subshell.  Given
> > this, how can a custom mergetool ever get access to this information to
> > do its work?
> > 
> > If there is another better way to try to accomplish this (other than
> > forcing whitespace to be the same in both trees for now!) I'd appreciate
> > it if someone would clue me in!
> > 
> >              --- Keith
> > 
> > 
> > #!/bin/bash
> > #
> > # Perform a merge for GIT in which whitespace is ignored.  Because the
> > # underlying diff tools don't seem to be able to ignore whitespace on
> > # a three-way merge, a 2-way merge is done where the first file is a
> > # copy of the remote file to be merged and the second file is copy of
> > # the current file from the branch into which files are being merged.
> > # The success of the merge is determined by whether a merged file is
> > # written out from xxdiff.  If you don't save the merged file, the
> > # merge will be aborted.
> > #
> > # This script should be configured as a merge tool in git as follows:
> > #
> > # git-config --global --add mergetool.xxdiff-2way-ignorews.cmd
> > xxdiff-2way-ignorews-git-mergetool
> > # git-config --global --add mergetool.xxdiff-2way-ignorews.trustExitCode
> > true
> > # 
> > 
> > rtmpfile=""
> > ltmpfile=""
> > 
> > function remove_tmpfiles () {
> >     if [ -n "$ltmpfile" ]; then
> >         rm -f "$ltmpfile"
> >     fi
> >     if [ -n "$rtmpfile" ]; then
> >         rm -f "$rtmpfile"
> >         rm -f "$rtmpfile.merge"
> >     fi
> > }
> > 
> > function die () {
> >     printf "%b" "$1"
> >     remove_tmpfiles
> >     exit 1
> > }
> > 
> > [ -f "$LOCAL" ] || die "Local file does not exists: $LOCAL\n"
> > [ -f "$REMOTE" ] || die "Remote file does not exists: $REMOTE\n"
> > 
> > # Be really paranoid and copy git's temp files to new ones so we aren't
> > # playing around with git's files...
> > ltmpfile=$(mktemp --tmpdir xxdiff-2way-tmp.remote.XXXXXXXXXX)
> > cp "$LOCAL" "$ltmpfile" || die "Could not copy local file to temporary
> > merge file.\nLocal file is: $LOCAL\nTemporary merge file is: $ltmpfile
> > \n"
> > 
> > rtmpfile=$(mktemp --tmpdir xxdiff-2way-tmp.local.XXXXXXXXXX)
> > cp "$REMOTE" "$rtmpfile" || die "Could not copy remote file to temporary
> > merge result file.\nLocal file is: $LOCAL\nTemporary merge file is:
> > $tmpfile\n"
> > 
> > xxdiff -w "$rtmpfile" "$ltmpfile"
> > 
> > if [ -f "$rtmpfile.merge" ]; then
> >     if [ -f "$MERGED" ]; then
> >         printf "Merged file already exists, removing so merge result can
> > be renamed.\n"
> >         rm -f "$MERGED"
> >     fi
> >     mv "$rtmpfile.merge" "$MERGED" || die "Could not rename merge result
> > to merged file: $MERGED\n"
> >     remove_tmpfiles
> > else
> >     die "Did not find merge output file from xxdiff, aborting merge.\n"
> > fi
> > 
