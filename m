From: Andy Isaacson <adi@hexapodia.org>
Subject: git hang with corrupted .pack
Date: Tue, 13 Oct 2009 21:22:49 -0700
Message-ID: <20091014042249.GA5250@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 06:30:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxvVM-0005XA-AD
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 06:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbZJNEX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2009 00:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbZJNEX0
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 00:23:26 -0400
Received: from straum.hexapodia.org ([64.81.70.185]:4000 "EHLO
	straum.hexapodia.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbZJNEXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2009 00:23:25 -0400
Received: by straum.hexapodia.org (Postfix, from userid 22448)
	id 2F60A19648; Tue, 13 Oct 2009 21:22:49 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.4.2.3i
X-GPG-Fingerprint: 1914 0645 FD53 C18E EEEF C402 4A69 B1F3 68D2 A63F
X-GPG-Key-URL: http://web.hexapodia.org/~adi/gpg.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130239>

I have a clone of torvalds/linux-2.6.git that got corrupted; many git
commands hang with a backtrace like

% git cat-file -p 60fa3f769f7651a60125a0f44e3ffe3246d7cf39
...

#0  use_pack (p=0x1dcf310, w_cursor=0x7fffb4c0e430, offset=43544957, 
    left=0x7fffb4c0e348) at sha1_file.c:792
#1  0x00000000004990ed in unpack_compressed_entry (p=0x1dcf310, 
    w_curs=0x7fffb4c0e430, curpos=43544957, size=728) at sha1_file.c:1594
#2  0x000000000049b089 in unpack_entry (p=0x1dcf310, obj_offset=43544534, 
    type=0x7fffb4c0e7b4, sizep=0x7fffb4c0e7a8) at sha1_file.c:1821
#3  0x000000000049b5f2 in read_packed_sha1 (
    sha1=0x7fffb4c0e780 "`xxxxxxxxxxxxxxxxxxxxxxxxxxx", 
    type=0x7fffb4c0e7b4, size=0x7fffb4c0e7a8) at sha1_file.c:2054
#4  0x000000000049b6d6 in read_object (
    sha1=0x7fffb4c0e780 "`xxxxxxxxxxxxxxxxxxxxxxxxxxx", 
    type=0x7fffb4c0e7b4, size=0x7fffb4c0e7a8) at sha1_file.c:2142
#5  0x000000000049b765 in read_sha1_file (sha1=0x1dcf310 "", 
    type=0x7fffb4c0e430, size=0x0) at sha1_file.c:2158
#6  0x00000000004128da in cmd_cat_file (argc=<value optimized out>, 
    argv=<value optimized out>, prefix=<value optimized out>)
    at builtin-cat-file.c:125
#7  0x0000000000404293 in handle_internal_command (argc=3, argv=0x7fffb4c0ea30)
    at git.c:246
#8  0x0000000000404454 in main (argc=3, argv=0x7fffb4c0ea30) at git.c:438

(I overwrote the UTF8 that gdb helpfully spewed with 'x'.)

We're looping in unpack_compressed_entry, adding a fprintf immediately
after the call to git_inflate() shows:

git_inflate returned -5 next_in=0x7f5e602bc17d curpos=43544536 avail_in=293462652 avail_out=0
git_inflate returned -5 next_in=0x7f5e602bc17d curpos=43544957 avail_in=293462652 avail_out=0
git_inflate returned -5 next_in=0x7f5e602bc17d curpos=43544957 avail_in=293462652 avail_out=0
git_inflate returned -5 next_in=0x7f5e602bc17d curpos=43544957 avail_in=293462652 avail_out=0
git_inflate returned -5 next_in=0x7f5e602bc17d curpos=43544957 avail_in=293462652 avail_out=0

The pack is corrupt:

