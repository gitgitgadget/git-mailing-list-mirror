From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Errors cloning large repo
Date: Sat, 17 Mar 2007 14:23:28 +0100
Message-ID: <200703171423.29265.jnareb@gmail.com>
References: <645002.46177.qm@web52608.mail.yahoo.com> <200703121209.35052.jnareb@gmail.com> <20070312142451.GC15150@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 17 14:20:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSYq3-0005Dk-DX
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 14:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965525AbXCQNUt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 09:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933874AbXCQNUt
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 09:20:49 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:48381 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933826AbXCQNUs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 09:20:48 -0400
Received: by nf-out-0910.google.com with SMTP id b2so587361nfe
        for <git@vger.kernel.org>; Sat, 17 Mar 2007 06:20:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=s28X+CRam5WBmg8orpPr5wcVuHkvth5LYM/estAX8jibKzbjRii1P2wQkuf8xxTWPatlneOpK45NXktRKC19KQjc7mGWJvw7Z9kL9O56KxtILmIMENwZdpa3ce/rBRQvF+u96Fk+c3n7GJ7d4AJkGHPDCm+Z1V8uy197DcVtgYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sUMbdz52wTs5ui7YsMuJoYMkE2j7DfeAovGr4qws4h/XiuotOxKzAbe3PYO2pmtz5zW2Zlc+oCgtCU9UnRokeECDJhJtVifjt7rE23KgMjnAJbtht0qBGEI661nGw8MjFa0/xfX8t7BbTOj8DCJcTrQJ1bohW22cpPzOVelRA2g=
Received: by 10.78.185.7 with SMTP id i7mr290949huf.1174137646634;
        Sat, 17 Mar 2007 06:20:46 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id y6sm10976569mug.2007.03.17.06.20.44;
        Sat, 17 Mar 2007 06:20:45 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20070312142451.GC15150@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42432>

On Mon, 12 March 2007, Shawn O. Pearce wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:

>> But what would happen if server supporting concatenated packfiles
>> sends such stream to the old client? So I think some kind of protocol
>> extension, or at least new request / new feature is needed for that.
> 
> No, a protocol extension is not required.  The packfile format
> is: 12 byte header, objects, 20 byte SHA-1 footer.  When sending
> concatenated packfiles to a client the server just needs to:
> 
>   - figure out how many objects total will be sent;
>   - send its own (new) header with that count;
>   - initialize a SHA-1 context and update it with the header;
>   - for each packfile to be sent:
>     - strip the first 12 bytes of the packfile;
>     - send the remaining bytes, except the last 20;
>     - update the SHA-1 context with the packfile data;
>   - send its own footer with the SHA-1 context.
> 
> Very simple.  Even the oldest Git clients (pre multi-ack extension)
> would understand that.  That's what's great about the way the
> packfile protocol and disk format is organized.  ;-)

It would be a very nice thing to have, if it is backwards compatibile.
It would ease load to server on clone, even if packs are divided into
large tight archive pack and perhaps a few more current packs to make
dumb transport do not neeed to download everything on [incremental]
fetch.

On fetch... perhaps there should be some configuration variable which
would change balance between load and bandwidth used...

And automatic splitting large pack on client side would help if for
example we have huge repository (non-compressable binaries) and client
has smaller filesystem limit on maximum file size than server.

-- 
Jakub Narebski
Poland
