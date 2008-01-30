From: Luke Lu <git@vicaya.com>
Subject: Re: [PATCH] Optimize rename detection for a huge diff
Date: Tue, 29 Jan 2008 23:24:13 -0800
Message-ID: <EB54EAD7-EC20-4449-B1A1-DEC5EECD70B3@vicaya.com>
References: <20080127172748.GD2558@does.not.exist> <20080128055933.GA13521@coredump.intra.peff.net> <alpine.LFD.1.00.0801300844170.28476@www.l.google.com> <20080129222007.GA3985@coredump.intra.peff.net> <7vfxwgmf87.fsf@gitster.siamese.dyndns.org> <7vwspskynz.fsf@gitster.siamese.dyndns.org> <7vprvkj58q.fsf_-_@gitster.siamese.dyndns.org> <1AC39411-D78E-4663-A4E0-7B179AAA56EB@vicaya.com>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>, Adrian Bunk <bunk@kernel.org>,
	git@vger.kernel.org
To: Luke Lu <git@vicaya.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 08:25:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK7Jh-0005vi-Gn
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 08:25:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646AbYA3HYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 02:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753541AbYA3HYX
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 02:24:23 -0500
Received: from wx-out-0506.google.com ([66.249.82.239]:42778 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753203AbYA3HYW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 02:24:22 -0500
Received: by wx-out-0506.google.com with SMTP id h31so131693wxd.4
        for <git@vger.kernel.org>; Tue, 29 Jan 2008 23:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        bh=JDDhvin/fNqoxUBlZI8n7MBZGBWNMA5MPhhme1QMKvs=;
        b=soMgiazdGHaWcbeShJGxJU6PonbSSwQRXbiGvn13hObDZeJJEMOWD2bsLz56i3ICGtgrWy540zhqTWO/h8JORAS8f/PIametLjwVSbHaKBgLsC5wn/6ipVHdyVu62GfqJbLswpSZY77hyUzteCcEC7tNzziwfPjFItuZEAUyBkU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        b=HmAx1IH3QJ1svWtIXw56Lm9VbqheDFPiZ1mAzWHaGXhZiMq0+oCu8hOhmQ/+ysfzuhbwsRpI39BYT+So3xvR1trW2G0ZWl6+NBq1j3m1IbNwlKSE/isu+UNe9g4QOoR6pRB7qJ5xCtGtR9qBE4VI8MB+ylz2RibtbFW7ruWYrCY=
Received: by 10.70.25.1 with SMTP id 1mr273225wxy.44.1201677861397;
        Tue, 29 Jan 2008 23:24:21 -0800 (PST)
Received: from ?192.168.7.8? ( [69.181.4.225])
        by mx.google.com with ESMTPS id i37sm1439699wxd.12.2008.01.29.23.24.16
        (version=SSLv3 cipher=OTHER);
        Tue, 29 Jan 2008 23:24:17 -0800 (PST)
In-Reply-To: <1AC39411-D78E-4663-A4E0-7B179AAA56EB@vicaya.com>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72043>

On Jan 29, 2008, at 10:57 PM, Luke Lu wrote:
> On Jan 29, 2008, at 8:40 PM, Junio C Hamano wrote:
>> When there are N deleted paths and M created paths, we used to
>> allocate (N x M) "struct diff_score" that record how similar
>> each of the pair is, and picked the <src,dst> pair that gives
>> the best match first, and then went on to process worse matches.
>>
>> This sorting is done so that when two new files in the postimage
>> that are similar to the same file deleted from the preimage, we
>> can process the more similar one first, and when processing the
>> second one, it can notice "Ah, the source I was planning to say
>> I am a copy of is already taken by somebody else" and continue
>> on to match itself with another file in the preimage with a
>> lessor match.  This matters to a change introduced between
>> 1.5.3.X series and 1.5.4-rc, that lets the code to favor unused
>> matches first and then falls back to using already used
>> matches.
>>
>> This instead allocates and keeps only a handful rename source
>> candidates per new files in the postimage.  I.e. it makes the
>> memory requirement from O(N x M) to O(M).
>>
>> For each dst, we compute similarlity with all sources (i.e. the
>> number of similarity estimate computations is still O(N x M)),
>> but we keep handful best src candidates for each dst.
>
> I can think of cases where you'll throw away better candidates this  
> way. How about using a priority queue of size max(N, M)?
>
> I don't know about the details of the current algorithm but it  
> seems to me that using a naive Rabin Karp fingerprinting approach  
> would not use too much memory: say L is total number of bytes of  
> created files and the fingerprint size S and hash size of 4 bytes.  
> To keep track of M files You only need to keep 8(additional 4 bytes  
> as an index to the file names)*(L/S + M(for filenames)) plus some  
> overhead for the hash table in memory. One pass through D (number  
> of bytes of deleted files) you can get the NxM scores. The score is  
> defined as Wf * Mf + Wt, where Wf is the weight for fingerprinting  
> match and Wt is the weight for title match score; Mf is the  
> fingerprint match score = (number of matching fingerprints)/(number  
> of fingerprints of original (deleted) file). Wf and Wt can be tuned  
> to boost exact basename match.
>
> By pushing the scores into a priority queue you'll get the final  
> top (max(N, M) = K) scores in the end. The computation complexity  
> is really O(D+L+(MxN)logK) and memory requirement O(L)
>
> You can compute the entire linux source tree renaming (24K files  
> and total 260MB uncompressed) this way using only about 92MB of  
> memory in 18 seconds (limited by hash lookup speed, assuming 15M  
> lookups per second based on my past experience).

The estimate is based on fingerprint size of 64 bytes and a 2.4GHz  
C2D class Intel CPU, YMMV. One can trade off the accuracy for less  
memory by using larger fingerprint size and vice versa.

__Luke
