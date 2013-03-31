From: =?ISO-8859-1?Q?Sebastian_G=F6tte?= <jaseg@physik.tu-berlin.de>
Subject: [PATCH v7 0/5] Verify GPG signatures when merging and extend %G?
 pretty string
Date: Sun, 31 Mar 2013 16:32:04 +0200
Message-ID: <515848E4.5000509@physik.tu-berlin.de>
References: <20130331133332.GD2286@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trast@inf.ethz.ch, john@keeping.me.uk,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 31 16:33:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMJJn-0007O0-76
	for gcvg-git-2@plane.gmane.org; Sun, 31 Mar 2013 16:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755649Ab3CaOcc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Mar 2013 10:32:32 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:35686 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755626Ab3CaOca (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Mar 2013 10:32:30 -0400
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-3) with esmtp 
	id 1UMJJ2-0002VQ-Fs; Sun, 31 Mar 2013 16:32:29 +0200
Received: from [94.45.250.108] (unknown [94.45.250.108])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id DBB4111404;
	Sun, 31 Mar 2013 16:32:16 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <20130331133332.GD2286@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219621>

On 03/31/2013 03:33 PM, John Keeping wrote:
> It looks like the "found" pointer has wandered off the end of the
> string.  In the test case here, the gpg_status is:
>=20
> -- >8 --
> [GNUPG:] SIG_ID rzX3GbdzQyxB4Jdm1uD0CzL4B4Y 2013-03-31 1364735152
> [GNUPG:] GOODSIG 61092E85B7227189 Eris Discordia <discord@example.net=
>
> [GNUPG:] VALIDSIG D4BE22311AD3131E5EDA29A461092E85B7227189 2013-03-31
> 1364735152 0 4 0 1 2 00 D4BE22311AD3131E5EDA29A461092E85B7227189
> [GNUPG:] TRUST_UNDEFINED
> -- 8< --
>=20
> But the parse_signature_lines code assumes that after reading a
> signature it can fill in the key from the next 16 bytes and then look
> for a newline after that.  In this case it clearly needs to only read
> the signature if it's a GOODSIG or BADSIG line.
>=20
> Wrapping a "signature_check[i].result !=3D 'U'" condition around the =
lines
> that extract the key and advance the "found" pointer after doing so
> fixes this for me.
This was in fact the case and your fix works. I modified the code a bit=
 so it
does not break at the end of the loop and it checks for untrusted signa=
tures
*last*, this way even in case 'signature_check.result' is 'U' (untruste=
d),
'key' and 'signer' are available.

I also removed two stray spaces.

Sebastian G=F6tte (5):
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
 commit.c                           |  69 +++++++++++++++++++++++++++
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
 13 files changed, 215 insertions(+), 82 deletions(-)
 create mode 100755 t/t7612-merge-verify-signatures.sh

--=20
1.8.1.5
