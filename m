From: Max Horn <max@quendi.de>
Subject: Re: What's cooking in git.git (Feb 2014, #06; Wed, 19)
Date: Fri, 21 Feb 2014 10:55:59 +0100
Message-ID: <FB0B19C8-65BF-49CF-8EE4-5B9D55BBCE7C@quendi.de>
References: <xmqqppmi7pbn.fsf@gitster.dls.corp.google.com> <BCF58F31-7130-4F4B-BE53-D917C4D50D96@quendi.de> <xmqqsird6137.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_6270842C-8B4B-4BE4-A27A-0BE0DA7E21A0"; protocol="application/pgp-signature"; micalg=pgp-sha256
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 21 10:56:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGmq1-0007LA-4c
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 10:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691AbaBUJ4C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 04:56:02 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:46131 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754391AbaBUJ4A (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Feb 2014 04:56:00 -0500
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1WGmpp-00060e-ND; Fri, 21 Feb 2014 10:55:57 +0100
In-Reply-To: <xmqqsird6137.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1510)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1392976560;84eb43b2;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242460>


--Apple-Mail=_6270842C-8B4B-4BE4-A27A-0BE0DA7E21A0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On 20.02.2014, at 20:22, Junio C Hamano <gitster@pobox.com> wrote:

> Max Horn <max@quendi.de> writes:
>=20
>> On 19.02.2014, at 22:41, Junio C Hamano <gitster@pobox.com> wrote:
>>=20
>>> * fc/transport-helper-fixes (2013-12-09) 6 commits
>>> - remote-bzr: support the new 'force' option
>>> - test-hg.sh: tests are now expected to pass
>>> - transport-helper: check for 'forced update' message
>>> - transport-helper: add 'force' to 'export' helpers
>>> - transport-helper: don't update refs in dry-run
>>> - transport-helper: mismerge fix
>>>=20
>>> Reported to break t5541, and has been stalled for a while without
>>> fixes.
>> ...
>> Since I somewhat care about transport-helpers, I had a closer look
>> at this failure.
>=20
> Thanks.  Let's keep it a bit longer and see how your new
> investigation (and possibly help from others) develops to a
> solution.

So I had a closer look, and I now believe to now understand what the =
right fix is. Simply dropping=20
  transport-helper: check for 'forced update' message
would be wrong, because it would cause the contrib/remote-helpers test =
cases to fail -- when I tested last night, I forgot that I had to run =
those separately. Silly me!

Indeed, these tests include a test with a force push, and trigger the =
code path added in that commit. The remaining problem then is that the =
new code should be changed to only tell git when a remote-helper signals =
a forced update; but it should not incorrectly reset the forced_update =
flag to 0 if git already considers the update to be forced.

In other words, the following patch should be the correct solution, as =
far as I can tell. I verified that it fixes t5541 and causes no =
regressions in the contrib/remote-helpers test suite.

-- 8< --
diff --git a/transport-helper.c b/transport-helper.c
index fa7c608..86e1679 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -734,7 +734,7 @@ static int push_update_ref_status(struct strbuf =
*buf,
        }

        (*ref)->status =3D status;
-       (*ref)->forced_update =3D forced;
+       (*ref)->forced_update |=3D forced;
        (*ref)->remote_status =3D msg;
        return !(status =3D=3D REF_STATUS_OK);
 }
-- 8< --



--Apple-Mail=_6270842C-8B4B-4BE4-A27A-0BE0DA7E21A0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF4EAREIAAYFAlMHIrQACgkQIpJVslrhe1ktWgEAj65/oKCvM0MRbD09rxH0F+CN
H55NXzrMlYE4WMk2ooIA/3t7jTA0UWdgwyphvC5D6PtA1HFvEHOPSqRTixkxpWj8
=0dz5
-----END PGP SIGNATURE-----

--Apple-Mail=_6270842C-8B4B-4BE4-A27A-0BE0DA7E21A0--
