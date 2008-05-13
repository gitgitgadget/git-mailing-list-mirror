From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: Why repository grows after "git gc"? / Purpose of *.keep files?
Date: Tue, 13 May 2008 07:08:19 +0200
Message-ID: <48292243.3050307@gnu.org>
References: <20080512122900.GA13050@mithlond.arda.local> <20080512155243.GA3592@mithlond.arda.local> <e1dab3980805121017u4c244d25s76b39cf015f6c5c5@mail.gmail.com> <20080512234906.GX29038@spearce.org> <7vod7bw03a.fsf@gitster.siamese.dyndns.org> <20080513000925.GA29038@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	David Tweed <david.tweed@gmail.com>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue May 13 07:09:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvmlH-00033l-7N
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 07:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525AbYEMFIY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 01:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753760AbYEMFIY
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 01:08:24 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:8642 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621AbYEMFIX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 01:08:23 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2024423fgg.17
        for <git@vger.kernel.org>; Mon, 12 May 2008 22:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        bh=8pdPbF5vJnu/mMvSQT3SusAnX8QCnyC8T7OBKhxySds=;
        b=HuOfCv40SXMpFe3AIdYOoqrC240NcOya3Csl3VI1vTx0M8HHRIhaZKKLG7jtrdVr6mHjPF+dGXeT0d+h/qmDWe9iY1zvljvdK3kVyPLUZUq+71Q9TEoRWCZMbSOD7iFu3tbiTfwimYHrfbxmnr+hEOS6emY/qM6OnOTX5sUybCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=SlQd5qgrXWPj0SN2SgbK/GqLvE3MTKJ4vKKPsW5TPa4Q1XTzeXoOesBrMPNjNFiG/nxd/M1gT49x5vbiRoFOatEJFkLVUMgeEl/EQvTleKZH8k+/zPcBYyUIrv7yg3qf8sYGtOZMx+5OkA/yHnYA4Vj1kZ8XFP9YyYk6lK39hZc=
Received: by 10.86.92.7 with SMTP id p7mr15645159fgb.72.1210655302147;
        Mon, 12 May 2008 22:08:22 -0700 (PDT)
Received: from scientist-2.lan ( [213.140.22.65])
        by mx.google.com with ESMTPS id l19sm7304410fgb.9.2008.05.12.22.08.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 May 2008 22:08:21 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <20080513000925.GA29038@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81987>

Shawn O. Pearce wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>>> I think git-clone marking a 150M linux-2.6 pack with .keep is wrong;
>>> most users working with the linux-2.6 sources have sufficient
>>> hardware to deal with the disk IO required to copy that with 100%
>>> delta reuse.  But I have a repository at day-job with a 600M pack,
>>> that's starting to head into the realm where git-gc while running
>>> on battery on a laptop would prefer to have that .keep.
>> Perhaps clone can decide to keep the .keep file depending on the size of
>> the pack then?
> 
> Yea, I think that's the better thing to do here.  I'm not sure where
> the cut-off is, maybe its <512M delete the .keep once the refs are
> inplace and the objects are ensured to be reachable.

I think separate cutoffs should be in place for file size and number of 
objects.  Very tight packs probably require hours to repack as efficiently.

By the way, another scenario where I used pack files is when I can only 
distribute via http because of firewalls.  I make a clone of the 
original repository and mark the pack as keep; then I push to the 
distribution site, gc, and mark the pack as keep; then I have every day 
a cron job that does git-gc.  This way I know that the user will only 
have to download the third pack.  I think I'll modify the cron job to 
mark as keep the packs that exceed 2 megabytes or something like that.

Thinking about both use cases, the best would be to have options (common 
to git-clone, git-remote add, git-gc at least; and available via config 
keys too) like

   --keep-packs[=THRES1,THRES2,...]

where:

- one threshold would be enough to mark a pack as keep
- thresholds could be in the form "\d+[kmg]?b" for file size, 
"\d+[kmg]?" for number of objects.
- if no threshold is given, the default could be --keep-packs=100k,512MB 
or whatever is in the config.
- to mark all packs, use --keep-packs=0


Paolo
