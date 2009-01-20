From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: [PATCH] diff: Support diff.color-words config option
Date: Mon, 19 Jan 2009 21:45:20 -0600
Message-ID: <200901192145.21115.bss@iguanasuicide.net>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901200031350.3586@pacific.mpi-cbg.de> <200901192017.54163.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Santi =?utf-8?q?B=C3=A9jar?= <santi@agolina.net>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <junio@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 20 04:46:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LP7Zm-0001wB-OY
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 04:46:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064AbZATDp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 22:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753722AbZATDp0
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 22:45:26 -0500
Received: from eastrmmtao105.cox.net ([68.230.240.47]:46877 "EHLO
	eastrmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950AbZATDpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 22:45:25 -0500
Received: from eastrmimpo01.cox.net ([68.1.16.119])
          by eastrmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090120034523.LCGO4139.eastrmmtao105.cox.net@eastrmimpo01.cox.net>;
          Mon, 19 Jan 2009 22:45:23 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo01.cox.net with bizsmtp
	id 5flM1b0082i4SyG02flNXs; Mon, 19 Jan 2009 22:45:23 -0500
X-Authority-Analysis: v=1.0 c=1 a=3QrhBsWpi_MA:10 a=hdysKSRg9uoA:10
 a=Fq1VQ0LPAAAA:8 a=iIiQs3FGN_yVk9y51I8A:9 a=wP91kG-iaO84DSqcG7YA:7
 a=n21FPWh6KRz9UyqPMPCd-YzBArUA:4 a=T3brmoaXcPoA:10 a=hpF-ijbX5cwA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LP7YH-000CBQ-8u; Mon, 19 Jan 2009 21:45:21 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <200901192017.54163.bss@iguanasuicide.net>
X-Eric-Conspiracy: There is no conspiracy
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106431>

When diff is invoked with --color-words (w/o =regex), use the regular
expression the user has configured as diff.color-words.

diff drivers configured via attributes take precedence over the
diff.color-words setting.  If the user wants to change them, they have
their own configuration variables.

Signed-off-by: Boyd Stephen Smith Jr <bss@iguanasuicide.net>
---
On Monday 19 January 2009, "Boyd Stephen Smith Jr." <bss@iguanasuicide.net> wrote about '[PATCH] Add 
tests for diff.color-words configuration option.':
>Yes, I also think I'll work on the actual implementation, but I'd be glad
>to have someone beat me to it.  I'm not sure why the diff is crazy long.

Here's a patch that makes the added test case succeed, but I think it and
the tests themselves should probably be reworked.  Hopefully, this doesn't
show up in quoted-printable format (damn you kmail).

While it might be a corner-case, we probably need a test of some sort for
when a user/system has a global diff.color-words configuration wants
to have a single repository (or single run of 'git diff') use the default
algorithm. I.e. run as if no regex had been set.

 diff.c                |    5 +++++
 t/t4034-diff-words.sh |    2 +-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/diff.c b/diff.c
index 9fcde96..c53e1d1 100644
--- a/diff.c
+++ b/diff.c
@@ -23,6 +23,7 @@ static int diff_detect_rename_default;
 static int diff_rename_limit_default = 200;
 static int diff_suppress_blank_empty;
 int diff_use_color_default = -1;
+static const char *diff_color_words_cfg = NULL;
 static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
@@ -92,6 +93,8 @@ int git_diff_ui_config(const char *var, const char *value, void *cb)
 	}
 	if (!strcmp(var, "diff.external"))
 		return git_config_string(&external_diff_cmd_cfg, var, value);
+	if (!strcmp(var, "diff.color-words"))
+		return git_config_string(&diff_color_words_cfg, var, value);
 
 	return git_diff_basic_config(var, value, cb);
 }
@@ -1550,6 +1553,8 @@ static void builtin_diff(const char *name_a,
 				o->word_regex = userdiff_word_regex(one);
 			if (!o->word_regex)
 				o->word_regex = userdiff_word_regex(two);
+			if (!o->word_regex)
+				o->word_regex = diff_color_words_cfg;
 			if (o->word_regex) {
 				ecbdata.diff_words->word_regex = (regex_t *)
 					xmalloc(sizeof(regex_t));
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 6ebce9d..a207d9e 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -105,7 +105,7 @@ a = b + c<RESET>
 EOF
 cp expect.non-whitespace-is-word expect
 
-test_expect_failure 'use default supplied by config' '
+test_expect_success 'use default supplied by config' '
 
 	word_diff --color-words
 
-- 
1.5.6.5
-- 
Boyd Stephen Smith Jr.                     ,= ,-_-. =. 
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-' 
http://iguanasuicide.net/                      \_/     
