From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] interpret_nth_last_branch(): avoid traversing the
 reflogs twice
Date: Mon, 19 Jan 2009 00:08:09 -0800
Message-ID: <7vprijra52.fsf@gitster.siamese.dyndns.org>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org>
 <1232163011-20088-1-git-send-email-trast@student.ethz.ch>
 <alpine.DEB.1.00.0901170646560.3586@pacific.mpi-cbg.de>
 <200901171438.22504.trast@student.ethz.ch>
 <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
 <7vljt97nld.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901172028470.3586@pacific.mpi-cbg.de>
 <7vmydp5tqj.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901180201070.3586@pacific.mpi-cbg.de>
 <7vprilyt1w.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901182152010.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 19 09:09:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOpCa-00080b-TJ
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 09:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754861AbZASIIU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 03:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754813AbZASIIU
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 03:08:20 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55865 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754709AbZASIIT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 03:08:19 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A0D639174E;
	Mon, 19 Jan 2009 03:08:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EAD949174D; Mon,
 19 Jan 2009 03:08:10 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901182152010.3586@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Sun, 18 Jan 2009 21:59:40 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 541B8FA4-E600-11DD-8FEB-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106332>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 17 Jan 2009, Junio C Hamano wrote:
> ...
>> My HEAD reflog is 7MB long with 39000 entries, and among them, 13100
>> entries have "checkout: moving ".
>> 
>> I know I will never want to switch back to the 10000th from the last 
>> branch.  I am quite sure that I would forget which branch I was on after 
>> switching branches three or four times (hence my original hardcoded 
>> limitation of 10 which "should be plenty").  When I know I only have to 
>> keep track of 10 entries, having to keep track of 13100 entries, even if 
>> it is 36kB (it would actually be 260kB in my case) feels there is 
>> something wrong in the design.
>
> Hrm.  So let's leave it as a two-pass thing?

Well, I would rather be in favor of something like this.

-- >8 --
Subject: interpret_nth_last_branch(): avoid traversing the reflog twice

You can have quite a many reflog entries, but you typically won't recall
which branch you were on after switching branches for more than several
times.

Instead of reading the reflog twice, this reads the branch switching event
and keeps the latest 16 (which is an arbitrary limitation that should be
plenty) such entry, to switch back to the branch we were recently on.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c              |   48 +++++++++++++++++++++------------------------
 t/t2012-checkout-last.sh |   44 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 26 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 9e1538e..d6622f2 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -684,10 +684,11 @@ static int get_sha1_oneline(const char *prefix, unsigned char *sha1)
 	return retval;
 }
 
+#define MAX_PREVIOUS_BRANCH 16
+
 struct grab_nth_branch_switch_cbdata {
-	int counting;
-	int nth;
-	struct strbuf *buf;
+	long cnt;
+	struct strbuf buf[MAX_PREVIOUS_BRANCH];
 };
 
 static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
@@ -697,6 +698,7 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
 	struct grab_nth_branch_switch_cbdata *cb = cb_data;
 	const char *match = NULL, *target = NULL;
 	size_t len;
+	int nth;
 
 	if (!prefixcmp(message, "checkout: moving from ")) {
 		match = message + strlen("checkout: moving from ");
@@ -711,16 +713,9 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
 	if (target[len] == '\n' && !strncmp(match, target, len))
 		return 0;
 
-	if (cb->counting) {
-		cb->nth++;
-		return 0;
-	}
-
-	if (cb->nth-- <= 0) {
-		strbuf_reset(cb->buf);
-		strbuf_add(cb->buf, match, len);
-		return 1;
-	}
+	nth = cb->cnt++ % MAX_PREVIOUS_BRANCH;
+	strbuf_reset(&cb->buf[nth]);
+	strbuf_add(&cb->buf[nth], match, len);
 	return 0;
 }
 
@@ -737,7 +732,8 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
  */
 int interpret_nth_last_branch(const char *name, struct strbuf *buf)
 {
-	int nth;
+	long nth;
+	int i;
 	struct grab_nth_branch_switch_cbdata cb;
 	const char *brace;
 	char *num_end;
@@ -750,19 +746,19 @@ int interpret_nth_last_branch(const char *name, struct strbuf *buf)
 	nth = strtol(name+3, &num_end, 10);
 	if (num_end != brace)
 		return -1;
-
-	cb.counting = 1;
-	cb.nth = 0;
-	cb.buf = buf;
-	for_each_reflog_ent("HEAD", grab_nth_branch_switch, &cb);
-
-	if (cb.nth < nth)
-		return 0;
-
-	cb.counting = 0;
-	cb.nth -= nth;
-	cb.buf = buf;
+	if (nth <= 0 || MAX_PREVIOUS_BRANCH < nth)
+		return -1;
+	for (i = 0; i < MAX_PREVIOUS_BRANCH; i++)
+		strbuf_init(&cb.buf[i], 20);
+	cb.cnt = 0;
 	for_each_reflog_ent("HEAD", grab_nth_branch_switch, &cb);
+	if (cb.cnt < nth)
+		return -1;
+	i = (cb.cnt + MAX_PREVIOUS_BRANCH - nth) % MAX_PREVIOUS_BRANCH;
+	strbuf_reset(buf);
+	strbuf_add(buf, cb.buf[i].buf, cb.buf[i].len);
+	for (i = 0; i < MAX_PREVIOUS_BRANCH; i++)
+		strbuf_release(&cb.buf[i]);
 
 	return brace-name+1;
 }
diff --git a/t/t2012-checkout-last.sh b/t/t2012-checkout-last.sh
index 320f6eb..87b30a2 100755
--- a/t/t2012-checkout-last.sh
+++ b/t/t2012-checkout-last.sh
@@ -47,4 +47,48 @@ test_expect_success '"checkout -" detaches again' '
 	test_must_fail git symbolic-ref HEAD
 '
 
+test_expect_success 'more switches' '
+	for i in 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1
+	do
+		git checkout -b branch$i
+	done
+'
+
+more_switches () {
+	for i in 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1
+	do
+		git checkout branch$i
+	done
+}
+
+test_expect_success 'switch to the last' '
+	more_switches &&
+	git checkout @{-1} &&
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/branch2"
+'
+
+test_expect_success 'switch to second from the last' '
+	more_switches &&
+	git checkout @{-2} &&
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/branch3"
+'
+
+test_expect_success 'switch to third from the last' '
+	more_switches &&
+	git checkout @{-3} &&
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/branch4"
+'
+
+test_expect_success 'switch to fourth from the last' '
+	more_switches &&
+	git checkout @{-4} &&
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/branch5"
+'
+
+test_expect_success 'switch to twelfth from the last' '
+	more_switches &&
+	git checkout @{-12} &&
+	test "z$(git symbolic-ref HEAD)" = "zrefs/heads/branch13"
+'
+
 test_done
-- 
1.6.1.245.gdd9f9
