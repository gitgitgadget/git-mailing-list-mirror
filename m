From: Frans Pop <elendil@planet.nl>
Subject: Extremely slow progress during 'git reflog expire --all'
Date: Fri, 2 Apr 2010 21:54:14 +0200
Message-ID: <201004022154.14793.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 02 21:54:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxmwr-0003lZ-1x
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 21:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754505Ab0DBTy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 15:54:27 -0400
Received: from Cpsmtpm-eml107.kpnxchange.com ([195.121.3.11]:65312 "EHLO
	CPSMTPM-EML107.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754281Ab0DBTyW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 2 Apr 2010 15:54:22 -0400
Received: from aragorn.fjphome.nl ([77.166.180.99]) by CPSMTPM-EML107.kpnxchange.com with Microsoft SMTPSVC(7.0.6001.18000);
	 Fri, 2 Apr 2010 21:54:15 +0200
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-OriginalArrivalTime: 02 Apr 2010 19:54:15.0697 (UTC) FILETIME=[4624E810:01CAD29E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143846>

I wanted to to a 'git gc' on my kernel repo, but that seemed to end in a 
loop: loads of CPU usage, no output. Using 'ps' I found it's not 'git gc' 
itself, but 'git reflog' that's causing the problem.

>From the strace below it does seem like it still makes some progress, but 
I've never had it take anywhere near this long before. Normally it starts 
the count of objects almost immediately.

It's using hardly any memory at all but has one core going flat out.

I'm seeing this with both git 1.6.6.1 and 1.7.0.3 on the same repo.
Environment:
- Debian amd64/Lenny; Core Duo x86_64 2.6.34-rc3 -> 1.6.6.1
- Debian i386/Sid; chroot on the same machine -> 1.7.0.3
I've also tried with 2.6.33 to rule out a kernel issue.

Here's the tail end of an strace I ran. I broke it off after 9+ minutes, 
but I had let it go for longer than that earlier. You can clearly see 
where it starts to "stall" at 21:40:14.

Cheers,
FJP

$ strace -t git reflog expire --all
[...]
21:40:11 open(".git/logs/HEAD.lock", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 4
21:40:11 open(".git/objects/db/315842dd99ce7fd59697df36185df4b807000a", 
O_RDONLY|O_NOATIME) = 23
21:40:11 fstat(23, {st_mode=S_IFREG|0444, st_size=289, ...}) = 0
21:40:11 mmap(NULL, 289, PROT_READ, MAP_PRIVATE, 23, 0) = 0x7f9b135bb000
21:40:11 close(23)                      = 0
21:40:11 munmap(0x7f9b135bb000, 289)    = 0
21:40:11 open(".git/logs/HEAD", O_RDONLY) = 23
21:40:11 fstat(23, {st_mode=S_IFREG|0644, st_size=171397, ...}) = 0
21:40:11 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|
MAP_ANONYMOUS, -1, 0) = 0x7f9b135bb000
21:40:11 read(23, "bea4c899f2b5fad80099aea979780ef19"..., 4096) = 4096
21:40:11 fstat(4, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
21:40:11 mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|
MAP_ANONYMOUS, -1, 0) = 0x7f9b135ba000
21:40:11 read(23, "aca305e8a0209efda740b522024cfdefe"..., 4096) = 4096
21:40:11 read(23, "es\n134a0f063d0c48f08b8731118c4732"..., 4096) = 4096
21:40:12 read(23, "c82b7849a0fe 416c623fe337da58f52a"..., 4096) = 4096
21:40:12 brk(0x2029000)                 = 0x2029000
21:40:12 brk(0x2058000)                 = 0x2058000
21:40:12 brk(0x2080000)                 = 0x2080000
21:40:12 brk(0x20a6000)                 = 0x20a6000
21:40:12 brk(0x20cb000)                 = 0x20cb000
21:40:12 brk(0x20ef000)                 = 0x20ef000
21:40:12 mmap(NULL, 2101248, PROT_READ|PROT_WRITE, MAP_PRIVATE|
MAP_ANONYMOUS, -1, 0) = 0x7f9b133b9000
21:40:12 munmap(0x7f9b156a5000, 1052672) = 0
21:40:12 brk(0x2113000)                 = 0x2113000
21:40:12 brk(0x2138000)                 = 0x2138000
21:40:12 brk(0x215c000)                 = 0x215c000
21:40:12 brk(0x217e000)                 = 0x217e000
21:40:12 brk(0x219f000)                 = 0x219f000
21:40:12 brk(0x21c0000)                 = 0x21c0000
21:40:12 brk(0x21e4000)                 = 0x21e4000
21:40:12 brk(0x2208000)                 = 0x2208000
21:40:12 brk(0x222e000)                 = 0x222e000
21:40:12 brk(0x2252000)                 = 0x2252000
21:40:12 brk(0x2275000)                 = 0x2275000
21:40:12 brk(0x2299000)                 = 0x2299000
21:40:12 brk(0x22bf000)                 = 0x22bf000
21:40:12 brk(0x22e3000)                 = 0x22e3000
21:40:12 brk(0x2309000)                 = 0x2309000
21:40:12 brk(0x232f000)                 = 0x232f000
21:40:12 brk(0x2355000)                 = 0x2355000
21:40:12 brk(0x237a000)                 = 0x237a000
21:40:12 brk(0x239e000)                 = 0x239e000
21:40:12 brk(0x23c4000)                 = 0x23c4000
21:40:12 brk(0x23e8000)                 = 0x23e8000
21:40:12 brk(0x240b000)                 = 0x240b000
21:40:12 brk(0x242e000)                 = 0x242e000
21:40:12 brk(0x2454000)                 = 0x2454000
21:40:13 brk(0x2476000)                 = 0x2476000
21:40:13 brk(0x249b000)                 = 0x249b000
21:40:13 brk(0x24c0000)                 = 0x24c0000
21:40:13 brk(0x24e6000)                 = 0x24e6000
21:40:13 brk(0x250b000)                 = 0x250b000
21:40:13 brk(0x2531000)                 = 0x2531000
21:40:13 brk(0x2556000)                 = 0x2556000
21:40:13 brk(0x2578000)                 = 0x2578000
21:40:13 brk(0x259d000)                 = 0x259d000
21:40:13 mmap(NULL, 4198400, PROT_READ|PROT_WRITE, MAP_PRIVATE|
MAP_ANONYMOUS, -1, 0) = 0x7f9b12fb8000
21:40:13 munmap(0x7f9b133b9000, 2101248) = 0
21:40:13 brk(0x25c5000)                 = 0x25c5000
21:40:13 brk(0x25ee000)                 = 0x25ee000
21:40:13 brk(0x260f000)                 = 0x260f000
21:40:13 brk(0x2633000)                 = 0x2633000
21:40:13 brk(0x2659000)                 = 0x2659000
21:40:13 brk(0x267e000)                 = 0x267e000
21:40:13 brk(0x26a3000)                 = 0x26a3000
21:40:13 brk(0x26c8000)                 = 0x26c8000
21:40:13 brk(0x26ec000)                 = 0x26ec000
21:40:13 brk(0x2712000)                 = 0x2712000
21:40:13 brk(0x2737000)                 = 0x2737000
21:40:13 brk(0x275b000)                 = 0x275b000
21:40:13 brk(0x2780000)                 = 0x2780000
21:40:13 brk(0x27a6000)                 = 0x27a6000
21:40:13 brk(0x27c9000)                 = 0x27c9000
21:40:13 brk(0x27ec000)                 = 0x27ec000
21:40:13 brk(0x2811000)                 = 0x2811000
21:40:13 brk(0x2839000)                 = 0x2839000
21:40:13 brk(0x285d000)                 = 0x285d000
21:40:13 brk(0x2885000)                 = 0x2885000
21:40:13 brk(0x28ac000)                 = 0x28ac000
21:40:13 brk(0x28d0000)                 = 0x28d0000
21:40:13 brk(0x28f5000)                 = 0x28f5000
21:40:13 brk(0x291f000)                 = 0x291f000
21:40:13 brk(0x2943000)                 = 0x2943000
21:40:14 brk(0x2965000)                 = 0x2965000
21:40:14 brk(0x2988000)                 = 0x2988000
21:40:14 brk(0x29ac000)                 = 0x29ac000
21:40:14 brk(0x29d1000)                 = 0x29d1000
21:40:14 brk(0x29f7000)                 = 0x29f7000
21:40:14 brk(0x2a1b000)                 = 0x2a1b000
21:40:20 brk(0x2a3c000)                 = 0x2a3c000
21:40:35 brk(0x2a5d000)                 = 0x2a5d000
21:40:50 brk(0x2a7e000)                 = 0x2a7e000
21:41:06 brk(0x2a9f000)                 = 0x2a9f000
21:41:22 brk(0x2ac0000)                 = 0x2ac0000
21:41:37 brk(0x2ae1000)                 = 0x2ae1000
21:41:52 brk(0x2b02000)                 = 0x2b02000
21:42:08 brk(0x2b23000)                 = 0x2b23000
21:42:22 brk(0x2b44000)                 = 0x2b44000
21:42:37 brk(0x2b65000)                 = 0x2b65000
21:42:52 brk(0x2b86000)                 = 0x2b86000
21:43:07 brk(0x2ba7000)                 = 0x2ba7000
21:43:22 brk(0x2bc8000)                 = 0x2bc8000
21:43:37 brk(0x2beb000)                 = 0x2beb000
21:43:51 read(23, "ab433be0e8a388d3354bdf15937 Frans"..., 4096) = 4096
21:43:53 brk(0x2c0c000)                 = 0x2c0c000
21:44:04 read(23, "nl> 1265475450 +0100\trebase -i (e"..., 4096) = 4096
21:44:04 read(23, "1265475836 +0100\tcommit: parisc: "..., 4096) = 4096
21:44:05 brk(0x2c2d000)                 = 0x2c2d000
21:44:05 read(23, "0\tcheckout: moving from master to"..., 4096) = 4096
21:44:05 read(23, "c84e745ec814f386ef7f454295ba54d64"..., 4096) = 4096
21:44:05 read(23, "792 1ff647af5425c749e4d625b807d3b"..., 4096) = 4096
21:44:05 brk(0x2c54000)                 = 0x2c54000
21:44:05 brk(0x2c75000)                 = 0x2c75000
21:44:12 brk(0x2c96000)                 = 0x2c96000
21:44:25 brk(0x2cb9000)                 = 0x2cb9000
21:44:37 brk(0x2cda000)                 = 0x2cda000
21:44:50 brk(0x2cfb000)                 = 0x2cfb000
21:45:01 brk(0x2d1c000)                 = 0x2d1c000
21:45:14 brk(0x2d3d000)                 = 0x2d3d000
21:45:26 brk(0x2d5e000)                 = 0x2d5e000
21:45:38 brk(0x2d7f000)                 = 0x2d7f000
21:45:50 brk(0x2da0000)                 = 0x2da0000
21:46:03 brk(0x2dc1000)                 = 0x2dc1000
21:46:14 brk(0x2de2000)                 = 0x2de2000
21:46:27 brk(0x2e03000)                 = 0x2e03000
21:46:39 brk(0x2e24000)                 = 0x2e24000
21:46:51 brk(0x2e45000)                 = 0x2e45000
21:47:03 brk(0x2e66000)                 = 0x2e66000
21:47:15 brk(0x2e87000)                 = 0x2e87000
21:47:27 brk(0x2ea8000)                 = 0x2ea8000
21:47:40 brk(0x2ec9000)                 = 0x2ec9000
21:47:52 brk(0x2eea000)                 = 0x2eea000
21:48:04 brk(0x2f0b000)                 = 0x2f0b000
21:48:17 read(23, "ng HEAD\n8d76bb3b759cba01d3cb9f6ab"..., 4096) = 4096
21:48:17 brk(0x2f2d000)                 = 0x2f2d000
21:48:29 brk(0x2f4e000)                 = 0x2f4e000
21:48:42 brk(0x2f6f000)                 = 0x2f6f000
21:48:53 brk(0x2f90000)                 = 0x2f90000
21:49:05 brk(0x2fb1000)                 = 0x2fb1000
21:49:17 brk(0x2fd2000)                 = 0x2fd2000
21:49:29 brk(0x2ff3000)                 = 0x2ff3000
