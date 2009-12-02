From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH/RFC] Allow curl to rewind the RPC read buffer at any time
Date: Wed, 2 Dec 2009 11:15:15 +0800
Message-ID: <be6fef0d0912011915u78945c77x29880da3f709a912@mail.gmail.com>
References: <25718488.post@talk.nabble.com>
	 <20091127234110.7b7e9993.rctay89@gmail.com>
	 <alpine.DEB.2.00.0912011208160.5582@cone.home.martin.st>
	 <alpine.DEB.2.00.0912011236360.5582@cone.home.martin.st>
	 <20091201161428.GC21299@spearce.org>
	 <alpine.DEB.2.00.0912011852030.5582@cone.home.martin.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Nicholas Miell <nmiell@gmail.com>, gsky51@gmail.com,
	Clemens Buchacher <drizzd@aon.at>,
	Mark Lodato <lodatom@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: =?ISO-8859-1?Q?Martin_Storsj=F6?= <martin@martin.st>
X-From: git-owner@vger.kernel.org Wed Dec 02 04:15:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFfgf-00066v-Dq
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 04:15:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753736AbZLBDPL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2009 22:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753480AbZLBDPK
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 22:15:10 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:47250 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178AbZLBDPJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2009 22:15:09 -0500
Received: by iwn1 with SMTP id 1so3587937iwn.33
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 19:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RRTYA9u5YeS7rrkKXOvp/Jyft4qByoWWcQmIN+RPAF8=;
        b=ewypEW8AayJ4goQetxoHZxypmGAf8eHA3305I7+THxgueIL+OVneV21H10bBzC3zhq
         IlG62XqPK8m+yhaXTVkytFvnIN7K1lQCL3QxFK8X5H9jvqTpGdb57bHYsw8G/S9JS+3w
         HfCLTVcyHBJ9WpHL7oOkIK8CJKU91dcuIznz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RKSsaCFFkB8JJkgth78p+a7CKoWhmp58Rn+nY5nUK8G/uggyWVBG2k7e/SQ4o+GzfU
         dM6VtFUMDN7zy0wg9zyQltONkZTD2dsQLl0dBoSki1GYqWwU9EGSwenTx1UUt0ih3KRP
         NorUPmUjOVECpNUmKiYxXVFd+GDdoJptfb+L4=
Received: by 10.231.9.33 with SMTP id j33mr1027997ibj.37.1259723715969; Tue, 
	01 Dec 2009 19:15:15 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0912011852030.5582@cone.home.martin.st>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134296>

Hi,

On Wed, Dec 2, 2009 at 12:59 AM, Martin Storsj=F6 <martin@martin.st> wr=
ote:
> On Tue, 1 Dec 2009, Shawn O. Pearce wrote:
>> The *correct* way to support an arbitrary rewind is to modify the
>> outgoing channel from remote-curl to its protocol engine (client.in
>> within the rpc_service method) to somehow request the protocol engin=
e
>> (aka git-send-pack or git-fetch-pack) to stop and regenerate the
>> current request.
>
> That's a good idea!
>
>> Another approach would be to modify http-backend (and the protocol)
>> to support an "auth ping" request prior to spooling out the entire
>> payload if its more than an http.postBuffer size. =A0Basically we
>> do what the "Expect: 100-continue" protocol is supposed to do,
>> but in the application layer rather than the HTTP/1.1 layer, so
>> our CGI actually gets invoked.
>
> That's also quite a good idea, especially if it would be done in a wa=
y so
> that it's certain that the same curl session will be reused, instead =
of
> getting a potentially new curl session when using get_active_slot().

I think restarting the read by killing the protocol engine/client and
starting again would be the easier of the two.

Not just that, it would be neater than storing everything that the
protocol engine has spewed out, like Martin's patch does.

--=20
Cheers,
Ray Chuan
