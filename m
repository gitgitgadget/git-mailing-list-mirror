From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Errors cloning large repo
Date: Mon, 12 Mar 2007 12:09:33 +0100
Message-ID: <200703121209.35052.jnareb@gmail.com>
References: <645002.46177.qm@web52608.mail.yahoo.com> <esu11i$m54$1@sea.gmane.org> <20070311020013.GD10343@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 12 12:07:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQiMw-0007wc-9M
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 12:07:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965547AbXCLLHH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 07:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965540AbXCLLHG
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 07:07:06 -0400
Received: from mu-out-0910.google.com ([209.85.134.185]:14456 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965547AbXCLLHF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 07:07:05 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1991029muf
        for <git@vger.kernel.org>; Mon, 12 Mar 2007 04:07:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GsO0l5VIZxAdhi17I+BSE11O/81tXdSUhqXjQRWbPZvBatCN27xmdRHYPFAf2N3OQjqB5/H9h+QoVALEvQXsN2V74HD4wlcdQpWcVFfrR19JySP9pb2ABBOfHCt8T1OlLaZuwpQEOCvtclxwFgx4UzGwWFr22AmvdNlzESZmrfM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=dqQQR1US6CiA0g1D4n7rgmdUx363U3MS0F+OAcgISDP5fWnDQVk4svuDSpcdo9QKMMaBDfu4cmDpdDtIZRCCLmK4Fdwx18QwCadbmi0JSEDPIjnfntZ5x58nAbNDtexgqyiLe4iwPR6V5VnJZU2qaTTAerHVlfGU5BWlS4vuzKw=
Received: by 10.82.116.15 with SMTP id o15mr7828313buc.1173697621760;
        Mon, 12 Mar 2007 04:07:01 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id g8sm21446523muf.2007.03.12.04.06.59;
        Mon, 12 Mar 2007 04:07:00 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070311020013.GD10343@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42017>

Shawn O. Pearce wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
>> Shawn O. Pearce wrote:
>> 
>>> One thing that you could do is segment the repository into multiple
>>> packfiles yourself, and then clone using rsync or http, rather than
>>> using the native Git protocol.
>> 
>> By the way, it would be nice to have talked about fetch / clone
>> support for sending (and creating) _multiple_ pack files. Beside
>> the situation where we must use more than one packfile because
>> of size limits, it would also help clone as it could send existing
>> packs and pack only loose objects (trading perhaps some bandwidth
>> with CPU load on the server; think kernel.org).
> 
> I've thought about adding that type of protocol extension on
> more than one occasion, but have now convinced myself that it is
> completely unnecessary.  Well at least until a project has more
> than 2^32-1 objects anyway.
> 
> The reason is we can send any size packfile over the network; there
> is no index sent so there is no limit on how much data we transfer.
> We could easily just dump all existing packfiles as-is (just clip
> the header/footers and generate our own for the entire stream)
> and then send the loose objects on the end.

But what would happen if server supporting concatenated packfiles
sends such stream to the old client? So I think some kind of protocol
extension, or at least new request / new feature is needed for that.

Wouldn't it be better to pack loose objects into separate pack
(and perhaps save it, if some threshold is crossed, and we have
writing rights to repo), by the way?

> The client could easily segment that into multiple packfiles
> locally using two rules:
> 
>   - if the last object was not a OBJ_COMMIT and this object is
>   an OBJ_COMMIT, start a new packfile with this object.
> 
>   - if adding this object to the current packfile exceeds my local
>   filesize threshold, start a new packfile.
> 
> The first rule works because we sort objects by type, and commits
> appear at the front of a packfile.  So if you see a non-commit
> followed by a commit, that's the packfile boundary that the
> server had.
> 
> The second rule is just common sense.  But I'm not sure the first
> rule is even worthwhile; the server's packfile boundaries have no
> real interest for the client.

Without first rule, wouldn't client end with strange packfile?
Or would it have to rewrite a pack?

-- 
Jakub Narebski
Poland
