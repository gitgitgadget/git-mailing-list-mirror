Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762E61993AC
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723553155; cv=none; b=oEHDRhUFVQFV/qKrwXkq39aLf1XNzEu1NltsrnDKvD2x+AkL8yCys4U/ZLeXDe4/BW3P8SBPyUZ7Z/M5vjz5vDYOZR2QmCKbdsj9V/b2qiE5gNrlzgkBBibySnIQCpaZk75whbcd55NFETt668jqKjrQrMHvDM9+5lij79bon0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723553155; c=relaxed/simple;
	bh=3a82u8+dOu2A/q+klbqldIgmSg7HN1+Mk3MRn43IgaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qa/BRpJOw4g/UHGux8lfnM9btzYVuUklXf1R441+gatRVCqrFsX1X/cjExRvI25o8bEdEPmubPw2wHZI+Ip4fOsVNP8TfHPBsrjxeAUU0AAD7NbSqyIFn4GCUheclSiTffJIzoE4N+4Ia5jfLsno2ToGvQEhtTiTlpdkMn7DCOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 4617 invoked by uid 109); 13 Aug 2024 12:45:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Aug 2024 12:45:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6587 invoked by uid 111); 13 Aug 2024 12:45:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Aug 2024 08:45:51 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 13 Aug 2024 08:45:50 -0400
From: Jeff King <peff@peff.net>
To: Matt Thompson <fortran@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH] get_oid(): enforce minimum length for "-g<hex>" names
Message-ID: <20240813124550.GC968816@coredump.intra.peff.net>
References: <CAFb48S8LDz4kiWsKSCBn8J=AHyQ5SVPFH4GY=z+8=DntT=PyAw@mail.gmail.com>
 <xmqqy15b2aiz.fsf@gitster.g>
 <CAFb48S8+X0=Zqi8oisB0fAgx7HoyQrahF-RGQdagXTX3RdfSNQ@mail.gmail.com>
 <20240813115358.GB968816@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240813115358.GB968816@coredump.intra.peff.net>

On Tue, Aug 13, 2024 at 07:53:58AM -0400, Jeff King wrote:

