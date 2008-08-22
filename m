From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Subject: Re: Linux 2.6.27-rc3: kernel BUG at mm/vmalloc.c - bisected
Date: Fri, 22 Aug 2008 14:07:40 -0400
Message-ID: <48AF006C.9030705@hp.com>
References: <48A36838.3050309@hp.com>	<20080819124602.9e8e69f7.akpm@linux-foundation.org>	<48AEDD3D.4060507@hp.com>	<20080822092549.ddcb7e79.akpm@linux-foundation.org>	<20080822171651.GP10544@machine.or.cz> <20080822105136.a8432875.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, linux-kernel@vger.kernel.org,
	git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756639AbYHVSH6@vger.kernel.org Fri Aug 22 20:09:05 2008
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756639AbYHVSH6@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWb4L-0006KJ-9U
	for glk-linux-kernel-3@gmane.org; Fri, 22 Aug 2008 20:09:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756639AbYHVSH6 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 22 Aug 2008 14:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751764AbYHVSHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2008 14:07:49 -0400
Received: from g1t0027.austin.hp.com ([15.216.28.34]:5493 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbYHVSHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2008 14:07:48 -0400
Received: from g1t0038.austin.hp.com (g1t0038.austin.hp.com [16.236.32.44])
	by g1t0027.austin.hp.com (Postfix) with ESMTP id B889F38167;
	Fri, 22 Aug 2008 18:07:45 +0000 (UTC)
Received: from ldl.fc.hp.com (ldl.fc.hp.com [15.11.146.30])
	by g1t0038.austin.hp.com (Postfix) with ESMTP id BD67130062;
	Fri, 22 Aug 2008 18:07:44 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl.fc.hp.com (Postfix) with ESMTP id 64D4439C06D;
	Fri, 22 Aug 2008 12:07:44 -0600 (MDT)
X-Virus-Scanned: Debian amavisd-new at ldl.fc.hp.com
Received: from ldl.fc.hp.com ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gOTlkecTcGwI; Fri, 22 Aug 2008 12:07:42 -0600 (MDT)
Received: from [127.0.0.1] (squirrel.fc.hp.com [15.11.146.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ldl.fc.hp.com (Postfix) with ESMTP id ACC3A39C00C;
	Fri, 22 Aug 2008 12:07:41 -0600 (MDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <20080822105136.a8432875.akpm@linux-foundation.org>
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93338>

Andrew Morton wrote:
> On Fri, 22 Aug 2008 19:16:51 +0200
> Petr Baudis <pasky@suse.cz> wrote:
> 
>> On Fri, Aug 22, 2008 at 09:25:49AM -0700, Andrew Morton wrote:
>>> On Fri, 22 Aug 2008 11:37:33 -0400 "Alan D. Brunelle" <Alan.Brunelle@hp.com> wrote:
>>>
>>>> I /did/ bisect it down to the aforementioned merge, the question is: How
>>>> to crack open that merge into it's composite pieces? (Where do I go to
>>>> bisect within that?)
>>> urgh, it's irritating when git-bisect directs you to a merge commit - it
>>> hasn't done it for me for ages.
>> Hmm, but doesn't that happen only when it's actually really the merge
>> commit that introduces the bug? Both parents of the merge commit were
>> marked as good by the user, so...
> 
> A merge commit doesn't contain any kernel changes?  It's the individual
> commits (aka "patches") which were in that merge which broke stuff. 
> Confused.
> 
> We're trying to dive inside that merge commit to find out which of the
> real commits caused the regression.
> 
>>> One (probably wrong) approach is to run
>>>
>>> 	gitk 1c89ac55017f982355c7761e1c912c88c941483d
>>>
>>> then peer at the output, work out which real commits were in that
>>> merge.
>>>
>>> It looks like the merge ended with
>>> b1b135c8d619cb2c7045d6ee4e48375882518bb5 and started with
>>> 40c42076ebd362dc69210cccea101ac80b6d4bd4, so perhaps you can do
>>>
>>> 	git bisect bad b1b135c8d619cb2c7045d6ee4e48375882518bb5
>>> 	git bisect good 40c42076ebd362dc69210cccea101ac80b6d4bd4
>> ...I don't quite get this - according to the bisection log,
>>
>> 	# good: [b1b135c8d619cb2c7045d6ee4e48375882518bb5] fix spinlock recursion in hvc_console
>>
>> and now you want to mark it as bad?
> 
> <what bisection log?>
> 
> I assume that Alan's bisection search ended up saying that the merge
> commit (1c89ac55017f982355c7761e1c912c88c941483d) was the first bad
> commit.
> 
> Now I don't know what's going on.
> 
>> You could try to revert some of the merged commits at the point of the
>> merge, though.

You're right - this is where the bisection ended up (in fact, just
removing this merge commit allowed later kernels to boot just fine).

I've patched the kernel w/ your suggestion, and now I'm getting
something a bit different - and I'm looking into this...

Begin: Loading essential drivers... ...

[    6.594525] fuse init (API version 7.9)

[    6.618686] ACPI: SSDT CFFD0D0A, 08C4 (r1 HPQOEM  CPU_TM2        1
MSFT  100000E)
[    6.621481] BUG: unable to handle kernel NULL pointer dereference at
0000000000000858
[    6.625017] IP: [<ffffffff8025e282>] debug_mutex_add_waiter+0x32/0x80

[    6.625017] PGD 21a456067 PUD 21a45f067 PMD 0

[    6.625017] Oops: 0002 [1] SMP

[    6.625017] CPU 1

[    6.625017] Modules linked in: processor(+) fan thermal_sys fuse

[    6.625017] Pid: 1259, comm: modprobe Not tainted 2.6.27-rc3 #24

[    6.625017] RIP: 0010:[<ffffffff8025e282>]  [<ffffffff8025e282>]
debug_mutex_add_waiter+0x32/0x80

[    6.625017] RSP: 0018:ffff88021a073998  EFLAGS: 00010002

[    6.625017] RAX: 0000000000000000 RBX: ffff88021a0739d8 RCX:
0000000000000000

[    6.625017] RDX: 0000000000000001 RSI: ffff88021a0739d8 RDI:
ffffffffa0091a60

[    6.625017] RBP: ffff88021a0739b8 R08: ffffffff811deea0 R09:
ffff8800a6fdb000

[    6.625017] R10: ffffffffa008f524 R11: 0000000000000000 R12:
ffffffffa0091a60

[    6.625017] R13: ffff88021a072000 R14: ffff88021a9840a0 R15:
ffffffffa0091a98

[    6.625017] FS:  00007f40ce2de6e0(0000) GS:ffff88022fc02a00(0000)
knlGS:0000000000000000

[    6.625017] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b

[    6.625017] CR2: 0000000000000858 CR3: 000000022d86b000 CR4:
00000000000006e0

[    6.625017] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000

[    6.625017] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7:
0000000000000400

[    6.625017] Process modprobe (pid: 1259, threadinfo ffff88021a072000,
task ffff88021a9840a0)
[    6.625017] Stack:  0000000000000000 ffffffffa0091a60
0000000000000246 ffffffffa008f524

[    6.625017]  ffff88021a073a38 ffffffff8049f556 ffffffffa008f524
ffffffffa0091a18

[    6.625017]  ffff88021a0739d8 ffff88021a0739d8 1111111111111111
1111111111111111

[    6.625017] Call Trace:

[    6.625017]  [<ffffffffa008f524>] ? get_idr+0x44/0xa0 [thermal_sys]

[    6.625017]  [<ffffffff8049f556>] mutex_lock_nested+0xa6/0x250

[    6.625017]  [<ffffffffa008f524>] ? get_idr+0x44/0xa0 [thermal_sys]

[    6.625017]  [<ffffffff80363584>] ? idr_pre_get+0x44/0x90

[    6.625017]  [<ffffffffa008f524>] get_idr+0x44/0xa0 [thermal_sys]

[    6.625017]  [<ffffffffa008fe43>]
thermal_cooling_device_register+0x83/0x250 [thermal_sys]

[    6.625017]  [<ffffffffa019b2a3>] acpi_processor_start+0x64b/0x774
[processor]
[    6.625017]  [<ffffffff8031a90b>] ? __sysfs_add_one+0x6b/0xa0

[    6.625017]  [<ffffffff8031b9fc>] ? sysfs_do_create_link+0xbc/0x150

[    6.625017]  [<ffffffff803a7f1e>] acpi_start_single_object+0x2d/0x52

[    6.625017]  [<ffffffff803a9516>] acpi_device_probe+0x7e/0x92

[    6.625017]  [<ffffffff803dd3ab>] driver_probe_device+0x9b/0x1a0

[    6.625017]  [<ffffffff803dd536>] __driver_attach+0x86/0x90

[    6.625017]  [<ffffffff803dd4b0>] ? __driver_attach+0x0/0x90

[    6.625017]  [<ffffffff803dc8fd>] bus_for_each_dev+0x5d/0x90

[    6.625017]  [<ffffffff803dd1ec>] driver_attach+0x1c/0x20

[    6.625017]  [<ffffffff803dcf39>] bus_add_driver+0x1e9/0x260

[    6.625017]  [<ffffffffa0222000>] ? acpi_processor_init+0x0/0x107
[processor]

[    6.625017]  [<ffffffff803dd70f>] driver_register+0x5f/0x140

[    6.625017]  [<ffffffffa0222000>] ? acpi_processor_init+0x0/0x107
[processor]

[    6.625017]  [<ffffffff803a9826>] acpi_bus_register_driver+0x3e/0x40

[    6.625017]  [<ffffffffa0222094>] acpi_processor_init+0x94/0x107
[processor]

[    6.625017]  [<ffffffff80209040>] _stext+0x40/0x180

[    6.625017]  [<ffffffff802a88d1>] ? __vunmap+0xa1/0x110

[    6.625017]  [<ffffffff80267642>] sys_init_module+0x142/0x1dc0

[    6.625017]  [<ffffffff80367ad6>] ? __up_read+0x46/0xb0

[    6.625017]  [<ffffffff8048e530>] ? cpu_down+0x0/0x70

[    6.625017]  [<ffffffff8020c34b>] system_call_fastpath+0x16/0x1b

[    6.625017]
