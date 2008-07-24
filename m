From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-checkout: improve error messages, detect
 ambiguities.
Date: Wed, 23 Jul 2008 19:07:38 -0700
Message-ID: <7vljzs6nmd.fsf@gitster.siamese.dyndns.org>
References: <1216774940-4955-1-git-send-email-madcoder@debian.org>
 <1216808133-31919-1-git-send-email-madcoder@debian.org>
 <1216808133-31919-2-git-send-email-madcoder@debian.org>
 <1216808133-31919-3-git-send-email-madcoder@debian.org>
 <7v7ibc9p93.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jul 24 04:09:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLqG5-0000Qw-Kz
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 04:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbYGXCHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 22:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbYGXCHp
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 22:07:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60421 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184AbYGXCHo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 22:07:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 917893C4E6;
	Wed, 23 Jul 2008 22:07:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A195B3C4E5; Wed, 23 Jul 2008 22:07:40 -0400 (EDT)
In-Reply-To: <7v7ibc9p93.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 23 Jul 2008 16:04:08 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4D424582-5925-11DD-9648-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89827>

Junio C Hamano <gitster@pobox.com> writes:

> Pierre Habouzit <madcoder@debian.org> writes:
>
>> The patch is twofold: it moves the option consistency checks just under
>> the parse_options call so that it doesn't get in the way of the tree
>> reference vs. pathspecs desambiguation.
>
> I think this goes a bit too far.
>
> Even if you have a file called 'master' tracked in your project, when you
> say:
>
>     $ git checkout master
>
> that's almost always branch switching.  Forcing "git checkout master --"
> disambiguation for such a common case is simply a wrong thing to do from
> the usability point of view.

So something like this on top of your patch.

 builtin-checkout.c            |   19 +++++++++++++++----
 t/t2010-checkout-ambiguous.sh |   15 +++++++++++++--
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index d99c1c0..411cc51 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -460,7 +460,10 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	 *
 	 * case 3: git checkout <something> [<paths>]
 	 *
-	 *   <something> shall not be ambiguous.
+	 *   With no paths, if <something> is a commit, that is to
+	 *   switch to the branch or detach HEAD at it.
+	 *
+	 *   Otherwise <something> shall not be ambiguous.
 	 *   - If it's *only* a reference, treat it like case (1).
 	 *   - If it's only a path, treat it like case (2).
 	 *   - else: fail.
@@ -474,7 +477,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		}
 
 		arg = argv[0];
-		has_dash_dash = argc > 1 && !strcmp(argv[1], "--");
+		has_dash_dash = (argc > 1) && !strcmp(argv[1], "--");
 
 		if (get_sha1(arg, rev)) {
 			if (has_dash_dash)          /* case (1) */
@@ -500,8 +503,16 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 
 		if (!source_tree)                   /* case (1): want a tree */
 			die("reference is not a tree: %s", arg);
-		if (!has_dash_dash)                 /* case (3 -> 1) */
-			verify_non_filename(NULL, arg);
+		if (!has_dash_dash) {/* case (3 -> 1) */
+			/*
+			 * Do not complain the most common case
+			 *	git checkout branch
+			 * even if there happen to be a file called 'branch';
+			 * it would be extremely annoying.
+			 */
+			if (argc)
+				verify_non_filename(NULL, arg);
+		}
 		else {
 			argv++;
 			argc--;
diff --git a/t/t2010-checkout-ambiguous.sh b/t/t2010-checkout-ambiguous.sh
index 50d1f43..7cc0a35 100755
--- a/t/t2010-checkout-ambiguous.sh
+++ b/t/t2010-checkout-ambiguous.sh
@@ -32,8 +32,19 @@ test_expect_success 'non ambiguous call' '
 	git checkout all
 '
 
-test_expect_success 'ambiguous call' '
-	test_must_fail git checkout world
+test_expect_success 'allow the most common case' '
+	git checkout world &&
+	test "refs/heads/world" = "$(git symbolic-ref HEAD)"
+'
+
+test_expect_success 'check ambiguity' '
+	test_must_fail git checkout world all
+'
+
+test_expect_success 'disambiguate checking out from a tree-ish' '
+	echo bye > world &&
+	git checkout world -- world &&
+	git diff --exit-code --quiet
 '
 
 test_done
