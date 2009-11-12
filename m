From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: Git in next is broken
Date: Thu, 12 Nov 2009 23:17:04 +0100
Message-ID: <4AFC8960.9090808@lsrfire.ath.cx>
References: <alpine.LFD.2.00.0911121513470.16711@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Julian Phillips <julian@quantumfyre.co.uk>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Nov 12 23:17:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8hyk-0006Af-T6
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 23:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702AbZKLWRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 17:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754673AbZKLWRN
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 17:17:13 -0500
Received: from india601.server4you.de ([85.25.151.105]:33806 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754702AbZKLWRM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 17:17:12 -0500
Received: from [10.0.1.101] (p57B7E231.dip.t-dialin.net [87.183.226.49])
	by india601.server4you.de (Postfix) with ESMTPSA id 8D1392F8053;
	Thu, 12 Nov 2009 23:17:16 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <alpine.LFD.2.00.0911121513470.16711@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132802>

Nicolas Pitre schrieb:
> Simply issuing a "git fetch" in my copy of git.git makes glibc complain 
> with this:
> 
> *** glibc detected *** git: corrupted double-linked list: 0x0000000000974180 ***
> 
> The gdb backtrace is:
> 
> (gdb) bt
> #0  0x0000003c76632f05 in raise () from /lib64/libc.so.6
> #1  0x0000003c76634a73 in abort () from /lib64/libc.so.6
> #2  0x0000003c76672438 in __libc_message () from /lib64/libc.so.6
> #3  0x0000003c76677ec8 in malloc_printerr () from /lib64/libc.so.6
> #4  0x0000003c7667a23e in _int_free () from /lib64/libc.so.6
> #5  0x0000003c7667a486 in free () from /lib64/libc.so.6
> #6  0x0000000000493f3f in ref_remove_duplicates (ref_map=0x7562b0)
>     at remote.c:756
> #7  0x0000000000424afc in get_ref_map () at builtin-fetch.c:165
> #8  do_fetch () at builtin-fetch.c:644
> #9  cmd_fetch (argc=<value optimized out>, argv=0x7fffffffe6a0,
>     prefix=<value optimized out>) at builtin-fetch.c:754
> #10 0x0000000000403d83 in run_builtin () at git.c:251
> #11 handle_internal_command (argc=1, argv=0x7fffffffe6a0) at git.c:396
> #12 0x0000000000403f2d in run_argv () at git.c:438
> #13 main (argc=1, argv=0x7fffffffe6a0) at git.c:509
> 
> Bisection reveals the following culprit:
> 
> commit 73cf0822b2a4ffa7ad559d1f0772e39718fc7776
> Author: Julian Phillips <julian@quantumfyre.co.uk>
> Date:   Sun Oct 25 21:28:11 2009 +0000
> 
>     remote: Make ref_remove_duplicates faster for large numbers of refs

Can't reproduce because I don't know how to create duplicate refs, but does
the following help?


 remote.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/remote.c b/remote.c
index 4f9f0cc..10cc985 100644
--- a/remote.c
+++ b/remote.c
@@ -754,6 +754,8 @@ void ref_remove_duplicates(struct ref *ref_map)
 			prev->next = ref_map->next;
 			free(ref_map->peer_ref);
 			free(ref_map);
+			ref_map = next;
+			continue;
 		}
 
 		item = string_list_insert(ref_map->peer_ref->name, &refs);
