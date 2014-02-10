From: Vovan-VE <vovan-ve@yandex.ru>
Subject: [BUG] git-stash confused when directory replaced with symlink
Date: Mon, 10 Feb 2014 19:54:53 +0900
Organization: VE
Message-ID: <op.xa2a9r00tcop7l@dev-server>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 10 12:06:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCogf-0006ZY-4F
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 12:06:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbaBJLF5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Feb 2014 06:05:57 -0500
Received: from forward2h.mail.yandex.net ([84.201.187.147]:46026 "EHLO
	forward2h.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372AbaBJLF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Feb 2014 06:05:56 -0500
X-Greylist: delayed 655 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Feb 2014 06:05:56 EST
Received: from smtp2h.mail.yandex.net (smtp2h.mail.yandex.net [84.201.187.145])
	by forward2h.mail.yandex.net (Yandex) with ESMTP id A79E9701F96
	for <git@vger.kernel.org>; Mon, 10 Feb 2014 14:54:55 +0400 (MSK)
Received: from smtp2h.mail.yandex.net (localhost [127.0.0.1])
	by smtp2h.mail.yandex.net (Yandex) with ESMTP id 6C029170342D
	for <git@vger.kernel.org>; Mon, 10 Feb 2014 14:54:55 +0400 (MSK)
Received: from 14-151-184-178.pppoe.irtel.ru (14-151-184-178.pppoe.irtel.ru [178.184.151.14])
	by smtp2h.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 8UuAFK2YPO-ssg8r3hc;
	Mon, 10 Feb 2014 14:54:54 +0400
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client certificate not present)
X-Yandex-Uniq: 3a36e58f-1b8b-4648-b5a2-b44540104bc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1392029694;
	bh=fLLT0hUTfcRKfB5V4pkN8tJxnftyeIVaJdv5iowDd5Y=;
	h=Content-Type:Date:To:Subject:MIME-Version:
	 Content-Transfer-Encoding:From:Organization:Message-ID:User-Agent;
	b=bGWtijJdYIlibkWiSZ2SOpTlqWniEBu4OseLJSHzbtQWrw4F0PDbEXIGbiWqmg3tC
	 WoESqoQHYiFn0EbPEi6lSTzwEx9fJE4N/sfgEsWHqFY5veJkSxAVf04MYAIb8PXuRs
	 7NqmjP6BnrekY1XQRwlpmtO5+xI7q/8b7CmTAcUI=
Authentication-Results: smtp2h.mail.yandex.net; dkim=pass header.i=@yandex.ru
User-Agent: Opera Mail/12.16 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241909>

Hello!

Looks like a bug. `git stash` fails with fatal error, when whole  
subdirectory is replaced with a symlink.

I'm using latest Git/1.8.5.4 under Ubuntu 12.04.4 x64.

Steps to reproduce initial state:

     $ git init
     $ mkdir dir
     $ touch dir/file.txt
     $ git add dir/file.txt
     $ git commit -m 'Initial commit'

     $ rm -r dir
     $ ln -s -T /something/does/not/matter dir
     $ git status
     # Changes not staged for commit:
     #
     #	deleted:    dir/file.txt
     #
     # Untracked files:
     #
     #	dir

Now the bug itself:

     $ git stash
     error: 'dir/file.txt' is beyond a symbolic link
     fatal: Unable to process path dir/file.txt
     Cannot save the current worktree state

Target of the symlink doesn't matter, as far as I understand.
Doing `git add --all` or `git rm --cached dir/file.txt` doesn't change the  
result - still fatal.

Git tries to delete file "dir/file.txt", which does not exist. It confused  
by existing "dir".

However `git checkout .` works fine: symlink deleted, directory restored.

-- 
Vovan-VE
