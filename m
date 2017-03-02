Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C628B1F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 19:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752620AbdCBTOE (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 14:14:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60456 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751422AbdCBTOB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 14:14:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 140E38209D;
        Thu,  2 Mar 2017 13:51:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=HOHGLQtRDgZ0
        1SJLjg292RleiVQ=; b=yAceNEHZZ1qTeDeVP/fNhgKoNopZ7RfMGQgyor4rbCQ6
        5eIUXozr+s2zj25wHzMArYMNObAdfQiCis4UR2YEYhFtxDvox5glsViYEnSkl7Lq
        DN+wN29jEcHw2kSuD39M9fNmep5FCNNlW/okY1DhRC0P2cj3f3rSmI5BcZzplZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WQ1qxv
        2xbB8/l99UiQ5wIyS4Z2BXkt/mdvWHrDMNQ3RdcWp17z84xxKkugGQOj3OkKpqfH
        DwtyhsxKIWQ4dhPc+coT+JemyjpoAjXPdvww0FeDFJkUxMlHuxCM+TvIaY600+rW
        UWnyJY1j64YYteD6WCdqEgiDrJ4G0HJEnVq/E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C6D08209C;
        Thu,  2 Mar 2017 13:51:43 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 751F882099;
        Thu,  2 Mar 2017 13:51:42 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     tboegi@web.de, Jeff King <peff@peff.net>, mac@mcrowe.com
Subject: [PATCH v2] diff: do not short-cut CHECK_SIZE_ONLY check in diff_populate_filespec()
References: <xmqqshmyhtnu.fsf@gitster.mtv.corp.google.com>
        <20170301170444.14274-1-tboegi@web.de>
        <xmqqr32gg0o6.fsf@gitster.mtv.corp.google.com>
        <xmqqa894fyst.fsf@gitster.mtv.corp.google.com>
        <20170302085313.r6dox4wa2kqnp7ao@sigill.intra.peff.net>
Date:   Thu, 02 Mar 2017 10:51:41 -0800
In-Reply-To: <20170302085313.r6dox4wa2kqnp7ao@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 2 Mar 2017 03:53:13 -0500")
Message-ID: <xmqqwpc7bjgi.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 46C66298-FF79-11E6-88F8-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

 * With "test size_only to avoid more expensive would_convert call"
   fix applied.  Also the new test is now in t4xxx that it belongs
   to.

 diff.c                | 19 ++++++++++++++++++-
 t/t4035-diff-quiet.sh |  9 +++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 059123c5dc..37e60ca601 100644
--- a/diff.c
+++ b/diff.c
@@ -2783,8 +2783,25 @@ int diff_populate_filespec(struct diff_filespec *s=
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
+		if (size_only && !would_convert_to_git(s->path))
 			return 0;
+
+		/*
+		 * Note: this check uses xsize_t(st.st_size) that may
+		 * not be the true size of the blob after it goes
+		 * through convert_to_git().  This may not strictly be
+		 * correct, but the whole point of big_file_threshold
+		 * and is_binary check being that we want to avoid
+		 * opening the file and inspecting the contents, this
+		 * is probably fine.
+		 */
 		if ((flags & CHECK_BINARY) &&
 		    s->size > big_file_threshold && s->is_binary =3D=3D -1) {
 			s->is_binary =3D 1;
diff --git a/t/t4035-diff-quiet.sh b/t/t4035-diff-quiet.sh
index 461f4bb583..2f1737fcef 100755
--- a/t/t4035-diff-quiet.sh
+++ b/t/t4035-diff-quiet.sh
@@ -152,4 +152,13 @@ test_expect_success 'git diff --quiet ignores stat-c=
hange only entries' '
 	test_expect_code 1 git diff --quiet
 '
=20
+test_expect_success 'git diff --quiet on a path that need conversion' '
+	echo "crlf.txt text=3Dauto" >.gitattributes &&
+	printf "Hello\r\nWorld\r\n" >crlf.txt &&
+	git add .gitattributes crlf.txt &&
+
+	printf "Hello\r\nWorld\n" >crlf.txt &&
+	git diff --quiet crlf.txt
+'
+
 test_done
--=20
2.12.0-352-gb05ccab5eb
