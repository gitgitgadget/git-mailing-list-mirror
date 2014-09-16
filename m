From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] mailinfo: do not treat ">From" lines as in-body headers
Date: Tue, 16 Sep 2014 11:41:08 -0700
Message-ID: <xmqq38br2yt7.fsf@gitster.dls.corp.google.com>
References: <20140913205751.GA17875@mwanda> <20140913210908.GG6549@mwanda>
	<20140913212504.GA25190@peff.net>
	<20140913225713.GB189120@vauxhall.crustytoothpaste.net>
	<20140914004725.GA28010@peff.net>
	<CAPc5daWxZdi+JTTsznefPk2U+Q8uWWYuBUa-rJA4knDZzwU38w@mail.gmail.com>
	<20140914010120.GA28498@peff.net> <20140914013038.GA5974@peff.net>
	<xmqqha087lwv.fsf@gitster.dls.corp.google.com>
	<xmqq1trc63o8.fsf@gitster.dls.corp.google.com>
	<20140916001948.GC5019@peff.net>
	<xmqqy4tj30ny.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Mark Einon <mark.einon@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 16 20:41:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTxgj-0000aT-MJ
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 20:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754815AbaIPSlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 14:41:14 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60690 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754221AbaIPSlN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 14:41:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 748DB38DD6;
	Tue, 16 Sep 2014 14:41:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SZJqrmaEOXmddexPYgR674IPoVw=; b=r3nOjh
	8x40+dd5+ITNchFKedMs3KfgTkt4Glnuq1VdrORm2kTwN0Kmy60Nn4g0pVxLdIG7
	J9ktoo6KlEByiSycd53fYPR1Vrjho2sNgQExudVpWQlFVN4MDtPbOOnZJAP3GLB6
	zu3ckPuzwYQTRL/f6YSzHxjZPUk4kLNlyYbIU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CqMzTVEeQvAY/W1XKQKzFx9G1g5d8mho
	ouO5OLz7EXssFGMBbxZrZMCd+vSZcURqtIBPwCM5Npd5jvmpGZ9oAPWxnTA3cD7i
	bhzPDYOB9D5E4LeNh4hJb3bdT31Ojxobrjp4dCTklLJVxVAHNuIa0Vk3HJ00SCFf
	MDcoXlfsZIQ=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5A41A38DD4;
	Tue, 16 Sep 2014 14:41:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2946338DD0;
	Tue, 16 Sep 2014 14:41:11 -0400 (EDT)
In-Reply-To: <xmqqy4tj30ny.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 16 Sep 2014 11:01:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0788E13A-3DD1-11E4-80C4-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257141>

Junio C Hamano <gitster@pobox.com> writes:

>> I think you forgot to "git add" mbox.h. That being said, if we did go
>> this route, I do not see any reason to share the code at all. This can
>> be purely a mailinfo.c thing.
>
> OK.  A reroll coming today when I find time.

-- >8 --
From: Jeff King <peff@peff.net>
Date: Sat, 13 Sep 2014 21:30:38 -0400
Subject: [PATCH] mailinfo: make ">From" in-body header check more robust

Since commit 81c5cf7 (mailinfo: skip bogus UNIX From line inside
body, 2006-05-21), we have treated lines like ">From" in the body as
headers. This makes "git am" work for people who erroneously paste
the whole output from format-patch:

  From 12345abcd...fedcba543210 Mon Sep 17 00:00:00 2001
  From: them
  Subject: [PATCH] whatever

into their email body (assuming that an mbox writer then quotes
"From" as ">From", as otherwise we would actually mailsplit on the
in-body line).

However, this has false positives if somebody actually has a commit
body that starts with "From "; in this case we erroneously remove
the line entirely from the commit message. We can make this check
more robust by making sure the line actually looks like a real mbox
"From" line.

Inspect the line that begins with ">From " a more carefully to only
skip lines that match the expected pattern (note that the datestamp
part of the format-patch output is designed to be kept constant to
help those who write magic(5) entries).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c         | 17 ++++++++++++++++-
 t/t5100-mailinfo.sh        | 18 ++++++++++++++++++
 t/t5100/embed-from.expect  |  5 +++++
 t/t5100/embed-from.in      | 13 +++++++++++++
 t/t5100/quoted-from.expect |  3 +++
 t/t5100/quoted-from.in     | 10 ++++++++++
 6 files changed, 65 insertions(+), 1 deletion(-)
 create mode 100644 t/t5100/embed-from.expect
 create mode 100644 t/t5100/embed-from.in
 create mode 100644 t/t5100/quoted-from.expect
 create mode 100644 t/t5100/quoted-from.in

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index cf11c8d..2632fb0 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -288,6 +288,21 @@ static inline int cmp_header(const struct strbuf *line, const char *hdr)
 			line->buf[len] == ':' && isspace(line->buf[len + 1]);
 }
 
