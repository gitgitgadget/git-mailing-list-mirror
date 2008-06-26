From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [PATCH] cmd_reset: don't trash uncommitted changes unless
 told to
Date: Wed, 25 Jun 2008 18:26:05 -0700
Message-ID: <7vk5gduguq.fsf@gitster.siamese.dyndns.org>
References: <20080624222105.GA24549@dervierte>
 <486220CE.3070103@viscovery.net> <alpine.DEB.1.00.0806251334060.9925@racer>
 <20080625135100.GF20361@mit.edu> <7v63rx2zwf.fsf@gitster.siamese.dyndns.org>
 <20080625195003.GB15077@mit.edu>
 <32541b130806251304u39c8ffdenc52904391aebd089@mail.gmail.com>
 <7vlk0tz33n.fsf@gitster.siamese.dyndns.org>
 <32541b130806251322l478faa87gc9f2016254689022@mail.gmail.com>
 <7vd4m5z1f8.fsf@gitster.siamese.dyndns.org>
 <32541b130806251358n3ab6cfc8y7a90d898b9308e12@mail.gmail.com>
 <7vwskdxl6z.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Theodore Tso" <tytso@mit.edu>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Boaz Harrosh" <bharrosh@panasas.com>,
	"Steven Walter" <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 03:27:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBgGi-0003Cg-HD
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 03:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbYFZB02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 21:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752034AbYFZB01
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 21:26:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39187 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893AbYFZB00 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 21:26:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1B6ADC24F;
	Wed, 25 Jun 2008 21:26:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8C8C1C24E; Wed, 25 Jun 2008 21:26:10 -0400 (EDT)
