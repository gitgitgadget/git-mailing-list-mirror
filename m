From: Milton Soares Filho <milton.soares.filho@gmail.com>
Subject: [PATCH] graph.c: visual difference on subsequent series
Date: Fri, 25 Oct 2013 14:07:48 -0200
Message-ID: <1382717268-21884-1-git-send-email-milton.soares.filho@gmail.com>
Cc: Milton Soares Filho <milton.soares.filho@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 25 18:08:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZjvq-0000LF-Dp
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 18:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754720Ab3JYQIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 12:08:06 -0400
Received: from mail-qa0-f44.google.com ([209.85.216.44]:45678 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662Ab3JYQIE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 12:08:04 -0400
Received: by mail-qa0-f44.google.com with SMTP id cm18so679371qab.10
        for <git@vger.kernel.org>; Fri, 25 Oct 2013 09:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ZYPy5UUAQiLX7aAXiro4HNtz5c/IJE8UP2BXoDlyxVE=;
        b=oOC/66e+7ofZBSxmJxide2Aqr6rLsMr4JFOKr8YHz7RRmNMy2ofzc12vv2gGixXrbj
         3YJuj45F+yNZ1h1K6FMAsm0Fga4Dzq3S4X14V8AsX75Gc/lrd7VSdbALRII7S5qX4DrN
         4pauBEeWeeJ9cQuZdn5huZpcfOJLUpsCHBApmqDr/DZwupElFmpm+pK8KYKHqUyBnuES
         P5WXrpWnLEXnoqE1Vr1YHLL8hb2jd2Y+Vr8vHv5LVQF7RWfu/CjRGTkD7q6MLusbAEHA
         HHX7O9ZnZ6OEfOjRk2HzZ1K3C2H0udj9r7tbvC2zlpVKrefDlGr9fjIDy51ji9l7l81m
         TMGw==
X-Received: by 10.224.114.196 with SMTP id f4mr2404752qaq.96.1382717284098;
        Fri, 25 Oct 2013 09:08:04 -0700 (PDT)
Received: from localhost.localdomain ([186.212.83.148])
        by mx.google.com with ESMTPSA id a9sm14616683qed.6.2013.10.25.09.08.02
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 25 Oct 2013 09:08:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.1.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236708>

For projects with separate history lines and, thus, multiple root-commits, the
linear arrangement of `git log --graph --oneline` does not allow the user to
spot where the sequence ends, giving the impression that it's a contiguous
history. E.g.

History sequence A: a1 -- a2 -- a3 (root-commit)
History sequence B: b1 -- b2 -- b3 (root-commit)

    git log --graph --oneline
    * a1
    * a2
    * a3
    * b1
    * b2
    * b3

In a GUI tool, the root-commit of each series would stand out on the graph.

This modification changes the commit char to a different symbol ('x'), so users
of the command-line graph tool can easily identify root-commits and make sense
of where each series is limited to.

    git log --graph --oneline
    * a1
    * a2
    x a3
    * b1
    * b2
    x b3

Signed-off-by: Milton Soares Filho <milton.soares.filho@gmail.com>
---
 graph.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/graph.c b/graph.c
index b24d04c..ec8e960 100644
--- a/graph.c
+++ b/graph.c
@@ -780,6 +780,15 @@ static void graph_output_commit_char(struct git_graph *graph, struct strbuf *sb)
 	}
 
 	/*
+	 * Out-stand parentless commits to enforce non-continuity on subsequent
+	 * but separate series
+	 */
+	if (graph->commit->parents == NULL) {
+		strbuf_addch(sb, 'x');
+		return;
+	}
+
+	/*
 	 * get_revision_mark() handles all other cases without assert()
 	 */
 	strbuf_addstr(sb, get_revision_mark(graph->revs, graph->commit));
-- 
1.8.1.2
