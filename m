Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 886F420437
	for <e@80x24.org>; Thu, 12 Oct 2017 08:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755354AbdJLIqo (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 04:46:44 -0400
Received: from resqmta-po-03v.sys.comcast.net ([96.114.154.162]:55118 "EHLO
        resqmta-po-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752545AbdJLIqm (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Oct 2017 04:46:42 -0400
Received: from resomta-po-06v.sys.comcast.net ([96.114.154.230])
        by resqmta-po-03v.sys.comcast.net with ESMTP
        id 2Z8ceogzWa26B2Z8cerVCH; Thu, 12 Oct 2017 08:46:42 +0000
Received: from mail.tremily.us ([67.168.186.5])
        by resomta-po-06v.sys.comcast.net with SMTP
        id 2Z6feKN0e14XP2Z6gebjWN; Thu, 12 Oct 2017 08:44:42 +0000
Received: from ullr.tremily.us (ullr.tremily.us [192.168.10.7])
        by mail.tremily.us (Postfix) with SMTP id CE951FED58B;
        Thu, 12 Oct 2017 01:45:08 -0700 (PDT)
Received: (nullmailer pid 13226 invoked by uid 1000);
        Thu, 12 Oct 2017 08:46:41 -0000
From:   "W. Trevor King" <wking@tremily.us>
To:     Git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C5=81ukasz=20Gryglicki?= <lukaszgryglicki@o2.pl>,
        "W. Trevor King" <wking@tremily.us>
Subject: [PATCH v2] pull: pass --signoff/--no-signoff to "git merge"
Date:   Thu, 12 Oct 2017 01:46:39 -0700
Message-Id: <51d67d6d707182d4973d9961ab29358f26c4988a.1507796638.git.wking@tremily.us>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <18953f46ffb5e3dbc4da8fbda7fe3ab4298d7cbd.1507752482.git.wking@tremily.us>
References: <18953f46ffb5e3dbc4da8fbda7fe3ab4298d7cbd.1507752482.git.wking@tremily.us>
X-CMAE-Envelope: MS4wfAc0ZLJoVO3Y93pFix2Ky0zA9TgTFOuJ5rUn5trXbXAEOt1fKQckN6vUodWAtlNCWnw2Cgg8KxrqRfeb2Ly9PvY+NXrAyodoRxXHzw5jaWGvYBABSlNM
 FJC1JNlV+MBzZQCdSlbRo8GKO7mT3QlRmh5UghooJVCSchkKtaF9q9/5N6ysVTBshX2oVyUwx+weJANnqD5k6F+qBtR9klS9sbSlwU3GLGUFTzuJABcyMEqn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

e379fdf3 (merge: refuse to create too cool a merge by default,
2016-03-18) gave a reason for *not* passing options from pull to
merge:

  ...because such a "two project merge" would be done after fetching
  the other project into some location in the working tree of an
  existing project and making sure how well they fit together...

That's certainly an acceptable workflow, but I'd also like to support
merge options in pull for folks who want to optimistically pull and
then sort out "how well they fit together" after pull exits (possibly
with a merge failure).  And in cases where an optimistic pull is
likely to succeed, suggesting it is easier to explain to Git newbies
than a FETCH_HEAD merge or remote-addition/merge/remote-removal.

09c2cb87 (pull: pass --allow-unrelated-histories to "git merge",
2016-03-18) added a pull-to-merge pass for a different option but
didn't motivate its change, only citing the reason from e379fdf3 for
not adding the pull-to-merge pass for that option.  I'm personally in
favor of pull-to-merge passing for any unambiguous options, but if the
decision for pull-to-merge passes depends on the specific option, then
--allow-unrelated-histories is probably the weakest candidate because
unrelated-history merged are more likely to have "fit together" issues
than the other merge-only options.

The test_has_trailer helper gives folks a convenient way check these
sorts of things.  I haven't gone through and updated existing trailer
checks (e.g. the ones in t7614-merge-signoff.sh) to avoid the "only to
correct the inconconsistency" issue discussed in SubmittingPatches.
Other test may gradually migrate to the new helper if they find it
useful.  The helper may be useful enough to eventually become a
plumbing command (a read version of interpret-trailers with an API
similar to 'git config ...'?), but I'm not going that far in this
commit ;).

The order of options in merge-options.txt isn't clear to me, but I've
put --signoff between --log and --stat as somewhat alphabetized and
having an "add to the commit message" function like --log.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: W. Trevor King <wking@tremily.us>
---
Changes since v1 [1]:

* Dropped "Following" paragraph.  Junio took issue with the phrasing
  [2], and the implementation in v2 has diverged sufficiently from
  09c2cb87 and 14d01b4f that I don't think citing them as
  implementation references is useful anymore.

* Lead the commit message with reworked motivation paragraphs, since
  Junio read the v1 motivation paragraph as off-topic [2].

* Add a test_has_trailer helper, which I'd floated in [3] after
  Junio's get_signoff suggestion in [2].

* Drop subshells in favor of '-C <directory>' in the tests, as
  suggested in [2].

* Add tests for the bare pull and lonely --no-signoff cases, as
  suggested in [2].  With these additions in place, I've dropped v1's
  "The tests aren't as extensive..." paragraph from the commit
  message.

* Use OPT_PASSTHRU in pull.c.  I'm not sure why
  --allow-unrelated-histories didn't go this route, but there are lots
  of other pull-to-merge options using OPT_PASSTHRU, so using it for
  --signoff isn't breaking consistency.

Not changed since v1:

* The merge-options.txt order paragraph.  Junio had suggested it be
  moved after the break [2], but I think having some commit-message
  discussion of merge-options.txt ordering is useful, even though I
  don't have strong opinions on what the ordering should be [3].

This patch (and v1) are based on v2.15.0-rc1, although I expect
they'll apply cleanly to anything in that vicinity.

Cheers,
Trevor

[1]: https://public-inbox.org/git/18953f46ffb5e3dbc4da8fbda7fe3ab4298d7cbd.1507752482.git.wking@tremily.us/
[2]: https://public-inbox.org/git/xmqqefq92mgw.fsf@gitster.mtv.corp.google.com/
[3]: https://public-inbox.org/git/20171012053002.GZ11004@valgrind.tremily.us/

 Documentation/git-merge.txt     |  8 --------
 Documentation/merge-options.txt | 10 ++++++++++
 builtin/pull.c                  |  6 ++++++
 t/t5521-pull-options.sh         | 40 ++++++++++++++++++++++++++++++++++++++
 t/test-lib-functions.sh         | 43 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 99 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 4df6431c34..0ada8c856b 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -64,14 +64,6 @@ OPTIONS
 -------
 include::merge-options.txt[]
 
---signoff::
-	Add Signed-off-by line by the committer at the end of the commit
-	log message.  The meaning of a signoff depends on the project,
-	but it typically certifies that committer has
-	the rights to submit this work under the same license and
-	agrees to a Developer Certificate of Origin
-	(see http://developercertificate.org/ for more information).
-
 -S[<keyid>]::
 --gpg-sign[=<keyid>]::
 	GPG-sign the resulting merge commit. The `keyid` argument is
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 4e32304301..f394622d65 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -51,6 +51,16 @@ set to `no` at the beginning of them.
 With --no-log do not list one-line descriptions from the
 actual commits being merged.
 
+--signoff::
+--no-signoff::
+	Add Signed-off-by line by the committer at the end of the commit
+	log message.  The meaning of a signoff depends on the project,
+	but it typically certifies that committer has
+	the rights to submit this work under the same license and
+	agrees to a Developer Certificate of Origin
+	(see http://developercertificate.org/ for more information).
++
+With --no-signoff do not add a Signed-off-by line.
 
 --stat::
 -n::
diff --git a/builtin/pull.c b/builtin/pull.c
index 6f772e8a22..0413c78a3a 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -86,6 +86,7 @@ static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static enum rebase_type opt_rebase = -1;
 static char *opt_diffstat;
 static char *opt_log;
+static char *opt_signoff;
 static char *opt_squash;
 static char *opt_commit;
 static char *opt_edit;
@@ -142,6 +143,9 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "log", &opt_log, N_("n"),
 		N_("add (at most <n>) entries from shortlog to merge commit message"),
 		PARSE_OPT_OPTARG),
+	OPT_PASSTHRU(0, "signoff", &opt_signoff, NULL,
+		N_("add Signed-off-by:"),
+		PARSE_OPT_OPTARG),
 	OPT_PASSTHRU(0, "squash", &opt_squash, NULL,
 		N_("create a single commit instead of doing a merge"),
 		PARSE_OPT_NOARG),
@@ -594,6 +598,8 @@ static int run_merge(void)
 		argv_array_push(&args, opt_diffstat);
 	if (opt_log)
 		argv_array_push(&args, opt_log);
+	if (opt_signoff)
+		argv_array_push(&args, opt_signoff);
 	if (opt_squash)
 		argv_array_push(&args, opt_squash);
 	if (opt_commit)
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index ded8f98dbe..82680a30f8 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -165,4 +165,44 @@ test_expect_success 'git pull --allow-unrelated-histories' '
 	)
 '
 
+test_expect_success 'git pull does not add a sign-off line' '
+	test_when_finished "rm -fr src dst" &&
+	git init src &&
+	test_commit -C src one &&
+	git clone src dst &&
+	test_commit -C src two &&
+	git -C dst pull --no-ff &&
+	! test_has_trailer -C dst HEAD Signed-off-by
+'
+
+test_expect_success 'git pull --no-signoff does not add sign-off line' '
+	test_when_finished "rm -fr src dst" &&
+	git init src &&
+	test_commit -C src one &&
+	git clone src dst &&
+	test_commit -C src two &&
+	git -C dst pull --no-signoff --no-ff &&
+	! test_has_trailer -C dst HEAD Signed-off-by
+'
+
+test_expect_success 'git pull --signoff add a sign-off line' '
+	test_when_finished "rm -fr src dst" &&
+	git init src &&
+	test_commit -C src one &&
+	git clone src dst &&
+	test_commit -C src two &&
+	git -C dst pull --signoff --no-ff &&
+	test_has_trailer -C dst HEAD Signed-off-by "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"
+'
+
+test_expect_success 'git pull --no-signoff flag cancels --signoff flag' '
+	test_when_finished "rm -fr src dst actual" &&
+	git init src &&
+	test_commit -C src one &&
+	git clone src dst &&
+	test_commit -C src two &&
+	git -C dst pull --signoff --no-signoff --no-ff &&
+	! test_has_trailer -C dst HEAD Signed-off-by
+'
+
 test_done
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 1701fe2a06..08409b1c25 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -726,6 +726,49 @@ test_must_be_empty () {
 	fi
 }
 
+# Call test_has_trailer with the arguments:
+# [-C <directory>] <object> <token> [<value>]
+# where <object> is an object name as described in gitrevisions(7),
+# <token> is a trailer token (e.g. 'Signed-off-by'), and
+# <value> is an optional value (e.g. 'A U Thor <author@example.com>').
+# test_has_trailer returns success if the specified trailer is found
+# in the object content.  If <value> is unset, any value will match.
+#
+# Both <token> and <value> are basic regular expressions.
+#
+# If the first argument is "-C", the second argument is used as a path for
+# the git invocations.
+test_has_trailer () {
+	INDIR=
+	case "$1" in
+	-C)
+		INDIR="$2"
+		shift 2 || error "<directory> not specified"
+		;;
+	esac
+	INDIR="${INDIR:+${INDIR}/}"
+	OBJECT="$1"
+	shift || error "<object> not specified"
+	TOKEN="$1"
+	shift || error "<token> not specified"
+	SEP=':'  # FIXME: read from trailer.separators?
+	CONTENT="$(git ${INDIR:+ -C "${INDIR}"} cat-file -p "${OBJECT}")" || error "object ${OBJECT} not found${INDIR:+ in ${INDIR}}"
+	PATTERN="^${TOKEN}${SEP}"
+	if test 0 -lt "$#"
+	then
+		VALUE="$1"
+		PATTERN="${PATTERN} *${VALUE}$"
+	fi
+	if (echo "${CONTENT}" | grep -q "${PATTERN}")
+	then
+		printf "%s found in:\n%s\n" "${PATTERN}" "${CONTENT}"
+		return 0
+	else
+		printf "%s not found in:\n%s\n" "${PATTERN}" "${CONTENT}"
+		return 1
+	fi
+}
+
 # Tests that its two parameters refer to the same revision
 test_cmp_rev () {
 	git rev-parse --verify "$1" >expect.rev &&
-- 
2.13.6

