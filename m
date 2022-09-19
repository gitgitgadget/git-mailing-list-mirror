Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFF7ECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 15:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiISPAY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 11:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiISPAP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 11:00:15 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365E42E9F3
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 08:00:09 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id C39F35A508;
        Mon, 19 Sep 2022 15:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1663599608;
        bh=TcGuH9UMQ6Mebqf4Iv5lJl2DZbZEUuFifvKni2AR+dE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=g5CpeJzhISWFpjrsBQZv7uWkI/y7GY3VYG0447NRFFR98vVeSHxb9wq3Me5clki7s
         alJwggm3D+PTAJNnYVRT63xWUp5+CtUyxrWPNWne/AZul80hU0IL88e8sv2lb3cNCg
         azwgdVXykMvCnDitMDUjjDgXvtioBaZDWZXJacGssH1t3HHQQk19xNvL5BwTZRJJx0
         bjFOwOz5gvHDUmq7XDmFvHhCkGVPr977lFNotlS32YMX0ClsXTrbzqQRmMxofGw3vw
         5Z2vZAstBMhZ1cCcrjM+A04OEprs0A95G9Vt3VjfosY2ouBFpT0GI11I6/vdSHjTZc
         nLz4p18x8b2QMwGQB5Gs4fOTcK5zX+F/Te/qdZgTNI7mXlBWos/GI6x41lCx9YHq1M
         RDTQZ5xjyLJh2AUSICzUKnrgovJL9fo+RE4F1s2EP3nXckYehmlUUVBOXEYwEJtoPa
         CoDyuPz3KRq0vxGgaOtruKKXTFqaFYzuDzAAVdVNYkytRNRnT/6
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC PATCH 2/2] docs: document a format for anonymous author and committer IDs
Date:   Mon, 19 Sep 2022 14:52:31 +0000
Message-Id: <20220919145231.48245-3-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a
In-Reply-To: <20220919145231.48245-1-sandals@crustytoothpaste.net>
References: <20220919145231.48245-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The original design of Git embeds a personal name and email in every
commit.  This has lots of downsides, including the following.

First, people do not want to bake an email into an immutable Merkle tree
that they send everywhere.  Spam, whether in general or by recruiters,
is a problem, and even when it's not, people change companies or
institutions and emails become invalid.

Second, some people prefer to operate anonymously and don't want to
specify personal details everywhere.

Third, and most important, people change names.  This happens for many
reasons, but it comes up most saliently for transgender people, who
frequently change their name as part of their transition.  Referring to
a transgender person's former name, their "deadname", is considered
inappropriate.

We have a solution that can map former personal names and emails into
current ones, the mailmap.  However, this last case poses a problem,
because we don't really want to correlate the person's deadname (or
their email, which may contain their deadname) right next to their
current name.

Several solutions have been proposed for this case, including hashing or
encoding the old information, but these are all easily invertible.
Instead, let's propose a new form of identifier which is opaque and some
mailmap improvements to store the mailmap information outside of the
main history.

Propose that users use the fingerprint of a cryptographic key as part of
a special-form email which is not valid according to RFC 1123, but is
accepted by earlier versions of Git.  Now that we have SSH signing and
OpenSSH is available on all major platforms, creating a unique ID is as
easy as running ssh-keygen.  This approach results in an identifier
which is unique, deterministic, and completely anonymous.

Propose this new option instead of using a name and email, although
users can continue to use those as before if they prefer. Continue to
associate personal information with this opaque identifier using the
mailmap, but in such a way that it lives in a special ref outside of the
history and that ref is customarily kept squashed to a single commit.
Create a special RFC 5322 header to associate a mailmap entry with the
user's opaque identifier when sending a patch if desired.

Because the mailmap now lives outside the history in a single squashed
commit, a user may simply update their name by sending a new patch with
the same opaque ID, or proposing a change to the mailmap independently.
A person's former name or email address is not retained in the history
(unless the project chooses to do that for the mailmap ref).

