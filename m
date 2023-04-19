Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88178C77B75
	for <git@archiver.kernel.org>; Wed, 19 Apr 2023 01:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjDSBaC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 21:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjDSBaB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 21:30:01 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F817ED7
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 18:29:58 -0700 (PDT)
Received: (qmail 11949 invoked by uid 109); 19 Apr 2023 01:29:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 19 Apr 2023 01:29:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8116 invoked by uid 111); 19 Apr 2023 01:29:57 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Apr 2023 21:29:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Apr 2023 21:29:57 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Rolf Eike Beer <eb@emlix.com>, git@vger.kernel.org,
        Jaydeep P Das <jaydeepjd.8914@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] gpg-interface: set trust level of missing key to "undefined"
Message-ID: <20230419012957.GA503941@coredump.intra.peff.net>
References: <5926995.lOV4Wx5bFT@devpool47.emlix.com>
 <20230418064846.GA1414@coredump.intra.peff.net>
 <xmqqy1mpduq3.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy1mpduq3.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2023 at 09:24:20AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > which restores the original behavior, or if the original was papering
> > over another bug (e.g., should this be "undefined"?). Certainly the
> > empty string matches other placeholders like %GS for this case (since we
> > obviously don't know anything about the signer).
> 
> Heh, I shouldn't have wasted my cycles in "git log" but in my
> newsreader ;-)
> 
> Looking at the original before the gpg_trust_level_to_str() function
> was introduced, the switch statement looks like it is missing the
> usual "default: BUG()" for unhandled enum.  My version made it mimic
> what ssh side seems to do, but I tend to prefer your empty string
> that differentiates between "we never saw any trust level" and "the
> system says this key should never be trusted".

Actually it gets weirder even, as I think we're violating the C standard
a bit here. ;)

Here's the patch that I came up with, though it does not distinguish
between "we did not see any trust level" and "gpg told us the trust
level was undefined". I think that's OK. That level is still below
TRUST_NEVER. But if we really want to distinguish we can introduce a new
value for the enum.

-- >8 --
Subject: gpg-interface: set trust level of missing key to "undefined"

In check_signature(), we initialize the trust_level field to "-1", with
the idea that if gpg does not return a trust level at all (if there is
no signature, or if the signature is made by an unknown key), we'll
use that value. But this has two problems:

  1. Since the field is an enum, it's up to the compiler to decide what
     underlying storage to use, and it only has to fit the values we've
     declared. So we may not be able to store "-1" at all. And indeed,
     on my system (linux with gcc), the resulting enum is an unsigned
     32-bit value, and -1 becomes 4294967295.

     The difference may seem academic (and you even get "-1" if you pass
     it to printf("%d")), but it means that code like this:

       status |= sigc->trust_level < configured_min_trust_level;

     does not necessarily behave as expected. This turns out not to be a
     bug in practice, though, because we keep the "-1" only when gpg did
     not report a signature from a known key, in which case the line
     above:

       status |= sigc->result != 'G';

     would always set status to non-zero anyway. So only a 'G' signature
     with no parsed trust level would cause a problem, which doesn't
     seem likely to trigger (outside of unexpected gpg behavior).

  2. When using the "%GT" format placeholder, we pass the value to
     gpg_trust_level_to_str(), which complains that the value is out of
     range with a BUG(). This behavior was introduced by 803978da49
     (gpg-interface: add function for converting trust level to string,
     2022-07-11). Before that, we just did a switch() on the enum, and
     anything that wasn't matched would end up as the empty string.

     Curiously, solving this by naively doing:

       if (level < 0)
               return "";

     in that function isn't sufficient. Because of (1) above, the
     compiler can (and does in my case) actually remove that conditional
     as dead code!

We can solve both by representing this state as an enum value. We could
do this by adding a new "unknown" value. But this really seems to match
the existing "undefined" level well. GPG describes this as "Not enough
information for calculation".

We have tests in t7510 that trigger this case (verifying a signature
from a key that we don't have, and then checking various %G
placeholders), but they didn't notice the BUG() because we didn't look
at %GT for that case! Let's make sure we check all %G placeholders for
each case in the formatting tests.

The interesting ones here are "show unknown signature with custom
format" and "show lack of signature with custom format", both of which
would BUG() before, and now turn %GT into "undefined". Prior to
803978da49 they would have turned it into the empty string, but I think
saying "undefined" consistently is a reasonable outcome, and probably
makes life easier for anyone parsing the output (and any such parser had
to be ready to see "undefined" already).

