From: David Greaves <david@dgreaves.com>
Subject: [PATCH 1/1] add, rm + status patches
Date: Mon, 18 Apr 2005 23:18:07 +0100
Message-ID: <4264321F.2050107@dgreaves.com>
References: <42641AE4.9050700@dgreaves.com> <20050418204814.GF5554@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 19 00:15:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNeVk-0007zN-E8
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 00:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbVDRWS3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 18:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVDRWS3
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 18:18:29 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:29852 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261192AbVDRWSK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 18:18:10 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id F1FA7E6D7A; Mon, 18 Apr 2005 23:16:35 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 07109-19; Mon, 18 Apr 2005 23:16:35 +0100 (BST)
Received: from oak.dgreaves.com (modem-3514.leopard.dialup.pol.co.uk [217.135.157.186])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 54A59E6D75; Mon, 18 Apr 2005 23:16:34 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DNeZD-0005KM-IO; Mon, 18 Apr 2005 23:18:07 +0100
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050418204814.GF5554@pasky.ji.cz>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:

>  Thanks. Could you please send the patches signed off and either with
>  content-disposition: inline or in the mail body?
Is this OK.
Thunderbird isn't the best for attaching patches.
>
>  I think it would be cleaner to do the testing for the dash in the for
>  loop, so that I can do git add foo bar -. Also, don't forget to
>  update git add's documentation at the top. For the usage string, I'd
>  probably prefer (-|FILE)...
>
>  thanks,

Here you are:
* git add and git rm now take (-|FILE)...
* noted some bugs to be fixed
* introduced de-dupe code into add and rm
* git status reports added/removed files (although there are extra entries)
* README, git and command docs updated

I realise as I write this that I should have split these patches up - I 
will do so next time.

Has a decision been reached to _not_ code the cogito part of the git 
suite in perl?

I ask because the code in git status is getting pretty ugly.
I'd be happy to help with a preliminary port to perl.

David

Signed-off-by: David Greaves <david@dgreaves.com>
---
Index: README
===================================================================
--- c0aff9b98c4242ab8965c428241df1d8f7a1d4bb/README (mode:100644 
sha1:798476ad292cc6edf5a2f5782e1de82f6052abe2)
+++ cd5cd7a9272ce1966aca3bfce15f703e33cafc04/README (mode:100644 
sha1:4282af1604e429dd767fe721751b5ac4a87c410e)
@@ -89,6 +89,10 @@
Of course you will want to commit. If you added any new files, do

git add newfile1 newfile2 ...
+
+or even
+
+ find src -type f | git add -

first. Then feel free to commit by

Index: git
===================================================================
--- c0aff9b98c4242ab8965c428241df1d8f7a1d4bb/git (mode:100755 
sha1:b648169640025bd68d1b27a0fcc85b65d85e4440)
+++ cd5cd7a9272ce1966aca3bfce15f703e33cafc04/git (mode:100755 
sha1:2549bc3dc36ec00e747e91edb6e839be0f37ae4a)
@@ -25,7 +25,7 @@
Usage: git COMMAND [ARG]...

Available commands:
- add FILE...
+ add (-|FILE)...
addremote RNAME RSYNC_URL
apply < patch on stdin
cancel
@@ -41,7 +41,7 @@
lsremote
merge -b BASE_ID FROM_ID
pull [RNAME]
- rm FILE...
+ rm (-|FILE)...
seek [COMMIT_ID]
status
tag TNAME [COMMIT_ID]
Index: gitadd.sh
===================================================================
--- c0aff9b98c4242ab8965c428241df1d8f7a1d4bb/gitadd.sh (mode:100755 
sha1:3ed93ea0fcb995673ba9ee1982e0e7abdbe35982)
+++ cd5cd7a9272ce1966aca3bfce15f703e33cafc04/gitadd.sh (mode:100755 
sha1:a3e83ac52abd5a9cdc6abd560f95b2f19646fd99)
@@ -5,14 +5,26 @@
#
# Takes a list of file names at the command line, and schedules them
# for addition to the GIT repository at the next commit.
+# If one of the filenames is '-' then also read a filelist from STDIN
#
# FIXME: Those files are omitted from show-diff output!
+# FIXME: No checking against git-ignore
+# FIXME: No checking against .git/del-queue
+

