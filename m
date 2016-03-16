From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH/RFC] parse-options.c: make OPTION__COUNTUP consider negative
 values
Date: Wed, 16 Mar 2016 23:16:58 +0000
Message-ID: <0102015381b7c7b5-5b57a780-369b-478b-94d2-7094f0befdad-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 17 00:37:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agL0g-0005lm-Lz
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 00:37:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591AbcCPXhq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 19:37:46 -0400
Received: from a6-243.smtp-out.eu-west-1.amazonses.com ([54.240.6.243]:46842
	"EHLO a6-243.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752552AbcCPXhp (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2016 19:37:45 -0400
X-Greylist: delayed 1245 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Mar 2016 19:37:45 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1458170218;
	h=From:To:Message-ID:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=1M3M9g5uQwqOnoyQ0dLhBM3S1r3GoxHhvstqtwLFEBM=;
	b=FsI0ZC47iOKSQf/F4DYMD7nHRrkCh6+LrKviSZFP6Ofda6ZoBjZMhV6+bGOlJro2
	FT2Wnl1EeSN3jz85Z8qKHXslbG7Taj4lGEuTGek3mFcJWqVywjecwUIYX9AMZopfdKC
	Rvw1Uk1Ndo+qn0fYMw6PFOft+pDyBpjzeyQzI3dY=
X-SES-Outgoing: 2016.03.16-54.240.6.243
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289061>

The reason to make it consider negative values or more specifically
"unspecified" values is to differentiate between the option passed
once, multiple times or with --no-option. This makes the receiver
know what actually happened with the arguments which is particularly
required with option have multiple levels of that option.

Eg. :
initialize verbose = -1
`git commit` => verbose = -1
`git commit -v` => verbose = 1
`git commit -v -v` => verbose = 1
`git commit --no-verbose` => verbose = 0

Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

---
The discussion on the mailing list[1] suggested this approach.
I plan to include this with my previous patch regarding "configuration
for commonly used command `git commit -v`" as this is a requirement for
latter.

[1] : http://thread.gmane.org/gmane.comp.version-control.git/289027
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
https://github.com/git/git/pull/212
