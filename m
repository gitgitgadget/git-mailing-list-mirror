From: =?ISO-8859-1?Q?Sebastian_G=F6tte?= <jaseg@physik.tu-berlin.de>
Subject: [PATCH v5 0/5] Verify GPG signatures when merging and extend %G?
 pretty string
Date: Sat, 30 Mar 2013 01:13:50 +0100
Message-ID: <51562E3E.6060301@physik.tu-berlin.de>
References: <7vy5d7qhmm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 30 01:14:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULjRY-0000dg-VG
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 01:14:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757301Ab3C3AOO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Mar 2013 20:14:14 -0400
Received: from mail.tu-berlin.de ([130.149.7.33]:40282 "EHLO mail.tu-berlin.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757274Ab3C3AOO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 20:14:14 -0400
X-tubIT-Incoming-IP: 130.149.58.163
Received: from mail.physik-pool.tu-berlin.de ([130.149.58.163] helo=mail.physik.tu-berlin.de)
	by mail.tu-berlin.de (exim-4.75/mailfrontend-4) with esmtp 
	id 1ULjQu-00062P-Bu; Sat, 30 Mar 2013 01:14:12 +0100
Received: from [94.45.252.144] (unknown [94.45.252.144])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.physik.tu-berlin.de (Postfix) with ESMTPSA id 12CDE11402;
	Sat, 30 Mar 2013 01:14:01 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <7vy5d7qhmm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219540>

I hope I did not introduce more problems than I fixed in this revision =
;)

On 03/28/2013 11:33 PM, Junio C Hamano wrote:
> It would be much easier to read if it were "unless we are not
> looking at the very first byte, the previous byte must be LF", i.e.
>=20
> 	if (found !=3D buf && found[-1] !=3D '\n')
>=20
> Is that continue correct?  Don't you want to retry from the end of
> the line that contains the mistaken hit?
Actually it is not. Sorry.
> The "\n" at the beginning anchors the expected string for quicker
> multi-line scan done with strstr().  If you really want to lose that
> LF and still write this function correctly and clearly, I think you
> would need to iterate over the buffer line by line.
The function now does that and calls prefixcmp on each line.

On 03/28/2013 11:33 PM, Junio C Hamano wrote:> Sebastian G=F6tte <jaseg=
@physik.tu-berlin.de> writes:
>> +	if (verify_signatures) {
>> +		/* Verify the commit signatures */
>> +		for (p =3D remoteheads; p; p =3D p->next) {
>> +			struct commit *commit =3D p->item;
>> +			struct signature signature;
>> +			signature.check_result =3D 0;
>=20
> [...]=20
> By the way, I think this variable and type should be called more
> like "signature_check" or something with "check" in its name, not
> "signature".  After all it is _not_ a signature itself.
I renamed it "signature_check". I put that into the commit moving the c=
ode to
commit.c. I also renamed the array/struct containing the GPG status out=
put
strings since that was originally called "signature_check".

>> +	grep "does not have a GPG signature" mergeerror
>=20
> Do we plan to make this message localized?  If so I think you would
> need to do this with test_i18ngrep.
Yes, this message should be localized since it is "normal" status outpu=
t. I
fixed the test case, however I noticed a possible problem with the "git=
 log
 --show-signature" test case (t/t7510-signed-commit.sh): Here, grep is =
used on
git output, but this git output is actually just passed-through GPG out=
put, and
GPG localizes that output. Are the tests alwasy run with LANG=3Den_US.u=
tf-8,
LANG=3DC etc.?

>> +test_expect_success GPG 'merge commit with bad signature with verif=
ication' '
>> +	test_must_fail git merge --ff-only --verify-signatures $(cat forge=
d.commit) 2> mergeerror &&
>> +	grep "has a bad GPG signature" mergeerror
>> +'
>> +
>> +test_expect_success GPG 'merge signed commit with verification' '
>> +	git merge -v --ff-only --verify-signatures side-signed > mergeoutp=
ut &&
>> +	grep "has a good GPG signature" mergeoutput
>> +'
>=20
> Hmph.
>=20
> So the caller needs to check both the standard output and the
> standard error to get the whole picture?  Is there a reason why we
> are not sending everything to the standard output consistently?
If --verify-signatures is given, everything but a good signature result=
s in
"die(_("foo")), with _("foo") being printed on stderr. I clarified that=
 point
in merge-options.txt. If additionally --verbose is given on the command=
 line,
git will print _("Commit %s has a good GPG signature by %s (key fingerp=
rint
%s)\n") on stdout for each "good" commit.  I think it is ok that way be=
cause
the caller only needs to check the exit code to get a picture. The "goo=
d GPG
signature"-message is only meant to convey the signer's name and key
fingerprint in case the caller is interested. If the caller does not wa=
nt to
abort the merge in case of GPG trouble, git merge may be called without
 --verify-signatures followed by a git log --show-signature on the comm=
its
that have been merged.

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
 builtin/merge.c                    |  35 +++++++++++++-
 commit.c                           |  67 ++++++++++++++++++++++++++
 commit.h                           |  10 ++++
 git-pull.sh                        |  10 +++-
 gpg-interface.h                    |   8 ++++
 pretty.c                           |  93 ++++++-----------------------=
--------
 t/lib-gpg/pubring.gpg              | Bin 1164 -> 2359 bytes
 t/lib-gpg/random_seed              | Bin 600 -> 600 bytes
 t/lib-gpg/secring.gpg              | Bin 1237 -> 3734 bytes
 t/lib-gpg/trustdb.gpg              | Bin 1280 -> 1360 bytes
 t/t7612-merge-verify-signatures.sh |  61 ++++++++++++++++++++++++
 13 files changed, 210 insertions(+), 82 deletions(-)
 create mode 100755 t/t7612-merge-verify-signatures.sh

--=20
1.8.1.5
