From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [RFC] multi_ack protocol v2
Date: Thu, 27 Oct 2005 14:16:19 +0400
Message-ID: <20051027141619.0e8029f2.vsu@altlinux.ru>
References: <Pine.LNX.4.63.0510270149590.12163@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vzmov4elu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__27_Oct_2005_14_16_19_+0400_wn/gAjENG4ahAEiy"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 27 12:18:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EV4oW-000362-7T
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 12:16:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932629AbVJ0KQa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 06:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932632AbVJ0KQa
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 06:16:30 -0400
Received: from mivlgu.ru ([81.18.140.87]:7654 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S932629AbVJ0KQ3 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Oct 2005 06:16:29 -0400
Received: from master.mivlgu.local (master.mivlgu.local [192.168.1.230])
	by mail.mivlgu.ru (Postfix) with SMTP
	id E5A6F801B; Thu, 27 Oct 2005 14:31:58 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmov4elu.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Sylpheed version 1.0.0beta4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10710>

--Signature=_Thu__27_Oct_2005_14_16_19_+0400_wn/gAjENG4ahAEiy
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 27 Oct 2005 00:13:17 -0700 Junio C Hamano wrote:

[skip]
> So let's illustrate the v2 the same way as I understand it.
> 
> upload-pack (S) | fetch/clone-pack (C) protocol (v2):
> 
> 	# Tell the puller what commits we have and what their names are
> 	S: SHA1 name
> 	S: ...
> 	S: SHA1 name
> 	S: # flush -- it's your turn
> 	# Tell the pusher what commits we want, and what we have.
>         # In addition, we tell the other end that we support protocol
> 	# extensions, without breaking the old servers.
> 	C: want SHA1 extended
> 	C: ..
> 	C: want SHA1
> 	C: # flush -- done with "want" lines.
> 
> Notice that until we hear from the server, we cannot tell if our
> "extended" protocol wish will be granted, and in the original
> protocol, "NAK" will come in fixed length, and the only thing we
> could tack arbitrary garbage to was "ACK SHA1".  That's why your
> "ACK SHA1 continue" works nicely, but at the time you could not
> find out if you are talking with updated server until you get at
> least one ACK.

Actually, there is another way to pass some data from the server
which would be ignored by older clients - at the first stage,
when upload-pack sends the list of refs to the client:

	packet_write(1, "%s %s%c%s\n", sha1_to_hex(sha1), refname, '\0',
		     server_capabilities);

Old clients will ignore the additional data (functions which
work with the received name will happily stop at the added NUL
character; just some memory will be wasted), but the new
implementation of get_remote_heads() could look for that NUL
inside the received packet and find extended server capabilities
after it.  Then the client could just use new commands at the
"want" stage.

> However, at this point, we *could* force the server to reveal
> what it supports, by doing an extra flush here, before sending
> *ANY* "have" lines yet:
> 
> 	C: # flush -- this is another one after "I'm done with wants".
> 
> Upon receiving this, if we were talking with an old upload-pack,
> we would certanly get an NAK.  Note that the server already
> knows that we support extended protocol at this point, so our
> updated server can send anything here to say it knows what
> protocol extensions it supports.  Let's say it says something
> like this:
> 
> 	S: proto v2 v3 v5
> 
> to tell the puller it understands protocol v2, v3, and v5, to
> which the puller responds:
> 
> 	C: proto v2
> 
> After this exchange, both ends know they understand and would
> want to talk at protocol level v2.  This leaves door open for
> future protocol extension, but more importantly, I think this
> arrangement would make things safer.

This looks cleaner (no NUL bytes in the protocol), but does not
allow to replace the "want" stage with something entirely
different (if we ever want to do that).

--Signature=_Thu__27_Oct_2005_14_16_19_+0400_wn/gAjENG4ahAEiy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDYKj2W82GfkQfsqIRAiIuAJsGE0hS6o3H+ieZNJKZMr04UnLEcQCffxSs
RQNWW88uMVoqnk9G18+pb1s=
=hgaQ
-----END PGP SIGNATURE-----

--Signature=_Thu__27_Oct_2005_14_16_19_+0400_wn/gAjENG4ahAEiy--
