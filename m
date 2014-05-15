From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH/RFC] Gitweb: Convert UTF-8 encoded file names
Date: Thu, 15 May 2014 10:04:24 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1405150957520.10221@ds9.cixit.se>
References: <20140514184145.GA25699@localhost.localdomain> <xmqqd2fghvlf.fsf@gitster.dls.corp.google.com> <CANQwDwdh1qQkYi9sB=22wbNnb+g5qv5prCzj2aWhHBbTZhVhdg@mail.gmail.com> <20140515050820.GA30785@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-2?Q?Jakub_Nar=EAbski?= <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Michael Wagner <accounts@mwagner.org>
X-From: git-owner@vger.kernel.org Thu May 15 11:04:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkrap-0006fP-Pz
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 11:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751642AbaEOJEn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 May 2014 05:04:43 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:51358 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751000AbaEOJEl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 05:04:41 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id s4F94R4X016725
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 15 May 2014 11:04:28 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id s4F94Pw2016721;
	Thu, 15 May 2014 11:04:25 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <20140515050820.GA30785@localhost.localdomain>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Thu, 15 May 2014 11:04:29 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249077>

Michael Wagner:

> Decoding the UTF-8 encoded file name (again with an additional print
> statement):
>
> $ REQUEST_METHOD=3DGET QUERY_STRING=3D'p=3Dnotes.git;a=3Dblob_plain;f=
=3Dwork/G%C3%83%C2%BCtekriterien.txt;hb=3DHEAD' ./gitweb.cgi
>
> work/G=FCtekriterien.txt
> Content-disposition: inline; filename=3D"work/G=FCtekriterien.txt"

You should fix the code path that created that URI, though, as it is=20
not what you expected.

%C3%83 decodes to U+00C3 Latin Capital Letter A With Tilde
%C2%BC decodes to U+00BC Vulgar Graction One Quarter

The proper UTF-8 encoding for =FC (U+00FC) is, as you can probably gues=
s from=20
looking at which two characters the sequence above yielded, C3 BC,=20
which in a URI is represented as %C3%BC.

Your QUERY_STRING should thus be

   p=3Dnotes.git;a=3Dblob_plain;f=3Dwork/G%C3%BCtekriterien.txt;hb=3DHE=
AD

which probably works as expected.

What is happening is that whatever is generating the URI us=20
UTF-8-encoding the string twice (i.e., it generates a string with the=20
proper C3 BC in it, and then interprets it as iso-8859-1 data and runs=20
that through a UTF-8 encoder again, yielding the C3 83 C2 BC sequence=20
you see above).

--=20
\\// Peter - http://www.softwolves.pp.se/
