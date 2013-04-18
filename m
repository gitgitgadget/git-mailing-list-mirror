From: Pete Wyckoff <pw@padd.com>
Subject: Re: git p4 submit failing
Date: Thu, 18 Apr 2013 19:43:28 -0400
Message-ID: <20130418234328.GA9048@padd.com>
References: <CAG4Fb8ejKCpUqZ+YVQT=S2-p6YcNo5+s81j2Jrx8q1ijtu8yqw@mail.gmail.com>
 <CAE5ih78rw1_oE2SFQFnfUSfRfDGRW0pVC7TL1qgxwdcOFbBdCw@mail.gmail.com>
 <20130413215110.GA5370@padd.com>
 <CAG4Fb8ekKSAiLGf_hCuLiwznCe=JOQmjS3q2-9=YeEmMaCYUNQ@mail.gmail.com>
 <CAG4Fb8cxdCGvzAztEk8+V59hge3hVdyBKAtUB73uXgOaLWzKCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
	simon@lst.de
To: Christopher Yee Mon <christopher.yeemon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 01:43:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USyUK-0002Qc-Sb
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 01:43:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967434Ab3DRXnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 19:43:32 -0400
Received: from honk.padd.com ([74.3.171.149]:38478 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966999Ab3DRXnb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 19:43:31 -0400
Received: from arf.padd.com (unknown [50.55.134.154])
	by honk.padd.com (Postfix) with ESMTPSA id 854143362;
	Thu, 18 Apr 2013 16:43:30 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 51C472D182; Thu, 18 Apr 2013 19:43:28 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAG4Fb8cxdCGvzAztEk8+V59hge3hVdyBKAtUB73uXgOaLWzKCQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221716>

christopher.yeemon@gmail.com wrote on Thu, 18 Apr 2013 11:24 -0500:
> The issue is caused by the line endings. I retested the problem with a
> different file and in this case, the error is caused by the line
> endings of the file checked out in the perforce workspace being
> win-style crlf, and the line endings of the file in the git repo being
> unix style lf. (In this scenario, I took out the .gitattributes,
> core.autocrlf was set to false and LineEnd was set to share)
> 
> In this case, I checked out the file in perforce, ran dos2unix against
> it, and submitted that, then ran git p4 submit and it worked.
> 
> I noticed that the error is caused by the git apply failing in the def
> applyCommit(self, id) function at lines 1296-1305.
> 
>         diffcmd = "git format-patch -k --stdout \"%s^\"..\"%s\"" % (id, id)
>         patchcmd = diffcmd + " | git apply "
>         tryPatchCmd = patchcmd + "--check -"
>         applyPatchCmd = patchcmd + "--check --apply -"
>         patch_succeeded = True
> 
>         if os.system(tryPatchCmd) != 0:
>             fixed_rcs_keywords = False
>             patch_succeeded = False
>             print "Unfortunately applying the change failed!"
> 
> So most likely in git apply command, it can't find the changes because
> of the line endings being different between them. I couldn't find a
> parameter that would magically make it work. When I added --verbose to
> git apply the output only says:
> error: while searching for:
> <and then the first lines of the first diff>

That seems like exactly the correct diagnosis of the problem.
What to do about it, I'm not so sure.

We could suggest that people use the same line-ending conventions
in both git and p4 land.  This is easy if they are both lf.  But,
if crlf is preferred, do you know how to configure git to use
crlf line endings?  Does that fix it?  There's also the config
setting "apply.ignorewhitespace"; not sure if that would allow
the apply step to apply an lf-ending patch to the crlf-ending p4
workspace.

		-- Pete

> Hello Simon,
> 
> I have CCed you to alert you to the possible bug. Any assistance would
> be appreciated.
> 
> 
> On Sat, Apr 13, 2013 at 5:09 PM, Christopher Yee Mon
> <christopher.yeemon@gmail.com> wrote:
> > Yes this is the case.
> >
> > Many of the files have crlf endings.
> >
> > core.autocrlf was recently set to input. I can't remember the timeline
> > exactly though, but in addition to this, I have a .gitattributes file
> > with the default set to text=auto (* text=auto) and the php files set
> > to text eol=lf (*.php text eol=lf) Also my perforce workspace's
> > LineEnd setting is set to Share.
> >
> > I've experienced the behavior in both .php and .xml files though
> >
> > Before all of this started I had core.autocrlf set to false, and no
> > .gitattributes file and perforce workspace's LineEnd was set to the
> > default, but I got a conflict where the only difference was the line
> > endings, so I changed things to the way they are now.
> >
> > Any recommendations? Should I change everything back the way it was?
> >
> > On Sat, Apr 13, 2013 at 5:51 PM, Pete Wyckoff <pw@padd.com> wrote:
> >> luke@diamand.org wrote on Thu, 11 Apr 2013 21:19 +0100:
> >>> Just a thought, but check the files that are failing to see if they've
> >>> got RCS keywords in them ($Id$, $File$, $Date$, etc). These cause all
> >>> sorts of nasty problems.
> >>>
> >>> That's assuming it's definitely not a CRLF line ending problem on Windows.
> >>
> >> I had recently debugged a similar-looking problem
> >> where core.autocrlf was set to "input".
> >>
> >> Christopher, if you have this set and/or the .xml files
> >> have ^M (CRLF) line endings, please let us know.
> >>
> >>                 -- Pete
> >>
> >>>
> >>> On Thu, Apr 11, 2013 at 8:01 PM, Christopher Yee Mon
> >>> <christopher.yeemon@gmail.com> wrote:
> >>> > I tried running git p4 submit on a repo that I've been running as an
> >>> > interim bridge between git and perforce. Multiple people are using the
> >>> > repo as a remote and its being periodically submitted back to
> >>> > perforce.
> >>> >
> >>> > It's been working mostly fine. Then one day out of the blue I get this
> >>> > error. I can no longer push any git commits to perforce. (This is from
> >>> > the remote repo which I am pushing back to perforce)
> >>> >
> >>> > user@hostname:~/Source/code$ git p4 submit -M --export-labels
> >>> > Perforce checkout for depot path //depot/perforce/workspace/ located
> >>> > at /home/user/Source/git-p4-area/perforce/workspace/
> >>> > Synchronizing p4 checkout...
> >>> > ... - file(s) up-to-date.
> >>> > Applying ffa390f comments in config xml files
> >>> > //depot/perforce/workspace/sub/folder/structure/first.xml#3 - opened for edit
> >>> > //depot/perforce/workspace/sub/folder/structure/second.xml#3 - opened for edit
> >>> > //depot/perforce/workspace/sub/folder/structure/third.xml#3 - opened for edit
> >>> > //depot/perforce/workspace/sub/folder/structure/forth.xml#3 - opened for edit
> >>> > //depot/perforce/workspace/sub/folder/structure/fifth.xml#1 - opened for edit
> >>> > error: patch failed: sub/folder/structure/first.xml:1
> >>> > error: sub/folder/structure/first.xml: patch does not apply
> >>> > error: patch failed: sub/folder/structure/second.xml:1
> >>> > error: sub/folder/structure/second.xml: patch does not apply
> >>> > error: patch failed: sub/folder/structure/third.xml:1
> >>> > error: sub/folder/structure/third.xml: patch does not apply
> >>> > error: patch failed: sub/folder/structure/forth.xml:1
> >>> > error: sub/folder/structure/forth.xml: patch does not apply
> >>> > error: patch failed: sub/folder/structure/fifth.xml:1
> >>> > error: sub/folder/structure/fifth.xml: patch does not apply
> >>> > Unfortunately applying the change failed!
> >>> > //depot/perforce/workspace/sub/folder/structure/first.xml#1 - was edit, reverted
> >>> > //depot/perforce/workspace/sub/folder/structure/second.xml#3 - was
> >>> > edit, reverted
> >>> > //depot/perforce/workspace/sub/folder/structure/third.xml#3 - was edit, reverted
> >>> > //depot/perforce/workspace/sub/folder/structure/forth.xml#3 - was edit, reverted
> >>> > //depot/perforce/workspace/sub/folder/structure/fifth.xml#3 - was edit, reverted
> >>> > No commits applied.
> >>> >
> >>> > I thought it could be the .gitattributes setting that I had which was
> >>> > this at the time was this:
> >>> >
> >>> > * text eol=lf
> >>> >
> >>> > My global core.autocrlf setting was also false.
> >>> >
> >>> > So I remade a new remote repo, and changed core.autocrlf to input and
> >>> > changed .gitattributes to this
> >>> >
> >>> > * text=auto
> >>> >
> >>> > *.php text eol=lf
> >>> > *.pl text eol=lf
> >>> > *.pm text eol=lf
> >>> > *.sh text eol=lf
> >>> >
> >>> > *.vbs text eol=crlf
> >>> > *.bat text eol=crlf
> >>> > *.ps1 text eol=crlf
> >>> >
> >>> > *.bdb binary
> >>> > *.mtr binary
> >>> >
> >>> > Then I started to realize that it could just be the files in the
> >>> > initial commit that are suspect, because when i made edits to other
> >>> > files in the repo then tried to push them back with git p4 submit,
> >>> > those files submitted successfully  But the files in the commit where
> >>> > I initially got the failure still give me this problem.
> >>> >
> >>> > Here's what it looks like when I retested with a fresh git repo cloned
> >>> > from perforce with git p4 clone and tried to do the git p4 submit with
> >>> > verbose turned on on only one of the suspecting files
> >>> >
> >>> > user@hostname:/code$ git p4 submit -M --export-labels --verbose
> >>> > Reading pipe: git name-rev HEAD
> >>> > Reading pipe: ['git', 'config', 'git-p4.allowSubmit']
> >>> > Reading pipe: git rev-parse --symbolic --remotes
> >>> > Reading pipe: git rev-parse p4/master
> >>> > Reading pipe: git cat-file commit 0457c7589ea679dcc0c9114b34f8f30bc2ee08cf
> >>> > Reading pipe: git cat-file commit HEAD~0
> >>> > Reading pipe: git cat-file commit HEAD~1
> >>> > Reading pipe: ['git', 'config', 'git-p4.conflict']
> >>> > Origin branch is remotes/p4/master
> >>> > Reading pipe: ['git', 'config', '--bool', 'git-p4.useclientspec']
> >>> > Opening pipe: ['p4', '-G', 'where', '//depot/perforce/workspace/...']
> >>> > Perforce checkout for depot path //depot/perforce/workspace/ located
> >>> > at /home/user/Source/git-p4-area/perforce/workspace/
> >>> > Synchronizing p4 checkout...
> >>> > ... - file(s) up-to-date.
> >>> > Opening pipe: p4 -G opened ...
> >>> > Reading pipe: ['git', 'rev-list', '--no-merges', 'remotes/p4/master..master']
> >>> > Reading pipe: ['git', 'config', '--bool', 'git-p4.skipUserNameCheck']
> >>> > Reading pipe: ['git', 'config', 'git-p4.detectCopies']
> >>> > Reading pipe: ['git', 'config', '--bool', 'git-p4.detectCopiesHarder']
> >>> > Reading pipe: ['git', 'show', '-s', '--format=format:%h %s',
> >>> > 'ef3b95f5fec193fe2612b28e2e3b5e7f8ba9419e']
> >>> > Applying ef3b95f making test change
> >>> > Opening pipe: p4 -G users
> >>> > Reading pipe: ['git', 'log', '--max-count=1', '--format=%ae',
> >>> > 'ef3b95f5fec193fe2612b28e2e3b5e7f8ba9419e']
> >>> > Reading pipe: git diff-tree -r -M
> >>> > "ef3b95f5fec193fe2612b28e2e3b5e7f8ba9419e^"
> >>> > "ef3b95f5fec193fe2612b28e2e3b5e7f8ba9419e"
> >>> > //depot/perforce/workspace/sub/folder/structure/first.xml#3 - opened for edit
> >>> > <stdin>:17: trailing whitespace.
> >>> > <!-- comment line 1 -->
> >>> > <stdin>:18: trailing whitespace.
> >>> > <!-- comment line 2 -->
> >>> > <stdin>:19: trailing whitespace.
> >>> > <!-- comment line 3 -->
> >>> > error: patch failed: sub/folder/structure/first.xml:1
> >>> > error: sub/folder/structure/first.xml: patch does not apply
> >>> > Unfortunately applying the change failed!
> >>> > Reading pipe: ['git', 'config', '--bool', 'git-p4.attemptRCSCleanup']
> >>> > //depot/perforce/workspace/sub/folder/structure/first.xml#3 - was edit, reverted
> >>> > No commits applied.
> >>> > Reading pipe: ['git', 'config', '--bool', 'git-p4.exportLabels']
> >>> > Opening pipe: ['p4', '-G', 'labels', '//depot/ipstor.maple/automation/...']
> >>> > Reading pipe: ['git', 'tag']
> >>> > Reading pipe: ['git', 'config', 'git-p4.labelExportRegexp']
> >>> >
> >>> > In any case, I'm starting to think it could be a legitimate bug, which
> >>> > is why I am submitting it here. Does anyone have any ideas for
> >>> > suggestions on diagnosing what could be wrong?
> >>> > --
> >>> > To unsubscribe from this list: send the line "unsubscribe git" in
> >>> > the body of a message to majordomo@vger.kernel.org
> >>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe git" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>
> 
