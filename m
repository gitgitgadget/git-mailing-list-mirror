From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH v4] gc: call "prune --expire 2.weeks.ago" by default
Date: Thu, 13 Mar 2008 10:48:50 +0100
Message-ID: <7FB80115-C1E4-4F83-9374-41AB1BDA0579@wincent.com>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site> <7vskywadum.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803112234470.2947@xanadu.home> <alpine.LSU.1.00.0803121833210.1656@racer.site> <47D8193B.901@nrlssc.navy.mil> <m3prtzyens.fsf@localhost.localdomain> <47D83532.70103@nrlssc.navy.mil> <alpine.LSU.1.00.0803122058430.1656@racer.site> <47D83C53.7000602@nrlssc.navy.mil> <7vejaf65q0.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803122153440.1656@racer.site> <7vwso74p33.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803122348210.1656@racer.site> <7vzlt335a5.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803130021520.1656@racer.site> <7vod9j342h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jakub Narebski <jnareb@gmail.com>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 10:53:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZk7t-0004f6-7w
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 10:53:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbYCMJwu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Mar 2008 05:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752002AbYCMJwt
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 05:52:49 -0400
Received: from wincent.com ([72.3.236.74]:38798 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751937AbYCMJwt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Mar 2008 05:52:49 -0400
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m2D9nTcx003637;
	Thu, 13 Mar 2008 04:49:30 -0500
In-Reply-To: <7vod9j342h.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77056>

El 13/3/2008, a las 0:39, Junio C Hamano escribi=F3:

> Ah,...
>
> But C language rules haven't changed in such a way that it =20
> guarantees B to
> be evaluated before A when you write "A >=3D B", have it?
>
> So at least I think you would need something like this if you go that
> route:
>
>  		if (strcmp(value, "now")) {
>                	unsigned long now =3D approxidate("now");
>                	if (approxidate(value) >=3D now)
> 				return error("Invalid %s: '%s'", var, value);
> 			...
> 		}


Are you sure that that alternative provides any guarantees about =20
evaluation order either? (I'm not a compiler expert, nor am I =20
consulting a copy of the standard; but I don't think it does.)

In order to enforce evaluation in the required order I think it might =20
have to be something like this:

	if (strcmp(value, "now")) {
		unsigned long now;
		if ((now =3D approxidate("now")) &&
		    approxidate(value) >=3D now)
			return error("Invalid %s: '%s'", var, value);
		...
	}

ie. the && operator guarantees left to right evaluation order, and =20
since approxidate always returns a non-zero ulong the second =20
expression (after the &&) will always be evaluated.

Cheers,
Wincent