In-Reply-To: <7vwskdxl6z.fsf_-_@gitster.siamese.dyndns.org> (Junio C.
 Hamano's message of "Wed, 25 Jun 2008 14:24:04 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E3CDFBB2-431E-11DD-BD79-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86382>

Junio C Hamano <gitster@pobox.com> writes:

> Reset is about resetting the index and --hard option tells it to propagate
> the change down to the work tree as well.
>
> There is no "reset to the index", so "reset -- path" would be a redundant
> way to spell "reset HEAD path" or "reset HEAD -- path" which is even more
> redundant.
>
> As long as builti-fetch.c is not a valid ref, you should be able to get
> out of the above mess by any one of:
>
>         $ git reset builtin-fetch.c
>         $ git reset -- builtin-fetch.c
>         $ git reset HEAD builtin-fetch.c
>
> but the first one complains, saying builtin-fetch.c is not a valid ref.
>
> This may help.

And this is a cleaned-up patch that is more through.

-- >8 --
Allow "git-reset path" when unambiguous

Resetting a selected set of index entries is done with
"git reset -- paths" syntax, but we did not allow -- to be omitted
even when the command is unambiguous.

This updates the command to follow the general rule:

 * When -- appears, revs come before it, and paths come after it;

 * When there is no --, earlier ones are revs and the rest are paths, and
   we need to guess.  When lack of -- marker forces us to guess, we
   protect from user errors and typoes by making sure what we treat as
   revs do not appear as filenames in the work tree, and what we treat as
   paths do appear as filenames in the work tree, and by erroring out if
   that is not the case.  We tell the user to disambiguate by using -- in
   such a case.

which is employed elsewhere in the system.

When this rule is applied to "reset", because we can have only zero or one
rev to the command, the check can be slightly simpler than other programs.
We have to check only the first one or two tokens after the command name
and options, and when they are:

    -- A:
    	no explicit rev given; "A" and whatever follows it are paths.

    A --:
        explicit rev "A" given and whatever follows the "--" are paths.

    A B:
       "A" could be rev or path and we need to guess.  "B" could
       be missing but if exists that (and everything that follows) would
       be paths.

So we apply the guess only in the last case and only to "A" (not "B" and
what comes after it).

 * As long as "A" is unambiguously a path, index entries for "A", "B" (and
   everything that follows) are reset to the HEAD revision.

 * If "A" is unambiguously a rev, on the other hand, the index entries for
   "B" (and everything that follows) are reset to the "A" revision.

Signed-off-by: Junio C Hamano <gitster@pobox.com>

---

 builtin-reset.c  |   39 ++++++++++++++++++++++++++++++++++-----
 t/t7102-reset.sh |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 5 deletions(-)

diff --git a/builtin-reset.c b/builtin-reset.c
index f34acb1..a032169 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -194,8 +194,40 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	reflog_action = args_to_str(argv);
 	setenv("GIT_REFLOG_ACTION", reflog_action, 0);
 
-	if (i < argc && strcmp(argv[i], "--"))
-		rev = argv[i++];
+	/*
+	 * Possible arguments are:
+	 *
+	 * git reset [-opts] <rev> <paths>...
+	 * git reset [-opts] <rev> -- <paths>...
+	 * git reset [-opts] -- <paths>...
+	 * git reset [-opts] <paths>...
+	 *
+	 * At this point, argv[i] points immediately after [-opts].
+	 */
+
+	if (i < argc) {
+		if (!strcmp(argv[i], "--")) {
+			i++; /* reset to HEAD, possibly with paths */
+		} else if (i + 1 < argc && !strcmp(argv[i+1], "--")) {
+			rev = argv[i];
+			i += 2;
+		}
+		/*
+		 * Otherwise, argv[i] could be either <rev> or <paths> and
+		 * has to be unambigous.
+		 */
+		else if (!get_sha1(argv[i], sha1)) {
+			/*
+			 * Ok, argv[i] looks like a rev; it should not
+			 * be a filename.
+			 */
+			verify_non_filename(prefix, argv[i]);
+			rev = argv[i++];
+		} else {
+			/* Otherwise we treat this as a filename */
+			verify_filename(prefix, argv[i]);
+		}
+	}
 
 	if (get_sha1(rev, sha1))
 		die("Failed to resolve '%s' as a valid ref.", rev);
@@ -205,9 +237,6 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 		die("Could not parse object '%s'.", rev);
 	hashcpy(sha1, commit->object.sha1);
 
-	if (i < argc && !strcmp(argv[i], "--"))
-		i++;
-
 	/* git reset tree [--] paths... can be used to
 	 * load chosen paths from the tree into the index without
 	 * affecting the working tree nor HEAD. */
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 39ba141..96d1508 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -428,4 +428,51 @@ test_expect_success '--mixed refreshes the index' '
 	test_cmp expect output
 '
 
+test_expect_success 'disambiguation (1)' '
+
+	git reset --hard &&
+	>secondfile &&
+	git add secondfile &&
+	test_must_fail git reset secondfile &&
+	test -z "$(git diff --cached --name-only)" &&
+	test -f secondfile &&
+	test ! -s secondfile
+
+'
+
+test_expect_success 'disambiguation (2)' '
+
+	git reset --hard &&
+	>secondfile &&
+	git add secondfile &&
+	rm -f secondfile &&
+	test_must_fail git reset secondfile &&
+	test -n "$(git diff --cached --name-only -- secondfile)" &&
+	test ! -f secondfile
+
+'
+
+test_expect_success 'disambiguation (3)' '
+
+	git reset --hard &&
+	>secondfile &&
+	git add secondfile &&
+	rm -f secondfile &&
+	test_must_fail git reset HEAD secondfile &&
+	test -z "$(git diff --cached --name-only)" &&
+	test ! -f secondfile
+
+'
+
+test_expect_success 'disambiguation (4)' '
+
+	git reset --hard &&
+	>secondfile &&
+	git add secondfile &&
+	rm -f secondfile &&
+	test_must_fail git reset -- secondfile &&
+	test -z "$(git diff --cached --name-only)" &&
+	test ! -f secondfile
+'
+
 test_done
