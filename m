From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix use after free() in builtin-fetch
Date: Mon, 28 Apr 2008 22:23:35 +0200
Message-ID: <20080428202335.GA10600@steel.home>
References: <20080428184138.GA30702@redhat.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dave Jones <davej@redhat.com>, Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 22:24:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqZtl-00048a-B3
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 22:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933240AbYD1UXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 16:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763964AbYD1UXi
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 16:23:38 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:17884 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933127AbYD1UXh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 16:23:37 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarKZBJxGkw==
Received: from tigra.home (Faada.f.strato-dslnet.de [195.4.170.218])
	by post.webmailer.de (klopstock mo9) (RZmta 16.27)
	with ESMTP id m072f0k3SIRlzk ; Mon, 28 Apr 2008 22:23:36 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 0B5BC277BD;
	Mon, 28 Apr 2008 22:23:36 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id D84C456D28; Mon, 28 Apr 2008 22:23:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080428184138.GA30702@redhat.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80606>

As reported by Dave Jones:

Since master.kernel.org updated to latest, I noticed that I could crash
git-fetch by doing this..

export KERNEL=/pub/scm/linux/kernel/git/
git fetch $KERNEL/torvalds/linux-2.6 master:linus

(gdb) bt
 0  0x000000349fd6d44b in free () from /lib64/libc.so.6
 1  0x000000000048f4eb in transport_unlock_pack (transport=0x7ce530) at transport.c:811
 2  0x000000349fd31b25 in exit () from /lib64/libc.so.6
 3  0x00000000004043d8 in handle_internal_command (argc=3, argv=0x7fffea4449f0) at git.c:379
 4  0x0000000000404547 in main (argc=3, argv=0x7fffea4449f0) at git.c:443
 5  0x000000349fd1c784 in __libc_start_main () from /lib64/libc.so.6
 6  0x0000000000403ef9 in ?? ()
 7  0x00007fffea4449d8 in ?? ()
 8  0x0000000000000000 in ?? ()

I then remembered, my .bashrc has this..

export MALLOC_PERTURB_=$(($RANDOM % 255 + 1))

which is handy for showing up such bugs.

More info on this glibc feature is at http://udrepper.livejournal.com/11429.html

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
Dave Jones, Mon, Apr 28, 2008 20:41:38 +0200:
> (gdb) bt
> #0  0x000000349fd6d44b in free () from /lib64/libc.so.6
> #1  0x000000000048f4eb in transport_unlock_pack (transport=0x7ce530) at transport.c:811
> #2  0x000000349fd31b25 in exit () from /lib64/libc.so.6

atexit strikes again. Besides, I believe, do_fetch has no bussiness in
deallocation of resources it did not allocate.

 builtin-fetch.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 139a6b1..167f948 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -577,8 +577,6 @@ static int do_fetch(struct transport *transport,
 		free_refs(ref_map);
 	}
 
-	transport_disconnect(transport);
-
 	return 0;
 }
 
@@ -599,6 +597,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	int i;
 	static const char **refs = NULL;
 	int ref_nr = 0;
+	int exit_code;
 
 	/* Record the command line for the reflog */
 	strbuf_addstr(&default_rla, "fetch");
@@ -652,6 +651,9 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	signal(SIGINT, unlock_pack_on_signal);
 	atexit(unlock_pack);
-	return do_fetch(transport,
+	exit_code = do_fetch(transport,
 			parse_fetch_refspec(ref_nr, refs), ref_nr);
+	transport_disconnect(transport);
+	transport = NULL;
+	return exit_code;
 }
-- 
1.5.5.1.118.g6dd1b6.dirty
