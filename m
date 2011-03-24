From: Harald Welte <laforge@gnumonks.org>
Subject: Unable to clone via git protocol / early EOF / index-pack failed
Date: Thu, 24 Mar 2011 11:27:03 +0100
Message-ID: <20110324102703.GH4534@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 11:27:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2hlK-000315-G5
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 11:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933398Ab1CXK1Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 06:27:24 -0400
Received: from ganesha.gnumonks.org ([213.95.27.120]:50480 "EHLO
	ganesha.gnumonks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932907Ab1CXK1X (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 06:27:23 -0400
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.69)
	(envelope-from <laforge@gnumonks.org>)
	id 1Q2hlC-0006X0-S7
	for git@vger.kernel.org; Thu, 24 Mar 2011 11:27:22 +0100
Received: from laforge by nataraja.de.gnumonks.org with local (Exim 4.72)
	(envelope-from <laforge@gnumonks.org>)
	id 1Q2hku-0001UQ-0H
	for git@vger.kernel.org; Thu, 24 Mar 2011 11:27:04 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169909>

Hi all,

since a couple of days ago, I'm encountering a very strange problem regarding
one of my git-daemon installations.  It started when I updated the kernel on
the git server to Debians "2.6.32-5-openvz-amd64".

However, all openvz limits have been set to 'unlimited', and there is plenty
of memory available, the system is idle otherwise.  The repositories are _very_
small, so I do not think resource limitations are an issue.  Also, thre is no
-ENOMEM or any similar error message from the kernel to git-daemon that would
make OpenVZ resource constraints become a suspect.

This is the output I get on the client side:
---
vishnu:/tmp# GIT_TRACE=1 git clone git://git.osmocom.org/cyberflex-shell.git
trace: built-in: git 'clone' 'git://git.osmocom.org/cyberflex-shell.git'
Initialized empty Git repository in /tmp/cyberflex-shell/.git/
trace: run_command: 'index-pack' '--stdin' '-v' '--fix-thin' '--keep=fetch-pack 19371 on vishnu.netfilter.org'
trace: exec: 'git-index-pack' '--stdin' '-v' '--fix-thin' '--keep=fetch-pack 19371 on vishnu.netfilter.org'
remote: trace: exec: 'git-pack-objects' '--stdout' '--progress' '--delta-base-offset'
remote: trace: built-in: git 'pack-objects' '--stdout' '--progress' '--delta-base-offset'
remote: Counting objects: 1310, done.
remote: Compressing objects: 100% (341/341), done.
remote: Total 1310 (delta 968), reused 1299 (delta 963)
fatal: The remote end hung up unexpectedly
fatal: early EOF
fatal: index-pack failed
---

The output on the server side looks normal:
---
trace: run_command: '/root/git/git-daemon' '--serve' '--verbose' '--base-path=/srv/gitosis/repositories' '/srv/gitosis/repositories'
[27202] Connection from 82.99.25.66:5329
[27202] Extended attributes (22 bytes) exist <host=git.osmocom.org>
[27202] Request upload-pack for '/openggsn.git'
trace: run_command: 'upload-pack' '--strict' '--timeout=0' '.'
[27202] trace: exec: 'git' 'upload-pack' '--strict' '--timeout=0' '.'
[27202] trace: exec: 'git-upload-pack' '--strict' '--timeout=0' '.'
[27202] trace: run_command: 'pack-objects' '--stdout' '--progress' '--delta-base-offset'
[24307] [27202] Disconnected
---

When I retry the 'git clone' on the client many times, in about 1 of every 10
to 20 cases it will succeed, but will fail with the same EOF the other 90-95%.

I have tried git version 1.5.6.5, current git.git master, and 1.7.2.5 - they
all show the same problem, though I had the feeling that git.git master has
a higher probability of success.

The probability of successful cloning also seems to be influenced by the amount
of latency between the server and the client.  If I run it on the same machine
it always works, if I run it on the same ethernet segment, it almost always works,
and via internet it almost always fails.

Looking at a strace of git-daemon, I get a segment close to the process
termination, where a child process is first doing close(1), then fstat(1),
which returns -EBADF.  I'm not sure if this is the cause of the problem,
but it looks strange anyway:
---
[pid 24306] write(1, "X\261_v\312\256\265\240\220\227\350\4\201WA@Y\341y7"..., 20) = 20
[pid 24306] close(1)                    = 0
[pid 24306] brk(0x2411000)              = 0x2411000
[pid 24306] write(2, "Total 102 (delta 58), reused 0 (delta 0)\n"..., 41) = 41
[pid 24306] fstat(1, 0x7fff9070e0a0)    = -1 EBADF (Bad file descriptor)
[pid 24306] exit_group(0)               = ?
Process 24306 detached
[pid 24302] <... write resumed> )       = 7832
[pid 24302] --- SIGCHLD (Child exited) @ 0 (0) ---
[pid 24302] write(1, "0G\n\34182w\227['\307\243\232^cn'H\30\243\25Y\2032yU\24\213\3653+\205`\0309\331kFo\4\330\310wE\4\274kk\244c\32\331HJ\32\300\213r.\272Q\24FF\345\255\355*\260\241d\265\20\225\352F\0102\231Y\4\262:\314Pw\241\4b\16\10\31\205\\\31ma\336#\216\31\251\35\366\350,\234\v\272\374x\336\347\34\344\353\30\201\344z\302\214\n\202\31#\374\332\331\31\340/\256+\300\342\n\374\306w\201\263\26v\261\211$@\250;\370P\335R.]`\252\23c\235\273\306\216@_sd\2325\3450\6|L\5\274\265^D[:hV\t\315\300(z\233\0106\10\270QTL\253\2\376L\275^\247\323{\327\350\235\17{\215\17\262q\246\2546\356\342\2+\271\344\216Ya&p\311\300\227\201\240\17R\207X+z#\225\256\214\275\\0*\252Kz\361\206=r#"..., 360) = 360
[pid 24302] read(6, "jects:  49% (49/99)   \rCompressing objects:  50% (50/99)   \rCompressing objects:  51% (51/99)   \rCompressing objects:  52% (52/9"..., 128) = 128
[pid 24302] write(1, "0085\2"..., 5)    = 5
---

I have tried 'git fsck' and 'git gc' on the server repositories, this caused
no change whatsoever in the behaviour.

I have taken pcap files on the server and client.  They both agree, so I don't
expect any firewall, NAT or other IP device to interfere with the communication.

It is clearly git-daemon who terminates the TCP connection with a [RST,ACK]
packet towards the client.

Do you have any idea how to further debug the problem?  I've been searching
the web for quite soem time, and while I can find a number of reports
describing similar issues, even with small repositories, and as early as 2009,
there is no response or solution to any of those postings.

If you want to experience the problem on the client side, try cloning any
of the repositories listed on http://cgit.osmocom.org/

Regards,
	Harald
-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
