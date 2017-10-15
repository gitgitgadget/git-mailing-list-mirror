Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D7D520445
	for <e@80x24.org>; Sun, 15 Oct 2017 15:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751767AbdJOPTK convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sun, 15 Oct 2017 11:19:10 -0400
Received: from mail2.pdinc.us ([67.90.184.28]:38334 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751258AbdJOPTK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Oct 2017 11:19:10 -0400
X-Greylist: delayed 3795 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Oct 2017 11:19:09 EDT
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id v9FEFrsd018234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 15 Oct 2017 10:15:53 -0400
Reply-To: "Joris Valette" <joris.valette@gmail.com>, <git@vger.kernel.org>
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     "'Joris Valette'" <joris.valette@gmail.com>, <git@vger.kernel.org>
References: <CA+o7MD8bhXWxy2M7z++jrq+k85SwzdEV6uwnUjV9=0_X99=VJg@mail.gmail.com>
In-Reply-To: <CA+o7MD8bhXWxy2M7z++jrq+k85SwzdEV6uwnUjV9=0_X99=VJg@mail.gmail.com>
Subject: RE: Consider escaping special characters like 'less' does
Date:   Sun, 15 Oct 2017 10:15:52 -0400
Organization: PD Inc
Message-ID: <773EDE3B5FDB48AD8FB0DB048CAEC8DE@blackfat>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdNFukBdEf5yvB8nRNOsfqFzTnhlUQAA/C8A
X-MimeOLE: Produced By Microsoft MimeOLE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -----Original Message-----
> From: Joris Valette
> Sent: Sunday, October 15, 2017 9:34 AM
> To: git@vger.kernel.org
> Subject: Consider escaping special characters like 'less' does
> 
> The pager 'less' escapes some characters when calling 'git diff'. This
> is what I might get:
> 
> $ git diff --cached
> diff --git a/some_file b/some_file
> new file mode 100644
> index 0000000..357323f
> --- /dev/null
> +++ b/some_file
> @@ -0,0 +1 @@
> +<U+FEFF>Hello
> \ No newline at end of file
> 
> This example is a simple file encoded in UTF-8 *with BOM*.
> On the other hand, the built-in git output shows this:
> 
> $ git --no-pager diff --cached
> diff --git a/some_file b/some_file
> new file mode 100644
> index 0000000..357323f
> --- /dev/null
> +++ b/some_file
> @@ -0,0 +1 @@
> +?Hello
> \ No newline at end of file

It is your terminal, not git's fault that you get a ? rendered.

$ git diff
diff --git a/test.txt b/test.txt
index af9f93a..294e397 100644
--- a/test.txt
+++ b/test.txt
@@ -1 +1 @@
-the quick brown fox jumps over the lazy dog
+<U+FEFF>the quick brown fox jumps over the lazy dog

$ git diff | hexdump.exe -C
00000000  64 69 66 66 20 2d 2d 67  69 74 20 61 2f 74 65 73  |diff --git a/tes|
00000010  74 2e 74 78 74 20 62 2f  74 65 73 74 2e 74 78 74  |t.txt b/test.txt|
00000020  0a 69 6e 64 65 78 20 61  66 39 66 39 33 61 2e 2e  |.index af9f93a..|
00000030  32 39 34 65 33 39 37 20  31 30 30 36 34 34 0a 2d  |294e397 100644.-|
00000040  2d 2d 20 61 2f 74 65 73  74 2e 74 78 74 0a 2b 2b  |-- a/test.txt.++|
00000050  2b 20 62 2f 74 65 73 74  2e 74 78 74 0a 40 40 20  |+ b/test.txt.@@ |
00000060  2d 31 20 2b 31 20 40 40  0a 2d 74 68 65 20 71 75  |-1 +1 @@.-the qu|
00000070  69 63 6b 20 62 72 6f 77  6e 20 66 6f 78 20 6a 75  |ick brown fox ju|
00000080  6d 70 73 20 6f 76 65 72  20 74 68 65 20 6c 61 7a  |mps over the laz|

Note: 0a is newline, 2b is + ef bb bf are the specials added to the file, 74 68 65 20 71 75 is 'the qu'

00000090  79 20 64 6f 67 0a 2b ef  bb bf 74 68 65 20 71 75  |y dog.+...the qu|
000000a0  69 63 6b 20 62 72 6f 77  6e 20 66 6f 78 20 6a 75  |ick brown fox ju|
000000b0  6d 70 73 20 6f 76 65 72  20 74 68 65 20 6c 61 7a  |mps over the laz|
000000c0  79 20 64 6f 67 0a                                 |y dog.|
000000c6

$ git diff | cat
diff --git a/test.txt b/test.txt
index af9f93a..294e397 100644
--- a/test.txt
+++ b/test.txt
@@ -1 +1 @@
-the quick brown fox jumps over the lazy dog
+﻿the quick brown fox jumps over the lazy dog

$ git --no-pager diff
diff --git a/test.txt b/test.txt
index af9f93a..294e397 100644
--- a/test.txt
+++ b/test.txt
@@ -1 +1 @@
-the quick brown fox jumps over the lazy dog
+﻿the quick brown fox jumps over the lazy dog

And my UTF-8 capable terminal displays it fine.

What do you get when you pipe to hexdump?

-Jason

