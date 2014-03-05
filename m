From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] push: detect local refspec errors early
Date: Wed, 5 Mar 2014 14:04:54 -0500
Message-ID: <20140305190454.GC11039@sigill.intra.peff.net>
References: <20140305190248.GB31252@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dmitry <wipedout@yandex.ru>
X-From: git-owner@vger.kernel.org Wed Mar 05 20:05:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLH7l-0004ps-Pd
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 20:05:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753028AbaCETE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 14:04:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:33577 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750817AbaCETE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 14:04:57 -0500
Received: (qmail 17991 invoked by uid 102); 5 Mar 2014 19:04:57 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Mar 2014 13:04:57 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Mar 2014 14:04:54 -0500
Content-Disposition: inline
In-Reply-To: <20140305190248.GB31252@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243466>

When pushing, we do not even look at our push refspecs until
after we have made contact with the remote receive-pack and
gotten its list of refs. This means that we may go to some
work, including asking the user to log in, before realizing
we have simple errors like "git push origin matser".

We cannot catch all refspec problems, since fully evaluating
the refspecs requires knowing what the remote side has. But
we can do a quick sanity check of the local side and catch a
few simple error cases.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c               | 25 +++++++++++++++++++++++++
 remote.h               |  1 +
 t/t5529-push-errors.sh | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 transport.c            |  8 ++++++--
 4 files changed, 80 insertions(+), 2 deletions(-)
 create mode 100755 t/t5529-push-errors.sh

diff --git a/remote.c b/remote.c
index b6586c0..8471fb1 100644
--- a/remote.c
+++ b/remote.c
@@ -1374,6 +1374,31 @@ static void prepare_ref_index(struct string_list *ref_index, struct ref *ref)
 }
 
 /*
+ * Given only the set of local refs, sanity-check the set of push
+ * refspecs. We can't catch all errors that match_push_refs would,
+ * but we can catch some errors early before even talking to the
+ * remote side.
+ */
+int check_push_refs(struct ref *src, int nr_refspec, const char **refspec_names)
+{
+	struct refspec *refspec = parse_push_refspec(nr_refspec, refspec_names);
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < nr_refspec; i++) {
+		struct refspec *rs = refspec + i;
+
+		if (rs->pattern || rs->matching)
+			continue;
+
+		ret |= match_explicit_lhs(src, rs, NULL, NULL);
+	}
+
+	free_refspec(nr_refspec, refspec);
+	return ret;
+}
+
+/*
  * Given the set of refs the local repository has, the set of refs the
  * remote repository has, and the refspec used for push, determine
  * what remote refs we will update and with what value by setting
diff --git a/remote.h b/remote.h
index fb7647f..917d383 100644
--- a/remote.h
+++ b/remote.h
@@ -166,6 +166,7 @@ extern int query_refspecs(struct refspec *specs, int nr, struct refspec *query);
 char *apply_refspecs(struct refspec *refspecs, int nr_refspec,
 		     const char *name);
 
+int check_push_refs(struct ref *src, int nr_refspec, const char **refspec);
 int match_push_refs(struct ref *src, struct ref **dst,
 		    int nr_refspec, const char **refspec, int all);
 void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
diff --git a/t/t5529-push-errors.sh b/t/t5529-push-errors.sh
new file mode 100755
index 0000000..9871307
--- /dev/null
+++ b/t/t5529-push-errors.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+
+test_description='detect some push errors early (before contacting remote)'
+. ./test-lib.sh
+
+test_expect_success 'setup commits' '
+	test_commit one
+'
+
+test_expect_success 'setup remote' '
+	git init --bare remote.git &&
+	git remote add origin remote.git
+'
+
+test_expect_success 'setup fake receive-pack' '
+	FAKE_RP_ROOT=$(pwd) &&
+	export FAKE_RP_ROOT &&
+	write_script fake-rp <<-\EOF &&
+	echo yes >"$FAKE_RP_ROOT"/rp-ran
+	exit 1
+	EOF
+	git config remote.origin.receivepack "\"\$FAKE_RP_ROOT/fake-rp\""
+'
+
+test_expect_success 'detect missing branches early' '
+	echo no >rp-ran &&
+	echo no >expect &&
+	test_must_fail git push origin missing &&
+	test_cmp expect rp-ran
+'
+
+test_expect_success 'detect missing sha1 expressions early' '
+	echo no >rp-ran &&
+	echo no >expect &&
+	test_must_fail git push origin master~2:master &&
+	test_cmp expect rp-ran
+'
+
+test_expect_success 'detect ambiguous refs early' '
+	git branch foo &&
+	git tag foo &&
+	echo no >rp-ran &&
+	echo no >expect &&
+	test_must_fail git push origin foo &&
+	test_cmp expect rp-ran
+'
+
+test_done
diff --git a/transport.c b/transport.c
index ca7bb44..325f03e 100644
--- a/transport.c
+++ b/transport.c
@@ -1132,8 +1132,7 @@ int transport_push(struct transport *transport,
 
 		return transport->push(transport, refspec_nr, refspec, flags);
 	} else if (transport->push_refs) {
-		struct ref *remote_refs =
-			transport->get_refs_list(transport, 1);
+		struct ref *remote_refs;
 		struct ref *local_refs = get_local_heads();
 		int match_flags = MATCH_REFS_NONE;
 		int verbose = (transport->verbose > 0);
@@ -1142,6 +1141,11 @@ int transport_push(struct transport *transport,
 		int pretend = flags & TRANSPORT_PUSH_DRY_RUN;
 		int push_ret, ret, err;
 
+		if (check_push_refs(local_refs, refspec_nr, refspec) < 0)
+			return -1;
+
+		remote_refs = transport->get_refs_list(transport, 1);
+
 		if (flags & TRANSPORT_PUSH_ALL)
 			match_flags |= MATCH_REFS_ALL;
 		if (flags & TRANSPORT_PUSH_MIRROR)
-- 
1.8.5.2.500.g8060133
