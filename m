From: Petr Baudis <pasky@ucw.cz>
Subject: Re: First git-pasky bug report? :) error: bad signature/verify header failed
Date: Mon, 18 Apr 2005 15:40:42 +0200
Message-ID: <20050418134042.GP1461@pasky.ji.cz>
References: <4263B4A3.4030000@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 15:38:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNWQv-0000bA-Ao
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 15:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbVDRNkz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 09:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262084AbVDRNkz
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 09:40:55 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53158 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262083AbVDRNko (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 09:40:44 -0400
Received: (qmail 13152 invoked by uid 2001); 18 Apr 2005 13:40:42 -0000
To: David Greaves <david@dgreaves.com>
Content-Disposition: inline
In-Reply-To: <4263B4A3.4030000@dgreaves.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Apr 18, 2005 at 03:22:43PM CEST, I got a letter
where David Greaves <david@dgreaves.com> told me that...
> Hi

Hi,

I should release early and often. :-)

> Tree change: 
> c29b3b29c2861ab0ffb475c7a7c9cfc946106eaf:5bf2f464d382b0bd746d06e264bc6951e7bfcd3a
> Tracked branch, applying changes...
> error: bad signature
> error: verify header failed
> read_cache: Invalid argument
> error: bad signature
> error: verify header failed
> error: bad signature
> error: verify header failed

this is a known problem, caused by the directory cache index format
change (to fix endianity issues). You can solve it by doing

	read-tree $(tree-id)
	update-cache --refresh

(if you are reading this and didn't to the problematic pull yet, do it
right after you get git-pasky-base, do your first pull and rebuild;
you won't get into problems that way).

To recover, do this now, and then do:

	(i) if you have local commits:
		git merge -b c29b3b29c2861ab0ffb475c7a7c9cfc946106eaf \
			5bf2f464d382b0bd746d06e264bc6951e7bfcd3a

	(ii) if you don't have local commits:
		git diff -r c29b3b29c2861ab0ffb475c7a7c9cfc946106eaf:5bf2f464d382b0bd746d06e264bc6951e7bfcd3a \
			| git apply

I'm thinking how to handle future directory cache changes. Doing
read-tree $(tree-id) && update-cache --refresh on the kernel tree is
fast (three seconds?) if you have it in cache already, but SLOOOOOW
(more than a minute) if you have cold cache; so I wouldn't do it
always.

I think I will do something like check-cache which will just return
exitcode based on whether the cache is ok or not, and do this time
in the git multiplexer.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
