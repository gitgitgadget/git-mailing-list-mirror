From: Andreas Ericsson <ae@op5.se>
Subject: Re: Cancelling certain commits
Date: Mon, 16 Jan 2006 15:22:03 +0100
Message-ID: <43CBAC0B.3020104@op5.se>
References: <7ac1e90c0601160557r78599886nca9be9b6672a1bd7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 15:22:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyVFK-0000f2-I6
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 15:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWAPOWH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 09:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbWAPOWG
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 09:22:06 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:65478 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750819AbWAPOWE
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 09:22:04 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 5FFBC6BCBE; Mon, 16 Jan 2006 15:22:03 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Bahadir Balban <bahadir.balban@gmail.com>
In-Reply-To: <7ac1e90c0601160557r78599886nca9be9b6672a1bd7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14745>

Bahadir Balban wrote:
> Hi,
> 
> If I'm not happy with the changes I made in certain commits during
> development, how do I cancel those commits and remove them from git
> records most cleanly?
> 

As a general rule, it's desirable to do

	$ git revert --edit

if you've made some programmatical error which is non-obvious (not a 
typo, fe), as you can then make clear why that code wasn't proper for 
implementation. It will also hinder others from doing the same mistake.

Enough lessons though.

> For example if I did commits 1 to 10, and want to get rid of commit 3
> and 7, such that, the other commits are irrelevant to changes made in
> 3 and 7, but may involve changes in the same file as 3 and 7 changed,
> how do I handle it?
> 

# make sure "git status" doesn't show any changes

$ git branch anchor # to make a safe point to reset to if things go bad
$ git reset --hard HEAD~7 # undo commits 3 - 10
# replay commits 4, 5, 6, 8, 9
$ for i in 6 5 4 2 1; do git cherry-pick -r anchor~$i || break; done
# replay commit 10
$ git cherry-pick -r anchor

# done

Another variant:
$ git format-patch --mbox -k HEAD~7
$ git reset --hard HEAD~7
# remove undesired commits from the files created
$ git am -k 000*

# done

If some commits depend on other commits both of these will fail and 
you'll have to fix up by hand.


> Furthermore, how would I handle it if there was a commit 4, that
> depended partially on commit 3? (For example if it uses a type that
> was changed in commit 3?) Would I hand-edit commit 4 to fix it?
> 

Some more lecturing then;
You should have used a topic-branch to introduce such changes. This is 
always desirable when making a change that requires a series of patches.

If this didn't actually require several commits you should have done 
them as one (I always try to make sure my projects at least compile 
cleanly, even in topic-branches although they may contain warnings about 
static but unused functions and variables).

As for fixing up commits by hand when they're already written to the 
object database, you can't really do that (in an easy way, at least). 
What you can do is use "git format-patch" to get patches in mbox format 
for all the commits you eventually wish to keep, then do

$ git reset --hard <one-committish-*after*-undesired>
$ git cat-file commit HEAD > msg
$ git reset --soft HEAD~1
# edit changed files and msg
$ git commit -F msg changed_file1.c changed_file2.c changed_filen.c

Note that in all cases you should create an anchor branch to get you 
back to where you were in case something goes wrong, and never *ever* do

$ git prune

on a repo where you're juggling loose commits like this (although that 
should actually be safe when you create 'anchor' as a branch rather than 
as a tag, which Junio usually recommends).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
