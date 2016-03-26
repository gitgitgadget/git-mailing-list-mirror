From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH v10 1/3] parse-options.c: make OPTION__COUNTUP understand
 "unspecified" values
Date: Sat, 26 Mar 2016 19:48:49 +0000
Message-ID: <01020153b478cf07-758c7f14-33a1-4a67-9bc9-4688de3d6742-000000@eu-west-1.amazonses.com>
References: <01020153a7ba4e07-f326395b-63df-4f8a-b378-8f387b02d0bd-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 26 21:10:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajuX7-0007x4-DA
	for gcvg-git-2@plane.gmane.org; Sat, 26 Mar 2016 21:10:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072AbcCZUKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2016 16:10:00 -0400
Received: from a6-245.smtp-out.eu-west-1.amazonses.com ([54.240.6.245]:46321
	"EHLO a6-245.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753921AbcCZUJ7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Mar 2016 16:09:59 -0400
X-Greylist: delayed 1251 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Mar 2016 16:09:42 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1459021729;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=ACyLmOsxhOWUy1ZatpRWP+Tcw+9/lCqf/GyRYtSAjv8=;
	b=WSwM2P6/RbmpimfnkRNiwRxrPvlJ0qqS72sSeXWc0g1m/MyKWNqjGYGqJOljt6DK
	UQnhMh0vC9ukPVx9rjnV449kfmjoykPCPqnYvnJAaiQfA3RYu9bGZL3XfGPuLVgtwdm
	Y/NwEsEz8okZqPdoaxBD+pZ/ny7CjCQR66wh7/58=
In-Reply-To: <01020153a7ba4e07-f326395b-63df-4f8a-b378-8f387b02d0bd-000000@eu-west-1.amazonses.com>
X-SES-Outgoing: 2016.03.26-54.240.6.245
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289988>

The reason to make it understand negative values or more specifically
"unspecified" values is to give the ability to differentiate whether
`--option` or `--no-option` was specified at all.

Many uses of COUNTUP have now been replaced with BOOL and what remains
are verbose/quiet/force. This change will not affect existing users of
COUNTUP at all, as long as they use the initial value of 0 (or more), as
there is no mechanism to decrement. The only thing the command line can
do is to reset it to zero with "--no-foo".

Verbose or quiet don't use negative values before this commit but force
uses it in a different way to handle its config and then munges the "-1"
into 0 before we get to parse_options.

There are uses of COUNTUP in cmd_hash_object() and test-parse-options.c
and they are both fine.

Helped-by: Jeff King <peff@peff.net>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>

---
The discussion about this patch:
[1] : http://thread.gmane.org/gmane.comp.version-control.git/289027

Previous version of the patch:
[v1] : http://thread.gmane.org/gmane.comp.version-control.git/289061

Changes introduced:
Use a different language in commit message to make the change and its
utility more clear. Also added some points as to where this patch could
break but it doesn't.
---
 Documentation/technical/api-parse-options.txt | 8 ++++++--
 parse-options.c                               | 8 +++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 5f0757d..8908bf7 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -144,8 +144,12 @@ There are some macros to easily define options:
 
 `OPT_COUNTUP(short, long, &int_var, description)`::
 	Introduce a count-up option.
-	`int_var` is incremented on each use of `--option`, and
-	reset to zero with `--no-option`.
+	Each use of `--option` increments `int_var`, starting from zero
+	(even if initially negative), and `--no-option` resets it to
+	zero. To determine if `--option` or `--no-option` was set at
+	all, set `int_var` to a negative value, and if it is still
+	negative after parse_options(), then neither `--option` nor
+	`--no-option` was seen.
 
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
https://github.com/git/git/pull/218
