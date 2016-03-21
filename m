From: Daniel Stenberg <daniel@haxx.se>
Subject: git master describe segfault
Date: Mon, 21 Mar 2016 10:35:05 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603211025330.20859@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1129329158-203895681-1458552906=:20859"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 21 10:46:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahwPY-0005Ae-0a
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 10:46:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753223AbcCUJqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 05:46:04 -0400
Received: from giant.haxx.se ([80.67.6.50]:45416 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751842AbcCUJqB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 05:46:01 -0400
X-Greylist: delayed 650 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Mar 2016 05:46:00 EDT
Received: from giant.haxx.se (dast@localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.15.2/8.15.2/Debian-3) with ESMTPS id u2L9Z6qQ002601
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <git@vger.kernel.org>; Mon, 21 Mar 2016 10:35:06 +0100
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.15.2/8.15.2/Submit) with ESMTP id u2L9Z5M3002563
	for <git@vger.kernel.org>; Mon, 21 Mar 2016 10:35:06 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289412>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1129329158-203895681-1458552906=:20859
Content-Type: text/plain; format=flowed; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hello good peeps!

I just ran head-first into a segfault that is fully reproducable for me but 
I'm not at all fluent in these internals so I'm not the suitable person to 
offer a fix. Let me instead offer you some fine details:

0. I'm on a Linux box: a reasonably updated Debian unstable.

1. I'm up to date with the latest git master branch of gecko-dev: 
https://github.com/mozilla/gecko-dev (counting a little over 467K commits)

2. I built the current git off the master branch (v2.8.0-rc3-12-g047057b)

3. In the gecko-dev dir, I run 'git describe --contains f495d0cc2'

The outcome is what looks like a fine stack smash due to very very extensive 
recursion:

$ gdb --args ../git/git describe --contains f495d0cc2
(gdb) run
Program received signal SIGSEGV, Segmentation fault.
0x00007ffff7bccf73 in ?? () from /lib/x86_64-linux-gnu/libz.so.1
#0  0x00007ffff7bccf73 in ?? () from /lib/x86_64-linux-gnu/libz.so.1
#1  0x00007ffff7bcc233 in inflate () from /lib/x86_64-linux-gnu/libz.so.1
#2  0x00000000005935d6 in git_inflate (strm=0x7fffff7ff1d0, flush=4) at 
zlib.c:118
#3  0x000000000055d2fd in unpack_compressed_entry (p=0x886b00, 
w_curs=0x7fffff7ff8e8, curpos=83902121, size=242) at sha1_file.c:2087
#4  0x000000000055dcbb in unpack_entry (p=0x886b00, obj_offset=83902119, 
final_type=0x7fffff7ffb50, final_size=0x7fffff7ffb48) at sha1_file.c:2341
#5  0x000000000055d533 in cache_or_unpack_entry (p=0x886b00, 
base_offset=83902119, base_size=0x7fffff7ffb48, type=0x7fffff7ffb50, 
keep_cache=1) at sha1_file.c:2165
#6  0x000000000055ed88 in read_packed_sha1 (sha1=0x170df24 
"w\367\026,ũD\362\b4\001{\216\b[\255\261", <incomplete sequence \335>, 
type=0x7fffff7ffb50, size=0x7fffff7ffb48) at sha1_file.c:2789
#7  0x000000000055f01b in read_object (sha1=0x170df24 
"w\367\026,ũD\362\b4\001{\216\b[\255\261", <incomplete sequence \335>, 
type=0x7fffff7ffb50, size=0x7fffff7ffb48) at sha1_file.c:2837
#8  0x000000000055f0f3 in read_sha1_file_extended (sha1=0x170df24 
"w\367\026,ũD\362\b4\001{\216\b[\255\261", <incomplete sequence \335>, 
type=0x7fffff7ffb50, size=0x7fffff7ffb48, flag=1) at sha1_file.c:2865
#9  0x00000000004b1e2b in read_sha1_file (sha1=0x170df24 
"w\367\026,ũD\362\b4\001{\216\b[\255\261", <incomplete sequence \335>, 
type=0x7fffff7ffb50, size=0x7fffff7ffb48) at cache.h:1008
#10 0x00000000004b2fc9 in parse_commit_gently (item=0x170df20, 
quiet_on_missing=0) at commit.c:383
#11 0x0000000000464627 in parse_commit (item=0x170df20) at ./commit.h:65
#12 0x0000000000464662 in name_rev (commit=0x170df20, tip_name=0x8e9170 
"B2G_1_0_0_20130115070201", generation=87254, distance=87254, deref=0) at 
builtin/name-rev.c:30
#13 0x00000000004647de in name_rev (commit=0x170dee0, tip_name=0x8e9170 
"B2G_1_0_0_20130115070201", generation=87253, distance=87253, deref=0) at 
builtin/name-rev.c:72
#14 0x00000000004647de in name_rev (commit=0x170dea0, tip_name=0x8e9170 
"B2G_1_0_0_20130115070201", generation=87252, distance=87252, deref=0) at 
builtin/name-rev.c:72
#15 0x00000000004647de in name_rev (commit=0x170de60, tip_name=0x8e9170 
"B2G_1_0_0_20130115070201", generation=87251, distance=87251, deref=0) at 
builtin/name-rev.c:72
#16 0x00000000004647de in name_rev (commit=0x170de20, tip_name=0x8e9170 
"B2G_1_0_0_20130115070201", generation=87250, distance=87250, deref=0) at 
builtin/name-rev.c:72
#17 0x00000000004647de in name_rev (commit=0x170dde0, tip_name=0x8e9170 
"B2G_1_0_0_20130115070201", generation=87249, distance=87249, deref=0) at 
builtin/name-rev.c:72

