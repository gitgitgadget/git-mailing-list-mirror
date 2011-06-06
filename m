From: Alexander Neronskiy <zakmagnus@google.com>
Subject: [PATCH] Document the underlying protocol used by shallow repositories
 and --depth commands.
Date: Mon, 6 Jun 2011 10:26:44 -0700
Message-ID: <BANLkTi=SVZPebW2YXRnaLvkxEDGy_rrtJ3jayt8Oco6Sn8hciQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: schacon@gmail.com, Johannes.Schindelin@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 19:26:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTdZn-00017y-4H
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 19:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754555Ab1FFR0t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2011 13:26:49 -0400
Received: from smtp-out.google.com ([74.125.121.67]:14045 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121Ab1FFR0s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2011 13:26:48 -0400
Received: from wpaz29.hot.corp.google.com (wpaz29.hot.corp.google.com [172.24.198.93])
	by smtp-out.google.com with ESMTP id p56HQkbq022044
	for <git@vger.kernel.org>; Mon, 6 Jun 2011 10:26:46 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1307381206; bh=tIVtihPBNxh+x7ElYgnv1Bu7vS4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	b=fZPzIdbsRudnaGXA4DvfTlgtey9qEpdu7UX6a4tu76eIDGjWqqJ83bWERdQMzk7hj
	 e7I7+72KF7KJG7fhtnrLA==
Received: from gwaa12 (gwaa12.prod.google.com [10.200.27.12])
	by wpaz29.hot.corp.google.com with ESMTP id p56HQitm030725
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Mon, 6 Jun 2011 10:26:45 -0700
Received: by gwaa12 with SMTP id a12so1865938gwa.0
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 10:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=lsvcfPWhmHFv3XQu5GSFrdE/CH4Ebf+xuvaG5cwTklQ=;
        b=ZP/y63c3kW0wwSy0yDH7mq6Kfi3PVhWV5FYKicNqC2gpN1ACGp4vDAVXf/BS/yH8yM
         n9Fl4CuozippzIEcT4fw==
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=google.com; s=beta;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=MPDiaRGXzUbv2rTdMC/R2QPw8RrMF4ekiTrH/IsqiUFFAll7B09+mzmu6n6Mwo58wD
         1cof0HZdafURAKhyN/Sw==
Received: by 10.151.43.15 with SMTP id v15mr4495333ybj.170.1307381204700; Mon,
 06 Jun 2011 10:26:44 -0700 (PDT)
Received: by 10.151.46.11 with HTTP; Mon, 6 Jun 2011 10:26:44 -0700 (PDT)
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175138>

Explain the exchange that occurs between a client and server when
the client is requesting shallow history and/or is already using
a shallow repository.

Signed-off-by: Alex Neronskiy <zakmagnus@google.com>
---
=A0Documentation/technical/pack-protocol.txt |=A0=A0 87 +++++++++++++++=
+++++++-------
=A01 files changed, 66 insertions(+), 21 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt
b/Documentation/technical/pack-protocol.txt
index 369f91d..f576386 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -187,26 +187,28 @@ server determine what the minimal packfile
necessary for transport is.

=A0Once the client has the initial list of references that the server
=A0has, as well as the list of capabilities, it will begin telling the
-server what objects it wants and what objects it has, so the server
-can make a packfile that only contains the objects that the client nee=
ds.
-The client will also send a list of the capabilities it wants to be in
-effect, out of what the server said it could do with the first 'want' =
line.
+server what objects it wants, its shallow objects (if any), and the
+maximum commit depth it wants (if any).=A0 The client will also send a
+list of the capabilities it wants to be in effect, out of what the
+server said it could do with the first 'want' line.

=A0----
=A0=A0 upload-request=A0=A0=A0 =3D=A0 want-list
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 have-l=
ist
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 comput=
e-end
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *shall=
ow-line
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *1dept=
h-request
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 flush-=
pkt

=A0=A0 want-list=A0=A0=A0=A0=A0=A0=A0=A0 =3D=A0 first-want
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *add=
itional-want
-=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 flush-=
pkt
+
+=A0 shallow-line=A0=A0=A0=A0=A0 =3D=A0 PKT_LINE("shallow" SP obj-id)
+
+=A0 depth-request=A0=A0=A0=A0 =3D=A0 PKT_LINE("deepen" SP depth)

=A0=A0 first-want=A0=A0=A0=A0=A0=A0=A0 =3D=A0 PKT-LINE("want" SP obj-id=
 SP capability-list LF)
=A0=A0 additional-want=A0=A0 =3D=A0 PKT-LINE("want" SP obj-id LF)

-=A0 have-list=A0=A0=A0=A0=A0=A0=A0=A0 =3D=A0 *have-line
-=A0 have-line=A0=A0=A0=A0=A0=A0=A0=A0 =3D=A0 PKT-LINE("have" SP obj-id=
 LF)
-=A0 compute-end=A0=A0=A0=A0=A0=A0 =3D=A0 flush-pkt / PKT-LINE("done")
+=A0 depth=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =3D=A0 1*DIGIT
=A0----

=A0Clients MUST send all the obj-ids it wants from the reference
@@ -215,21 +217,64 @@ discovery phase as 'want' lines. Clients MUST
send at least one
=A0obj-id in a 'want' command which did not appear in the response
=A0obtained through ref discovery.

-If client is requesting a shallow clone, it will now send a 'deepen'
-line with the depth it is requesting.
+The client MUST write all obj-ids which it only has shallow copies
+of (meaning that it does not have the parents of a commit) as
+'shallow' lines so that the server is aware of the limitations of
+the client's history. Clients MUST NOT mention an obj-id which
+it does not know exists on the server.
+
+The client now sends the maximum commit history depth it wants for
+this transaction, which is the number of commits it wants from the
+tip of the history, if any, as a 'deepen' line.=A0 A depth of 0 is the
+same as not making a depth request. The client does not want to receiv=
e
+any commits beyond this depth, nor objects needed only to complete
+those commits. Commits whose parents are not received as a result are
+marked as shallow.
+
+Once all the 'want's and 'shallow's (and optional 'deepen') are
+transferred, clients MUST send a flush-pkt. If the client has all
+the references on the server, and as much of their commit history
+as it is interested in, client flushes and disconnects.
+
+Otherwise, if the client sent a positive depth request, the server
+will determine which commits will and will not be shallow and
+send this information to the client. If the client did not request
+a positive depth, this step is skipped.

-Once all the "want"s (and optional 'deepen') are transferred,
-clients MUST send a flush-pkt. If the client has all the references
-on the server, client flushes and disconnects.
+----
+=A0 shallow-update=A0=A0=A0 =3D=A0 *shallow-line
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 *unsha=
llow-line
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 flush-=
pkt

-TODO: shallow/unshallow response and document the deepen command in th=
e ABNF.
+=A0 shallow-line=A0=A0=A0=A0 =3D=A0 PKT-LINE("shallow" SP obj-id)
+
+=A0 unshallow-line=A0=A0 =3D=A0 PKT-LINE("unshallow" SP obj-id)
+----
+
+If the client has requested a positive depth, the server will compute
+the set of commits which are no deeper than the desired depth, startin=
g
+at the client's wants. The server writes 'shallow' lines for each
+commit whose parents will not be sent as a result. The server writes
+an 'unshallow' line for each commit which the client has indicated is
+shallow, but is no longer shallow at the currently requested depth
+(that is, its parents will now be sent). The server MUST NOT mark
+as unshallow anything which the client has not indicated was shallow.

=A0Now the client will send a list of the obj-ids it has using 'have'
-lines.=A0 In multi_ack mode, the canonical implementation will send up
-to 32 of these at a time, then will send a flush-pkt.=A0 The canonical
-implementation will skip ahead and send the next 32 immediately,
-so that there is always a block of 32 "in-flight on the wire" at a
-time.
+lines, so the server can make a packfile that only contains the object=
s
+that the client needs. In multi_ack mode, the canonical implementation
+will send up to 32 of these at a time, then will send a flush-pkt. The
+canonical implementation will skip ahead and send the next 32 immediat=
ely,
+so that there is always a block of 32 "in-flight on the wire" at a tim=
e.
+
+----
+=A0 upload-haves=A0=A0=A0=A0=A0 =3D=A0 have-list
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 comput=
e-end
+
+=A0 have-list=A0=A0=A0=A0=A0=A0=A0=A0 =3D=A0 *have-line
+=A0 have-line=A0=A0=A0=A0=A0=A0=A0=A0 =3D=A0 PKT-LINE("have" SP obj-id=
 LF)
+=A0 compute-end=A0=A0=A0=A0=A0=A0 =3D=A0 flush-pkt / PKT-LINE("done")
+----

=A0If the server reads 'have' lines, it then will respond by ACKing any
=A0of the obj-ids the client said it had that the server also has. The
--
1.7.3.1
