From: Magnus =?iso-8859-1?Q?B=E4ck?= <magnus.back@sonyericsson.com>
Subject: Inspecting a corrupt git object
Date: Wed, 4 Aug 2010 11:25:30 +0200
Message-ID: <20100804092530.GA30070@jpl.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 04 11:26:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgaEX-00048R-86
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 11:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177Ab0HDJZr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Aug 2010 05:25:47 -0400
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:57045 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756253Ab0HDJZq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 05:25:46 -0400
Received: from ipb3.telenor.se (ipb3.telenor.se [195.54.127.166])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id 05B3DC069
	for <git@vger.kernel.org>; Wed,  4 Aug 2010 11:25:44 +0200 (CEST)
X-SMTPAUTH-B2: [b627879]
X-SENDER-IP: [83.227.167.132]
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AmRAAI/OWExT46eEPGdsb2JhbACHZ4tajF0MAQEBATUtwymFOwQ
X-IronPort-AV: E=Sophos;i="4.55,314,1278280800"; 
   d="scan'208";a="556856974"
Received: from ua-83-227-167-132.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.167.132])
  by ipb3.telenor.se with ESMTP; 04 Aug 2010 11:25:32 +0200
Received: by elwood.jpl.local (Postfix, from userid 1000)
	id 50BB5422BF; Wed,  4 Aug 2010 11:25:30 +0200 (CEST)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152567>

We recently discovered a git tree object corruption in one of our
busiest gits on the master server. From what I can tell "git cat-file -=
p"
output looked just fine, but "git gc" complained loudly about the objec=
t
being corrupt. I had the same git cloned on my machine and found (after
unpacking the packfiles) that my object was different from the one on
the server. Same size and everything, but the second byte (and only the
second byte) differed between good and bad object.

$ head -n 5 /tmp/hexdump_corrupt.txt
00000000  78 9c 2b 29 4a 4d 55 30  32 36 62 30 34 30 30 33 |x.+)JMU026b=
04003|
00000010  31 51 70 cc 4b 29 ca cf  4c d1 cb cd 66 a8 38 dd |1Qp.K)..L..=
=2Ef.8.|
00000020  76 77 82 ba af da a1 66  06 b9 b4 03 66 9d 27 18 |vw.....f...=
=2Ef.'.|
00000030  93 ec 50 55 f9 26 e6 65  a6 a5 16 97 e8 55 e4 e6 |..PU.&.e...=
=2E.U..|
00000040  30 d8 98 fe a9 93 98 cc  be 24 a4 ac 93 3b 43 b7 |0........$.=
=2E.;C.|
$ head -n 5 /tmp/hexdump_okay.txt
00000000  78 01 2b 29 4a 4d 55 30  32 36 62 30 34 30 30 33 |x.+)JMU026b=
04003|
00000010  31 51 70 cc 4b 29 ca cf  4c d1 cb cd 66 a8 38 dd |1Qp.K)..L..=
=2Ef.8.|
00000020  76 77 82 ba af da a1 66  06 b9 b4 03 66 9d 27 18 |vw.....f...=
=2Ef.'.|
00000030  93 ec 50 55 f9 26 e6 65  a6 a5 16 97 e8 55 e4 e6 |..PU.&.e...=
=2E.U..|
00000040  30 d8 98 fe a9 93 98 cc  be 24 a4 ac 93 3b 43 b7 |0........$.=
=2E.;C.|

=46rom what I gather from the community book and Pro Git, a git object
file is a deflated representation of the object type as a string, the
payload size, a null byte, and the payload. Is there a standard tool fo=
r
inflating the file back so that I can inspect what the actual differenc=
e
between these two are? Short of writing a tool utilizing zlib, at least=
=2E

Any other ideas why we would see such a difference? Hardware
malfunction or memory corruption I guess, but something else?
I can supply the actual object files if necessary.

--=20
Magnus B=E4ck                      Opinions are my own and do not neces=
sarily
SW Configuration Manager         represent the ones of my employer, etc=
=2E
Sony Ericsson
