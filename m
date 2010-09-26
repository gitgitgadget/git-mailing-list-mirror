From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH v7 3/3] rev-parse: stop interpreting flags as options to rev-parse once --flags is specified
Date: Mon, 27 Sep 2010 00:44:07 +1000
Message-ID: <1285512247-15600-4-git-send-email-jon.seymour@gmail.com>
References: <7v1v8hnflx.fsf@alter.siamese.dyndns.org>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org, robbat2@gentoo.org, casey@nrlssc.navy.mil,
	avarab@gmail.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 26 16:41:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzsPu-00071L-Vu
	for gcvg-git-2@lo.gmane.org; Sun, 26 Sep 2010 16:41:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161Ab0IZOlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Sep 2010 10:41:14 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:36707 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932089Ab0IZOlN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 10:41:13 -0400
Received: by pvg2 with SMTP id 2so1039756pvg.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 07:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=F7F1NAhfwcB36LYV9fBgyD0QDrf2vCxEYTEnhirpSU4=;
        b=cISLTEVkdi74ntpVjzly5JfSwOVy1lMKaoT2Nb5dxtKcicKErJbzBLHAIorcCFFEkr
         c6xUk1uyyDp69Ti+9wiQ09aJ4QotS+wSZ2F6bJCLp+Qu+6TrtIWf0SetksftUXc/IPTN
         xaHo3ogA+RKn+K9VlCao+lRbbBpbE6RX/hWfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SS68BGuqe33RVodbDc9mspWjoo89oJVcEJpRfaclZcsmyoUGDDg27RAbIWwnIqXzb9
         6MzRr1L54ItxU+kHWlTMLJSOIiT4fZUCCMRg4cYm21zWSglGT2vEfWCL9R3pnBtHDxpE
         4XYTroRb5ynrPNPTRP2pwfbyZ4kaSJwFzjnt4=
Received: by 10.142.185.16 with SMTP id i16mr5174997wff.212.1285512072946;
        Sun, 26 Sep 2010 07:41:12 -0700 (PDT)
Received: from localhost.localdomain (124-169-4-134.dyn.iinet.net.au [124.169.4.134])
        by mx.google.com with ESMTPS id o9sm5877375wfd.4.2010.09.26.07.41.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 07:41:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.3.g9129b6
In-Reply-To: <7v1v8hnflx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157230>

Current git rev-parse behaviour makes --flags hard to use if the remaining
arguments to git rev-parse contain an option that would otherwise be interpreted
as an option by git rev-parse itself.

So, for example:

  $> git rev-parse --flags -q -X
  -X

Normally one might expect to use -- to prevent -q being interpreted:

  $> git rev-parse --flags -- -q -X
  -q -X

But we can't really use -- in this way, because commands that use
git rev-parse might reasonably expect:

  $> git rev-parse --flags -Y -- -q -X
  -Y

That is, -Y to be regarded as a flag but everything after -- to be uninterpreted.

This proposed change modifies git rev-parse so that git rev-parse stops
interpreting flag arguments as options to git rev-parse once --flags is
interpreted. We also exit early once -- is found.

Previously:
 $> git rev-parse --flags --all
 {list of sha1 hashes}
 $>

Now:
 $> git rev-parse --flags --all
 --all
 $>

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 Documentation/git-rev-parse.txt |   11 +++++++++--
 builtin/rev-parse.c             |    8 ++++++++
 t/t1510-rev-parse-flags.sh      |   14 ++++++--------
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 27d15b0..3eac735 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -51,11 +51,18 @@ OPTIONS
 --flags::
 	Output any flag and revision-like values in the remaining parameters.
 +
-Note that any parameter which is also a valid 'git rev-parse' option
-will be interpreted as an option to 'git rev-parse' and thus will not be output.
+If specified, this option causes 'git rev-parse' to stop
+interpreting remaining arguments as options for its own
+consumption. As such, this option should be specified
+after all other options that 'git rev-parse' is expected
+to interpret.
 
 --no-flags::
 	Do not output flag parameters.
++
+If both `--flags` and `--no-flags` are specified, the first
+option specified wins and the other option is treated like
+a non-option argument.
 
 --default <arg>::
 	If there is no parameter given by the user, use `<arg>`
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index a5a1c86..2ad269a 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -497,8 +497,16 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				/* Pass on the "--" if we show anything but files.. */
 				if (filter & (DO_FLAGS | DO_REVS))
 					show_file(arg);
+				if (!(filter & DO_NONFLAGS)) {
+					return 0;
+				}
 				continue;
 			}
+			if (!(filter & DO_NONFLAGS)) {
+				/* once we see --flags, we stop interpreting other flags */
+				 show_flag(arg);
+				 continue;
+			}
 			if (!strcmp(arg, "--default")) {
 				def = argv[i+1];
 				i++;
diff --git a/t/t1510-rev-parse-flags.sh b/t/t1510-rev-parse-flags.sh
index e327b96..1e8311e 100755
--- a/t/t1510-rev-parse-flags.sh
+++ b/t/t1510-rev-parse-flags.sh
@@ -92,16 +92,16 @@ test_expect_success 'git rev-parse --symbolic --no-flags --flags HEAD -> "HEAD"'
 	test_cmp expected actual
 '
 
-test_expect_success 'git rev-parse --flags -q -> ""' \
+test_expect_success 'git rev-parse --flags -q -> "-q"' \
 '
-	>expected &&
+	printf "%s\n" -q > expected &&
 	git rev-parse --flags -q >actual &&
 	test_cmp expected actual
 '
 
-test_expect_success 'git rev-parse --flags --no-flags -> ""' \
+test_expect_success 'git rev-parse --flags --no-flags -> "--no-flags"' \
 '
-	>expected &&
+	printf "%s\n" --no-flags > expected &&
 	git rev-parse --flags --no-flags >actual &&
 	test_cmp expected actual
 '
@@ -134,10 +134,8 @@ not-a-file
 
 test_expect_success 'git rev-parse --flags --all -> list of revs' \
 '
-	cat >expected <<-EOF &&
-commit
-	EOF
-	git cat-file -t $(git rev-parse --flags --all | head -1) >actual &&
+	printf "%s\n" "--all" >expected &&
+	git rev-parse --flags --all >actual &&
 	test_cmp expected actual
 '
 
-- 
1.7.3.3.g9129b6