% hd -s $((0x2986fd0)) .git/objects/pack/pack-9836f9e49a483ad95e7de546d775a4f247e6ac74.pack
02986fd0  f6 17 44 74 4e d5 98 2d  78 9c 95 51 5d 8b db 30  |..DtN..-x..Q]..0|
02986fe0  10 7c d7 af d8 1f d0 18  cb df 0e a1 04 72 77 10  |.|...........rw.|
02986ff0  b8 f4 a0 97 f7 20 4b ab  58 77 8a 64 24 f9 92 fc  |..... K.Xw.d$...|
02987000  fb ca 4e 08 a5 b4 0f 7d  d3 ce 8e 66 76 77 82 43  |..N....}...fvw.C|
02987010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
02987020  00 00 00 00 00 00 00 00  0f 00 00 00 00 00 00 00  |................|
02987030  0f 00 00 00 33 a4 6d db  94 35 4d 5b 51 74 59 d9  |....3.m..5M[QtY.|
02987040  b5 b4 ca 51 ca a2 2a aa  28 83 88 b9 20 6c 0c bd  |...Q..*.(... l..|
02987050  75 b0 77 d6 08 d8 5d 3f  35 76 a3 0f b0 9a 81 e4  |u.w...]?5v......|
02987060  01 ac 0d 06 36 0c 09 b7  a7 ef 40 69 5d 95 6d 96  |....6.....@i].m.|
02987070  d3 0c 16 69 91 a6 24 a2  27 15 02 3a 78 55 66 f4  |...i..$.'..:xUf.|
02987080  b0 b7 ee 8b 69 e1 61 15  ee af f5 d9 5a 71 4d 74  |....i.a.....ZqMt|
02987090  6c 5f 16 d2 8e 46 b0 a0  ac 49 ac 3b de f4 2a 9a  |l_...F...I.;..*.|
029870a0  15 69 13 f5 ea a8 47 7e  bc bc 2f e1 45 5d 20 9c  |.i....G~../.E] .|
029870b0  2d 74 e3 d1 83 32 10 7a  84 b7 c3 d3 f6 e7 f3 66  |-t...2.z.......f|

and that corruption is almost certainly a kernel bug or hardware
failure, but git shouldn't lock up.

Ilari on #git suggested the following, which does resolve the hangs in
my case.

diff --git a/sha1_file.c b/sha1_file.c
index 4ea0b18..838df82 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1594,6 +1594,8 @@ static void *unpack_compressed_entry(struct packed_git *p,
 		in = use_pack(p, w_curs, curpos, &stream.avail_in);
 		stream.next_in = in;
 		st = git_inflate(&stream, Z_FINISH);
+		if (stream.next_in == in)
+			break;
 		curpos += stream.next_in - in;
 	} while (st == Z_OK || st == Z_BUF_ERROR);
 	git_inflate_end(&stream);

If anyone has a suggestion for how 36 bytes of my .pack got overwritten,
I'm interested in that too; it's a Core 2 Duo (Thinkpad x200) running
Ubuntu Karmic beta with 2.6.31-13 (upgraded from -10 it looks like),
Intel GMA graphics, CONFIG_DMAR=n, ext4 on the internal HDD, which now
that I look at it actually does have a fair number of non-zero SMART
counters:

Device Model:     FUJITSU MHZ2160BH G1
Serial Number:    K60WT8C2HHRS
Firmware Version: 0084000A
User Capacity:    160,041,885,696 bytes
...
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000f   100   100   046    Pre-fail  Always       -       219593
  2 Throughput_Performance  0x0005   100   100   030    Pre-fail  Offline      -       27721728
  3 Spin_Up_Time            0x0003   100   100   025    Pre-fail  Always       -       0
  4 Start_Stop_Count        0x0032   099   099   000    Old_age   Always       -       406
  5 Reallocated_Sector_Ct   0x0033   100   100   024    Pre-fail  Always       -       8589934592000
  7 Seek_Error_Rate         0x000f   100   100   047    Pre-fail  Always       -       112
  8 Seek_Time_Performance   0x0005   100   100   019    Pre-fail  Offline      -       0
  9 Power_On_Hours          0x0032   097   097   000    Old_age   Always       -       1598
 10 Spin_Retry_Count        0x0013   100   100   020    Pre-fail  Always       -       0
 12 Power_Cycle_Count       0x0032   100   100   000    Old_age   Always       -       284
192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age   Always       -       78
193 Load_Cycle_Count        0x0032   100   100   000    Old_age   Always       -       1216
194 Temperature_Celsius     0x0022   100   100   000    Old_age   Always       -       38 (Lifetime Min/Max 21/46)
195 Hardware_ECC_Recovered  0x001a   100   100   000    Old_age   Always       -       247
196 Reallocated_Event_Count 0x0032   100   100   000    Old_age   Always       -       457965568
197 Current_Pending_Sector  0x0012   100   100   000    Old_age   Always       -       0
198 Offline_Uncorrectable   0x0010   100   100   000    Old_age   Offline      -       0
199 UDMA_CRC_Error_Count    0x003e   200   253   000    Old_age   Always       -       0
200 Multi_Zone_Error_Rate   0x000f   100   100   060    Pre-fail  Always       -       10448
203 Run_Out_Cancel          0x0002   100   100   000    Old_age   Always       -       1529011503750
240 Head_Flying_Hours       0x003e   200   200   000    Old_age   Always       -       0

-andy
