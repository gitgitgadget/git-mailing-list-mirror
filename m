From: John Keeping <john@keeping.me.uk>
Subject: [RFC] test_when_finished in subshells
Date: Fri,  4 Sep 2015 18:58:45 +0100
Message-ID: <54923cf9cc5a66bf9034051b3c2f930fa7ef88a4.1441388803.git.john@keeping.me.uk>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 04 19:58:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXvGF-0001xs-Jx
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 19:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759426AbbIDR6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 13:58:47 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:58648 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601AbbIDR6q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 13:58:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 266A9CDA5BB;
	Fri,  4 Sep 2015 18:58:46 +0100 (BST)
X-Quarantine-ID: <07zMh7SWTJiA>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 07zMh7SWTJiA; Fri,  4 Sep 2015 18:58:45 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 4BA41CDA605;
	Fri,  4 Sep 2015 18:58:34 +0100 (BST)
X-Mailer: git-send-email 2.5.0.466.g9af26fa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277323>

A recent thread [0] made me realise that using test_when_finished in a
subshell is likely to be a bug, since the change to $test_cleanup will
be lost when the subshell exits.

There is no POSIX way to detect that we are in a subshell ($$ and $PPID
are specified to remain unchanged), but we can detect it on Bash and
gracefully fall back to disabling the test on other shells, which is
what the patch below does.

There are three tests currently in master that fail with this patch (at
least on my system):

	Test Summary Report
	-------------------
	t7610-mergetool.sh                               (Wstat: 256 Tests: 18 Failed: 1)
	  Failed test:  7
	  Non-zero exit status: 1
	t7800-difftool.sh                                (Wstat: 256 Tests: 56 Failed: 1)
	  Failed test:  56
	  Non-zero exit status: 1
	t5801-remote-helpers.sh                          (Wstat: 256 Tests: 30 Failed: 1)
	  Failed test:  27
	  Non-zero exit status: 1

All are harmless at the moment and t7610 and t5801 can be fixed by
moving the test_when_finished call out of the subshell relatively
easily.

t7800 (in its final test) calls test_config in a subshell which has cd'd
into a submodule.

Is this something worth worrying about, or is it sufficiently rare that
we can live with the current behaviour?

[0] http://article.gmane.org/gmane.comp.version-control.git/277199

-- >8 --
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index e8d3c0f..d29cd7b 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -722,6 +722,8 @@ test_seq () {
 # what went wrong.
 
 test_when_finished () {
+	test "${BASH_SUBSHELL-0}" = 0 ||
+	error "bug in test script: test_when_finished does nothing in a subshell"
 	test_cleanup="{ $*
 		} && (exit \"\$eval_ret\"); eval_ret=\$?; $test_cleanup"
 }
-- 
2.5.0.466.g9af26fa
