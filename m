Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47D542023D
	for <e@80x24.org>; Wed,  1 Mar 2017 22:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753270AbdCAV7x (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 16:59:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58016 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751495AbdCAV7u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 16:59:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3CE3076924;
        Wed,  1 Mar 2017 16:54:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=h0+uGTa1AmzT
        uKeU3nRL2CpmpmY=; b=vsRPaARJOqI4fuycZFZOsrpjDYuKPEh8pzCO5PK4z+wk
        5yqJSp9KoxvJrLgVpYNWbLGE3V49Kvj+4sjERBXm1QeDxjXnaR+IpxPRXz2jVec6
        hr39kEEt3J7SW+ifBbzxZSwT+p0LozNoF7GYYe2Cc1J/jm1hXb/EOBomNWb89vY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Nkq/Jf
        zgH+mpZppWUaOxVIfJ1j25gGCDyVfy5yEDf8k5MQMlUCtK6oAtQT0F00uPANFLib
        WIQpypZfxbdUcnznjicKRBFqBrX7MRSm2SuXetx2jsim6UWJUdUthtysiTpepjEa
        fAAcuxGUd314Kl2pvwkvhOIc1HO9XdYArJRXY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 36F9C76923;
        Wed,  1 Mar 2017 16:54:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 963B376922;
        Wed,  1 Mar 2017 16:54:27 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, mac@mcrowe.com
Subject: Re: [PATCH v1 1/1] git diff --quiet exits with 1 on clean tree with CRLF conversions
References: <xmqqshmyhtnu.fsf@gitster.mtv.corp.google.com>
        <20170301170444.14274-1-tboegi@web.de>
        <xmqqr32gg0o6.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 01 Mar 2017 13:54:26 -0800
In-Reply-To: <xmqqr32gg0o6.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 01 Mar 2017 13:14:01 -0800")
Message-ID: <xmqqa894fyst.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A4182B6C-FEC9-11E6-96D2-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now I thought about it through a bit more thoroughly, I think this
is the right approach, so here is my (tenative) final version.

I seem to be getty really rusty---after all the codepaths involved
are practically all my code and I should have noticed the real
culprit during my first attempt X-<.

Thanks for helping.

-- >8 --
Subject: [PATCH] diff: do not short-cut CHECK_SIZE_ONLY check in diff_pop=
ulate_filespec()

Callers of diff_populate_filespec() can choose to ask only for the
size of the blob without grabbing the blob data, and the function,
after running lstat() when the filespec points at a working tree
file, returns by copying the value in size field of the stat
structure into the size field of the filespec when this is the case.

However, this short-cut cannot be taken if the contents from the
path needs to go through convert_to_git(), whose resulting real blob
data may be different from what is in the working tree file.

As "git diff --quiet" compares the .size fields of filespec
structures to skip content comparison, this bug manifests as a
false "there are differences" for a file that needs eol conversion,
for example.

Reported-by: Mike Crowe <mac@mcrowe.com>
Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c                    | 19 ++++++++++++++++++-
 t/t0028-diff-converted.sh | 27 +++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)
 create mode 100755 t/t0028-diff-converted.sh

diff --git a/diff.c b/diff.c
index 8c78fce49d..dc51dceb44 100644
--- a/diff.c
+++ b/diff.c
@@ -2792,8 +2792,25 @@ int diff_populate_filespec(struct diff_filespec *s=
, unsigned int flags)
 			s->should_free =3D 1;
 			return 0;
 		}
-		if (size_only)
+
+		/*
+		 * Even if the caller would be happy with getting
+		 * only the size, we cannot return early at this
+		 * point if the path requires us to run the content
+		 * conversion.
+		 */
+		if (!would_convert_to_git(s->path) && size_only)
 			return 0;
+
+		/*
+		 * Note: this check uses xsize_t(st.st_size) that may
+		 * not be the true size of the blob after it goes
+		 * through convert_to_git().  This may not strictly be
+		 * correct, but the whole point of big_file_threashold
+		 * and is_binary check being that we want to avoid
+		 * opening the file and inspecting the contents, this
+		 * is probably fine.
+		 */
 		if ((flags & CHECK_BINARY) &&
 		    s->size > big_file_threshold && s->is_binary =3D=3D -1) {
 			s->is_binary =3D 1;
diff --git a/t/t0028-diff-converted.sh b/t/t0028-diff-converted.sh
new file mode 100755
index 0000000000..3d5ab9565b
--- /dev/null
+++ b/t/t0028-diff-converted.sh
@@ -0,0 +1,27 @@
+#!/bin/sh
+#
+# Copyright (c) 2017 Mike Crowe
+#
+# These tests ensure that files changing line endings in the presence
+# of .gitattributes to indicate that line endings should be ignored
+# don't cause 'git diff' or 'git diff --quiet' to think that they have
+# been changed.
+
+test_description=3D'git diff with files that require CRLF conversion'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+	echo "* text=3Dauto" >.gitattributes &&
+	printf "Hello\r\nWorld\r\n" >crlf.txt &&
+	git add .gitattributes crlf.txt &&
+	git commit -m "initial"
+'
+
+test_expect_success 'quiet diff works on file with line-ending change th=
at has no effect on repository' '
+	printf "Hello\r\nWorld\n" >crlf.txt &&
+	git status &&
+	git diff --quiet
+'
+
+test_done
--=20
2.12.0-319-gc5f21175ee

