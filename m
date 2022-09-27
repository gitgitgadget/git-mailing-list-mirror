Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C719FC6FA82
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 20:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiI0UcL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 16:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbiI0UcG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 16:32:06 -0400
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15E26567A;
        Tue, 27 Sep 2022 13:32:03 -0700 (PDT)
Content-Type: multipart/signed;
        boundary="Apple-Mail=_6F771BEB-AB0E-416A-A064-2F102FF46030";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: readpassphrase(3) in glibc, and agetpass() (Was: Is getpass(3)
 really obsolete?)
From:   Sam James <sam@gentoo.org>
In-Reply-To: <c8287618-30c4-f14b-8ad7-898fee99d944@gmail.com>
Date:   Tue, 27 Sep 2022 21:30:12 +0100
Cc:     Zack Weinberg <zack@owlfolio.org>,
        Theo de Raadt <deraadt@openbsd.org>, rsbecker@nexbridge.com,
        linux-man <linux-man@vger.kernel.org>, tech@openbsd.org,
        Florian Weimer <libc-alpha@sourceware.org>, git@vger.kernel.org
Message-Id: <180409CA-768D-44E5-A15D-91F66F8EC0C2@gentoo.org>
References: <a0371f24-d8d3-07d9-83a3-00a4bf22c0f5@gmail.com>
 <73ac38a2-c287-4cc1-4e9c-0f9766ac4c0c@gmail.com>
 <00d501d7ccbe$0169c340$043d49c0$@nexbridge.com>
 <63238.1635515736@cvs.openbsd.org>
 <6d8642e9-71f7-4a83-9791-880d04f67d17@www.fastmail.com>
 <c8287618-30c4-f14b-8ad7-898fee99d944@gmail.com>
To:     Alejandro Colomar <alx.manpages@gmail.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Apple-Mail=_6F771BEB-AB0E-416A-A064-2F102FF46030
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



> On 27 Sep 2022, at 20:19, Alejandro Colomar via Libc-alpha =
<libc-alpha@sourceware.org> wrote:
>=20
> Hi Zack,
>=20
> On 10/29/21 16:53, Zack Weinberg via Libc-alpha wrote:
>> On Fri, Oct 29, 2021, at 9:55 AM, Theo de Raadt wrote:
>>> <rsbecker@nexbridge.com> wrote:
>>>> On October 29, 2021 7:29 AM, Alejandro Colomar wrote:
>>>>> On 10/29/21 13:15, Alejandro Colomar wrote:
>>>>>> Hi,
>>>>>>=20
>>>>>> As the manual pages says, SUSv2 marked it as LEGACY, and POSIX =
doesn't
>>>>>> have it at all.  The manual page goes further and says "This =
function
>>>>>> is obsolete. Do not use it." in its first lines.
>> ...
>>> The community finally had the balls to get rid of gets(3).
>>>=20
>>> getpass(3) shares the same flaw, that the buffer size isn't passed.
>>> This has been an issue in the past
>> I was about to post exactly the same thing.  getpass(3) is not =
deprecated because there's a better replacement, it's deprecated because =
it's _unsafe_.  The glibc implementation wraps getline(3) and therefore  =
doesn't truncate the passphrase or overflow a fixed-size buffer, no =
matter how long the input is, but portable code cannot rely on that.  =
And come to think of it, using getline(3) means that prefixes of the =
passphrase may be left lying around in malloc's free lists.
>> (getpass also cannot be made thread safe, due to recycling of a =
static buffer, but a program in which multiple threads are racing to =
prompt the user for passwords would be a UX disaster anyway, so I don't =
think that's a critical flaw the way it is for e.g. strtok(3).)
>> The Linux manpage project's documentation is, as I understand it, for =
Linux with glibc _first_, but not _only_; it should not describe this =
function as not-deprecated just because glibc has patched its worst =
problems and doesn't offer any better API.
>>> readpassphrase(3) has a few too many features/extensions for my =
taste, but
>>> at least it is harder to abuse.
>> I am inclined to agree that readpassphrase has too many knobs, and I =
can't think of any legitimate present-day use for several of them, which =
is not a good property for an API handling security-critical data.  =
Also, it relies on the caller to size the buffer for the passphrase, and =
therefore risks truncating people's passphrases.
>> With my libxcrypt hat on I've thought a bit about replacements for =
getpass.  The conclusion I came to is that the easy changes are all =
putting lipstick on a pig, and if I was going to work on this at all I =
was going to design a privilege-separated authentication service that =
could be asked to take over a tty, read a passphrase, check it, and =
return just success or failure to the caller.  Neither the passphrase =
itself, nor any strings derived from it, would ever be in the caller's =
address space.  But this is obviously well out of scope for the C =
library.
>> zw
>=20
> I happen to be working on replacing getpass(3) in shadow-utils.  As =
there is no replacement in glibc, I'm making the code depend on libbsd =
on GNU systems.
>=20
> I developed a function similar to getpass(3), but which allocates a =
buffer (similar to asprintf(3)).  I only allocate once, and bail out if =
the password exceeds PASS_MAX, so no leaks in allocated memory (modulo =
bugs that I may have not noticed).
>=20
> I also enforce both clearing and freeing the memory, by requiring a =
specific clean-up function.
>=20
> The prototypes for the function and the clean-up are:
>=20
> [snip]
> Would you mind implementing readpassphrase(3) in glibc so that it's =
easier to use something safe and portable without resorting to =
compatibility libraries?  Also, I'd like some review of this function, =
if you think the API could be improved.  Maybe agetpass() would be a =
simple almost-drop-in replacement for getpass(3), so if you like it for =
glibc, let's discuss it.
>=20
I assume it'd be libxcrypt instead?

Best,
sam

--Apple-Mail=_6F771BEB-AB0E-416A-A064-2F102FF46030
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iNUEARYKAH0WIQQlpruI3Zt2TGtVQcJzhAn1IN+RkAUCYzNdVV8UgAAAAAAuAChp
c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0MjVB
NkJCODhERDlCNzY0QzZCNTU0MUMyNzM4NDA5RjUyMERGOTE5MAAKCRBzhAn1IN+R
kP8FAP93cWRejaNr1xofyUlSVQxeIiH5bBpzYNW2ThKOV/8KzgEA7f5aqWlTtrwk
mMoUKUnEFjbmkjREJ2QlxcWOyegZlgM=
=Knaw
-----END PGP SIGNATURE-----

--Apple-Mail=_6F771BEB-AB0E-416A-A064-2F102FF46030--
