From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] blame: improve diagnosis for "--reverse NEW"
Date: Tue, 14 Jun 2016 10:20:05 -0700
Message-ID: <xmqqtwgvadru.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 19:20:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCs0f-0006K7-Uz
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 19:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727AbcFNRUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 13:20:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56273 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751401AbcFNRUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 13:20:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 62F7E2480C;
	Tue, 14 Jun 2016 13:20:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=c
	+/73zKluJtVq5HA8v+DA/SKUWo=; b=D39wPHaI8Hb4oNlh59yosavhCaVsS+WWE
	4dLB1bm9uGDBb5XWz+yu4iwMrJz+a7UJ5Y6nGWowCEA9R/I793shyIoAzDwwTLhD
	LPlx/DSpybG5CUxskjjYYcSFQXVYs0uq9n52XuiUu5Z/U8hgk4VkKqThfEQkOnuK
	R0fDZ8s1VQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=g9s
	IUmOgOKagcDcoCzWFD9lyDreisZVhR4IedZOQC6V6e/Suj7FB6fdXrNhr88+9OS4
	qBf8rBLOYdYnmefAc3cCrZacXtyGXRng/1Qv3UbwrLNWUkV64KwTKec64Zqq+UGm
	V4xHePSnJp6tldISmlDNCphloAOKJeKfJm+KHCWM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C0812480A;
	Tue, 14 Jun 2016 13:20:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6CE2F24809;
	Tue, 14 Jun 2016 13:20:07 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3DA9BB26-3254-11E6-9246-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297310>

"git blame --reverse OLD..NEW -- PATH" tells us to start from the
contents in PATH at OLD and observe how each line is changed while
the history developers up to NEW, and report for each line the
latest commit up to which the line survives in the original form.

If you say "git blame --reverse NEW -- PATH" by mistake, we complain
about the missing OLD, but we phrased it as "No commit to dig down
to?"  In this case, however, we are digging up from OLD, so say so.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-blame.txt | 2 +-
 builtin/blame.c             | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index ba54175..16323eb 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
 	    [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
-	    [--progress] [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>]
+	    [--progress] [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>..<rev>]
 	    [--] <file>
 
 DESCRIPTION
diff --git a/builtin/blame.c b/builtin/blame.c
index 21f42b0..281f372 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2473,7 +2473,7 @@ static char *prepare_initial(struct scoreboard *sb)
 		final_commit_name = revs->pending.objects[i].name;
 	}
 	if (!final_commit_name)
-		die("No commit to dig down to?");
+		die("No commit to dig up from?");
 	return xstrdup(final_commit_name);
 }
 
-- 
2.9.0-290-g8794d48