...

#35070 0x00000000004647de in name_rev (commit=0x1172250, tip_name=0x8e9170 
"B2G_1_0_0_20130115070201", generation=52196, distance=52196, deref=0) at 
builtin/name-rev.c:72
#35071 0x00000000004647de in name_rev (commit=0x1172210, tip_name=0x8e9170 
"B2G_1_0_0_20130115070201", generation=52195, distance=52195, deref=0) at 
builtin/name-rev.c:72
#35072 0x00000000004647de in name_rev (commit=0x11721d0, tip_name=0x8e9170 
"B2G_1_0_0_20130115070201", generation=52194, distance=52194, deref=0) at 
builtin/name-rev.c:72

...

and so on, I actually didn't bother to find the end of this but logically I'd 
guess there was about 52194 more stack frames to go!

(gdb) fr 2
#2  0x00000000005935d6 in git_inflate (strm=0x7fffff7ff1d0, flush=4) at 
zlib.c:118
118                     status = inflate(&strm->z,
(gdb) list
113             int status;
114
115             for (;;) {
116                     zlib_pre_call(strm);
117                     /* Never say Z_FINISH unless we are feeding everything 
*/
118                     status = inflate(&strm->z,
119                                      (strm->z.avail_in != strm->avail_in)
120                                      ? 0 : flush);
121                     if (status == Z_MEM_ERROR)
122                             die("inflate: out of memory");

... and the 'strm' struct looks fine to a layman like me:

(gdb) p *strm
$2 = {z = {
     next_in = 0x7fffb234bea9 "x\234\245\216\273\n\003!\020E{\277\302&U 
8\263\352(\204\374\213\343\003\267\330U\304@>?n\237.\267<\\\016g\216\234%\030\353-%\364D\314X\210\302\226\031t\214\316C\304d\035\004\255\vZ\321\303\310\347\224T\b\301\220\211\224La&}\235\213\"`\334,+\214X\034{mDx\317چ\254}\204T\303y\253m\366\326\037\261\035\362\371\003\276$(G\236\064lV\336՚X\364\330\347\314\177ID\331?\362\062\255x\361\005\272qJ\206\225\022x\234\245\214\061n\304 
\020", avail_in = 989839703, total_in = 0, next_out = 0x15d1920 
"x+3\367\377\177", avail_out = 243, total_out = 0, msg = 0x0, state = 
0x1728cd0, zalloc = 0x7ffff7bd0000, zfree = 0x7ffff7bd0010,
     opaque = 0x0, data_type = 0, adler = 1, reserved = 0}, avail_in = 
989839703, avail_out = 243, total_in = 0, total_out = 0,
   next_in = 0x7fffb234bea9 "x\234\245\216\273\n\003!\020E{\277\302&U 
8\263\352(\204\374\213\343\003\267\330U\304@>?n\237.\267<\\\016g\216\234%\030\353-%\364D\314X\210\302\226\031t\214\316C\304d\035\004\255\vZ\321\303\310\347\224T\b\301\220\211\224La&}\235\213\"`\334,+\214X\034{mDx\317چ\254}\204T\303y\253m\366\326\037\261\035\362\371\003\276$(G\236\064lV\336՚X\364\330\347\314\177ID\331?\362\062\255x\361\005\272qJ\206\225\022x\234\245\214\061n\304 
\020", next_out = 0x15d1920 "x+3\367\377\177"}


Let me know what else I can do to help anyone figure this out!

-- 

  / daniel.haxx.se
--1129329158-203895681-1458552906=:20859--