The other modified tests produce the same output before and after this
patch, but now we're consistently checking both %G? and %GT in all of
them.

Signed-off-by: Jeff King <peff@peff.net>
Reported-by: Rolf Eike Beer <eb@emlix.com>
---
 gpg-interface.c          |  2 +-
 t/t7510-signed-commit.sh | 21 ++++++++++++++-------
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index aceeb08336..f3ac5acdd9 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -650,7 +650,7 @@ int check_signature(struct signature_check *sigc,
 	gpg_interface_lazy_init();
 
 	sigc->result = 'N';
-	sigc->trust_level = -1;
+	sigc->trust_level = TRUST_UNDEFINED;
 
 	fmt = get_format_by_sig(signature);
 	if (!fmt)
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 48f86cb367..ccbc416402 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -221,84 +221,91 @@ test_expect_success GPG 'amending already signed commit' '
 test_expect_success GPG 'show good signature with custom format' '
 	cat >expect <<-\EOF &&
 	G
+	ultimate
 	13B6F51ECDDE430D
 	C O Mitter <committer@example.com>
 	73D758744BE721698EC54E8713B6F51ECDDE430D
 	73D758744BE721698EC54E8713B6F51ECDDE430D
 	EOF
-	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" sixth-signed >actual &&
+	git log -1 --format="%G?%n%GT%n%GK%n%GS%n%GF%n%GP" sixth-signed >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success GPG 'show bad signature with custom format' '
 	cat >expect <<-\EOF &&
 	B
+	undefined
 	13B6F51ECDDE430D
 	C O Mitter <committer@example.com>
 
 
 	EOF
-	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" $(cat forged1.commit) >actual &&
+	git log -1 --format="%G?%n%GT%n%GK%n%GS%n%GF%n%GP" $(cat forged1.commit) >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success GPG 'show untrusted signature with custom format' '
 	cat >expect <<-\EOF &&
 	U
+	undefined
 	65A0EEA02E30CAD7
 	Eris Discordia <discord@example.net>
 	F8364A59E07FFE9F4D63005A65A0EEA02E30CAD7
 	D4BE22311AD3131E5EDA29A461092E85B7227189
 	EOF
-	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >actual &&
+	git log -1 --format="%G?%n%GT%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success GPG 'show untrusted signature with undefined trust level' '
 	cat >expect <<-\EOF &&
+	U
 	undefined
 	65A0EEA02E30CAD7
 	Eris Discordia <discord@example.net>
 	F8364A59E07FFE9F4D63005A65A0EEA02E30CAD7
 	D4BE22311AD3131E5EDA29A461092E85B7227189
 	EOF
-	git log -1 --format="%GT%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >actual &&
+	git log -1 --format="%G?%n%GT%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success GPG 'show untrusted signature with ultimate trust level' '
 	cat >expect <<-\EOF &&
+	G
 	ultimate
 	13B6F51ECDDE430D
 	C O Mitter <committer@example.com>
 	73D758744BE721698EC54E8713B6F51ECDDE430D
 	73D758744BE721698EC54E8713B6F51ECDDE430D
 	EOF
-	git log -1 --format="%GT%n%GK%n%GS%n%GF%n%GP" sixth-signed >actual &&
+	git log -1 --format="%G?%n%GT%n%GK%n%GS%n%GF%n%GP" sixth-signed >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success GPG 'show unknown signature with custom format' '
 	cat >expect <<-\EOF &&
 	E
+	undefined
 	65A0EEA02E30CAD7
 
 
 
 	EOF
-	GNUPGHOME="$GNUPGHOME_NOT_USED" git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >actual &&
+	GNUPGHOME="$GNUPGHOME_NOT_USED" git log -1 --format="%G?%n%GT%n%GK%n%GS%n%GF%n%GP" eighth-signed-alt >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success GPG 'show lack of signature with custom format' '
 	cat >expect <<-\EOF &&
 	N
+	undefined
 
 
 
 
 	EOF
-	git log -1 --format="%G?%n%GK%n%GS%n%GF%n%GP" seventh-unsigned >actual &&
+	git log -1 --format="%G?%n%GT%n%GK%n%GS%n%GF%n%GP" seventh-unsigned >actual &&
 	test_cmp expect actual
 '
 
-- 
2.40.0.579.g88b9f0bf51

