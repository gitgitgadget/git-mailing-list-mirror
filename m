X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [WISH] Store also tag dereferences in packed-refs
Date: Sun, 19 Nov 2006 20:07:07 +0100
Message-ID: <e5bfff550611191107o63d89d8bp5ff4080803a0d784@mail.gmail.com>
References: <e5bfff550611180115j135746a1h916e8ae029d1374d@mail.gmail.com>
	 <7vmz6oeh2k.fsf@assigned-by-dhcp.cox.net>
	 <20061118184345.GO7201@pasky.or.cz>
	 <e5bfff550611181047w6712774fkccc697d312b87c7e@mail.gmail.com>
	 <7vac2oefuz.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550611181628o41e11652ycd17ddad5dd21225@mail.gmail.com>
	 <Pine.LNX.4.64.0611181706250.3692@woody.osdl.org>
	 <e5bfff550611190140n3277ee26v95feba26dd3348fa@mail.gmail.com>
	 <Pine.LNX.4.64.0611190945500.3692@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 19 Nov 2006 19:07:36 +0000 (UTC)
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eaARkliQc/YgjxJEZpnQwJDkZ1onmU8eRtHehtCpsYhYIOtyJnaWtAZsvUIg3q06LTR9f9lGkFlrOhU36BylYs6f+ZKJy+byTg+xFAF7KORwg5FZcWBTgKTKUmKwV7cFT/nUd7xz2OjRlEFtHplSLd86XxrReR3KHECcA3H0L74=
In-Reply-To: <Pine.LNX.4.64.0611190945500.3692@woody.osdl.org>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31855>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gls0q-00084z-St for gcvg-git@gmane.org; Sun, 19 Nov
 2006 20:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933026AbWKSTHa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 14:07:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933037AbWKSTH3
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 14:07:29 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:7320 "EHLO
 py-out-1112.google.com") by vger.kernel.org with ESMTP id S933026AbWKSTH2
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 14:07:28 -0500
Received: by py-out-1112.google.com with SMTP id a29so848976pyi for
 <git@vger.kernel.org>; Sun, 19 Nov 2006 11:07:28 -0800 (PST)
Received: by 10.35.103.12 with SMTP id f12mr3126pym.1163963240398; Sun, 19
 Nov 2006 11:07:20 -0800 (PST)
