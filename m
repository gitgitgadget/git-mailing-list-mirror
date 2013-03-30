From: =?UTF-8?B?U2ViYXN0aWFuIEfDtnR0ZQ==?= <jaseg@physik.tu-berlin.de>
Subject: [PATCH v6 0/5] Verify GPG signatures when merging and extend %G?
 pretty string
Date: Sat, 30 Mar 2013 15:14:46 +0100
Message-ID: <5156F356.30600@physik.tu-berlin.de>
References: <7vvc89k15t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 30 15:15:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULwZV-0002fT-Uv
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 15:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756051Ab3C3OPJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Mar 2013 10:15:09 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:43850 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755702Ab3C3OPH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Mar 2013 10:15:07 -0400
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-4) with esmtp 
	id 1ULwYg-0007G4-B5; Sat, 30 Mar 2013 15:15:06 +0100
Received: from [94.45.252.144] (unknown [94.45.252.144])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id 50C9C11402;
	Sat, 30 Mar 2013 15:14:57 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <7vvc89k15t.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219587>

> Yuck.  That termination condition is horrible.
Ok, I reverted it to your suggestion. In this case, a much more elegant
termination condition (foo =3D=3D 1) is not possible without casts beca=
use foo is a
pointer.=20

>> +			switch(signature_check.check_result){
>> +				case 'G':
>> +					if (verbosity >=3D 0)
>> +						printf(_("Commit %s has a good GPG signature by %s (key finge=
rprint %s)\n"), hex, signature_check.signer, signature_check.key);
>> +					break;
>> +				case 'B':
>> +					die(_("Commit %s has a bad GPG signature allegedly by %s (key =
fingerprint %s)."), hex, signature_check.signer, signature_check.key);
>> +				default: /* 'N' */
>> +					die(_("Commit %s does not have a good GPG signature. In fact, =
commit %s does not have a GPG signature at all."), hex, hex);
>> +			}
>=20
> Style.
I moved that verbose printf outside the switch(foo).

> Also avoid overlong lines, both in the source, but pay extra
> attention to what we show the user.  For example:
>=20
>     "Commit %s has a bad GPG signature allegedly by %s (key fingerpri=
nt %s)."
>=20
> The first %s will expand to 40 places, the other two are likely to
> be around 20-30 places.
The first %s is the output of find_unique_abbrev, so though it will be =
40
places worst-case, it will usually be *much* shorter (more like 7-8 pla=
ces).
>     "Commit %s does not have a good GPG signature. In fact, commit %s=
 does not have a GPG signature at all."
>=20
> Drop everything from the beginning up to "In fact, ", perhaps:
>=20
>     "Commit '%s' does not have any GPG signature."
>=20
> is sufficient?  You may also want to consider
>=20
> 	die(_("Commit '%.*s...' does not have any GPG signature."),
> 	    8, hex);
I shortened these messages and removed the key fingerprint output. Anyb=
ody
interested can use git log --show-signature to get these.

Sebastian G=C3=B6tte (5):
  Move commit GPG signature verification to commit.c
  commit.c/GPG signature verification: Also look at the first GPG statu=
s
    line
  merge/pull: verify GPG signatures of commits being merged
  merge/pull Check for untrusted good GPG signatures
  pretty printing: extend %G? to include 'N' and 'U'

 Documentation/merge-options.txt    |   5 ++
 Documentation/pretty-formats.txt   |   3 +-
 builtin/merge.c                    |  34 +++++++++++++-
 commit.c                           |  68 +++++++++++++++++++++++++++
 commit.h                           |  10 ++++
 git-pull.sh                        |  10 +++-
 gpg-interface.h                    |  12 +++++
 pretty.c                           |  93 ++++++-----------------------=
--------
 t/lib-gpg/pubring.gpg              | Bin 1164 -> 2359 bytes
 t/lib-gpg/random_seed              | Bin 600 -> 600 bytes
 t/lib-gpg/secring.gpg              | Bin 1237 -> 3734 bytes
 t/lib-gpg/trustdb.gpg              | Bin 1280 -> 1360 bytes
 t/t7612-merge-verify-signatures.sh |  61 ++++++++++++++++++++++++
 13 files changed, 214 insertions(+), 82 deletions(-)
 create mode 100755 t/t7612-merge-verify-signatures.sh

--=20
1.8.1.5
