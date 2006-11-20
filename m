X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Rename detection at git log
Date: Mon, 20 Nov 2006 12:01:02 +0100
Message-ID: <200611201101.04456.andyparkins@gmail.com>
References: <200611201157.23680.litvinov2004@gmail.com> <200611201022.10656.andyparkins@gmail.com> <7virha4cnm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 20 Nov 2006 11:04:18 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Xy/PVNRY2e4K8Z2nNvLHBCfwBoa6UTBjAcXjC9IXF6yybHcTw4H1AaeW3JG2Qo4K4zAHHOiV2E+qsU/AurwX10AkNABpp3UaMCsJARQkbbg6siDhUurFORonBPsoAB9y4zTUI0613qbMjKWr8BVaRVHvzTp4HDvzOmZeiLNFDz0=
User-Agent: KMail/1.9.5
In-Reply-To: <7virha4cnm.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31903>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gm6wZ-00076R-0W for gcvg-git@gmane.org; Mon, 20 Nov
 2006 12:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755926AbWKTLBo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 20 Nov 2006
 06:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755951AbWKTLBo
 (ORCPT <rfc822;git-outgoing>); Mon, 20 Nov 2006 06:01:44 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:1989 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1755926AbWKTLBn
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2006 06:01:43 -0500
Received: by ug-out-1314.google.com with SMTP id m3so1140883ugc for
 <git@vger.kernel.org>; Mon, 20 Nov 2006 03:01:09 -0800 (PST)
Received: by 10.67.19.17 with SMTP id w17mr3090671ugi.1164020468754; Mon, 20
 Nov 2006 03:01:08 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227]) by mx.google.com with
 ESMTP id 28sm7514513ugc.2006.11.20.03.01.08; Mon, 20 Nov 2006 03:01:08 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Monday 2006 November 20 10:48, Junio C Hamano wrote:

> I wrote the code and you contradict me ;-)?

Sorry; I wasn't so much contradicting that the filtering works exactly as you 
say (of course it must - I don't know anywhere near enough to make that sort 
of assertion).

However, I do think that the problem is not one of filtering.  I was saying 
that "-C" has no practical use.

> in your example, it would give you the creation of fileB, not
> copy.

I'm sure it would - but you had to use --find-copies-harder; -C would not find 
it as a copy.

>  - Renames are only picked up from files that were lost in the
>    same change (i.e. "mv fileA fileB" creates fileB and loses
>    fileA; fileB is checked if it is similar to fileA in the
>    original).

I've found rename detection to be flawless in all my uses.

>  - Copies are only picked up from files that were changed in the
>    same change (i.e. splitting major part of original file and
>    moving it to somewhere else, while leaving a skelton in the
>    original file).  "harder" is needed if the copy original was
>    untouched, as you found out.

Yep; I understand that.  I also understand that it is done for performance 
reasons.  However, since the typical copy will be one where the source 
doesn't change at the same time, I am arguing that the non-hard copy 
detection isn't much use.

> The last one is a compromise between performance and thoroughness,
> and the "harder" is one knob to tweak its behaviour.

I've been poking in tree-diff.c to see if I can understand why it it such a 
performance hog.  I still haven't.  Each file is stored under its hash right?  
So for copy detection why can't you just search for other files with the same 
hash, which I presume is very fast (as it is the basis of what makes git so 
fast)?

I am probably misunderstanding git, but I guess that a copy isn't even needed 
in the database because two files with the same hash in the working copy only 
need storing once and then referencing twice.  So for a copy (again, with my 
simple understanding of git) we'd have:

 commit1 -> tree1 -> fileA = fileA_hash
    ^
    |
 commit2 -> tree2 -> fileA = fileA_hash
                     fileB = fileB_hash

Doesn't that mean that copy detection is just a matter of searching the parent 
commit trees for references to the same hash?


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
