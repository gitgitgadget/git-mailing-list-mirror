Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C6D1ECAAD3
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 15:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiISPAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 11:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiISPAL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 11:00:11 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174922E9E7
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 08:00:09 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id A68035A26C;
        Mon, 19 Sep 2022 15:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1663599608;
        bh=Os+x/iohv6XEUfhg+2bapHAOUkDDaFpcfWQRCb7RD6s=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=0yK71yiGNfOxEXNlhxtyM/FljCD4AFixRHDY5TadvF+YdOfer0HBPWlVgudxcduL0
         6CZ08BICfr+oSEtA3GxlM9UbyrAfVNqJoAqHWaG7Axi9nOK/cZkC3104q/cwu6MPth
         lVJth6DF3Vu2YStFdVONRsHIY2/bbEx4Oq79cl7jC2rKPPSsXlEOdhtEdJZ5+C32yH
         CDwE88HSwEOGTFAC2OrLU1/oLzqDUGwzXKNni9jrgS6CQeYZzz6upiwmkVgiUKR3vY
         5tye48j/yhzQCpuBM7nMGz2lvoBxRO+I/xjmocToa9yZpU64j7noZLfTdHeNJ85zH8
         e33BlLBjLaT6yXgdu0h+YWFkawC9f/Ng3vid9pa6GCguHiPPbbOI09YDc1gwtYmPG/
         jsptJmkRE51kT/femXr2Pyz6I6L3iGwZwhJ4MkbL1/3zuRDjTsBlokNHujOdXoSNV5
         lM4uYoN73VT741JQuipvHg6xRCh7ctH9An+HNYXf4GUEDA4d61d
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC PATCH 0/2] Opaque author and committer identifiers
Date:   Mon, 19 Sep 2022 14:52:29 +0000
Message-Id: <20220919145231.48245-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.37.2.609.g9ff673ca1a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There have been frequent discussions on the list about the mailmap and
how it's not currently the ideal way to map former identities to current
identities.  This is especially true for transgender people, who often
don't want to associate their deadname with their current name in plain
text.

This is an RFC series that I talked about to some folks at Git Merge.
Roughly, this documents a format for an opaque identifier which is
compatible with existing implementations by overloading the email
address field with something that is not a real email address and cannot
be confused with one.  This opaque identifier is the fingerprint of some
key, which in most cases will be an SSH key.

It also proposes moving the mailmap out of the main history and into a
special ref for this purpose.  Notably, so as not to make the same
mistake we did with grafts, where they are not pushed by default and so
nobody uses them, the proposal here is to change tooling so that the
mailmap refs are easy to push and pull and that this is done by default
(with an easy way to opt-out).  By default, local changes to the mailmap
ref are squashed into the current commit such that there is only one
commit on the ref.  This preserves the existing mapping while not
retaining former identities, which we don't really need. (Who wants to
send email to a contributor's address at a former employer which doesn't
work anymore?)

Since this series needs a way to cart mailmap information around in
patches and I would not like to repeat the same design as base-commit,
I've proposed a separate header to include this information around.  I'm
not terribly attached to this proposal and am open to other ideas if
folks like them better, but I feel it moves us in a useful direction to
being able to include other metadata in a structured way and to sending
signed commits by patch, which other folks wanted to do (and I am in
favour of).  (I'm willing to implement such a feature based on this
approach in the future if folks desire.)

All of these changes will be optional to adopt.  Projects need not use
them if they don't want to.  However, I am proposing that they be
advertised prominently as a preferred option (for example, in the "Tell
me who you are" message) to encourage adoption.  Appropriate tooling
will be included to make this easy.

In addition, besides the general benefits for trans folks and the
ability to operate anonymously or pseudonymously, I also think using an
opaque identifier will cut down on spam.  I have received many unwelcome
solicitations from employers and survey-toting academics to my email
address, as I'm sure others have.  Receiving fewer of these in the
future will be a nice bonus.

For those folks using forges, it should be noted that associating an
identifier with an account should be very easy, since the forge usually
has SSH key support and commit verification and thus, the user's keys,
so there's no change to workflow on forges once they implement this
feature.  For those forges which use the user's personal name in the UI,
this can simply be replaced by the personal name the user has registered
with the forge.

None of this deals with rewriting identities in existing commits.  We
have what we have now and can't change it, but we can do something
different going forward.  If there is interest in the hashed mailmap
approach or another similar approach, I'm open to resurrecting that in
addition provided we agree as a project not to write tools which
trivially invert the hashed mailmap (which was the reason I dropped that
series in the first place).

I realize this is a radical departure from what we've done historically,
so this is an RFC series.  It's to gauge interest in this proposal and
design and to discuss alternatives before implementation. If we like
this approach, I will agree to implement it as my time allows, which I
expect could be done in a single series of under 30 patches.

I've CC'd some of the folks I talked to about this and some folks who I
think might be interested, but of course any constructive feedback is
welcome.

brian m. carlson (2):
  doc: specify a header for including arbitrary format-patch metadata
  docs: document a format for anonymous author and committer IDs

 Documentation/technical/anonymous-id.txt      | 143 ++++++++++++++++++
 .../technical/format-patch-metadata.txt       |  58 +++++++
 2 files changed, 201 insertions(+)
 create mode 100644 Documentation/technical/anonymous-id.txt
 create mode 100644 Documentation/technical/format-patch-metadata.txt

