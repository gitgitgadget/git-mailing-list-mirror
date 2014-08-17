From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: Signinig a commit with multiple signatures
Date: Sun, 17 Aug 2014 09:30:47 -0400
Organization: PD Inc
Message-ID: <DED50992A39F4A07ACD997A65602991E@black>
References: <CAFOYHZCiKC4TR4jFVUB=W5qbDG8XvB2Obx1ZfTH8OF3E_c5BnA@mail.gmail.com> <20140817075250.GH23808@peff.net>
Reply-To: "GIT" <git@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0039_01CFB9FD.ED85FF40"
To: "'GIT'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 17 15:36:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJ0d8-0002pT-F7
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 15:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbaHQNgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2014 09:36:11 -0400
Received: from mail.pdinc.us ([67.90.184.27]:41590 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282AbaHQNgK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2014 09:36:10 -0400
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Aug 2014 09:36:10 EDT
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id s7HDUlol003142
	for <git@vger.kernel.org>; Sun, 17 Aug 2014 09:30:47 -0400
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20140817075250.GH23808@peff.net>
Thread-Index: Ac+58E/ZvJNVSkfcQsWPtRoZlY5O6wAK6lhg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255367>

This is a multi-part message in MIME format.

------=_NextPart_000_0039_01CFB9FD.ED85FF40
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I am working on an open source project right now where we are looking to =
enforce a N of M audit approval process. It turns out that git supports =
verifying multiple signatures because gpg supports signature merging.

My question is how can this workflow best be added into git and if not =
added atleast supported.

Here are the manual procedures (scripts are in the bundle too):

> Procedures:
>=20
> 1. Identify a normal commit.
> 2. create a new commit file as:
> parent commit-id-of-step-1
> tree tree-id-from-git-cat-file-commit-commit-id-of-step-1
> author CipherShed Security Team <security@ciphershed.org>=20
> timestamp timezone
> committer Actual Person <username@ciphershed.org> timestamp timezone
> gpgsig output-from-merge-sig-tool [1]
>  more-output
>  more-output
>=20
> Comments for this commit
> ...
> ...
>=20
> 3. run ruby script [2] to add commit to git db
> 4. git update-ref refs/heads/BRANCH-NAME new-commit-id

To do this most properly I feel like there needs to be a way to "share" =
the repository state and intterrupt the commit process.

Comments?

1:=20
$ cat merge-multisigs.sh
#!/bin/bash
(
 for i in "$@"
 do
  gpg --dearmor < "$i"
 done
) | gpg --enarmor

2:
$ cat write-commit.ruby
#!/usr/bin/irb
require 'fileutils'
file =3D File.open(ARGV[0], "rb")
content =3D file.read
header =3D "commit #{content.length}\0"
store =3D header + content
require 'digest/sha1'
sha1 =3D Digest::SHA1.hexdigest(store)
require 'zlib'
zlib_content =3D Zlib::Deflate.deflate(store)
path =3D '.git/objects/' + sha1[0,2] + '/' + sha1[2,38]
FileUtils.mkdir_p(File.dirname(path))
File.open(path, 'w') { |f| f.write zlib_content }


P.S. This was inspired by actual events and the parent thread.

--
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
This message is copyright PD Inc, subject to license 20080407P00.

------=_NextPart_000_0039_01CFB9FD.ED85FF40
Content-Type: application/octet-stream;
	name="multisign.bundle"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="multisign.bundle"

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

------=_NextPart_000_0039_01CFB9FD.ED85FF40--
