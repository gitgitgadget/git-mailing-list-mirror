From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: Re: Git in next is broken
Date: Thu, 12 Nov 2009 22:45:37 +0000 (GMT)
Message-ID: <alpine.LNX.2.00.0911122239150.6967@reaper.quantumfyre.co.uk>
References: <alpine.LFD.2.00.0911121513470.16711@xanadu.home> <4AFC8960.9090808@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Thu Nov 12 23:52:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8iWh-0007YW-Ss
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 23:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754801AbZKLWwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 17:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754791AbZKLWwP
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 17:52:15 -0500
Received: from electron.quantumfyre.co.uk ([87.106.55.16]:48144 "EHLO
	electron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754771AbZKLWwP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Nov 2009 17:52:15 -0500
Received: from neutron.quantumfyre.co.uk (neutron.quantumfyre.co.uk [212.159.54.235])
	by electron.quantumfyre.co.uk (Postfix) with ESMTP id BA792372266
	for <git@vger.kernel.org>; Thu, 12 Nov 2009 22:52:19 +0000 (GMT)
Received: (qmail 26826 invoked by uid 103); 12 Nov 2009 22:45:37 +0000
Received: from reaper.quantumfyre.co.uk by neutron.quantumfyre.co.uk (envelope-from <julian@quantumfyre.co.uk>, uid 201) with qmail-scanner-2.05st 
 (clamdscan: 0.95.2/10016. spamassassin: 3.2.1. perlscan: 2.05st.  
 Clear:RC:1(212.159.54.234):. 
 Processed in 0.055858 secs); 12 Nov 2009 22:45:37 -0000
Received: from reaper.quantumfyre.co.uk (212.159.54.234)
  by neutron.quantumfyre.co.uk with SMTP; 12 Nov 2009 22:45:37 +0000
X-X-Sender: jp3@reaper.quantumfyre.co.uk
In-Reply-To: <4AFC8960.9090808@lsrfire.ath.cx>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132803>

On Thu, 12 Nov 2009, Ren? Scharfe wrote:

> Nicolas Pitre schrieb:
>> Simply issuing a "git fetch" in my copy of git.git makes glibc complain
>> with this:
>>
>> *** glibc detected *** git: corrupted double-linked list: 0x0000000000974180 ***
>>
>> The gdb backtrace is:
>>
>> (gdb) bt
>> #0  0x0000003c76632f05 in raise () from /lib64/libc.so.6
>> #1  0x0000003c76634a73 in abort () from /lib64/libc.so.6
>> #2  0x0000003c76672438 in __libc_message () from /lib64/libc.so.6
>> #3  0x0000003c76677ec8 in malloc_printerr () from /lib64/libc.so.6
>> #4  0x0000003c7667a23e in _int_free () from /lib64/libc.so.6
>> #5  0x0000003c7667a486 in free () from /lib64/libc.so.6
>> #6  0x0000000000493f3f in ref_remove_duplicates (ref_map=0x7562b0)
>>     at remote.c:756
>> #7  0x0000000000424afc in get_ref_map () at builtin-fetch.c:165
>> #8  do_fetch () at builtin-fetch.c:644
>> #9  cmd_fetch (argc=<value optimized out>, argv=0x7fffffffe6a0,
>>     prefix=<value optimized out>) at builtin-fetch.c:754
>> #10 0x0000000000403d83 in run_builtin () at git.c:251
>> #11 handle_internal_command (argc=1, argv=0x7fffffffe6a0) at git.c:396
>> #12 0x0000000000403f2d in run_argv () at git.c:438
>> #13 main (argc=1, argv=0x7fffffffe6a0) at git.c:509
>>
>> Bisection reveals the following culprit:
>>
>> commit 73cf0822b2a4ffa7ad559d1f0772e39718fc7776
>> Author: Julian Phillips <julian@quantumfyre.co.uk>
>> Date:   Sun Oct 25 21:28:11 2009 +0000
>>
>>     remote: Make ref_remove_duplicates faster for large numbers of refs
>
> Can't reproduce because I don't know how to create duplicate refs, but does
> the following help?
>
>
> remote.c |    2 ++
> 1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index 4f9f0cc..10cc985 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -754,6 +754,8 @@ void ref_remove_duplicates(struct ref *ref_map)
> 			prev->next = ref_map->next;
> 			free(ref_map->peer_ref);
> 			free(ref_map);
> +			ref_map = next;

You don't need this line (this is taken care of in the for(...)).

> +			continue;

Ack. This one however, you do need.  Good catch.

> 		}
>
> 		item = string_list_insert(ref_map->peer_ref->name, &refs);
>

-- 
Julian

  ---
Punishment becomes ineffective after a certain point.  Men become insensitive.
 		-- Eneg, "Patterns of Force", stardate 2534.7