Received: by 10.35.42.4 with HTTP; Sun, 19 Nov 2006 11:07:07 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On 11/19/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
> So it all looks _almost_ fine..
>
> Except for this one:
>
>    10:19:04.449236 stat64(".git/objects/3a/41a48d139d1425c1d27e3fbe4f511fb7e09e94", {st_mode=S_IFREG|0444, st_size=278, ...}) = 0 <0.817989>
>
> That's a _single_ "stat64()" system call that takes almost a second to
> execute. All the rest are in the millisecond range, and sometimes a
> hundreth of a second or two. Ie doing
>
>         grep -v ' <0.0[012]' tracefile_git_tree.txt
>
> on your tracefile, there's really not a lot of system calls that take a
> long time, and that one stat _really_ stands out (the others are 3 or four
> hundredths of a second, and then suddenly you have one that is 20 times
> longer than even the slowest other ones.
>
> Basically, you seem to have a _single_ object access that takes up half
> the time of the whole program.
>

But why my numbers are bad both in git, in Linux and also qgit (not
posted) local repo? If it is a single case other repos should load
fast.

> It's the object for 'refs/tags/v1.4.4-rc1' in case you care, btw.
>
> > If you want I can repack and prune, but for now I just wait to avoid
> > to corrupt this test case.
>
> What you could try to do is to re-run it a few times (cold-cache) and see
> if those numbers really are stable, and if it's always the same object
> that takes that long.
>

Right now I'm running smartctl -t long  /dev/hda, I was a little bit scared ;-)

When finished I will do additional cold chache (reboot) tests.

> In fact, you could even do a simple
>
>         time ls -l .git/objects/3a/41a48d139d1425c1d27e3fbe4f511fb7e09e94
>
> for the cold-cache case, and see if just even _that_ takes almost a
> second.
>
> If it _is_ stable, there's two possibilities:
>
>  - you have a large and slow disk, and that one object really is way out
>    there on the other side of the disk, and seeking really takes almost a
>    second.
>

Its a Thinkpad 2.5 inches HD, 2 years old (IBM/Hitachi Travelstar 40GNX family)

>    Quite frankly, I expected that the time when a single stat() took
>    almost a second was a decade or more in the past, back in the days of
>    floppy-disks. But what do I know?
>
>  - your disk is failing, and ends up doing error recovery etc.
>

No recent errors are reported:

Stripped from smartctl -a /dev/hda

SMART Attributes Data Structure revision number: 16
Vendor Specific SMART Attributes with Thresholds:
ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE
UPDATED  WHEN_FAILED RAW_VALUE
  1 Raw_Read_Error_Rate     0x000b   100   100   062    Pre-fail
Always       -       0
  2 Throughput_Performance  0x0005   100   100   040    Pre-fail
Offline      -       0
  3 Spin_Up_Time            0x0007   165   165   033    Pre-fail
Always       -       1
  4 Start_Stop_Count        0x0012   097   097   000    Old_age
Always       -       4928
  5 Reallocated_Sector_Ct   0x0033   100   100   005    Pre-fail
Always       -       0
  7 Seek_Error_Rate         0x000b   100   100   067    Pre-fail
Always       -       0
  8 Seek_Time_Performance   0x0005   100   100   040    Pre-fail
Offline      -       0
  9 Power_On_Hours          0x0012   073   073   000    Old_age
Always       -       11832
 10 Spin_Retry_Count        0x0013   100   100   060    Pre-fail
Always       -       0
 12 Power_Cycle_Count       0x0032   099   099   000    Old_age
Always       -       2563
191 G-Sense_Error_Rate      0x000a   100   100   000    Old_age
Always       -       0
192 Power-Off_Retract_Count 0x0032   100   100   000    Old_age
Always       -       117
193 Load_Cycle_Count        0x0012   045   045   000    Old_age
Always       -       558210
194 Temperature_Celsius     0x0002   130   130   000    Old_age
Always       -       42 (Lifetime Min/Max 5/59)
196 Reallocated_Event_Count 0x0032   100   100   000    Old_age
Always       -       1
197 Current_Pending_Sector  0x0022   100   100   000    Old_age
Always       -       0
198 Offline_Uncorrectable   0x0008   100   100   000    Old_age
Offline      -       0
199 UDMA_CRC_Error_Count    0x000a   200   200   000    Old_age
Always       -       0
210 Unknown_Attribute       0x0023   100   100   001    Pre-fail
Always       -       0

SMART Error Log Version: 1
ATA Error Count: 2
        CR = Command Register [HEX]
        FR = Features Register [HEX]
        SC = Sector Count Register [HEX]
        SN = Sector Number Register [HEX]
        CL = Cylinder Low Register [HEX]
        CH = Cylinder High Register [HEX]
        DH = Device/Head Register [HEX]
        DC = Device Command Register [HEX]
        ER = Error register [HEX]
        ST = Status register [HEX]
Powered_Up_Time is measured from power on, and printed as
DDd+hh:mm:SS.sss where DD=days, hh=hours, mm=minutes,
SS=sec, and sss=millisec. It "wraps" after 49.710 days.

Error 2 occurred at disk power-on lifetime: 0 hours (0 days + 0 hours)
  When the command that caused the error occurred, the device was
active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  10 51 01 0f 8e a8 e4  Error: IDNF at LBA = 0x04a88e0f = 78155279

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  20 ff 01 0f 8e a8 e4 00      00:05:26.850  READ SECTOR(S)
  c8 ff 01 0f 8e a8 e4 00      00:05:26.775  READ DMA
  c8 ff 01 00 00 00 e0 00      00:05:26.625  READ DMA
  ca 04 01 ff 52 a8 e4 00      00:03:40.575  WRITE DMA
  c8 04 01 ff 52 a8 e4 00      00:03:40.275  READ DMA

Error 1 occurred at disk power-on lifetime: 0 hours (0 days + 0 hours)
  When the command that caused the error occurred, the device was
active or idle.

  After command completion occurred, registers were:
  ER ST SC SN CL CH DH
  -- -- -- -- -- -- --
  10 51 01 0f 8e a8 e4  Error: IDNF 1 sectors at LBA = 0x04a88e0f = 78155279

  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 ff 01 0f 8e a8 e4 00      00:05:26.775  READ DMA
  c8 ff 01 00 00 00 e0 00      00:05:26.625  READ DMA
  ca 04 01 ff 52 a8 e4 00      00:03:40.575  WRITE DMA
  c8 04 01 ff 52 a8 e4 00      00:03:40.275  READ DMA
  ca 04 7d 73 49 02 e0 00      00:03:40.275  WRITE DMA

SMART Self-test log structure revision number 1
No self-tests have been logged.  [To run self-tests, use: smartctl -t]

>
> (NOTE NOTE NOTE! There could be other reasons for that second delay. If
> the machine was under heavy load, or was running low on memory, maybe the
> long delay was just due to havign to swap things out or run other things
> instead. That's why it might be interesting to see if the number is
> "stable" in that it's always that same object..)
>

No load, no low memory: I quitted everything before to test. I will
test again as soon smartctl finishes.

