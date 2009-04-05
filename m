From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: [PATCH 1/4] sha1-lookup: add new "sha1_pos" function to 
	efficiently lookup sha1
Date: Sun, 5 Apr 2009 21:39:44 +0100
Message-ID: <3f4fd2640904051339h8d31d73t40d79b03ba121e1c@mail.gmail.com>
References: <20090404225926.a9ad50e0.chriscool@tuxfamily.org>
	 <fabb9a1e0904050317o1399118erb15ddf86d0fe6c3c@mail.gmail.com>
	 <7vvdpjrkp0.fsf@gitster.siamese.dyndns.org>
	 <94a0d4530904051219q7d9ed028jd6e05f541d7c12b5@mail.gmail.com>
	 <3f4fd2640904051231x17117a4g3efe38067c8d3359@mail.gmail.com>
	 <7vocvaq36x.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 22:46:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqZ9d-00057N-1e
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 22:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551AbZDEUjt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 16:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757376AbZDEUjs
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 16:39:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:1312 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbZDEUjr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Apr 2009 16:39:47 -0400
Received: by fg-out-1718.google.com with SMTP id 16so157724fgg.17
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 13:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=heMcFwcU7ht7M0pxqOCB5s6N8TzUtcAA8X4xQtDVeGo=;
        b=MnYCXAj4cNk9utW60H4/mFO794GbBMkDdab9zSMm8xkh4G4GqacoPPOu6R5Gw62YBS
         e+uRWYYcUIHgdC62K6TapymlRecFy3LOyRPJ2yNlcWH4ZGnXj8Gg7eYt94/zPT5bHE89
         W4c+9NyBAHSZZ+6DKz0lCej5bvS0S+Y82K6qI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oDxlyznLVqNLOwwt1rkey+8YFDJYmjVr0vjoNnQAe0uzZm+BK3t2ROtJ66FgpFh+bp
         D2lqJ++BIfb9m391nsBihOVzpSIMee4wANSf8SZv+CpyQiJ8wt11vPKeZguOryzwk32k
         ElMMe32N1/t/0dS6PrtmUp4YODsLTk1Ke7wlY=
Received: by 10.239.133.65 with SMTP id 1mr78169hbu.150.1238963984283; Sun, 05 
	Apr 2009 13:39:44 -0700 (PDT)
In-Reply-To: <7vocvaq36x.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115704>

2009/4/5 Junio C Hamano <gitster@pobox.com>:
> Reece Dunn <msclrhd@googlemail.com> writes:
>
>> 2009/4/5 Felipe Contreras <felipe.contreras@gmail.com>:
>>>
>>> Huh?
>>
>> I think Junio is trying to learn base64 :)!
>
> I think that is what my Gnus/message-mode did. =A0I do not know which=
 letter
> triggered it to decide it is UTF-8 to begin with, though. =A0As far a=
s I am
> aware, I didn't type anything non-ascii in my message.

Ok, so digging a little deeper, `base64 -d | od -t x1` gives the
following (partial) output:

0000200 6f 74 65 3a 0d 0a 3e 3e 20 2b 20 c2 a0 20 c2 a0

The key entry here is the a0 character (NO-BREAK SPACE) or NBSP.

This is at:
$ base64 -d test | od -t x1 | grep a0 | head -n 1 | xxd -r
ote:
>> +

So looks like it is in the patch you are quoting. NOTE: I have removed
the spaces after the +. Also, according to www.unicode.org, c2 is A^
(A with a circumflex) -- not sure what that is doing there, though.

- Reece
