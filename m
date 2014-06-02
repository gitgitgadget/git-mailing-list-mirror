From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH alt-v3] Improve function dir.c:trim_trailing_spaces()
Date: Mon, 02 Jun 2014 15:54:06 -0700
Message-ID: <xmqqfvjm3ott.fsf@gitster.dls.corp.google.com>
References: <1401748616-14632-1-git-send-email-pasha.bolokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, pclouds@gmail.com, peff@peff.net
To: Pasha Bolokhov <pasha.bolokhov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 00:54:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wrb7Q-0002vO-GQ
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 00:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbaFBWyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 18:54:13 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62580 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751036AbaFBWyM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 18:54:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1DC871D53E;
	Mon,  2 Jun 2014 18:54:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=u3t9ruK1xiCcaPPbwQZkEjd6V7c=; b=NvqkXy
	tQmwQRbQNvm/gE1rh04u6cM2yQCIN7FzIbmUaQ7LL5gn18J5ke5sEo60ARw4z2Oa
	6sJb41GfEM5IXxeLsWd96sCVi6x9vnGh3/c8KKUF6pfXK+6E6Xw1Zzhm3GZViKIG
	MG95ZuYyCEGSTQt+aIuoIObNmqfMixmtK0gCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qbHDSRDMilz43zf+VQJgX4qsil6qKg2K
	dWD9g39pVSXC8xQPH3jfo2VzL/b7pSxC4FNJnUPCFBtH6ZzroXLMzjExtH4us9m/
	5C62ojdbrHjwIZtGHgSmN4NYrrxJCEkePz62/G16mQFgH4cX9yFkTNj5wJTlh0Ou
	Wrk+5DryaNo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1497D1D53D;
	Mon,  2 Jun 2014 18:54:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 85ED61D53B;
	Mon,  2 Jun 2014 18:54:07 -0400 (EDT)
In-Reply-To: <1401748616-14632-1-git-send-email-pasha.bolokhov@gmail.com>
	(Pasha Bolokhov's message of "Mon, 2 Jun 2014 15:36:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CD92AC5C-EAA8-11E3-8209-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250606>

Pasha Bolokhov <pasha.bolokhov@gmail.com> writes:

> Discard the unnecessary 'nr_spaces' variable, remove 'strlen()' and
> improve the 'if' structure. Switch to pointers instead of integers
>
> Slightly more rare occurrences of 'text  \    ' with a backslash
> in between spaces are handled correctly. Namely, the code in
> 8ba87adad6 does not reset 'last_space' when a backslash is
> encountered and the above line stays intact as a result.
> Add a test at the end of t/t0008-ignores.sh to exhibit this behavior
>
> Signed-off-by: Pasha Bolokhov <pasha.bolokhov@gmail.com>
> ---
> Add /* fallthrough */ comment to switch(), remove TABs in test,
> and remove ":" command in file truncation in the test

8ba87adad6 does not seem to do anything to do with this change,
though.  Tentatively I've queued the following (but not merged to
anywhere nor pushed out).

Thanks.

-- >8 --
From: Pasha Bolokhov <pasha.bolokhov@gmail.com>
Date: Mon, 2 Jun 2014 15:36:56 -0700
Subject: [PATCH] dir.c:trim_trailing_spaces(): fix for " \ " sequence

Discard the unnecessary 'nr_spaces' variable, remove 'strlen()' and
improve the 'if' structure.  Switch to pointers instead of integers
to control the loop.

Slightly more rare occurrences of 'text  \    ' with a backslash
in between spaces are handled correctly.  Namely, the code in
7e2e4b37 (dir: ignore trailing spaces in exclude patterns, 2014-02-09)
does not reset 'last_space' when a backslash is encountered and the above
line stays intact as a result.

Add a test at the end of t/t0008-ignores.sh to exhibit this behavior.

Signed-off-by: Pasha Bolokhov <pasha.bolokhov@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 dir.c              | 34 +++++++++++++++++++---------------
 t/t0008-ignores.sh | 23 +++++++++++++++++++++++
 2 files changed, 42 insertions(+), 15 deletions(-)

diff --git a/dir.c b/dir.c
index eb6f581..797805d 100644
--- a/dir.c
+++ b/dir.c
@@ -508,21 +508,25 @@ void clear_exclude_list(struct exclude_list *el)
 
 static void trim_trailing_spaces(char *buf)
 {
-	int i, last_space = -1, nr_spaces, len = strlen(buf);
-	for (i = 0; i < len; i++)
-		if (buf[i] == '\\')
-			i++;
-		else if (buf[i] == ' ') {
-			if (last_space == -1) {
-				last_space = i;
-				nr_spaces = 1;
-			} else
-				nr_spaces++;
-		} else
-			last_space = -1;
-
-	if (last_space != -1 && last_space + nr_spaces == len)
-		buf[last_space] = '\0';
+	char *p, *last_space = NULL;
+
+	for (p = buf; *p; p++)
+		switch (*p) {
+		case ' ':
+			if (!last_space)
+				last_space = p;
+			break;
+		case '\\':
+			p++;
+			if (!*p)
+				return;
+			/* fallthrough */
+		default:
+			last_space = NULL;
+		}
+
+	if (last_space)
+		*last_space = '\0';
 }
 
 int add_excludes_from_file_to_list(const char *fname,
diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index 63beb99..5ef5ad3 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -806,4 +806,27 @@ test_expect_success !MINGW 'quoting allows trailing whitespace' '
 	test_cmp err.expect err
 '
 
+test_expect_success NOT_MINGW,NOT_CYGWIN 'correct handling of backslashes' '
+	rm -rf whitespace &&
+	mkdir whitespace &&
+	>"whitespace/trailing 1  " &&
+	>"whitespace/trailing 2 \\\\" &&
+	>"whitespace/trailing 3 \\\\" &&
+	>"whitespace/trailing 4   \\ " &&
+	>"whitespace/trailing 5 \\ \\ " &&
+	>"whitespace/trailing 6 \\a\\" &&
+	>whitespace/untracked &&
+	echo "whitespace/trailing 1 \\    " >ignore  &&
+	echo "whitespace/trailing 2 \\\\\\\\\\\\\\\\" >>ignore &&
+	echo "whitespace/trailing 3 \\\\\\\\\\\\\\\\ " >>ignore &&
+	echo "whitespace/trailing 4   \\\\\\\\\\\\    " >>ignore &&
+	echo "whitespace/trailing 5 \\\\\\\\ \\\\\\\\\\\\   " >>ignore &&
+	echo "whitespace/trailing 6 \\\\\\\\a\\\\\\\\" >>ignore &&
+	echo whitespace/untracked >expect &&
+	>err.expect &&
+	git ls-files -o -X ignore whitespace >actual 2>err &&
+	test_cmp expect actual &&
+	test_cmp err.expect err
+'
+
 test_done
-- 
2.0.0-511-g1433423
