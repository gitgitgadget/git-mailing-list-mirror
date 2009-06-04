From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Thu, 4 Jun 2009 22:55:43 +0200
Message-ID: <200906042255.43952.jnareb@gmail.com>
References: <200905122329.15379.jnareb@gmail.com> <d411cc4a0905140655y244f21aem44f1e246dd74d80c@mail.gmail.com> <200906022339.08639.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 04 22:56:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCJyo-0000OR-IF
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 22:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbZFDUzy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jun 2009 16:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752172AbZFDUzx
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 16:55:53 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:56299 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751630AbZFDUzw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 16:55:52 -0400
Received: by fg-out-1718.google.com with SMTP id 16so388278fgg.17
        for <git@vger.kernel.org>; Thu, 04 Jun 2009 13:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:content-type:content-transfer-encoding
         :message-id;
        bh=a7A4OKHiLaWSeQ8/X77VQjjVMvbqkArf8MLPpQ+Yaww=;
        b=oyBHybanLn9je130spPGX0asi8wdq8SGSBu1tZdabuSPwP6fZMlA0XnbtMsU0d43R8
         zpMIqIulCHTjzC+cL/whAyio3wue2qTCe+W6MYmi0KjGwqFtIkEU2oIA7zLqAq6PQlI+
         v8HiBnNgOynNlmrXTgTPaJnPqyHLuTO9TFNpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        b=pJXhmuFvDjtuIPWQHzGVMTqv5uPP/vcpOAgj5Ao3W7JeltdG6+nYQdfhsBPptMsmoj
         hTVworCqW70KKcisPYhRn22fXyx0XSY5J6G9/18GryAjefU7NZdPAAZm8TyWCNsTE8vn
         tn2UAYa8R6vw6UCgINvx4DxGYbjZUzAU7rZlQ=
Received: by 10.86.1.1 with SMTP id 1mr3140633fga.0.1244148952490;
        Thu, 04 Jun 2009 13:55:52 -0700 (PDT)
Received: from ?192.168.1.13? (abvg76.neoplus.adsl.tpnet.pl [83.8.204.76])
        by mx.google.com with ESMTPS id d4sm865631fga.26.2009.06.04.13.55.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Jun 2009 13:55:51 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200906022339.08639.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120711>

This is combined response to various messages in this thread, following
my discoveries done using simple Perl script (using IO::Socket) which
assumes role of a git client, tested against github.com (IIRC it uses
Ruby implementation) and git.kernel.org (C Git), and "nc -l 9418".

