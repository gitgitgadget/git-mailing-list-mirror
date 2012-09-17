From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] mailinfo: do not concatenate charset= attribute values from
 mime headers
Date: Mon, 17 Sep 2012 15:28:11 -0700
Message-ID: <7vsjagqnev.fsf@alter.siamese.dyndns.org>
References: <CABZfb=UhKRREMG_XNJHDJHwbwroi5TKWwgQH-Ge1BDJETizG2Q@mail.gmail.com>
 <7vy5k8va90.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tomas Cohen Arazi <tomascohen@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 00:45:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDk4Y-0001zO-UH
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 00:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757396Ab2IQWpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 18:45:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46111 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755374Ab2IQWpQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 18:45:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5473834B;
	Mon, 17 Sep 2012 18:45:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=w831beQtCpWz/k2C1JqAh3RVcJs=; b=t2kF/uIDPyhoTWFTlIY9
	wzVrb3hGfdMocrHjUiiK9+qmbF39h8c7EFojq/7mVxtwJ1/MG7nR0GylaYGlwfNs
	Gdlez9F4wjxx5rFz2BEB7zNkY+UUiHERku1/ekK2PKJLdnWaEA3jiqUMvXLoI7j0
	KawRpHMAK4KvI6okiKefgv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=YG40SwJnYaD8f/lAtbfRj2HqC5ZWO9uh8mCG3lYQlq6uYu
	OrezVA4rIJatTflEGJTsMHbBsQaJdbzAG43bTP7kvwQ9HYxNz+5CRpQNuTvT4vhr
	goM+N02AwtXROBdfhzLWj9x8MOwmrBI6x2thDmns9wj12xw4V5sefGsUkd/BU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3130834A;
	Mon, 17 Sep 2012 18:45:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 212548349; Mon, 17 Sep 2012
 18:45:14 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 584788C0-0119-11E2-AAB2-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205765>

"Content-type: text/plain; charset=UTF-8" header should not appear
twice in the input, but it is always better to gracefully deal with
such a case.  The current code concatenates the value to the values
we have seen previously, producing nonsense such as "utf8UTF-8".

Instead of concatenating, forget the previous value and use the last
value we see.

Reported-by: Tomas Cohen Arazi
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I think this is the right thing to do after all.  Thanks for
   bringing the issue up, Tomas.

 builtin/mailinfo.c  |  5 ++---
 t/t5100-mailinfo.sh |  2 +-
 t/t5100/info0017    |  5 +++++
 t/t5100/msg0017     |  2 ++
 t/t5100/patch0017   |  6 ++++++
 t/t5100/sample.mbox | 16 ++++++++++++++++
 6 files changed, 32 insertions(+), 4 deletions(-)
 create mode 100644 t/t5100/info0017
 create mode 100644 t/t5100/msg0017
 create mode 100644 t/t5100/patch0017

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index eaf9e15..dd8b67c 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -160,10 +160,9 @@ static int slurp_attr(const char *line, const char *name, struct strbuf *attr)
 	const char *ends, *ap = strcasestr(line, name);
 	size_t sz;
 
-	if (!ap) {
-		strbuf_setlen(attr, 0);
+	strbuf_setlen(attr, 0);
+	if (!ap)
 		return 0;
-	}
 	ap += strlen(name);
 	if (*ap == '"') {
 		ap++;
diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 81904d9..3e64a7a 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -11,7 +11,7 @@ test_expect_success 'split sample box' \
 	'git mailsplit -o. "$TEST_DIRECTORY"/t5100/sample.mbox >last &&
 	last=`cat last` &&
 	echo total is $last &&
-	test `cat last` = 16'
+	test `cat last` = 17'
 
 check_mailinfo () {
 	mail=$1 opt=$2
diff --git a/t/t5100/info0017 b/t/t5100/info0017
new file mode 100644
index 0000000..d2bc89f
--- /dev/null
+++ b/t/t5100/info0017
@@ -0,0 +1,5 @@
+Author: A U Thor
+Email: a.u.thor@example.com
+Subject: A E I O U
+Date: Mon, 17 Sep 2012 14:23:44 -0700
+
diff --git a/t/t5100/msg0017 b/t/t5100/msg0017
new file mode 100644
index 0000000..2ee0900
--- /dev/null
+++ b/t/t5100/msg0017
@@ -0,0 +1,2 @@
+New content here
+
diff --git a/t/t5100/patch0017 b/t/t5100/patch0017
new file mode 100644
index 0000000..35cf84c
--- /dev/null
+++ b/t/t5100/patch0017
@@ -0,0 +1,6 @@
+diff --git a/foo b/foo
+index e69de29..d95f3ad 100644
+--- a/foo
++++ b/foo
+@@ -0,0 +1 @@
++New content
diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
index de10312..fcc0e0d 100644
--- a/t/t5100/sample.mbox
+++ b/t/t5100/sample.mbox
@@ -683,3 +683,19 @@ index e69de29..d95f3ad 100644
 @@ -0,0 +1 @@
 +content
 
+From nobody Mon Sep 17 00:00:00 2001
+From: A U Thor <a.u.thor@example.com>
+Subject: A E I O U
+Date: Mon, 17 Sep 2012 14:23:44 -0700
+MIME-Version: 1.0
+Content-Type: text/plain; charset="iso-2022-jp"
+Content-type: text/plain; charset="UTF-8"
+
+New content here
+
+diff --git a/foo b/foo
+index e69de29..d95f3ad 100644
+--- a/foo
++++ b/foo
+@@ -0,0 +1 @@
++New content
-- 
1.7.12.556.gb90bb19
