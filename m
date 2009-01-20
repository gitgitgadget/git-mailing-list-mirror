From: Brent Goodrick <bgoodr@gmail.com>
Subject: CR codes from git commands
Date: Tue, 20 Jan 2009 08:26:32 -0800
Message-ID: <18805.64312.289059.660023@hungover.brentg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 20 17:28:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPJSL-00018a-Dt
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 17:28:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755211AbZATQ0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 11:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755199AbZATQ0g
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 11:26:36 -0500
Received: from rv-out-0506.google.com ([209.85.198.231]:42546 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754967AbZATQ0f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 11:26:35 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3181569rvb.1
        for <git@vger.kernel.org>; Tue, 20 Jan 2009 08:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:mime-version
         :content-type:content-transfer-encoding:message-id:date:to:subject
         :x-mailer;
        bh=sJUNdHM2PzjEotSZLnqpisrAgqP9AzRXDSZ/igAODys=;
        b=tCxjgHPFZZWGFUJtNdHRdtm5vRvj45Ds2h+ukOTEc4GfOjf6ZuP/lpyoQ/zsOwcG4W
         rZ32B5Sinn94rtm9voe08h0pfBjBlzwTbz1hwvSXT8kmS3Kfr2A0XrsvFAf+L7ySwOh7
         w/Gd7STRuvYX/j/tYzJdjn0GWt7Ei4AyWO0GY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:mime-version:content-type:content-transfer-encoding:message-id
         :date:to:subject:x-mailer;
        b=Tv4igxA4xVomuP/+/X7EV+quOlftKIKigjOq9wsrPeMdEODigHiYsOHjOgavi1Sw8Q
         hkMbeioTlpnSlBf+GHjTLorH+ZNCE7XyjCaMEdUlySa5cRHGCZu6Hy/kPfb62LVLabHC
         Pa6c83cczaXpD/a+PLACedyuL6/RcUUHQSBXo=
Received: by 10.140.144.1 with SMTP id r1mr2308962rvd.0.1232468794928;
        Tue, 20 Jan 2009 08:26:34 -0800 (PST)
Received: from hungover.brentg.com.thisisbogus.com ([76.14.208.3])
        by mx.google.com with ESMTPS id c20sm5610808rvf.8.2009.01.20.08.26.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Jan 2009 08:26:34 -0800 (PST)
X-Mailer: VM viewmail-606 under 23.0.60.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106487>


Hi,

I am considering converting from CVS over to using git. I'm currently
using git version 1.5.6.5 on Debian Linux "testing". One of the first
things I ran into was having to set PAGER to "cat" to avoid the
problems when running git from anything other than a terminal.  The
second thing is that "git pull" (and possibly other commands) are
emitting ^M (octal 013) codes on output, possibly caused by the same
assumption as causes the problem that is fixed by setting PAGER to
"cat".  This is not a big deal on small repos, but on larger ones I
actually do want to see status line output (or be given some option to
see them), so that I can then run "tail -1lf" on the log file that is
written during a long "git pull" operation.

Is there some configuration option or some environment variable I can
set that tells git to stop treating every invocation as if it is
coming from a terminal?

You can reproduce this on Linux with the following script (look for
the CR codes on the final git pull at the end of the script):

-- cut below this line ---
#!/bin/sh

# I could have simply used "set -x" here but then I wouldn't see the
# redirection syntax like ">file1", so instead use a PrintRun
# function:
PrintRun ()
{
    echo "COMMAND: $*"
    eval "$*; exitcode=\$?"
    if [ $exitcode != 0 ]
    then
        echo "ERROR: Command failed: $*"
        exit 1
    fi
}

# Failed attempt at hacking around git insisting on using ^M codes on stderr:
# cat >/tmp/git_pager <<EOF
# sed 's%^% >> %g'
# # This doesn't work either since the output I want to filter is on stderr
# # tr '\013' '\012'
# EOF
# chmod a+x /tmp/git_pager
# GIT_PAGER=/tmp/git_pager; export GIT_PAGER

# Clear out the scratch areas:
PrintRun rm -rf /tmp/git_area1
PrintRun rm -rf /tmp/git_area2
# Populate the initial area:
PrintRun mkdir -p /tmp/git_area1
PrintRun cd /tmp/git_area1
PrintRun git init
PrintRun "echo a new file 1 >file1"
PrintRun "echo a new file 2 >file2"
PrintRun git add file1
PrintRun git add file2
PrintRun git status
PrintRun "git commit -m \"first commit in git_area1\""
PrintRun find .
# Clone from the first area into a second area and add a file there:
PrintRun rm -rf /tmp/git_area2
PrintRun cd /tmp
PrintRun git clone /tmp/git_area1 git_area2
PrintRun cd /tmp/git_area2
PrintRun find .
PrintRun "echo a new file 3 >file3"
PrintRun git add file3
PrintRun git status
PrintRun "git commit -m \"second commit but in git_area2\""
PrintRun "git status; true" # true means don't fail inside PrintRun
PrintRun "git status; true" # true means don't fail inside PrintRun
# Now attempt to somehow refresh (what is the "git" word for "cvs update"?) into the first area:
PrintRun cd /tmp/git_area1
PrintRun "git status; true" # true means don't fail inside PrintRun
PrintRun "git diff; true" # true means don't fail inside PrintRun
# PrintRun "git pull /tmp/git_area2 master 2>&1"
# PrintRun "git pull /tmp/git_area2 master 2>&1 | tr '\013' '\012'"
PrintRun git pull /tmp/git_area2 master
-- cut above this line ---


Attempts at hacking around the problem: Redirecting stderr output from
git and then manually translating CR codes into LF codes yeilds the
following output (but I can't do this in practice and, no, I can't use
aliases in Bourne scripts (Bash/KSH yes, Bourne no)):

git> COMMAND: git pull /tmp/git_area2 master 2>&1
git> remote: Counting objects: 4, done.        
git> remote: Compressing objects:  50% (1/2)           
git>  --> remote: Compressing objects: 100% (2/2)           
git>  --> remote: Compressing objects: 100% (2/2        )Unpacking objects:  33% (1/3)   
git>  --> Unpacking objects:  66% (2/3)   
git>  --> Unpacking objects: 100% (3/3)   
git>  --> Unpacking objects: 100% (3/3), done.
git> remote: , done.        
git> remote: Total 3 (delta 0), reused 0 (delta 0)        
git> From /tmp/git_area2
git>  * branch            master     -> FETCH_HEAD
git> Updating b2f942d..4f9ba90
git> Fast forward
git>  file3 |    1 +
git>  1 files changed, 1 insertions(+), 0 deletions(-)
git>  create mode 100644 file3

Trying to automatically filter this with redirection and use of tr
fails to show the progress output completely which is a non-option
either:

git> COMMAND: git pull /tmp/git_area2 master 2>&1 | tr '\013' '\012'
git> From /tmp/git_area2
git>  * branch            master     -> FETCH_HEAD
git> Updating 49b1897..bb5f57c
git> Fast forward
git>  file3 |    1 +
git>  1 files changed, 1 insertions(+), 0 deletions(-)
git>  create mode 100644 file3

Thanks,
bgoodr