if [ ! "$1" ]; then
- echo "gitadd.sh: usage: git add FILE..." >&2
+ echo "gitadd.sh: usage: git add (-|FILE)..." >&2
exit 1;
fi

for file in "$@"; do
- echo $file >>.git/add-queue
+ if [ $file = "-" -a ! "$DONE_STDIN" ]; then
+ cat >> .git/add-queue
+ DONE_STDIN=1
+ else
+ echo $file >>.git/add-queue
+ fi
done
+
+# Remove duplicates
+sort < .git/add-queue | uniq > .git/add-queue
\ No newline at end of file
Index: gitrm.sh
===================================================================
--- c0aff9b98c4242ab8965c428241df1d8f7a1d4bb/gitrm.sh (mode:100755 
sha1:5c18c38a890c9fd9ad2b866ee7b529539d2f3f8f)
+++ cd5cd7a9272ce1966aca3bfce15f703e33cafc04/gitrm.sh (mode:100755 
sha1:d76542dd6ad892fbbdc93e475aa9b77dd2922fe5)
@@ -5,15 +5,28 @@
#
# Takes a list of file names at the command line, and schedules them
# for addition to the GIT repository at the next commit.
+# If one of the filenames is '-' then also read a filelist from STDIN
#
# FIXME: Those files are omitted from show-diff output!
+# FIXME: No checking against git-ignore
+# FIXME: No checking against .git/add-queue
+# FIXME: Files read in on stdin aren't validated to exist
+

if [ ! "$1" ]; then
- echo "gitrm.sh: usage: git rm FILE..." >&2
+ echo "gitrm.sh: usage: git rm (-|FILE)..." >&2
exit 1;
fi

for file in "$@"; do
- [ -e "$file" ] && rm "$file"
- echo $file >>.git/rm-queue
+ if [ $file = "-" -a ! "$DONE_STDIN" ]; then
+ cat >> .git/rm-queue
+ DONE_STDIN=1
+ else
+ [ -e "$file" ] && rm "$file"
+ echo $file >>.git/rm-queue
+ fi
done
+
+# Remove duplicates
+sort < .git/rm-queue | uniq > .git/rm-queue
\ No newline at end of file
Index: gitstatus.sh
===================================================================
--- c0aff9b98c4242ab8965c428241df1d8f7a1d4bb/gitstatus.sh (mode:100755 
sha1:6c33f805ebc2630b14a88a07dfc891a9196d66a5)
+++ cd5cd7a9272ce1966aca3bfce15f703e33cafc04/gitstatus.sh (mode:100755 
sha1:2611d00189e5d03ba8356ec0e4c3af107bae6981)
@@ -3,10 +3,12 @@
# Show status of entries in your working tree.
# Copyright (c) Petr Baudis, 2005

+# FIXME: newly added files show up twice as ? _AND_ A
+
{
show-files -z -t --others --deleted --unmerged
- [ -s .git/add-queue ] && cat .git/add-queue | sed 's/^/A /' | { read 
x; echo -ne $x'\0'; }
- [ -s .git/rm-queue ] && cat .git/rm-queue | sed 's/^/D /' | { read x; 
echo -ne $x'\0'; }
+ [ -s .git/add-queue ] && cat .git/add-queue | sed 's/^/A /' | tr '\n' '\0'
+ [ -s .git/rm-queue ] && cat .git/rm-queue | sed 's/^/D /' | tr '\n' '\0'
} | sort -z -k 2 | xargs -0 sh -c '
while [ "$1" ]; do
tag=$(echo "$1" | cut -d " " -f 1);