+#define SAMPLE "From e6807f3efca28b30decfecb1732a56c7db1137ee Mon Sep 17 00:00:00 2001\n"
+static int is_format_patch_separator(const char *line, int len)
+{
+	const char *cp;
+
+	if (len != strlen(SAMPLE))
+		return 0;
+	if (!skip_prefix(line, "From ", &cp))
+		return 0;
+	if (strspn(cp, "0123456789abcdef") != 40)
+		return 0;
+	cp += 40;
+	return !memcmp(SAMPLE + (cp - line), cp, strlen(SAMPLE) - (cp - line));
+}
+
 static int check_header(const struct strbuf *line,
 				struct strbuf *hdr_data[], int overwrite)
 {
@@ -329,7 +344,7 @@ static int check_header(const struct strbuf *line,
 
 	/* for inbody stuff */
 	if (starts_with(line->buf, ">From") && isspace(line->buf[5])) {
-		ret = 1; /* Should this return 0? */
+		ret = is_format_patch_separator(line->buf + 1, line->len - 1);
 		goto check_header_out;
 	}
 	if (starts_with(line->buf, "[PATCH]") && isspace(line->buf[7])) {
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 3e64a7a..9e1ad1c 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -89,4 +89,22 @@ test_expect_success 'mailinfo on from header without name works' '
 
 '
 
+test_expect_success 'mailinfo finds headers after embedded From line' '
+	mkdir embed-from &&
+	git mailsplit -oembed-from "$TEST_DIRECTORY"/t5100/embed-from.in &&
+	test_cmp "$TEST_DIRECTORY"/t5100/embed-from.in embed-from/0001 &&
+	git mailinfo embed-from/msg embed-from/patch \
+	  <embed-from/0001 >embed-from/out &&
+	test_cmp "$TEST_DIRECTORY"/t5100/embed-from.expect embed-from/out
+'
+
+test_expect_success 'mailinfo on message with quoted >From' '
+	mkdir quoted-from &&
+	git mailsplit -oquoted-from "$TEST_DIRECTORY"/t5100/quoted-from.in &&
+	test_cmp "$TEST_DIRECTORY"/t5100/quoted-from.in quoted-from/0001 &&
+	git mailinfo quoted-from/msg quoted-from/patch \
+	  <quoted-from/0001 >quoted-from/out &&
+	test_cmp "$TEST_DIRECTORY"/t5100/quoted-from.expect quoted-from/msg
+'
+
 test_done
diff --git a/t/t5100/embed-from.expect b/t/t5100/embed-from.expect
new file mode 100644
index 0000000..06a3a38
--- /dev/null
+++ b/t/t5100/embed-from.expect
@@ -0,0 +1,5 @@
+Author: Commit Author
+Email: commit@example.com
+Subject: patch subject
+Date: Sat, 13 Sep 2014 21:13:23 -0400 
+
diff --git a/t/t5100/embed-from.in b/t/t5100/embed-from.in
new file mode 100644
index 0000000..5f3f84e
--- /dev/null
+++ b/t/t5100/embed-from.in
@@ -0,0 +1,13 @@
+From 1234567890123456789012345678901234567890 Mon Sep 17 00:00:00 2001
+From: Email Author <email@example.com>
+Date: Sun, 25 May 2008 00:38:18 -0700
+Subject: [PATCH] email subject
+
+>From 1234567890123456789012345678901234567890 Mon Sep 17 00:00:00 2001
+From: Commit Author <commit@example.com>
+Date: Sat, 13 Sep 2014 21:13:23 -0400
+Subject: patch subject
+
+patch body
+---
+patch
diff --git a/t/t5100/quoted-from.expect b/t/t5100/quoted-from.expect
new file mode 100644
index 0000000..8c9d48c
--- /dev/null
+++ b/t/t5100/quoted-from.expect
@@ -0,0 +1,3 @@
+>From the depths of history, we are stuck with the
+flaky mbox format.
+
diff --git a/t/t5100/quoted-from.in b/t/t5100/quoted-from.in
new file mode 100644
index 0000000..847e1c4
--- /dev/null
+++ b/t/t5100/quoted-from.in
@@ -0,0 +1,10 @@
+From 1234567890123456789012345678901234567890 Mon Sep 17 00:00:00 2001
+From: Author Name <somebody@example.com>
+Date: Sun, 25 May 2008 00:38:18 -0700
+Subject: [PATCH] testing quoted >From
+
+>From the depths of history, we are stuck with the
+flaky mbox format.
+
+---
+patch
-- 
2.1.0-420-g23b5121
