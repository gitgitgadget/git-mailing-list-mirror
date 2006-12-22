From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>
Subject: Re: specify charset for commits
Date: Fri, 22 Dec 2006 16:09:49 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20061222150948.GA6005@cepheus>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de> <20061221085907.GA2244@cepheus> <Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de> <200612211623.14236.litvinov2004@gmail.com> <7vejqtaz7q.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612220351520.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <junkio@cox.net>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 16:10:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxm2q-0002J0-A2
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 16:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423166AbWLVPJz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 22 Dec 2006 10:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423167AbWLVPJz
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 10:09:55 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:33090 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423166AbWLVPJy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Dec 2006 10:09:54 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1Gxm1x-0000jQ-6V; Fri, 22 Dec 2006 16:09:53 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id kBMF9ojF016412;
	Fri, 22 Dec 2006 16:09:50 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id kBMF9nAJ016411;
	Fri, 22 Dec 2006 16:09:49 +0100 (MET)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <zeisberg@informatik.uni-freiburg.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Alexander Litvinov <litvinov2004@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612220351520.19693@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35178>

Hello Johannes,

Johannes Schindelin wrote:
> The problem is: you cannot easily recognize if it is UTF8 or not,=20
> programatically. There is a good indicator _against_ UTF8, namely the=
=20
> first byte can _only_ be 0xxxxxxx, 110xxxxx, 1110xxxx, 11110xxx. But =
there=20
> is no _positive_ sign that it is UTF8. For example, many umlauts and =
other=20
> special modifications to letters, stay in the range 0x7f-0xff.
That's not the only indication.  Here comes a (Python) function that
checks is string s is correctly UTF-8 encoded:

	def is_utf8_str(s):
	  cnt_furtherbytes =3D 0
	  for c in s:
	    if cnt_furtherbytes > 0:
	      if ord(c) & 0xc0 =3D=3D 0x80:
		cnt_furtherbytes -=3D 1
	      else:
		return False
	    else:
	      if ord(c) < 0x80:
		continue
	      elif ord(c) < 0xc0:
	        return False
	      elif ord(c) < 0xe0:
		cnt_furtherbytes =3D 1
	      elif ord(c) < 0xf0:
		cnt_furtherbytes =3D 2
	      elif ord(c) < 0xf8:
		cnt_furtherbytes =3D 3
	      elif ord(c) < 0xfc:
		cnt_furtherbytes =3D 4
	      elif ord(c) < 0xfe:
		cnt_furtherbytes =3D 5
	      else:
		return False
	  return True

An UTF-8 character is either one byte long with the msb 0 or a sequence
starting with a value between 0xc0 and 0xfd (inclusive) and depending o=
n
that first value up to six further bytes in the range 0x80 to 0xbf.

You could even be more strict by checking for Unicode 3.1 conformance
(i.e. a character has to be encoded in it's shortest form).

Look at utf8(7) for further details.  (This manpage is included in the
Debian manpages package.)

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3D5+choose+3
