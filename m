X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-fetching from a big repository is slow
Date: Thu, 14 Dec 2006 23:28:46 +0100
Message-ID: <4581D01E.9020806@op5.se>
References: <200612141340.43925.andyparkins@gmail.com> <4581573E.40803@op5.se> <Pine.LNX.4.63.0612141513130.3635@wbgn013.biozentrum.uni-wuerzburg.de> <4581685D.1070407@op5.se> <C287764F-6755-4291-A87A-3E8816E90B49@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 22:29:25 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
In-Reply-To: <C287764F-6755-4291-A87A-3E8816E90B49@adacore.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34418>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guz4q-0002TO-ES for gcvg-git@gmane.org; Thu, 14 Dec
 2006 23:29:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964888AbWLNW3R (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 17:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964887AbWLNW3R
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 17:29:17 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:41830 "EHLO
 smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S964888AbWLNW3Q (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 17:29:16 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
 by smtp-gw1.op5.se (Postfix) with ESMTP id A2BF16BCBC; Thu, 14 Dec 2006
 23:29:13 +0100 (CET)
To: Geert Bosch <bosch@adacore.com>
Sender: git-owner@vger.kernel.org

Geert Bosch wrote:
> 
> On Dec 14, 2006, at 10:06, Andreas Ericsson wrote:
> 
>> It wouldn't work for this particular case though. In our distribution 
>> repository we have ~300 bzip2 compressed tarballs with an average size 
>> of 3MiB. 240 of those are between 2.5 and 4 MiB, so they don't 
>> drastically differ, but neither do they delta well.
>>
>> One option would be to add some sort of config option to skip 
>> attempting deltas of files with a certain suffix. That way we could 
>> just tell it to ignore *.gz,*.tgz,*.bz2 and everything would work just 
>> as it does today, but a lot faster.
> 
> Such special magic based on filenames is always a bad idea. Tomorrow 
> somebody
> comes with .zip files (oh, and of course .ZIP), then it's .jpg's other
> compressed content. In the end git will be doing lots of magic and still 
> perform
> badly on unknown compressed content.
> 

Hence config option. People can tell git to skip trying to delta 
whatever they want. For this particular mothership repo, we only ever 
work against it when we're at the office, meaning resulting datasize is 
not an issue, but data computation can be a real bottle-neck.

> There is a very simple way of detecting compressed files: just look at the
> size of the compressed blob and compare against the size of the expanded 
> blob.
> If the compressed blob has a non-trivial size which is close to the 
> expanded
> size, assume the file is not interesting as source or target for deltas.
> 
> Example:
>    if (compressed_size > expanded_size / 4 * 3 + 1024) {
>      /* don't try to deltify if blob doesn't compress well */
>      return ...;
>    }
> 

Many compression algorithms generate similar output for similar input. 
Most source-code projects change relatively little between releases, so 
they *could* delta well, it's just that in our repo they don't.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
