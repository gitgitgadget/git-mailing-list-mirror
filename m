Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D3382022A
	for <e@80x24.org>; Mon,  7 Nov 2016 13:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752427AbcKGNnP (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 08:43:15 -0500
Received: from ud03.udmedia.de ([194.117.254.43]:48254 "EHLO
        mail.ud03.udmedia.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752672AbcKGNnK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 08:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=jump-ing.de; h=subject:to
        :references:cc:from:message-id:date:mime-version:in-reply-to
        :content-type:content-transfer-encoding; s=k1; bh=1o38G+C5edTxVM
        +1GReSkDOz9+9kST6gEsx/fEyqrZM=; b=kbfbpQGrOocbJMPwoCEJ2YT5dkv1XV
        Fi47knOqseuqY3Gs/IH4uNVDGPiEZ3n2xlP/YVMzlmn+5XPkT/wb2VK7Wu7h18CR
        jcXkjM9LRNpajmd31tkPIRvQ7d1VFDcXE3EA233oudzFjl9IzHAN8Ix3r1/UhX1T
        iJ7TkNzQvfo6Y=
Received: (qmail 25998 invoked from network); 7 Nov 2016 14:43:05 +0100
Received: from hsi-kbw-37-209-119-31.hsi15.kabel-badenwuerttemberg.de (HELO ?10.0.0.102?) (ud03?291p1@37.209.119.31)
  by mail.ud03.udmedia.de with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256 encrypted, authenticated); 7 Nov 2016 14:43:05 +0100
Subject: Re: gitk: avoid obscene memory consumption
To:     Paul Mackerras <paulus@ozlabs.org>
References: <47c374cf-e6b9-8cd3-ee0d-d877e9e96a62@jump-ing.de>
 <CAGZ79kbavzGJ2sAcz5heg+BO+tZ=TgtrhxMH1-kqeJUpNNavyw@mail.gmail.com>
 <20161105110845.GA4039@fergus.ozlabs.ibm.com>
 <ff5bb36b-e30c-3998-100d-789b4b5e7249@jump-ing.de>
 <20161107041138.rnlzyuacoezsfwif@oak.ozlabs.ibm.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
From:   Markus Hitter <mah@jump-ing.de>
Message-ID: <3b16a0f5-46e3-b41c-553a-473ad3e9cf26@jump-ing.de>
Date:   Mon, 7 Nov 2016 14:43:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20161107041138.rnlzyuacoezsfwif@oak.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.11.2016 um 05:11 schrieb Paul Mackerras:
>> - Storing only the actually viewed diff. It's an interactive tool, so there's no advantage in displaying the diff in 0.001 seconds over viewing it in 0.1 seconds. As far as I can see, Gitk currently stores every diff it gets a hold of forever.
> It does?  That would be a bug. :)
> 

So far I've found three arrays being populated lazily (which is good) but never being released (which ignores changes to the underlying repo):

$commitinfo: one entry of about 500 bytes per line viewed in the list of commits. Maximum size of the array is the number of commits. As far as I can see, this array should be removed on a reload (Shift-F5).

$blobdifffd: one entry of about 45 bytes for every commit ever read. The underlying file descriptor gets closed, but the entry in this array remains. So far I didn't find the reason why this array exists at all. It's also not removed on a reload.

$treediffs: always the same number of entries as $blobdiffd, but > 1000 bytes/entry. Removed/refreshed on a reload (good!), different number of entries from that point on.

In case you want to play as well, here's the code I wrote for the investigation, it can be appended right at the bottom of the gitk script:

--------------8<---------------
proc variableSizes {} {
    # Add variable here to get them shown.
    global diffcontext diffids blobdifffd currdiffsubmod commitinfo
    global diffnexthead diffnextnote difffilestart
    global diffinhdr treediffs

    puts "---------------------------------------------------"
    foreach V [info vars] {
	if { ! [info exists $V] } {
	    continue
	}

	set count 0
	set bytes 0
	if [array exists $V] {
	    set count [array size $V]
	    foreach I [array get $V] {
		set bytes [expr $bytes + [string bytelength $I]]
	    }
	} elseif [catch {llength [set $V]}] {
	    set count [llength [set $V]]
#	    set bytes [string bytelength [list {*}[set $V]]]
	} else {
	    set bytes [string bytelength [set $V]]
	}
	puts [format "%20s: %5d items, %10d bytes" $V $count $bytes]
    }

#    catch {
#	set output [memory info]
#	puts $output
#    }

    after 3000 variableSizes
}

variableSizes
-------------->8---------------

[memory info] requires a Tcl with memory debug enabled.


Markus
-- 
- - - - - - - - - - - - - - - - - - -
Dipl. Ing. (FH) Markus Hitter
http://www.jump-ing.de/
