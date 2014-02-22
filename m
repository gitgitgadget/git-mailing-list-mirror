From: Max Horn <max@quendi.de>
Subject: Re: What's cooking in git.git (Feb 2014, #06; Wed, 19)
Date: Sat, 22 Feb 2014 01:55:55 +0100
Message-ID: <8732A8C8-145E-47F5-BD9A-ECD6E9DE07EF@quendi.de>
References: <xmqqppmi7pbn.fsf@gitster.dls.corp.google.com> <BCF58F31-7130-4F4B-BE53-D917C4D50D96@quendi.de> <xmqqsird6137.fsf@gitster.dls.corp.google.com> <FB0B19C8-65BF-49CF-8EE4-5B9D55BBCE7C@quendi.de> <xmqqr46w4a24.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_DC49F1FF-86AE-4FD0-AA04-D070398155B2"; protocol="application/pgp-signature"; micalg=pgp-sha256
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 22 01:55:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WH0sl-0001cl-Dn
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 01:55:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026AbaBVAzu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Feb 2014 19:55:50 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:41680 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751447AbaBVAzu (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Feb 2014 19:55:50 -0500
Received: from ip-78-94-254-175.unitymediagroup.de ([78.94.254.175] helo=zanovar.fritz.box); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1WH0sd-0003ta-BJ; Sat, 22 Feb 2014 01:55:47 +0100
In-Reply-To: <xmqqr46w4a24.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1510)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1393030550;2297cbfe;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242496>


--Apple-Mail=_DC49F1FF-86AE-4FD0-AA04-D070398155B2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On 21.02.2014, at 19:04, Junio C Hamano <gitster@pobox.com> wrote:

> Here is a description I wrote for a tentative commit to queue on
> 'pu' after seeing your response:
>=20
>    transport-helper.c: do not overwrite forced bit

I'd change "forced bit" to "forced_update bit"

>=20
>    It does not necessarily mean the update was *not* forced, when the
>    helper did not say "forced update".  When the helper does say so, =
we
>    know the update is forced.
>=20
>    A workaround to fix breakage introduced by the previous step,
>    proposed by Max Horn.
>=20
> It troubled me that "it does not necessarily mean" sounded really
> wishy-washy.

But it's correct. But if you want to be more precise, how about this:

  If the the transport helper says it was a forced update, then it is
  a forced update. But it is possible that an update is forced without
  the transport-helper knowing about it, namely because some higher up
  code had objections to the update and needed forcing in order to let
  it through to the transport helper.



>  Isn't it possible for some helpers to _do_ want to
> tell us that it did not have to force after all by _not_ saying
> "forced update" and overwrite ->forced_update with zero?

Yes to the first part, no to the last bit:  Yes, a transport helper can =
(and frequently does) tell us that no force happened -- by not saying =
"forced update".

But not, it should not get to reset the forced_update bit. Because it =
can't know what other reasons there might have been for requiring a =
--force. If you look at the code, right now the only place setting =
forced_update is set_ref_status_for_push() in remote.c. If it decides to =
set forced_update, it does so, without giving the transport helper any =
say in in the matter. So the update will fail. Unless the user forces =
it. Only then the transport helper gets involved, and indeed, it could =
happen that the transport helper happily pushes the changes without =
seeing any reason to signal a "forced update".

But the update still should be marked as "forced", because it *was* =
forced. The transport helper can't know about that, and consequently, it =
doesn't make sense to allow it to override the statement of its betters =
;-).


>  How do we tell helpers that do want to do so apart from other helpers =
that say
> "forced update" only when they noticed they are indeed forcing?

I am not completely sure I even understand that bit? So far, no remote =
helper should have ever said "forced update", as they weren't allowed =
to. Now, we allow transport helpers supporting the "force" feature to =
signal that, "yes, indeed, I had to force this update". And the only =
thing we use that for is to report this fact to the user. So, that seems =
fine and all cases covered. No?


BTW, I guess we could perform an extra test and raise an error if a =
transport helper dares to request the "forced update" message even =
though it wasn't told that this update is supposed to be forced, i.e. =
even though !ref->force && !(flags & TRANSPORT_PUSH_FORCE) holds -- but =
doing that would mostly be something to help transport helper developers =
to catch misbehavior in their remote helpers, and could just as well be =
verified by suitable test cases.



> Perhaps the logic needs to be more like:
>=20
> 	if (we know helper will tell us the push did not have to
>            force by *not* saying "forced update") {
> 		(*ref)->forced_update =3D forced;
> 	}
>=20
> i.e. for helpers that do not use the 'forced update' feature, simply
> ignore this "forced" variable altogether, no?

Huh? For helpers not using the "forced updated" feature, the local =
"forced" variable stays zero, hence "forced_update |=3D forced" already =
does nothing.



Max

--Apple-Mail=_DC49F1FF-86AE-4FD0-AA04-D070398155B2
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF4EAREIAAYFAlMH9Z8ACgkQIpJVslrhe1mrQgEAmc1VRh/leKfLTF1HAtktQXm9
KCuBag76LyktUAcYQVcA/iZaudyoTUtSSRbOnlbO2OL7IZXEtvwoj4YMg1I9Z+F0
=hu2i
-----END PGP SIGNATURE-----

--Apple-Mail=_DC49F1FF-86AE-4FD0-AA04-D070398155B2--
