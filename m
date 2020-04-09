Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99745C2BA19
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 20:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA8120730
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 20:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OCgjBiBq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgDIULj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 16:11:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54439 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgDIULj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 16:11:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 44D13C198F;
        Thu,  9 Apr 2020 16:11:38 -0400 (EDT)
        (envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=sasl; bh=I9Dafv51r66XpmBoPbkSokI4z
        OA=; b=OCgjBiBqwDaEIWL9ckqaYYDZCuzgn4MYeXUaEnFAnwIsX9Y8QigqQcEEP
        uLwskG+HC5Ja4SHzEa+Z4dIBqteocJ5hs0YRC00T2Jbw/mrLJ3RWpm4xcypxeXp0
        BNECPODjrwjxQb37qJplafAcZcTkiJWmHjEYch14ku3f/IUF74=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; q=dns; s=sasl; b=XiBvAXLadB3Znd9LcgW
        SildmwbtavUd390HROBl1VdQ/Q2C52Mx8BhEPBOKtLU/ykN5KIQti6qHHWqgYh44
        uvGS74fkumo9RlqZaUW96T7iVPRAu/ROdy6/faKCERb6rdAEhldR6ucAlG0gL8Ma
        kjBPY/xs+Jp1xHJ21oe240/g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3D455C198D;
        Thu,  9 Apr 2020 16:11:38 -0400 (EDT)
        (envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 89A52C198C;
        Thu,  9 Apr 2020 16:11:35 -0400 (EDT)
        (envelope-from gitster@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        gitgitgadget@gmail.com
Subject: [PATCH 2/2] t: protect against use of test_path_is_hidden outside MINGW
Date:   Thu,  9 Apr 2020 13:11:29 -0700
Message-Id: <20200409201129.82608-3-gitster@pobox.com>
X-Mailer: git-send-email 2.26.0-106-g9fadedd637
In-Reply-To: <20200409201129.82608-1-gitster@pobox.com>
References: <xmqqmu7locys.fsf@gitster.c.googlers.com>
 <20200409201129.82608-1-gitster@pobox.com>
MIME-Version: 1.0
X-Pobox-Relay-ID: 501DDCD8-7A9E-11EA-A3CC-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test helper function is meant to test if the "hidden"
atttribute is set (or unset) as expected on Windows, and use of it
outside MINGW prerequisite is an error.  Ensure we have the prereq
and trigger a BUG otherwise.

It is tempting to instead replace its implementation with something
like

	if test_have_prereq MINGW
	then
		... current Windows specific code ...
	else
		# ls without -a/-A hides paths that begin with a dot
		case "$(basename "$1")" in
		.*) return 0 ;;
		esac
	fi
	return 1

but one test in t0001 is designed specifically that with an option
"repository/.git" of a newly created repository is *not* hidden on
Windows, which means that it is impossible to make that feature work
on POSIX systems and the above won't test what we want to test.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/test-lib-functions.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 39b478e731..ad54863166 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -762,6 +762,11 @@ test_path_is_missing () {
=20
 # Tests for the hidden file attribute on windows
 test_path_is_hidden () {
+	if ! test_have_prereq MINGW
+	then
+		BUG "use of test_path_is_hidden without MINGW prerequisite"
+	fi
+
 	# Use the output of `attrib`, ignore the absolute path
 	case "$("$SYSTEMROOT"/system32/attrib "$1")" in
 	*H*?:*)		return 0;;
--=20
2.26.0-106-g9fadedd637

