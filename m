Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A912207BD
	for <e@80x24.org>; Sun, 23 Apr 2017 14:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1045698AbdDWOvZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 10:51:25 -0400
Received: from lamora.getmail.no ([84.210.184.7]:52381 "EHLO lamora.getmail.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1045695AbdDWOvX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 10:51:23 -0400
Received: from localhost (localhost [127.0.0.1])
        by lamora.getmail.no (Postfix) with ESMTP id 85C8910759E;
        Sun, 23 Apr 2017 16:51:21 +0200 (CEST)
Received: from lamora.getmail.no ([127.0.0.1])
        by localhost (lamora.get.c.bitbit.net [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id FOTc6G7T2cJj; Sun, 23 Apr 2017 16:51:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lamora.getmail.no (Postfix) with ESMTP id 147D31075DB;
        Sun, 23 Apr 2017 16:51:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at lamora.get.c.bitbit.net
Received: from lamora.getmail.no ([127.0.0.1])
        by localhost (lamora.get.c.bitbit.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wvPcaja6NFV2; Sun, 23 Apr 2017 16:51:20 +0200 (CEST)
Received: from perkele.intern.softwolves.pp.se (cm-84.209.33.229.getinternet.no [84.209.33.229])
        by lamora.getmail.no (Postfix) with ESMTPSA id E329310759E;
        Sun, 23 Apr 2017 16:51:20 +0200 (CEST)
Received: from peter (helo=localhost)
        by perkele.intern.softwolves.pp.se with local-esmtp (Exim 4.84_2)
        (envelope-from <peter@softwolves.pp.se>)
        id 1d2IrB-00019Y-CL; Sun, 23 Apr 2017 16:51:21 +0200
Date:   Sun, 23 Apr 2017 15:51:21 +0100 (CET)
From:   Peter Krefting <peter@softwolves.pp.se>
To:     Johannes Sixt <j6t@kdbg.org>
cc:     =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
        git@vger.kernel.org, Keith Goldfarb <keith@blackthorn-media.com>
Subject: Re: [PATCH v2] archive-zip: Add zip64 headers when file size is too
 large for 32 bits
In-Reply-To: <a1504d15-36d6-51f8-f2c9-a6563789bb6f@kdbg.org>
Message-ID: <alpine.DEB.2.11.1704231526450.3944@perkele.intern.softwolves.pp.se>
References: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org> <alpine.DEB.2.11.1704222341300.22361@perkele.intern.softwolves.pp.se> <a1504d15-36d6-51f8-f2c9-a6563789bb6f@kdbg.org>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt:

> Let's get the naming straight: There is no "zip64 local header". There is a 
> "zip64 extra record" for the "zip local header".

Indeed, sorry for the confusion. That's what I get for trying to write 
coherent email at half past midnight :-)

> The zip64 extra data record has an offset field, but since the local 
> header does not have an offset field, the offset field in the 
> corresponding zip64 extra data record is always omitted.

Ah, now I understand, I was a bit confused, as the same code generates 
the central directory entry as the local entry.

>> @@ -376,7 +397,7 @@ static int write_zip_entry(struct archiver_args *args,
>>  	copy_le16(dirent.comment_length, 0);
>>  	copy_le16(dirent.disk, 0);
>>  	copy_le32(dirent.attr2, attr2);
>> -	copy_le32(dirent.offset, zip_offset);
>> +	copy_le32(dirent.offset, clamp_max(zip_offset, 0xFFFFFFFFU, 
>> &clamped));
>
> I don't see any provisions to write the zip64 extra header in the central 
> directory when this offset is clamped. This means that ZIP archives whose 
> size exceed 4GB are still unsupported.

The clamped flag will trigger the inclusion of the zip64 central 
directory, which contains the 64-bit offset. Should the central 
directory entry also have the zip64 extra field?

> These are wrong, I think. Entries that did not overflow must be omitted 
> entirely from the zip64 extra record, not filled with 0. This implies that 
> the payload size (.extra_size) is dynamic.

That is what I was trying to figure out, APPNOTE is extremely vague on 
the subject, but thinking back I recall that you are correct.

-- 
\\// Peter - http://www.softwolves.pp.se/
