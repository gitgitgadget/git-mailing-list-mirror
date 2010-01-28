From: Michael Lukashov <michael.lukashov@gmail.com>
Subject: Re: [PATCH v2] Windows: improve performance by avoiding a static 
	dependency on ws2_32.dll and advapi32.dll
Date: Thu, 28 Jan 2010 13:47:19 +0300
Message-ID: <63cde7731001280247w51d32475ob5fa22f796fa50b7@mail.gmail.com>
References: <1264666525-4956-1-git-send-email-michael.lukashov@gmail.com>
	 <4B61543F.6020904@viscovery.net>
	 <63cde7731001280218g29a63094od4f5a8135c6986a4@mail.gmail.com>
	 <alpine.DEB.1.00.1001281137550.3380@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 28 11:47:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaRuJ-0002FO-Td
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jan 2010 11:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177Ab0A1KrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 05:47:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752963Ab0A1KrW
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 05:47:22 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:45328 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915Ab0A1KrV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 05:47:21 -0500
Received: by ewy19 with SMTP id 19so580228ewy.21
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 02:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Mxoj09eaAz0HmIpeSvu1uuUPEqcFP1V6vgLnndtFWKk=;
        b=A+HzfGEE+VpkkoRyirRlBKhvXg987bVPEBsJF0PjGifPyToO0hwTsH/3WW1qWuLKAu
         lr0kwYcXD6uEIFpOapqiDDJQXNY4pCx9aU0FIwTzEBzbmPDyx06ORfAUZ1GaH7phUv+n
         slRibq1/7A6fbyh0qQxmBgGiZ48ocK4QziLkE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=x5V9Gch7Uc40fIl9tgZ3DEaxfrMn2js0kbKJjkEXiCYB46jp+kZJRZWdrvv4QmrFuV
         2fVY2nj6yangiKdRCxPoYg7IPjAsvaG9t0LNf99zP/UPFGOCLfVEL7uDGR4solspv0Tx
         cHpn9ndhsRVCr3A213NYe0vT5isyY26V18D/M=
Received: by 10.216.85.68 with SMTP id t46mr231371wee.114.1264675640003; Thu, 
	28 Jan 2010 02:47:20 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1001281137550.3380@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138246>

>> >
>>
>> "git status" calls ntohs function, which was loaded from ws2_32.dll
>> I've noticed that bswap.h contains implementation of ntohl htonl functions,
>> so I decided to add implementation of ntohs htons functions, which is
>> pretty trivial.
>> After that call to "git status" doesn't load ws2_32.dll
>
> I am still not convinced of that patch, because the timings are still
> missing.
>
> Ciao,
> Dscho
>
>

Oops, sorry for the noise (again).

"git status" calls ntohs function, which was loaded from ws2_32.dll
I've noticed that bswap.h contains implementation of ntohl htonl functions,
so I decided to add implementation of ntohs htons functions, which is
pretty trivial.
After that call to "git status" doesn't load ws2_32.dll

The following commands were run and timed, the
best of five results is shown:

for i in `seq 1 10`;
do
	git status
	git log -n2
	git diff
done

before:
real    0m30.024s
user    0m0.105s
sys     0m0.425s

after:
real    0m29.578s
user    0m0.105s
sys     0m0.318s

The runtime of 'make -j2 test' went down from 35:19min
to 32:39min on my machine.
