From: Nicolas Vigier <boklm@mars-attacks.org>
Subject: [PATCH] rev-parse --parseopt: fix handling of optional arguments
Date: Tue, 15 Oct 2013 14:00:25 +0200
Message-ID: <1381838425-18244-1-git-send-email-boklm@mars-attacks.org>
Cc: Pierre Habouzit <madcoder@debian.org>,
	Nicolas Vigier <boklm@mars-attacks.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 15 14:01:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VW3JI-000673-SY
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 14:01:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759201Ab3JOMBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 08:01:07 -0400
Received: from mx0.mars-attacks.org ([92.243.25.60]:36032 "EHLO
	mx0.mars-attacks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758584Ab3JOMBE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 08:01:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by mx0.mars-attacks.org (Postfix) with ESMTP id 1F14A4E65;
	Tue, 15 Oct 2013 14:01:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mars-attacks.org
Received: from mx0.mars-attacks.org ([127.0.0.1])
	by localhost (mx0.mars-attacks.org [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Wx32KqgwuUlt; Tue, 15 Oct 2013 14:01:16 +0200 (CEST)
Received: from wxy.mars-attacks.org (moow.mars-attacks.org [82.242.116.57])
	by mx0.mars-attacks.org (Postfix) with ESMTPS id 7EC0E3ECC;
	Tue, 15 Oct 2013 14:01:16 +0200 (CEST)
Received: by wxy.mars-attacks.org (Postfix, from userid 500)
	id 2805243920; Tue, 15 Oct 2013 14:01:02 +0200 (CEST)
X-Mailer: git-send-email 1.8.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236178>

git rev-parse --parseopt does not allow us to see the difference
between an option with an optional argument starting with a dash, and an
option with an unset optional argument followed by an other option.

If I use this script :

  $ cat /tmp/opt.sh
  #!/bin/sh
  OPTIONS_SPEC="\
  git [options]
  --
  q,quiet         be quiet
  S,gpg-sign?     GPG-sign commit"
  echo "$OPTIONS_SPEC" | git rev-parse --parseopt $parseopt_extra -- "$@"

Then the following two commands give us the same result :

  $ /tmp/opt.sh -S -q
  set -- -S -q --
  $ /tmp/opt.sh -S-q
  set -- -S '-q' --

We cannot know if '-q' is an argument to '-S' or a new option.

With this patch, rev-parse --parseopt will always give an argument to
optional options, as an empty string if the argument is unset.

The same two commands now give us :

  $ /tmp/opt.sh -S -q
  set -- -S '' -q --
  $ /tmp/opt.sh -S-q
  set -- -S '-q' --

We can now see if '-q' is an argument to '-S' or an other option.

Also adding two tests in t1502.

There does not seem to be any shell script git command included in git
sources tree that is currently using optional arguments and could be
affected by this change.

Signed-off-by: Nicolas Vigier <boklm@mars-attacks.org>
---
 builtin/rev-parse.c           |  3 +++
 t/t1502-rev-parse-parseopt.sh | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index de894c7..25e8c74 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -327,6 +327,9 @@ static int parseopt_dump(const struct option *o, const char *arg, int unset)
 	if (arg) {
 		strbuf_addch(parsed, ' ');
 		sq_quote_buf(parsed, arg);
+	} else if (o->flags & PARSE_OPT_OPTARG) {
+		const char empty_arg[] = " ''";
+		strbuf_add(parsed, empty_arg, strlen(empty_arg));
 	}
 	return 0;
 }
diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index 13c88c9..abe7c2f 100755
--- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -99,4 +99,22 @@ test_expect_success 'test --parseopt --keep-dashdash --stop-at-non-option withou
 	test_cmp expect output
 '
 
+cat > expect <<EOF
+set -- -C '' --foo --
+EOF
+
+test_expect_success 'test --parseopt -C --foo' '
+	git rev-parse --parseopt -- -C --foo <optionspec >output &&
+	test_cmp expect output
+'
+
+cat > expect <<EOF
+set -- -C '--foo' --
+EOF
+
+test_expect_success 'test --parseopt -C--foo' '
+	git rev-parse --parseopt -- -C--foo <optionspec >output &&
+	test_cmp expect output
+'
+
 test_done
-- 
1.8.4
