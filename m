From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v8 1/2] parse-options.c: make OPTION__COUNTUP consider
 negative values
Date: Fri, 18 Mar 2016 21:19:10 +0000
Message-ID: <010201538b98a7e5-ee604368-5a27-4884-b01e-027fa02bf1c6-000000@eu-west-1.amazonses.com>
References: <010201537710be08-f31428b3-5df3-4694-8c4a-0e8f058131b3-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 18 22:38:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah26K-0002cm-CO
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 22:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757238AbcCRVi3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 17:38:29 -0400
Received: from a6-245.smtp-out.eu-west-1.amazonses.com ([54.240.6.245]:45006
	"EHLO a6-245.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754088AbcCRVi2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Mar 2016 17:38:28 -0400
X-Greylist: delayed 1154 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Mar 2016 17:38:27 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1458335950;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=bN3g+wf15nCJS74H5B2nMzGIDQnMjVaBV6mWu5EtlQU=;
	b=KcjaAVq8/gcbZfN1qgOfFgWXINL0lwAND74ZKvc9CH62A8fHK2hdA2IF8nPlNcN0
	b0aGa4CInKQpckMFnkNHZ+m4J8IgXh9NXoXjgiuckIqF59IwNQvnRjGuxuBZhXM6iph
	ZwZXVbbt2Jnr+SkzhgoOXN9LcNi6+/RZkdO4xl+A=
In-Reply-To: <010201537710be08-f31428b3-5df3-4694-8c4a-0e8f058131b3-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.03.18-54.240.6.245
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289255>

The reason to make it consider negative values or more specifically
"unspecified" values is to give the ability to differentiate between
once, multiple time or with --no-option.

Eg. :
initialize verbose = -1
`git commit` => verbose = -1
`git commit -v` => verbose = 1
`git commit -v -v` => verbose = 2
`git commit --no-verbose` => verbose = 0

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

---
The discussion about this patch:
[1] : http://thread.gmane.org/gmane.comp.version-control.git/289027

Previous version of the patch:
[v1] : http://thread.gmane.org/gmane.comp.version-control.git/289061

Changes introduced:
Use a different language in commit message to make the change and its
utility more clear.
---
 Documentation/technical/api-parse-options.txt | 6 ++++--
 parse-options.c                               | 8 +++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 5f0757d..a908d8a 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -144,8 +144,10 @@ There are some macros to easily define options:
 
 `OPT_COUNTUP(short, long, &int_var, description)`::
 	Introduce a count-up option.
-	`int_var` is incremented on each use of `--option`, and
-	reset to zero with `--no-option`.
+	If the `int_var` is negative and `--option` is absent,
+	then it will retain its value. Otherwise it will first set
+	`int_var` to 0 and then increment it on each use of `--option`,
+	and reset to zero with `--no-option`.
 
 `OPT_BIT(short, long, &int_var, description, mask)`::
 	Introduce a boolean option.
diff --git a/parse-options.c b/parse-options.c
index 47a9192..86d30bd 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -110,7 +110,13 @@ static int get_value(struct parse_opt_ctx_t *p,
 		return 0;
 
 	case OPTION_COUNTUP:
-		*(int *)opt->value = unset ? 0 : *(int *)opt->value + 1;
+		if (unset)
+			*(int *)opt->value = 0;
+		else {
+			if (*(int *)opt->value < 0)
+				*(int *)opt->value = 0;
+			*(int *)opt->value += 1;
+		}
 		return 0;
 
 	case OPTION_SET_INT:

--
https://github.com/git/git/pull/213
