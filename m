From: Kevin Stange <kevin@steadfast.net>
Subject: Re: [RFC] Deal with HTTP 401 by requesting credentials.
Date: Fri, 01 Jun 2012 12:02:08 -0500
Message-ID: <4FC8F590.2070308@steadfast.net>
References: <4FC7EFB7.4090704@steadfast.net> <20120601083537.GA32340@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD5BB78B2537C9099EB155359"
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Jun 01 19:02:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaVEx-0004jR-Gm
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 19:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759052Ab2FARCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 13:02:15 -0400
Received: from staffmx.steadfast.net ([67.202.100.6]:53415 "EHLO
	staffmx.steadfast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758167Ab2FARCN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 13:02:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by staffmx.steadfast.net (Postfix) with ESMTP id D11D916AC09E
	for <git@vger.kernel.org>; Fri,  1 Jun 2012 12:02:12 -0500 (CDT)
X-Virus-Scanned: amavisd-new at steadfast.net
Received: from staffmx.steadfast.net ([127.0.0.1])
	by localhost (staffmx.steadfast.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xQw1hjC+PR1z for <git@vger.kernel.org>;
	Fri,  1 Jun 2012 12:02:08 -0500 (CDT)
Received: from ziyal.office.steadfast.net (unknown [IPv6:2607:f128:0:1:222:4dff:fe51:2ed5])
	by staffmx.steadfast.net (Postfix) with ESMTPSA id 7EDAD16AC09B
	for <git@vger.kernel.org>; Fri,  1 Jun 2012 12:02:08 -0500 (CDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
In-Reply-To: <20120601083537.GA32340@sigill.intra.peff.net>
X-Enigmail-Version: 1.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199005>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD5BB78B2537C9099EB155359
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/01/2012 03:35 AM, Jeff King wrote:
> On Thu, May 31, 2012 at 05:24:55PM -0500, Kevin Stange wrote:
>=20
>> Request credentials from the user if none are already defined when a
>> HTTP 401 is received on a restricted repository.  Then, resubmit the
>> request and return the final result.
>>
>> This allows all webdav transactions to obtain credentials without havi=
ng
>> to individually handle the case in each request.  Having push working
>> with HTTP auth is needed for a use case I have where storing the
>> credentials in .netrc or using SSH keys is inappropriate.
>=20
> We already do this at a higher level in http_request, which in turns
> calls into finish_active_slot. So if we were going to go this route,
> wouldn't we also want to remove the 401 handling in http_request?

I did see the work being done there, and considered removing it.  In fact=
, I
used it as a reference for working out what was going on in the authentic=
ation
process.  I decided not to do anything there until soliciting feedback an=
d
deciding whether my approach was reasonable.

> The dumb-http push code is the only thing that does not go through
> http_request these days. So another option would be to refactor it to g=
o
> through that central point. I took a brief look at this when I was
> updating the credential code a few months ago, but didn't consider it a=

> priority, as most people should be using smart http these days. Is ther=
e
> a reason you can't use smart-http? It's significantly more efficient.

Smart HTTP didn't come up in any of my Google searches.  With that as an
option, I might just drop this work now.  I'd rather see incomplete metho=
ds
that aren't recommended go away than further facilitate their use, person=
ally.

> You also don't necessarily need to handle 401 in every code path of
> http-push; once we see the credential once, we will use it everywhere,
> so you really only need to handle it on the initial request (assuming
> that all requests will have the same authorization requirements).

I made the change where I did because I wasn't sure if the push code was
avoiding using http_request intentionally, and wasn't sure whether new co=
de
would be written that avoid it as well.

If that's not the case, then I gather http-push would be better rewritten=
 to
just use http_request, if anything.

>> Apologies for anything wrong I might have done here.  I'm not used to
>> procedures for this sort of patch submission, or terribly familiar wit=
h
>> the code base.  I'm seeking advice on whether this approach is sane or=

>> completely crazy, and I'm willing to adjust it to make it suitable for=

>> inclusion.
>>
>> Signed-off-by: Kevin <kevin@steadfast.net>
>> ---
>=20
> Cover letter material (i.e., anything that would not go into the commit=

> message of the final commit) should go below the "---".

Thanks, will remember this for future reference.

> Is it safe to just run start_active_slot again without reinitializing
> the request? The 401-handling code in http_request actually restarts a
> new request. I don't immediately see any state that would need to be
> reset; we might have written some data to the output file if curl gave
> us any body data, but presumably it would not have done so for a 401.

In my tests, this particular code flow never returns anything to the orig=
inal
request call because I interrupt it and start the request over.  Now that=
 I
look at it again, there's a chance it leaks the curl response, but it doe=
sn't
return that response and the new request works fine, replacing the origin=
al.

> In the "else" clause you add, I don't think there's any point in
> printing an error. The 401 should get propagated back to the caller, wh=
o
> will produce an error. However, you _should_ call credential_reject,
> since you know that the credential you have doesn't work.
>=20
> Similarly, you would want to call credential_accept after a successful
> request, so that helpers can store it.

If I decide to continue working on this, I will keep these in mind.  I'm
pretty sure that if I can get smart HTTP working, there's no reason to ev=
en
bother with this from my perspective, unless you think there's substantia=
l
value in it.

Thanks for the detailed feedback on the proposed change and suggestions o=
n
alternative options.

--=20
Kevin Stange
Chief Technology Officer
Steadfast Networks
http://steadfast.net
Phone: 312-602-2689 ext. 203 | Fax: 312-602-2688 | Cell: 312-320-5867


--------------enigD5BB78B2537C9099EB155359
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/I9ZAACgkQkd/BoeKjg0gy8gCdFdhwjvREy40vOcIM1exCPUbm
l8QAn16t50ajh850/tpkcsaLiQ+JI6Rg
=e665
-----END PGP SIGNATURE-----

--------------enigD5BB78B2537C9099EB155359--
