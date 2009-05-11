From: "Yann Dirson" <ydirson@linagora.com>
Subject: [BUG] reset abusive symlink removal;
      possible submodule-add misbehaviour
Date: Mon, 11 May 2009 10:59:19 +0200 (CEST)
Message-ID: <46017.10.0.0.1.1242032359.squirrel@intranet.linagora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 11 11:08:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3RUw-0003vH-RX
	for gcvg-git-2@gmane.org; Mon, 11 May 2009 11:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756845AbZEKJHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2009 05:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757174AbZEKJHP
	(ORCPT <rfc822;git-outgoing>); Mon, 11 May 2009 05:07:15 -0400
Received: from alderaan.linagora.com ([84.14.148.74]:39208 "EHLO
	alderaan.linagora.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757415AbZEKJHO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2009 05:07:14 -0400
X-Greylist: delayed 480 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 May 2009 05:07:14 EDT
Received: from 10.0.0.2 (unknown [10.75.192.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alderaan.linagora.com (Postfix) with ESMTPSA id 32556429F00
	for <git@vger.kernel.org>; Mon, 11 May 2009 10:59:13 +0200 (CEST)
Received: from 10.0.0.1 (proxying for 194.206.158.221)
        (SquirrelMail authenticated user ydirson)
        by intranet.linagora.com with HTTP;
        Mon, 11 May 2009 10:59:19 +0200 (CEST)
User-Agent: SquirrelMail/1.4.11
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118784>

This happenned to me while playing with changing from a manual
unversionned symlink to a submodule:

~/tmp/super$ ls -la
total 16
drwxr-xr-x 3 yann yann 4096 mai 11 10:49 .
drwxr-xr-x 4 yann yann 4096 mai 11 10:48 ..
drwxr-xr-x 8 yann yann 4096 mai 11 10:49 .git
-rw-r--r-- 1 yann yann    4 mai 11 10:48 README
lrwxrwxrwx 1 yann yann    6 mai 11 10:49 sub -> ../sub
~/tmp/super$ git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       sub
nothing added to commit but untracked files present (use "git add" to track)
~/tmp/super$ ls -la ../sub
total 12
drwxr-xr-x 3 yann yann 4096 mai 11 10:48 .
drwxr-xr-x 4 yann yann 4096 mai 11 10:48 ..
drwxr-xr-x 7 yann yann 4096 mai 11 10:48 .git
~/tmp/super$ git submodule add git://anything sub
Adding existing repo at 'sub' to the index
~/tmp/super$ ls -la
total 20
drwxr-xr-x 3 yann yann 4096 mai 11 10:50 .
drwxr-xr-x 4 yann yann 4096 mai 11 10:48 ..
drwxr-xr-x 8 yann yann 4096 mai 11 10:50 .git
-rw-r--r-- 1 yann yann   52 mai 11 10:50 .gitmodules
-rw-r--r-- 1 yann yann    4 mai 11 10:48 README
lrwxrwxrwx 1 yann yann    6 mai 11 10:49 sub -> ../sub

Here I realise the symlink may have had unwanted effects.  But shouldn't
it have "submodule add" failed here, since the target already exists ?

~/tmp/super$ git reset --hard
HEAD is now at abb75d6 foo
yann@cyann:~/tmp/super$ ls -la
total 16
drwxr-xr-x 3 yann yann 4096 mai 11 10:50 .
drwxr-xr-x 4 yann yann 4096 mai 11 10:48 ..
drwxr-xr-x 8 yann yann 4096 mai 11 10:50 .git
-rw-r--r-- 1 yann yann    4 mai 11 10:48 README

Although not critical, this seems to qualify as data loss.
