From: Hin-Tak Leung <hintak.leung@gmail.com>
Subject: Re: object/pack size x5 larger than a fresh clone?
Date: Tue, 27 Jul 2010 22:15:31 +0100
Message-ID: <AANLkTikDGzc5d=1w43eJFyO4JdcHEqYYaEm=1P-LpqCj@mail.gmail.com>
References: <AANLkTimL+wfu+yMPutq2VHD6vO2AtaF_7FpWt8aZPm1c@mail.gmail.com>
	<4C4D42BA.6070900@op5.se>
	<AANLkTimLAROADKgWvEXa9QyyDGbWQGP+9BdbcN4fMHJ0@mail.gmail.com>
	<7v7hkg982j.fsf@alter.siamese.dyndns.org>
	<20100727170317.GC25268@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jul 27 23:15:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdrUw-0008Hi-Rt
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 23:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349Ab0G0VPe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 17:15:34 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:65162 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306Ab0G0VPd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 17:15:33 -0400
Received: by wwj40 with SMTP id 40so1738869wwj.1
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 14:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=tJVvIacUcGqx37p8+isXOpaitjDRRVmRL3deago/BOE=;
        b=BKVrmSI7SqS8XxwEdm7P3lWwsljc+oScvQOIS0hOmbE8NZaA/829UXThIH9vRNAzmC
         8GFKhh4LA3Dcm1Yk26ZtgLUTJc3y/muZ0D2mUE1i2kXxkl2t2fNXoyIB3t1mHzYHxzwJ
         xfZEftldPhTpVXDr58eCP1PQMCEx5mYy19Rec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=f0ghUSIPGrZt5N/aTS/9fO78d8A5MAVeUUNtw1CkJEPRYIeioC38U9Giiz/3ch0gTm
         DT3AkYXMKN1cNwDAjZkspw1Cnf4Rijkfbk+achzDbm1jUF+dDqyBG4jjgUjWwyp9Fu6t
         gkCtAVuhKYB607M7Zt2ajIjVkiCs/V15iRl+Q=
Received: by 10.216.165.132 with SMTP id e4mr9574358wel.86.1280265331953; Tue, 
	27 Jul 2010 14:15:31 -0700 (PDT)
Received: by 10.216.166.15 with HTTP; Tue, 27 Jul 2010 14:15:31 -0700 (PDT)
In-Reply-To: <20100727170317.GC25268@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151998>

On 7/27/10, Shawn O. Pearce <spearce@spearce.org> wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
>> Hin-Tak Leung <hintak.leung@gmail.com> writes:
>>
>> > So I guess these *.idx without a corresponding *.pack are safe to
>> > delete? But git gc or one of the other house keeping commands should
>> > get rid of them though, I think.
>>
>> I agree.  I think the dumb transports like http:// grab *.idx files
>> without downloading corresponding *.pack files when they encounter an
>> object that is not found loose in the originating repository to see which
>> packfile to fetch, but after they are done (or when they are interrupted,
>> for that matter), these *.idx files may not be getting garbage-collected.
>>
>> And they should be, perhaps with or without some grace period (I don't
>> know which offhand---I didn't think this through).
>
> We should GC these, but only after a grace period.
>
> Long ago when I used dumb http it really helped to have the *.idx
> files cached.  If the upstream only did an incremental repack holding
> onto the *.idx files locally meant I didn't need to redownload
> them in order to rule-out those packs as onces interesting for the
> current fetch.
>
> Maybe we just prune those during git fetch if they don't have a
> local *.pack and they don't match a pack listed by the remote's
> objects/info/packs file?

Okay, so they are left-overs from using http:// for fetching but
serves a useful purpose for a limited period. The usual gc --prune
defaults to 2 weeks, is that good enough? Or should there be a longer
grace period?

I only switch over to git:// these last few days after it failing to
fetch for two weeks and it looks like only I have this problem and
around the web, failure-to-fetch seems to indicate an http proxy
problem.

FWIW, my left-over files seems to co-incide with the 2-3 week snapshot
release schedule of  wine. I don't know if any of you is familiar with
wine, but only one person (AJ) has commit rights and he reviews all
patches and does a periodic push, usually just before or after a
snapshot release but occasionally more frequent. My left-overs seems
to co-incide with the first fetch after such a push. My most recent
"permanent" fetch failure is due to the long-awaited wine 1.2 release,
I think.

Thanks for all the insights, and I hope a future git release will
prune some of these left-over files after a period.

Hin-Tak