>   - the hash is abbreviated in the usual way, making it as short as
>     possible while remaining unambiguous. But unless the user goes out
>     of their way to set core.abbrev to something smaller, the minimum is
>     always 7. So perhaps get_describe_name() should be a bit more picky
>     about about that?
> 
>     That doesn't fix the problem, but it makes it a lot less likely to
>     trigger in the real world. And anybody who really does somehow end
>     up with a describe name with 4 characters can always pick the hash
>     out of the string themselves (or just set core.abbrev in their local
>     repo to be more permissive).
> 
> I think the second one is something like this:
> 
> diff --git a/object-name.c b/object-name.c
> index 527b853ac4..a90338aa62 100644
> --- a/object-name.c
> +++ b/object-name.c
> @@ -1276,6 +1276,10 @@ static int get_describe_name(struct repository *r,
>  			if (ch == 'g' && cp[-1] == '-') {
>  				cp++;
>  				len -= cp - name;
> +				if (len < (default_abbrev < 0 ?
> +					   FALLBACK_DEFAULT_ABBREV :
> +					   default_abbrev))
> +					return -1;
>  				return get_short_oid(r,
>  						     cp, len, oid, flags);
>  			}

After thinking on this for a bit, it seems like the correct direction.
So here it is written in a slightly more readable way, and with a commit
message and tests.

-- >8 --
Subject: [PATCH] get_oid(): enforce minimum length for "-g<hex>" names

Since 7dd45e15c2 (sha1_name.c: understand "describe" output as a valid
object name, 2006-09-20), we'll resolve a name like "foo-g1234abc" into
the object name "1234abc". However, this has a small chance of creating
a surprising ambiguity.

For example, in a real world case we saw a name like "foo-gcc14" where
"gcc14" refers to the compiler, but which caused us to look for an
object with prefix "cc14". And if the repo is large enough to have such
an object, and small enough that there is only one such commit (since we
feed the disambiguation lookup code with the "commit" hint), then we'll
return that object.

Note that we would still resolve "foo-gcc14" as a tag name in preference
to the describe name. But in this case it did not exist, and resolving
anything was a surprise.

We can't solve the ambiguity completely, but we can reduce the chances
of it happening significantly by enforcing a minimum length we'll accept
for the hex component. Since the name may have been generated by another
repository, we can't know for sure what minimum they would have used,
but a good guess is the value of core.abbrev (or if it's set to "auto",
which is the default these days, the hard-coded minimum of "7").

There are five new tests here:

  1. We check that describe names can be resolved at all. As far as I
     can tell we had no existing test that covered this. It passes
     before and after this patch.

  2. Another option for solving this would be to insist that "foo" in
     "foo-gcc14" matches an existing ref (which would have been the
     source of the description). I don't think this is a good idea,
     though, as part of the point of having the "-g<hex>" suffix is that
     you might not have the same tags as whoever generated it. So this
     test codifies the existing behavior that we do not care about the
     parts before the "-g" at all.

  3. Looking at the loop in get_describe_name(), we read from the back
     end and check for "-g" when we see a non-hex digit. But if it's not
     "-g", we keep looking! So for a name like "foo-g1234abc-bar", we'll
     still pass "1234abc-bar" to get_short_oid()! This is OK in
     practice, since it will barf when seeing the non-hex digits. But
     let's confirm that it does so. This is particularly important
     with our length checks, since "foo-gcc14-bar" would yield a length
     of 8, which is plausibly long (so we are likewise depending on
     get_short_oid() to reject it).

  4. We check that names shorter than core.abbrev are rejected (i.e.,
     the fix in this patch).

  5. Likewise, when core.abbrev is "auto", we enforce the 7-character
     minimum.

Reported-by: Matt Thompson <fortran@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 object-name.c       | 12 ++++++++++++
 t/t6120-describe.sh | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/object-name.c b/object-name.c
index 527b853ac4..6507a30ace 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1274,8 +1274,20 @@ static int get_describe_name(struct repository *r,
 			 * for it to be describe output.
 			 */
 			if (ch == 'g' && cp[-1] == '-') {
+				/*
+				 * To reduce the chance of false positives,
+				 * assume that any "-g<hex>" must have some
+				 * minimum number of <hex> that matches what
+				 * we'd produce when abbreviating.
+				 */
+				int min_len = default_abbrev;
+				if (min_len < 0)
+					min_len = FALLBACK_DEFAULT_ABBREV;
+
 				cp++;
 				len -= cp - name;
+				if (len < min_len)
+					return -1;
 				return get_short_oid(r,
 						     cp, len, oid, flags);
 			}
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 79e0f19deb..790afe40ac 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -707,4 +707,37 @@ test_expect_success 'describe --broken --dirty with a file with changed stat' '
 	)
 '
 
+test_expect_success 'long describe name can be resolved' '
+	name=$(git describe --long A) &&
+	git rev-parse "A^{commit}" >expect &&
+	git rev-parse "$name" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'resolving describe name does not depend on tag' '
+	hash=$(git rev-parse A^{commit}) &&
+	abbrev=$(echo $hash | cut -c1-30) &&
+	echo "$hash" >expect &&
+	git rev-parse "does-not-exist-g$abbrev" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'resolving describe name only valid at end' '
+	hash=$(git rev-parse A^{commit}) &&
+	abbrev=$(echo $hash | cut -c1-30) &&
+	test_must_fail git rev-parse "foo-g$abbrev-bar"
+'
+
+test_expect_success 'resolving describe name requires minimum abbrev (auto)' '
+	hash=$(git rev-parse A^{commit}) &&
+	abbrev=$(echo $hash | cut -c1-6) &&
+	test_must_fail git -c core.abbrev=auto rev-parse "foo-g$abbrev"
+'
+
+test_expect_success 'resolving describe name requires minimum abbrev (config)' '
+	hash=$(git rev-parse A^{commit}) &&
+	abbrev=$(echo $hash | cut -c1-20) &&
+	test_must_fail git -c core.abbrev=25 rev-parse "foo-g$abbrev"
+'
+
 test_done
-- 
2.46.0.452.ga6607598b6

