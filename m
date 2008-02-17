From: Bob Copeland <me@bobcopeland.com>
Subject: segfault in http-push
Date: Sun, 17 Feb 2008 17:00:13 -0500
Message-ID: <20080217220013.GA12419@hash.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 17 23:34:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQs5M-0000an-Gv
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 23:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756107AbYBQWdh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 17:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753936AbYBQWdh
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 17:33:37 -0500
Received: from mail.deathmatch.net ([70.167.247.36]:38809 "EHLO
	mail.deathmatch.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754188AbYBQWdg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 17:33:36 -0500
Received: from hash.localnet ([72.196.246.81])
	(authenticated user bob@bobcopeland.com)
	by mail.deathmatch.net (Kerio MailServer 6.3.0)
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits))
	for git@vger.kernel.org;
	Sun, 17 Feb 2008 17:00:25 -0500
Received: from bob by hash.localnet with local (Exim 4.63)
	(envelope-from <me@bobcopeland.com>)
	id 1JQrYT-0003Ei-CZ
	for git@vger.kernel.org; Sun, 17 Feb 2008 17:00:13 -0500
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74200>

Hi,

With 1.4.5.2, I see this whenever I try to push a new branch over http:

$ git-push hash long_ids
Fetching remote heads...
  refs/
  refs/heads/
  refs/tags/
  refs/remotes/
updating 'refs/heads/long_ids'
  from 0000000000000000000000000000000000000000
  to   b24938890f04f3ba42b88f56f3ff2bbe0fda6629
    sending 10200 objects
    done
Updating remote server info
error: http-push died with strange error
error: failed to push to 'https://user@machine/foo.git/'

Here's a backtrace:

#0  0xb7cbd583 in strlen () from /lib/tls/i686/cmov/libc.so.6
#1  0x08053b5a in start_put (request=0xdce9ad8) at http-push.c:520
#2  0x080550d7 in fill_active_slot (unused=0x0) at http-push.c:810
#3  0x0804da9d in fill_active_slots () at http.c:428
#4  0x0804dc8b in step_active_slots () at http.c:454
#5  0x0804dd0b in run_active_slot (slot=0x8e70148) at http.c:474
#6  0x080502c9 in remote_ls (path=0x808bdbd "refs/", flags=5, 
    userFunc=0x804f2b0 <add_remote_info_ref>, userData=0xbfa04434)
    at http-push.c:1467
#7  0x08050552 in update_remote_info_refs (lock=0x80e66c0) at http-push.c:1942
#8  0x080534ee in main (argc=3, argv=Cannot access memory at address 0x4
) at http-push.c:2421

Error is at:
520             request->url = xmalloc(strlen(remote->url) +
521                                    strlen(request->lock->token) + 51);

(gdb) p request->lock
$1 = (struct remote_lock *) 0x80e7d40
(gdb) p request->lock->token
$2 = 0x65707954 <Address 0x65707954 out of bounds>

If I go fix up the remote repository I can usually get it to work.  
Any thoughts?

-- 
Bob Copeland %% www.bobcopeland.com
