From: Adam Piatyszek <ediap@users.sourceforge.net>
Subject: Re: Why does git track directory listed in .gitignore/".git/info/exclude"?
Date: Thu, 31 Jan 2008 08:05:34 +0100
Message-ID: <47A1733E.9040103@users.sourceforge.net>
References: <6bc632150801230554l3b24e1e4lb4641bf7c16857c0@mail.gmail.com>	<6bc632150801230604p2589c893pa05bb6f27e482de8@mail.gmail.com>	<alpine.LFD.1.00.0801231313590.2803@woody.linux-foundation.org>	<47A06EF9.60704@users.sourceforge.net> <7vprvjgi9v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	pradeep singh rautela <rautelap@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 08:16:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKTfK-0006iH-N8
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 08:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316AbYAaHQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 02:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753261AbYAaHQJ
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 02:16:09 -0500
Received: from ananke.et.put.poznan.pl ([150.254.29.121]:64728 "EHLO
	ananke.et.put.poznan.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbYAaHQH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 02:16:07 -0500
Received: from hydrus.et.put.poznan.pl (hydrus.et.put.poznan.pl [150.254.11.145])
	by ananke.et.put.poznan.pl (8.13.8/8.13.8) with ESMTP id m0V7A2tR016311;
	Thu, 31 Jan 2008 08:10:44 +0100 (CET)
	(envelope-from ediap@users.sourceforge.net)
Received: from [150.254.11.74] (pc1074.et.put.poznan.pl [150.254.11.74])
	by hydrus.et.put.poznan.pl (8.11.7p1+Sun/8.11.6) with ESMTP id m0V75YD00795;
	Thu, 31 Jan 2008 08:05:35 +0100 (MET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071116)
In-Reply-To: <7vprvjgi9v.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
OpenPGP: id=1F115CCB
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940, Antispam-Data: 2008.1.30.225641
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0, __USER_AGENT 0'
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72105>

Hi Junio,

* Junio C Hamano [30 I 2008 21:39]:
> When you say "foo", you mean "I want either 'foo' that is a
> non-directory, or everything under 'foo' if that is a
> directory".  When you say "foo/", you are saying "I do not want
> 'foo' if it is a non-directory.  I want everything under 'foo'
> if and only if that is a directory".  Compare:
> 
> 	git ls-files -s Makefile/
>         git ls-files -s Makefile
> 
> The first one is silent, and the latter answers.  On the other
> hand, for a directory, both of these give you the same:
> 
> 	git ls-files Documentation/
>         git ls-files Documentation
> 

As you said above both "Documentation/" and "Documentation" match the 
existing tracked directory named "Documentation". That is how ls-files 
works and it is the only sane way. The problem is that I expect that 
directory entries ending with "/" in .gitignore and .git/info/exclude 
files are treated in a similar way, i.e. they are being _ignored_ with 
all the stuff in them, in the same way as directory entries without the 
ending slash. Unfortunately this is not the case. See this example:

ediap@lespaul ~/tmp $ mkdir repo && cd repo
ediap@lespaul ~/tmp/repo $ git init
Initialized empty Git repository in .git/
ediap@lespaul ~/tmp/repo $ touch a.txt
ediap@lespaul ~/tmp/repo $ git add a.txt
ediap@lespaul ~/tmp/repo $ git commit -m "a file"
Created initial commit 1712595: a file
  0 files changed, 0 insertions(+), 0 deletions(-)
  create mode 100644 a.txt
ediap@lespaul ~/tmp/repo $ mkdir d
ediap@lespaul ~/tmp/repo $ touch d/b.txt
ediap@lespaul ~/tmp/repo $ git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       d/
nothing added to commit but untracked files present (use "git add" to track)
ediap@lespaul ~/tmp/repo $ echo "d/" > .gitignore
ediap@lespaul ~/tmp/repo $ git add .gitignore
ediap@lespaul ~/tmp/repo $ git commit -m "ignore"
Created commit 29ebf4d: ignore
  1 files changed, 1 insertions(+), 0 deletions(-)
  create mode 100644 .gitignore
ediap@lespaul ~/tmp/repo $ git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       d/
nothing added to commit but untracked files present (use "git add" to track)


But:

ediap@lespaul ~/tmp/repo $ echo "d" > .gitignore
ediap@lespaul ~/tmp/repo $ git add .gitignore
ediap@lespaul ~/tmp/repo $ git commit --amend -m "ignore"
Created commit 43198d4: ignore
  1 files changed, 1 insertions(+), 0 deletions(-)
  create mode 100644 .gitignore
ediap@lespaul ~/tmp/repo $ git status
# On branch master
nothing to commit (working directory clean)


I hope you now understand what I was trying to express in my previous 
email. :-)

BR,
/Adam


-- 
.:.  Adam Piatyszek (ediap)  .:.....................................:.
.:.  ediap@users.sourceforge.net  .:................................:.
