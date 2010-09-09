From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: git rebase --preserve-merges seems to not work
Date: Wed, 08 Sep 2010 23:17:39 -0600
Message-ID: <4C886DF3.8050903@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 09 07:17:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtZWH-0006ww-Al
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 07:17:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698Ab0IIFRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 01:17:40 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:41534 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905Ab0IIFRj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 01:17:39 -0400
Received: (qmail 28037 invoked by uid 399); 8 Sep 2010 23:17:39 -0600
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 8 Sep 2010 23:17:39 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.8) Gecko/20100802 Lightning/1.0b2 Thunderbird/3.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155839>

  In order to push changes to our master branch, one has to have pulled 
first.  We pull with the --rebase option.  It works great except for 
merge commits.

I discovered 'git rebase' has a --preserve-merges option.  I assumed it 
would allow me to rebase my merge commit on top of others' changes 
pushed to our central master branch.

Unfortunately, I can't seem to make it work.  Does anyone have thoughts 
on what I'm doing wrong?

My session is below.

Thanks!

Josh


$ git init

$ echo a > a
$ git add a
$ git commit -m a
$ git tag a

$ echo b > b
$ git add b
$ git commit -m b

$ echo c > c
$ git add c
$ git commit -m c
$ git tag c

# Note the hierarchy is simple: a <- b <- c
$ git lg --all
* d132c87 - (c) c
* 4a88fd1 - b
* b576660 - (a) a


# Create the hierarchy: a <- d
$ git checkout a
Note: checking out 'a'.

$ echo d > d
$ git add d
$ git commit -m d
$ git tag d

$ git lg --all
* 6abf527 - (HEAD, d) d
| * d132c87 - (c) c
| * 4a88fd1 - b
|/
* b576660 - (a) a


# Wanting to merge my branch back to my local master to push to the server.
$ git checkout a
$ git merge --no-ff c
Merge made by recursive.
  b |    1 +
  c |    1 +
  2 files changed, 2 insertions(+), 0 deletions(-)
  create mode 100644 b
  create mode 100644 c
$ git tag bc-merge


# Commit 'd' is something I would pull --rebase from the server before I 
push.
$ git lg --all
*   472fd93 - (HEAD, bc-merge) Merge commit 'c' into HEAD (3 seconds ago)
|\
| * d132c87 - (c) c (2 minutes ago)
| * 4a88fd1 - b (2 minutes ago)
|/
| * 6abf527 - (d) d (2 minutes ago)
|/
* b576660 - (a, master) a (3 minutes ago)


# Here is the rebase with the --preserve-merges option.
$ git rebase --preserve-merges d
Rebasing (n/3)
Successfully rebased and updated detached HEAD.

# Of course, bc-merge is an orphaned branch.  Its changes got replayed 
on top of 'd'.
# Note the merge commit with the description "Merge commit 'c' into 
HEAD" is missing.
$ git lg --all
* 2c93a8a - (HEAD) c (11 seconds ago)
* 2b98bc6 - b (11 seconds ago)
* 6abf527 - (d) d (3 minutes ago)
| *   472fd93 - (bc-merge) Merge commit 'c' into HEAD (74 seconds ago)
| |\
|/ /
| * d132c87 - (c) c (3 minutes ago)
| * 4a88fd1 - b (3 minutes ago)
|/
* b576660 - (a, master) a (4 minutes ago)