By the way, is there some publicly accessible JGit (Java) and Dulwich
(Python) git-daemon one can test against?

  sp =3D Shawn O. Pearce
  jn =3D Jakub Narebski
  gb =3D Git Community Book (http://book.git-scm.com)


jn>> I meant that in the request line for fetching via git:// protocol
jn>>
jn>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00032git-upload-pack /project.g=
it\\000host=3Dmyserver.com\\000
jn>>
jn>> you separate path to repository from extra options using "\0" / NU=
L
jn>> as a separator. Well, this is only sane separator, as it is path
jn>> terminator, the only character which cannot appear in pathname
jn>> (although I do wonder whether project names with e.g. control
jn>> characters or UTF-8 characters would work correctly).
sp>
sp> No, that isn't the reason '\0' is used here. =C2=A0But yea, that is=
 true.
sp>
sp> The reason \0 is used is, git-daemon reads the 4 byte length, decod=
es
sp> that, then reads that many bytes. =C2=A0Finally it writes a '\0' at=
 the
sp> end of what it read, so that the entire "line" is NUL terminated.
sp> Then it reads the "command path" part from the resulting C string.
sp>
sp> The host=3Dmyserver.com part came later, after many daemons were
sp> already running all over the world. =C2=A0By hiding it behind the '=
\0'
sp> an old daemon would never see it (but strlen() returned a value tha=
t
sp> was less than the length read, but the old daemons didn't care).
sp> Newer daemons look for where strlen() < length, and assume that
sp> the host header follows.
sp>
sp> The host header ends with '\0' in case additional headers would
sp> also appear here in the future. =C2=A0IOW, like HTTP allows new hea=
ders
sp> to be added before the "\r\n\r\n" terminator at the body, we allow
sp> them between "\0".
[...]

sp> The NUL at the end of the host name is not strictly required, but
sp> must be present if the client were to ever pass additional options
sp> to the server.

Actually both git.kernel.org and github.com failed (deadlocked / hung)
when I tried to add extra key=3Dvalue parameter at the end of request:

  003bgit-upload-pack /project.git\0host=3Dmyserver.com\0user=3Dme\0

Hmmmm...


jn>> Hmmm... the communication between server and client is not entirel=
y
jn>> clean. Do I understand correctly that this NAK is response to
jn>> clients flush after all those "want" lines?
sp>
sp> Yes.
sp>
jn>> And that "0009done" from client
jn>> tells server that it should send everything it has?
sp>
sp> Yes. =C2=A0It means the client will not issue any more "have" lines=
,
sp> as it has nothing further in its history, so the server just has
sp> to give up and start generating a pack based on what it knows.

Here we were talking about the following part of exchange:=20
(I have added "C:" prefix to signal that this is what client,=20
git-clone here, sends; I have added also explicit "\n" to mark LF
characters terminating lines, and put each pkt-line on separate line)

gb>  C: 0054want 74730d410fcb6603ace96f1dc55ea6196122532d multi_ack sid=
e-band-64k ofs-delta\n
gb>  C: 0032want 7d1665144a3a975c05f1f43902ddaf084e784dbe\n
gb>  C: 0032want 5a3f6be755bbb7deae50065988cbfa1ffa9ab68a\n
gb>  C: 0032want 7e47fe2bd8d01d481f44d7af0531bd93d3b21c01\n
gb>  C: 0032want 74730d410fcb6603ace96f1dc55ea6196122532d\n
gb>  C: 0000
gb>  C: 0009done\n

and where server response is (again the quote from "Git Community Book"
was modified, removing here doublequotes and doubling of backslashes):

gb>  S: 0008NAK\n
gb>  S: 0023\002Counting objects: 2797, done.\n
gb>  [...]
gb>  S: 2004\001PACK\000\000\000\002 [...]

I have thought that after sending "0000" flush line client can wait for
NAK or ACK server response... but it is not the case.  When I tried to
read from server after "0000" flush and before "0009done\n", my client
(or netcat instance) deadlocked (hung) waiting for server response.
I either did a mistake in my fake client, or I don't understand git pac=
k
protocol correctly.  Should client wait for NAK or ACK from server _onl=
y_
after sending maximum number of want/have lines (256 if I remember=20
correctly?)?

When I removed sending "0000" flush line my fake client again hung=20
(deadlocked?) waiting for server.


jn>> P.S. By the way, is pkt-line format original invention, or was it=20
jn>> 'borrowed' from some other standard or protocol?
sp>
sp> No clue.  I find it f'king odd that the length is in hex.  There
sp> isn't much value to the protocol being human readable.  The PACK
sp> part of the stream sure as hell ain't.  You aren't going to type
sp> out a sequence of "have" lines against the remote, like you could
sp> with say an HTTP GET.  *shrug*

"git gui blame pkt-line.c" shows that pkt-line format is Linus inventio=
n.

It looks quite a bit like 'chunked' transfer encoding[1] in HTTP; there
each non-empty chunk starts with the number of octets of the data it
embeds (size written in hexadecimal) followed by a CRLF (carriage retur=
n
and linefeed), and the data itself. The chunk is then closed with a CRL=
=46.
In some implementations, white space chars (0x20) are padded between
chunk-size and the CRLF.  In pkt-line format number of octet has fixed
width (4 hexadecimal digits, 0-padded), and we do not use CRLF as=20
terminator of chunk/packet length and of chunk/packet itself.

In HTTP 'chunked' transfer encoding the last chunk is a single line,
simply made of the chunk-size (0).  In pkt-line format we use special
size of "0000" for a flush packet.

[1] http://en.wikipedia.org/wiki/Chunked_transfer_encoding

--=20
Jakub Narebski
Poland
