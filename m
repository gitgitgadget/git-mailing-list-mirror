Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59BAE201A9
	for <e@80x24.org>; Mon, 20 Feb 2017 17:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751316AbdBTR7L convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 20 Feb 2017 12:59:11 -0500
Received: from goliath.siemens.de ([192.35.17.28]:59669 "EHLO
        goliath.siemens.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750920AbdBTR7K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2017 12:59:10 -0500
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
        by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id v1KHx8nL021696
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 18:59:08 +0100
Received: from DEFTHW99ERHMSX.ww902.siemens.net (defthw99erhmsx.ww902.siemens.net [139.22.70.133])
        by mail1.sbs.de (8.15.2/8.15.2) with ESMTPS id v1KHx6xT005460
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
        for <git@vger.kernel.org>; Mon, 20 Feb 2017 18:59:08 +0100
Received: from DENBGAT9EREMSX.ww902.siemens.net (139.22.70.81) by
 DEFTHW99ERHMSX.ww902.siemens.net (139.22.70.133) with Microsoft SMTP Server
 (TLS) id 14.3.339.0; Mon, 20 Feb 2017 18:59:07 +0100
Received: from DEFTHW99EH3MSX.ww902.siemens.net ([169.254.1.100]) by
 DENBGAT9EREMSX.ww902.siemens.net ([139.22.70.81]) with mapi id
 14.03.0339.000; Mon, 20 Feb 2017 18:59:06 +0100
From:   "Sokolov, Konstantin" <konstantin.sokolov.ext@siemens.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Inconsistent results of git blame --porcelain when detecting copies
 from other files
Thread-Topic: Inconsistent results of git blame --porcelain when detecting
 copies from other files
Thread-Index: AdKLoGqv8pkPtzH8SbSXH2hSKQRR8QAAmuIA
Date:   Mon, 20 Feb 2017 17:59:06 +0000
Message-ID: <71BF70CE41AEE741896AF3A5450D86F11F4268FF@DEFTHW99EH3MSX.ww902.siemens.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [139.22.70.11]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Folks!

The issue is best explained on an example. You can reproduce it using the Lucene repo https://github.com/apache/lucene-solr.git. Tested with the following versions:  1.8.1.6 (Ubuntu), 2.11.0.windows.1, 2.11.1.windows.1.

First, let's produce the correct results without using --procelain:

> git blame --show-name --show-number -s -w --abbrev=40 -C -C -C d1165b19726fa0cd13a539827a7cd43237a4feef..10ba9abeb208d37df985e95a742f756de067353f --not f5dba8b76709ff0ef8715b8b288a4b64d4993fa3 -- lucene/src/java/org/apache/lucene/index/DirectoryReader.java

The following excerpt shows lines 501-505 from the output. In particular we can see that lines 502-503 originate from IndexReader.java.

10ba9abeb208d37df985e95a742f756de067353f lucene/src/java/org/apache/lucene/index/DirectoryReader.java 501 501)    * <p>This method
^d1165b19726fa0cd13a539827a7cd43237a4fee lucene/src/java/org/apache/lucene/index/IndexReader.java     496 502)    * returns the version recorded in the commit that the
^d1165b19726fa0cd13a539827a7cd43237a4fee lucene/src/java/org/apache/lucene/index/IndexReader.java     497 503)    * reader opened.  This version is advanced every time
^d1165b19726fa0cd13a539827a7cd43237a4fee lucene/src/java/org/apache/lucene/index/IndexReader.java     498 504)    * a change is made with {@link IndexWriter}.</p>
10ba9abeb208d37df985e95a742f756de067353f lucene/src/java/org/apache/lucene/index/DirectoryReader.java 505 505)    */

The same information can be obtained as well by using --line-porcelain:

> git blame --show-name --show-number --line-porcelain -s -w --abbrev=40 -C -C -C d1165b19726fa0cd13a539827a7cd43237a4feef..10ba9abeb208d37df985e95a742f756de067353f --not f5dba8b76709ff0ef8715b8b288a4b64d4993fa3 -- lucene/src/java/org/apache/lucene/index/DirectoryReader.java

Here is the output for line 502:

d1165b19726fa0cd13a539827a7cd43237a4feef 496 502 3
author Michael McCandless
author-mail <mikemccand@apache.org>
author-time 1327877325
author-tz +0000
committer Michael McCandless
committer-mail <mikemccand@apache.org>
committer-time 1327877325
committer-tz +0000
summary LUCENE-3725: add optional packing to FSTs
boundary
filename lucene/src/java/org/apache/lucene/index/IndexReader.java
        * returns the version recorded in the commit that the

However, when using --porcelain DirectoryReader.java is reported as the origin of lines 502-504:

> git blame --show-name --show-number --porcelain -s -w --abbrev=40 -C -C -C d1165b19726fa0cd13a539827a7cd43237a4feef..10ba9abeb208d37df985e95a742f756de067353f --not f5dba8b76709ff0ef8715b8b288a4b64d4993fa3 -- lucene/src/java/org/apache/lucene/index/DirectoryReader.java

10ba9abeb208d37df985e95a742f756de067353f 501 501 1
author Uwe Schindler
author-mail <uschindler@apache.org>
author-time 1327879145
author-tz +0000
committer Uwe Schindler
committer-mail <uschindler@apache.org>
committer-time 1327879145
committer-tz +0000
summary Reverse merged revision(s) from lucene/dev/trunk up to 1237502
previous f5dba8b76709ff0ef8715b8b288a4b64d4993fa3 lucene/src/java/org/apache/lucene/index/DirectoryReader.java
filename lucene/src/java/org/apache/lucene/index/DirectoryReader.java
        * <p>This method
d1165b19726fa0cd13a539827a7cd43237a4feef 496 502 3
        * returns the version recorded in the commit that the
d1165b19726fa0cd13a539827a7cd43237a4feef 497 503
        * reader opened.  This version is advanced every time
d1165b19726fa0cd13a539827a7cd43237a4feef 498 504

This is not only inconsistent with the other outputs but the output is also inconsistent in itself because lines 496 -498 do not even exist in a previous version of DirectoryReader.java.

Thanks for any feedback.

Kind Regards
Konstantin Sokolov
