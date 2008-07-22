From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-merge: give a proper error message for invalid
 strategies in config
Date: Mon, 21 Jul 2008 22:22:30 -0700
Message-ID: <7vljzupk6h.fsf@gitster.siamese.dyndns.org>
References: <1216656647-16897-1-git-send-email-vmiklos@frugalware.org>
 <7vr69mpl5v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jul 22 07:24:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLALw-0003gm-25
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 07:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756782AbYGVFWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 01:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756552AbYGVFWi
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 01:22:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36001 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756778AbYGVFWh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 01:22:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AF7CD336D7;
	Tue, 22 Jul 2008 01:22:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id ADE98336D5; Tue, 22 Jul 2008 01:22:32 -0400 (EDT)
In-Reply-To: <7vr69mpl5v.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 21 Jul 2008 22:01:16 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 317B1D6A-57AE-11DD-B360-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89438>

Junio C Hamano <gitster@pobox.com> writes:

> Miklos Vajna <vmiklos@frugalware.org> writes:
>
>> Till now 'git merge -s foobar' bailed out with an error message, but
>> foobar in pull.twohead or pull.octopus was just silently ignored. It's
>> better to inform the user then just silently doing nothing.
>>
>> Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
>
> Doesn't this make "git merge -s 'recursive resolve'" to misbehave?

Perhaps this would be a better replacement.  It makes get_strategy() to
validate and barf on unknown one.  It is slightly smaller and more
contained.  If/when we add user-defined ones, that logic will also be
contained in the function.

 builtin-merge.c              |   37 ++++++++++++-------------------------
 t/t7601-merge-pull-config.sh |   12 ++++++++++++
 2 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index e97c79e..0fd7985 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -77,6 +77,7 @@ static int option_parse_message(const struct option *opt,
 static struct strategy *get_strategy(const char *name)
 {
 	int i;
+	struct strbuf err;
 
 	if (!name)
 		return NULL;
@@ -84,7 +85,13 @@ static struct strategy *get_strategy(const char *name)
 	for (i = 0; i < ARRAY_SIZE(all_strategy); i++)
 		if (!strcmp(name, all_strategy[i].name))
 			return &all_strategy[i];
-	return NULL;
+
+	strbuf_init(&err, 0);
+	for (i = 0; i < ARRAY_SIZE(all_strategy); i++)
+		strbuf_addf(&err, " %s", all_strategy[i].name);
+	fprintf(stderr, "Could not find merge strategy '%s'.\n", name);
+	fprintf(stderr, "Available strategies are:%s.\n", err.buf);
+	exit(1);
 }
 
 static void append_strategy(struct strategy *s)
@@ -96,25 +103,10 @@ static void append_strategy(struct strategy *s)
 static int option_parse_strategy(const struct option *opt,
 				 const char *name, int unset)
 {
-	int i;
-	struct strategy *s;
-
 	if (unset)
 		return 0;
 
-	s = get_strategy(name);
-
-	if (s)
-		append_strategy(s);
-	else {
-		struct strbuf err;
-		strbuf_init(&err, 0);
-		for (i = 0; i < ARRAY_SIZE(all_strategy); i++)
-			strbuf_addf(&err, " %s", all_strategy[i].name);
-		fprintf(stderr, "Could not find merge strategy '%s'.\n", name);
-		fprintf(stderr, "Available strategies are:%s.\n", err.buf);
-		exit(1);
-	}
+	append_strategy(get_strategy(name));
 	return 0;
 }
 
@@ -643,14 +635,9 @@ static void add_strategies(const char *string, unsigned attr)
 
 	memset(&list, 0, sizeof(list));
 	split_merge_strategies(string, &list, &list_nr, &list_alloc);
-	if (list != NULL) {
-		for (i = 0; i < list_nr; i++) {
-			struct strategy *s;
-
-			s = get_strategy(list[i].name);
-			if (s)
-				append_strategy(s);
-		}
+	if (list) {
+		for (i = 0; i < list_nr; i++)
+			append_strategy(get_strategy(list[i].name));
 		return;
 	}
 	for (i = 0; i < ARRAY_SIZE(all_strategy); i++)
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 95b4d71..6b9f638 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -126,4 +126,16 @@ test_expect_success 'merge picks up the best result' '
 	test $auto_count != $resolve_count
 '
 
+test_expect_success 'merge errors out on invalid strategy' '
+	git config pull.twohead "foobar" &&
+	git reset --hard c5 &&
+	test_must_fail git merge c6
+'
+
+test_expect_success 'merge errors out on invalid strategy' '
+	git config --unset-all pull.twohead &&
+	git reset --hard c5 &&
+	test_must_fail git merge -s "resolve recursive" c6
+'
+
 test_done
