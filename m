Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123F5C433EF
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 16:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbiBIQUF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 11:20:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236708AbiBIQUD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 11:20:03 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08297C05CB87
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 08:20:05 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1296210DEF3;
        Wed,  9 Feb 2022 11:20:04 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=L16hvJx7qKU4A
        X52UQyeFU+sFHbhcOlwUPscgUbNuJw=; b=BHPPtlmgdlhkt8TMhdFJeQ6GS9ZKD
        5CRVfMsVQXKhxuRYzVUQVv4oZj0hggr0GOy44qANSdcn3VQ3yXZNrFb3kbbrhBGR
        z8QOilav/Pc12CLYXQDn1s2IA1nIe4rW5PGEudKnop0szonfcrDF5OWz7p9UHVZ+
        69JNZ08R5FfUu0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A39F010DEF1;
        Wed,  9 Feb 2022 11:20:03 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [71.254.192.242])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AF01710DEED;
        Wed,  9 Feb 2022 11:20:02 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Wed, 9 Feb 2022 11:20:00 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org, Henning Schild <henning.schild@siemens.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Hans Jerry Illikainen <hji@dyntopia.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gpg-interface: fix for gpgsm v2.3
Message-ID: <YgPpsJ1UCEI0a4b6@pobox.com>
References: <20220203123724.47529-1-fs@gigacodes.de>
 <Yfw0kapgSSWO3Pyx@pobox.com>
 <20220207105240.dk443kcozynlonpp@fs>
 <YgFK+F6Ks8FnN5Q6@pobox.com>
 <20220209083351.dsoxnhhme3lracck@fs>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20220209083351.dsoxnhhme3lracck@fs>
X-Pobox-Relay-ID: 228CD45E-89C4-11EC-8B65-5E84C8D8090B-09356542!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer wrote:
> On 07.02.2022 11:38, Todd Zullinger wrote:
>> How did it fail for you?  It passes all the tests when I've
>> run it against Fedora and RHEL-based hosts.  If it's flaky
>> on other systems, that would put a damper on doing it this
>> way.  Though it _should_ work.
>=20
> Sorry for the delays, I'm a bit busy with other things at the moment.

No apologies needed.  This is something I worked on back in
November and had yet to send to the list, so I'm the last
person to rush another. :)

> I did get an interactive popup asking if I would like to
> trust the key when I ran the t4202 test. This never
> happened with the old variant.

Interesting.  I do have a patch in my gnupg-2.3 series to
reload the gpg agent after changing the trustlist, as the
changes were not picked up prior to that.  In my case, I was
running the tests in an environment where gpg could not
prompt me.  (It also seems like we should try harder to have
the test suite reject such prompts).

--- 8< ---
Subject: [PATCH] t/lib-gpg: reload gpg components after updating trustlis=
t

With gpgsm from gnupg-2.3, the changes to the trustlist.txt do not
appear to be picked up without refreshing the gpg-agent.  Use the 'all'
keyword to reload all of the gpg components.  The scdaemon is started as
a child of gpg-agent, for example.

We used to have a --kill at this spot, but I removed it in 2e285e7803
(t/lib-gpg: drop redundant killing of gpg-agent, 2019-02-07).  It seems
like it might be necessary (again) for 2.3.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---

Notes:
    An alternative to doing this dance with the trustlist.txt and having =
to
    kill and/or reload the gpg-agent to pick up the change right after th=
e
    import in each test might be to make this part of the steps used when
    adding/updating/removing certificates in t/lib-gpg.
   =20
    If not as a one-time affair when a cert is added/update/removed, then
    perhaps as a step taken by/in t/lib-gpg.sh only once.  It could popul=
ate
    a gpghome to be copied into the trash dir for each test which used
    gpg/gpgsm.  I haven't measured the effect of the extra reload precise=
ly,
    but I'm sure it's not free.
   =20
    (For what it's worth, it didn't add any noticeable amount of time to =
the
    full builds/test runs I made while working on this, so it's a seeming=
ly
    small cost, at least.)
   =20
    Also, hello Henning,
   =20
    Way back, in February 2019=B9, when I submitted 2e285e7803 to remove =
the
    "redundant" killing of the gpg-agent, you said:
   =20
    > Killing the agent once should be enough, i remember manually killin=
g
    > it many times as i was looking for a way to generate certs and trus=
t
    > (configure gpgsm for the test). That is probably why i copied it ov=
er
    > in the first place.
   =20
    As I wrote this patch to partially restore the gpg-agent killing (now
    just a reload), I thought this might have been the sort of issue that
    you hit while testing.
   =20
    It could be unrelated, but it sounds quite similar to what I found wi=
th
    gnupg-2.3 when trying to get it to pick up the trustlist.txt changes.=
  I
    thought you might at least enjoy seeing it come back around.  :)
   =20
    =B9 <20190208093324.7b17f270@md1za8fc.ad001.siemens.net>

 t/lib-gpg.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 6bc083ca77..38e2c0f4fb 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -75,6 +75,7 @@ test_lazy_prereq GPGSM '
 	gpgsm --homedir "${GNUPGHOME}" -K --with-colons |
 	awk -F ":" "/^fpr:/ {printf \"%s S relax\\n\", \$10}" \
 		>"${GNUPGHOME}/trustlist.txt" &&
+	(gpgconf --reload all || : ) &&
=20
 	echo hello | gpgsm --homedir "${GNUPGHOME}" >/dev/null \
 	       -u committer@example.com -o /dev/null --sign -

--- 8< ---

I have another patch which changes the earlier gpgconf call
which kills gpg-agent to kill all gpg daemons, as there are
some others which could potentially interfere with the
tests:

--- 8< ---
Subject: [PATCH] t/lib-gpg: kill all gpg components, not just gpg-agent

The gpg-agent is one of several processes that newer releases of GnuPG
start automatically.  Issue a kill to each of them to ensure they do not
affect separate tests.  (Yes, the separate GNUPGHOME should do that
already. If we find that is case, we could drop the --kill entirely.)

In terms of compatibility, the 'all' keyword was added to the --kill &
--reload options in GnuPG 2.1.18.  Debian and RHEL are often used as
indicators of how a change might affect older systems we often try to
support.

    - Debian Strech (old old stable), which has limited security support
      until June 2022, has GnuPG 2.1.18 (or 2.2.x in backports).

    - CentOS/RHEL 7, which is supported until June 2024, has GnuPG
      2.0.22, which lacks the --kill option, so the change won't have
      any impact.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 t/lib-gpg.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index d675698a2d..2bb309a8c1 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -40,7 +40,7 @@ test_lazy_prereq GPG '
 		#		> lib-gpg/ownertrust
 		mkdir "$GNUPGHOME" &&
 		chmod 0700 "$GNUPGHOME" &&
-		(gpgconf --kill gpg-agent || : ) &&
+		(gpgconf --kill all || : ) &&
 		gpg --homedir "${GNUPGHOME}" --import \
 			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
 		gpg --homedir "${GNUPGHOME}" --import-ownertrust \
--- 8< ---

I have the series in the gpg-misc-fixes branch:

    https://github.com/tmzullinger/git/commits/gpg-misc-fixes

(That series does differ in that it has `string_list_split()`
instead of the simpler `strbuf_addch(&gpg_status, '\n');` to
fix the gpgsm parsing.)

Iff you think it would be useful or helpful, I can post that
series.

Thanks,

--=20
Todd
