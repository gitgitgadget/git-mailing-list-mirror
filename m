From: Johannes Sixt <j.sixt@viscovery.net>
Subject: pack bitmap woes on Windows
Date: Wed, 12 Feb 2014 08:27:36 +0100
Message-ID: <52FB2268.7080906@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Vicent_Mart=ED?= <tanoku@gmail.com>,
	Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 12 08:27:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDUEW-0007pr-8I
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 08:27:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbaBLH1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 02:27:43 -0500
Received: from so.liwest.at ([212.33.55.18]:36646 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963AbaBLH1m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 02:27:42 -0500
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WDUEL-0000LB-8X; Wed, 12 Feb 2014 08:27:37 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E012F16613;
	Wed, 12 Feb 2014 08:27:36 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241974>

Running test suite of 'next' on Windows fails in t5310-pack-bitmaps with
the following symptoms. I haven't followed the topic. Have there been
patches floating that addressed the problem in one way or another?

(gdb) run
Starting program: D:\Src\mingw-git\t\trash directory.t5310-pack-bitmaps/..\..\git.exe rev-list --test-bitmap HEAD
[New thread 3528.0x8d4]
Bitmap v1 test (20 entries loaded)
Found bitmap for 537ea4d3eb79c95f602873b1167c480006d2ac2d. 64 bits / 15873b36 checksum

Breakpoint 1, die (err=0x5939e9 "Out of memory, realloc failed") at usage.c:97
97              if (die_is_recursing()) {
(gdb) bt
#0  die (err=0x5939e9 "Out of memory, realloc failed") at usage.c:97
#1  0x00487c4c in xrealloc (ptr=0x12b10008, size=837107040) at wrapper.c:109
#2  0x0055572b in ewah_to_bitmap (ewah=0xe58c18) at ewah/bitmap.c:105
#3  0x005426fc in test_bitmap_walk (revs=0x22f93c) at pack-bitmap.c:954
#4  0x0046b6ae in cmd_rev_list (argc=2, argv=0x3e263c, prefix=0x0)
    at builtin/rev-list.c:329
#5  0x00402048 in run_builtin (p=0x56d41c, argc=3, argv=0x3e263c) at git.c:314
#6  0x0040224f in handle_builtin (argc=3, argv=0x3e263c) at git.c:487
#7  0x00402351 in run_argv (argcp=0x22ff50, argv=0x22ff38) at git.c:533
#8  0x0040257f in mingw_main (argc=3, av=0x3e2638) at git.c:616
#9  0x0040242e in main (argc=4, argv=0x3e2638) at git.c:551
(gdb) up
#1  0x00487c4c in xrealloc (ptr=0x12b10008, size=837107040) at wrapper.c:109
109                             die("Out of memory, realloc failed");
(gdb) up
#2  0x0055572b in ewah_to_bitmap (ewah=0xe58c18) at ewah/bitmap.c:105
105                             bitmap->words = ewah_realloc(
(gdb) l
100             ewah_iterator_init(&it, ewah);
101
102             while (ewah_iterator_next(&blowup, &it)) {
103                     if (i >= bitmap->word_alloc) {
104                             bitmap->word_alloc *= 1.5;
105                             bitmap->words = ewah_realloc(
106                                     bitmap->words, bitmap->word_alloc * sizeof(eword_t));
107                     }
108
109                     bitmap->words[i++] = blowup;
(gdb) info locals
bitmap = (struct bitmap *) 0xe58aa0
it = {buffer = 0xe58cd0, buffer_size = 2, pointer = 1, compressed = 52981705,
  literals = 0, rl = 2141159439, lw = 8259520, b = 1}
blowup = 18446744073709551615
i = 69758920
(gdb) info args
ewah = (struct ewah_bitmap *) 0xe58c18
(gdb)

This is after "not ok 3 - rev-list --test-bitmap verifies bitmaps".
Numerous further test cases fail, but I didn't look at them.

-- Hannes
