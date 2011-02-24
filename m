From: Maaartin-1 <grajcar1@seznam.cz>
Subject: Re: Git pack - repo size doubled
Date: Thu, 24 Feb 2011 11:02:34 +0100
Message-ID: <4D662CBA.4080709@seznam.cz>
References: <ik549p$pq8$1@dough.gmane.org> <20110224083138.GA26439@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 24 11:17:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsYG3-0000s7-KO
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 11:17:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755105Ab1BXKRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 05:17:10 -0500
Received: from smtp.seznam.cz ([77.75.72.43]:37021 "EHLO smtp.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754765Ab1BXKRI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 05:17:08 -0500
X-Greylist: delayed 865 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Feb 2011 05:17:07 EST
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=beta; d=seznam.cz;
	h=X-Seznam-DomainKeys:X-Seznam-SPF:X-Virus-Info:Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Smtpd:X-Seznam-User:X-Session:X-Country:X-QM-Mark;
	b=T9frBjtdfGlh6BmQdNslS98EPDb1BzbOUpRLMSXGC2C5YVip51aa3ArLldWlzQXpd
	qTIufKPS02dMymGHF2GDChrVJQ6TvcNTlO4MUmiWb3GGO8A2wf0lDU7wmM8GnEdnfn8
	FF4hdkzg6uU37/boq6rsu0HxgB4oisV5m5DTf90=
X-Seznam-DomainKeys: unknown
X-Seznam-SPF: neutral
X-Virus-Info: clean
Received: from [10.0.3.100] (188-120-198-24.luckynet.cz [188.120.198.24])
	by email-relay1.go.seznam.cz (Seznam SMTPD 1.2.14@16206) with ESMTP;
	Thu, 24 Feb 2011 11:02:36 +0100 (CET)  
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110224083138.GA26439@sigill.intra.peff.net>
X-Smtpd: 1.2.14@16206
X-Seznam-User: grajcar1@seznam.cz
X-Session: 552
X-Country: CZ
X-QM-Mark: email-qm5<634024248>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167791>

On 11-02-24 09:31, Jeff King wrote:
> On Thu, Feb 24, 2011 at 09:19:06AM +0100, Maaartin wrote:
> 
>> I'm using git version 1.7.3.3 under cygwin (W XP64). When I tried
>>
>> git repack -A -d --depth=255 --window=255 --window-memory=4g
>>
>> I've got the message
>>
>> rm: cannot remove `pack-c75642be5314b1a98ddfcf0d51ac838db4af75ad.pack':
>> Device or resource busy
> 
> Presumably some git process still has the pack open, and Windows can't
> delete open files. The process which removes the old pack is different
> from the one that creates the new pack, so there shouldn't be conflict
> there. Were you running any other git programs at the time?

I was sure I weren't, otherwise I wouldn't have posted this. The problem
was reproducible. But there was EGit, what I didn't thing about. It must
have been the culprit, now it works perfectly.

>> It seems like the file hadn't got closed. The non-deletion of the file
>> roughly doubles the repo size (134070 KiB instead of 67470 KiB).
>>
>> - Can I manually remove the file?
> 
> Probably. Move it (and its associated .idx file) out of the pack
> directory, and then run "git fsck" to make sure all is well.

OK.

>> - If I do it, does "git fsck" suffice to make sure, everything's all right?
> 
> As a general rule, almost certainly, but there is one corner case. "git
> fsck" will proceed from your refs and reflogs and check that nothing is
> missing.
> 
> But it's possible that you had unreferenced objects in the old pack
> which will now be lost. In practice, this doesn't really matter much.
> Due to reflogs, things don't tend to be unreferenced. And even if they
> are, they are probably worthless old cruft that was expired from the
> reflog.
> 
> In your case, it is even more certain. Since you used "-A", unreachable
> objects in the original pack were exploded into loose objects. So
> assuming that process worked correctly, then everything in that pack is
> duplicated.

OK.

>> - Would creating of multiple packs work better? What "--max-pack-size"
>> would you recommend?
> 
> It shouldn't make a difference. This is about removing the old pack; it
> shouldn't matter how many new packs you've made, unless there is some
> bug.

This was meant as a workaround: create more smaller packs, manually
delete the large one, so that in the future maybe only one smaller pack
would get undeleted. But it was my fault and no bug at all.

Thanks a lot.
