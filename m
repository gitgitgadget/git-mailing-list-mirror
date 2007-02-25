From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: autoCRLF, git status, git-gui, what is the desired behavior?
Date: Sun, 25 Feb 2007 15:51:01 -0500
Message-ID: <45E1F6B5.8030907@verizon.net>
References: <45E1E47C.5090908@verizon.net>
 <7vlkimrp1f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Levedahl <mlevedahl@verizon.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 25 21:51:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLQKk-0006nu-D1
	for gcvg-git@gmane.org; Sun, 25 Feb 2007 21:51:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbXBYUvA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Feb 2007 15:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbXBYUvA
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Feb 2007 15:51:00 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:49885 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027AbXBYUu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Feb 2007 15:50:59 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JE100GOODWXWHN8@vms046.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 25 Feb 2007 14:50:59 -0600 (CST)
In-reply-to: <7vlkimrp1f.fsf@assigned-by-dhcp.cox.net>
Newsgroups: gmane.comp.version-control.git
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40574>

Junio C Hamano wrote:
> Mark Levedahl <mlevedahl@verizon.net> writes:
> 
>> I am trying autoCRLF in git compiled from next (75415c455dd307), find
>> some behavior that is probably different than desired dealing with a
>> file where the only changes are to line endings:
>>
>> create a text file (foo) with \n endings, check it in.
>> $ u2d foo
>> $ git diff foo
>> diff --git a/foo b/foo
>> $ git status
>> # On branch master
>> # Changed but not updated:
>> #   (use "git add <file>..." to update what will be committed)
>> #
>> #       modified:   foo
>> #
>> $ git ci -m 'x' foo
>> # On branch master
>> nothing to commit (working directory clean)
>>
>> So, git commit will not check in the file, but git status shows an
>> unclean file and git diff shows no actual differences.
> 
> Unless you are doing something other than what you demonstrated
> above, I think what 'diff' and 'commit' steps show is expected,
> even without autoCRLF.  'git status' might be buggy.

I forgot the vital "-a" argument to git commit above. Adding -a gets the
desired behavior (the difference disappears). Here is a sequence that
is clearly counter-intuitive:

create foo with CRLF endings, then ...
$ git config core.autocrlf input
$ git add foo
$ git commit -m x foo
Created commit a9e9d4e1b88087462a4e15ff9044fa31e16d11bc
  1 files changed, 935 insertions(+), 0 deletions(-)
  create mode 100644 foo
$ git diff
diff --git a/foo b/foo
$ git status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   foo
#
$ git add foo
$ git status
# On branch master
nothing to commit (working directory clean)

--- git should not show a just checked in file as being different.
Note: a simple "git add foo" clears the above up, as would
git-update-index foo

Also, if I invoke git-gui on the above repository showing foo as modified...

1) foo shows up in the "Changed But Not Updated" list.
2) Clicking on foo gives message box with "No differences detected. ...
    Clicking the "ok" button invokes a rescan, back to step 1.
3) Adding foo to the commit list in git-gui works.
4) Committing the above from git-gui gives a commit with no
    changes (commit is made, shows up in git log, but has no
    changes associated).

--- I don't think git-gui should make create an empty commit in the 
above case.

Mark