Since many people use forges for hosting their code and forges offer
commit verification and SSH access, it is extremely easy for a forge to
associate a commit with this new opaque identifier with a user, since
they probably already have this information.  Thus, for projects which
use solely a forge-based development workflow, no mailmap entry need
even be created unless one is desired.  If one is desired, it may be
able to be created and updated automatically as part of the forge's
normal infrastructure simply upon sending a patch.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/technical/anonymous-id.txt      | 143 ++++++++++++++++++
 .../technical/format-patch-metadata.txt       |   3 +
 2 files changed, 146 insertions(+)
 create mode 100644 Documentation/technical/anonymous-id.txt

diff --git a/Documentation/technical/anonymous-id.txt b/Documentation/technical/anonymous-id.txt
new file mode 100644
index 0000000000..aeba5e68f2
--- /dev/null
+++ b/Documentation/technical/anonymous-id.txt
@@ -0,0 +1,143 @@
+Anonymous IDs
+=============
+
+Objective
+---------
+
+Provide a way for people to identify themselves without the need to associate a
+fixed personal name or email.
+
+Background
+----------
+
+People change their name and email many times over the course over their lives.
+For example, people may marry or change jobs.  In many cases, these changes can
+be handled by the mailmap.  However, for many transgender people, keeping the
+old name in the mailmap is often undesirable.
+
+This document proposes a new way to specify anonymous IDs based on an SSH key or
+GnuPG key instead along with a mailmap which is automatically downloaded from
+the remote which provides an automatic correspondence.  In this approach, all
+users are expected to specify an anonymous ID and a mailmap entry.
+
+This does not solve the problem of previous commits, but it does solve the
+approach going forward if reasonably well adopted and avoids the problems of
+existing approaches of obscuring the mailmap which are defeated by simply
+enumerating all entries in all commits.
+
+Anonymous IDs
+-------------
+
+Git will implement a new form of email address which is acceptable to existing
+implementations but is not valid according to RFC 1123.  This takes the form of
+an email address where the local-part contains the identifier and the domain
+portion starts with `_.` and then a domain specifier which specifies an
+authority and the meaning of the identifier.
+
+In such a case, Git will specify the username as a single U+2060 in UTF-8 (the
+byte sequence 0xE2 0x81 0xA0), which is a zero width non-breaking space.  This
+is compatible with existing implementations.
+
+The Git project will specify a set of identifiers under the domain
+`id.git-scm.com`.  The next component is the type of key as specified by the
+`gpg.program` identifier, and then a component indicating the hash type or
+version number as specified below.
+
+This approach provides IDs which are simple and easy to create (almost all users
+will have an SSH implementation which can generate keys with a single command),
+opaque, completely deterministic, and not personally identifiable.
+
+Other authorities, such as hosting providers, may use different IDs.  For
+example, if the hosting provider example.com might issue the ID
+`1234@_.user.example.com` for user ID 1234.  Authorities are encouraged to use
+database IDs or other unique IDs rather than usernames, since many usernames
+contain human names or corporate affiliations, which defeats the point of this
+feature.
+
+In conjunction with a single, constantly rewritten mailmap reference and
+`mailmap.blob`, this allows users to move their real IDs outside of the commit
+IDs into a mailmap which is constantly rewritten.  If a user's real name or
+email changes, they can submit an update to the mailmap and the ID, which will
+be squashed into a single commit without history.
+
+Specifications
+~~~~~~~~~~~~~~
+
+OpenPGP Keys
+^^^^^^^^^^^^
+
+If a user possesses a v4 OpenPGP key, then they may use the domain
+`_.v4.openpgp.id.git-scm.com` using a lowercase hex form of the SHA-1
+fingerprint as the local-part.  For example, the key with the fingerprint
+`da39a3ee5e6b4b0d3255bfef95601890afd80709` would have the email address
+`da39a3ee5e6b4b0d3255bfef95601890afd80709@_v4.openpgp.id.git-scm.com`.
+
+Similarly, when RFC 4880 bis is implemented using v5 keys with SHA-256
+fingerprints, the domain `_.v5.openpgp.id.git-scm.com` may be used with a
+lowercase hex form of the SHA-256 fingerprint as the local-part.
+
+SSH Keys
+^^^^^^^^
+
+If a user possesses an SSH key, then they may use the domain
+`_.sha256.ssh.id.git-scm.com` using a base64url encoding (without padding) as
+the local-part.  This is the RFC 4648 Base64 encoding with URL and filename safe
+alphabet without the padding character.  For example, a user whose SSH key
+fingerprint is `47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU` may use
+`47DEQpj8HBSa-_TImW-5JCeuQeRkm5NMpJWZG3hSuFU@_.sha256.ssh.id.git-scm.com`.
+
+It's intentional that no specification is provided for MD5 fingerprints.  MD5 is
+obsolete and should not be used in new protocols such as this.
+
+X.509 Certificates
+^^^^^^^^^^^^^^^^^^
+
+If a user possesses an X.509 certificate, then they may use the domain
+`_.sha256.x509.id.git-scm.com` using a lowercase hex form of the SHA-256
+fingerpint of the certificate.  For example, if the key fingerprint is
+`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855`, then the ID
+would be
+`e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855@_.sha256.x509.id.git-scm.com`.
+
+Emission
+~~~~~~~~
+
+A user may specify, instead of `user.email`, a `user.signingkey` (or a suitable
+protocol-specific setting).  If `user.idFormat` is set to `email`, then the
+user's email will be written into the commit; if it is instead set to `key`,
+then the ID corresponding to the key is extracted from the signing program and
+that is used instead.  `id` can be used to specify the `user.id` value. An order
+of items to try can be specifed with a colon-separated list.  The default, which
+is subject to change, is `id:email:key`.  This allows users to specify an
+independent ID which is independent of their email.
+
+For patches, a user may specify `format.id` as `as-is` to leave the data as is,
+or as `mailmap` to use the mailmap value to rewrite it to the value in the
+mailmap. If the user specifies `mailmap-metadata`, then an in-body `From:` line
+in the patch is written to contain the author ID using the ID as written in the
+commit, but a format-patch metadata header is written using the mailmap entry in
+the commit.
+
+Expected Mailmap Improvements
+-----------------------------
+
+Right now, the mailmap is included in a repository as part of a regular commit.
+This means it has a history, which is undesirable if the user would like to
+completely rewrite their identity.
+
+This can be easily solved with some mailmap improvements.  `git clone` will
+learn a command, `--use-mailmap`, which will specifically fetch the ref
+`refs/mailmap` from the remote and keep it up to date using force updates if
+necessary.  This option will also specify `mailmap.blob` to point to the
+`.mailmap` file in this ref, which allows the user to automatically keep it up
+to date with the remote.
+
+`git am` or `git apply` can then apply the mailmap entry from the patch to the
+appropriate ref with `--use-mailmap`.  The default is `--use-mailmap=amend`,
+which amends the existing commit.   If a user would like to preserve a history
+for some reason, they can use `--use-mailmap=commit`.  For maintainers, they can
+then push this ref using the normal push refspecs, or explicitly with
+`--mailmap`, which is equivalent to `+refs/mailmap:refs/mailmap`.
+
+The goal of this is to make interacting with the mailmap refs automatic and
+transparent whenever other data is fetched or cloned from the remote.
diff --git a/Documentation/technical/format-patch-metadata.txt b/Documentation/technical/format-patch-metadata.txt
index 5448918da9..87e301b65e 100644
--- a/Documentation/technical/format-patch-metadata.txt
+++ b/Documentation/technical/format-patch-metadata.txt
@@ -40,6 +40,9 @@ gpgsig-sha1::
 gpgsig-sha256::
 	This specifies the base commit for this patch using the SHA-256 object ID, as
 	specified in the `gpgsig-sha256` header.
+mailmap-author::
+	This specifies the mailmap entry to associate with the email address or other
+	identifier in the `From:` header.
 
 Examples
 --------
