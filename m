From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Returning error message from custom smart http server
Date: Mon, 19 May 2014 11:40:20 +0200
Message-ID: <1400492420.2595.60.camel@centaur.cmartin.tk>
References: <5371CC4F.80602@intland.com>
	 <20140516230116.GC180798@vauxhall.crustytoothpaste.net>
	 <CAGyf7-EoSgTxZzReFArOgcrBaARv7fRiZTMPZX+Loy9dec23aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?=C1kos=2C?= Tajti <akos.tajti@intland.com>,
	Git Users <git@vger.kernel.org>
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Mon May 19 11:40:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmK3a-0005KV-5P
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 11:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177AbaESJkZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 May 2014 05:40:25 -0400
Received: from mx0.elegosoft.com ([78.47.87.163]:40239 "EHLO mx0.elegosoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752701AbaESJkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 05:40:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.elegosoft.com (Postfix) with ESMTP id EAF0DDE054;
	Mon, 19 May 2014 11:40:20 +0200 (CEST)
Received: from mx0.elegosoft.com ([127.0.0.1])
	by localhost (mx0.elegosoft.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A6E0NYTQVmZn; Mon, 19 May 2014 11:40:20 +0200 (CEST)
Received: from centaur.local (p57A971DA.dip0.t-ipconnect.de [87.169.113.218])
	by mx0.elegosoft.com (Postfix) with ESMTPSA id 9F9FCDE051;
	Mon, 19 May 2014 11:40:20 +0200 (CEST)
In-Reply-To: <CAGyf7-EoSgTxZzReFArOgcrBaARv7fRiZTMPZX+Loy9dec23aQ@mail.gmail.com>
X-Mailer: Evolution 3.12.1-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249568>

On Mon, 2014-05-19 at 18:12 +1000, Bryan Turner wrote:
> On Sat, May 17, 2014 at 9:01 AM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > On Tue, May 13, 2014 at 09:39:59AM +0200, "=C3=81kos, Tajti" wrote:
> >> Dear List,
> >>
> >> we implemented our own git smart http server to be able to check p=
ermissions
> >> and other thing before pushes. It works fine, however, the error m=
essages we
> >> generate on the server side are not displayed by the command line =
client. On
> >> the server we generate error messages like this:
> >>
> >>         response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
> >>         response.getWriter().write(msg);
> >>
> >> On the command line we get this:
> >>
> >> Total 0 (delta 0), reused 0 (delta 0)
> >> POST git-receive-pack (290 bytes)
> >> efrror: RPC failed; result=3D22, HTTP code =3D 401
> >> atal: The remote end hung up unexpectedly
> >> fatal: The remote end hung up unexpectedly
> >>
> >> The server message is completely missing. Is there a solution for =
this?
>=20
> You should not need a patched git; the wire protocol itself has a
> mechanism for sending "smart" error messages. It's not particularly
> _obvious_, but it's there.
>=20
> For starters, to return an error message, your status must be 200 OK.
> You can't return any other status code or Git will interpret your
> error as some form of _HTTP_ error rather than a _git_ error.
>=20
> In the smart protocol the client sends a service to the server as a
> query parameter, like "?service=3Dgit-receive-pack". For such a reque=
st,
> you need to:
> - Set the content type to "application/x-<service>-advertisement"
> (e.g. "application/x-git-receive-pack-advertisement") (Not all comman=
d
> line Git versions require this, but JGit does)
> - Set the status code as 200 OK
> - Write back a payload where the first 4 bytes are the hex-encoded
> length of the text (where "FFFF" is max length for a single packet).
> Note that the 4 bytes for the size are _part_ of that length, so if
> you're writing "Test" the length is 8, not 4
> - After the size, you write "# service=3D<service>" (e.g. "#
> service=3Dgit-receive-pack"; note the space after the #) This is the
> metadata. For an error, you don't really have much to say.
> - After that, an empty packet, which is "0000" (four zeros) This
> separates the metadata from the ref advertisement
> - After that you can write your message, beginning with "ERR " (note
> the trailing space there). The "ERR " tells Git what you're writing
> isn't a ref, it's an error. I'd recommend appending a newline (and ad=
d
> 1 more to your length for it), because when Git echoes your error
> message it doesn't seem to do that
>=20
> I'm not sure whether there's a document that describes all of this; I
> found it by digging into the Git source code (you can find the "ERR"
> handling in connect.c, get_remote_heads). This may be exploiting the
> protocol, I'll leave that to someone more knowledgeable on how they
> _intended_ this all to be used, but it works for us.
>=20
> A full example looks something like this: "0036#
> service=3Dgit-receive-pack0000ERR This is a test\n"

This is indeed documented, namely in=20

    Documentation/technical/pack-protocol.txt

I guess it could do with an example, but your usage seems correct. Ther=
e
are two different places where things could go wrong, either in HTTP,
such as authentication, or in the Git part of the request. If you retur=
n
an HTTP 404, then all you're telling the client is that you couldn't
find what it asked for, but that could mean either the
receice-pack/upload-pack program or the repository itself. If something
went wrong at the Git level, whether it's a resource problem in the
server or simply that the repo doesn't exist, then ERR is the right
thing to use.

Particularly, we can't rely on the HTTP 404 response being anything
meaningful, as it could simply be the host's default 404 page, and you
don't want html flying through your terminal.

Cheers,
   cmn
