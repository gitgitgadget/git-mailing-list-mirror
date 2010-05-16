From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/7] grep: --count over binary
Date: Sun, 16 May 2010 19:45:39 +0200
Message-ID: <4BF02F43.7020204@lsrfire.ath.cx>
References: <4BEC6211.2000309@lsrfire.ath.cx> <4BEC62F6.9050602@lsrfire.ath.cx> <20100514093424.GA6212@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Phil Lawrence <prlawrence@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 16 19:45:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODhuS-0000e6-Mf
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 19:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754344Ab0EPRps convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 May 2010 13:45:48 -0400
Received: from india601.server4you.de ([85.25.151.105]:55715 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124Ab0EPRpr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 May 2010 13:45:47 -0400
Received: from [10.0.1.100] (p57B7E290.dip.t-dialin.net [87.183.226.144])
	by india601.server4you.de (Postfix) with ESMTPSA id 068ED2F8043;
	Sun, 16 May 2010 19:45:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <20100514093424.GA6212@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147198>

Am 14.05.2010 11:34, schrieb Dmitry Potapov:
> On Thu, May 13, 2010 at 10:37:10PM +0200, Ren=E9 Scharfe wrote:
>> The intent of showing the message "Binary file xyz matches" for
>> binary files is to avoid annoying users by potentially messing up
>> their terminals by printing control characters.  In --count mode,
>> this precaution isn't necessary.
>>
>> Display counts of matches if -c/--count was specified, even if -a
>> was not given.  GNU grep does the same.
>=20
> It is also not necessary with '-l' and '-L' options. (At least, if
> we follow GNU grep).

Good point.  The same is true for -q, too.  ->unmatch_name_only (-L)
and ->status_only (-q) are already handled correctly because they are
checked before binary_match_only.  We can do the same for ->name_only.

-- >8 --
Subject: grep: --name-only over binary

As with the option -c/--count, git grep with the option -l/--name-only
should work the same with binary files as with text files because
there is no danger of messing up the terminal with control characters
from the contents of matching files.  GNU grep does the same.

Move the check for ->name_only before the one for binary_match_only,
thus making the latter irrelevant for git grep -l.  Also add a simple
test for each of -l, -L and -q.  The latter two options were already
handled before binary_match_only, so no code changes were needed to
make them pass.

Reported-by: Dmitry Potapov <dpotapov@gmail.com>
Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 grep.c                 |    8 ++++----
 t/t7008-grep-binary.sh |   18 ++++++++++++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/grep.c b/grep.c
index 2b2f70e..f292e25 100644
--- a/grep.c
+++ b/grep.c
@@ -885,6 +885,10 @@ static int grep_buffer_1(struct grep_opt *opt, con=
st char *name,
 			count++;
 			if (opt->status_only)
 				return 1;
+			if (opt->name_only) {
+				show_name(opt, name);
+				return 1;
+			}
 			if (binary_match_only) {
 				opt->output(opt, "Binary file ", 12);
 				output_color(opt, name, strlen(name),
@@ -892,10 +896,6 @@ static int grep_buffer_1(struct grep_opt *opt, con=
st char *name,
 				opt->output(opt, " matches\n", 9);
 				return 1;
 			}
-			if (opt->name_only) {
-				show_name(opt, name);
-				return 1;
-			}
 			/* Hit at this line.  If we haven't shown the
 			 * pre-context lines, we would need to show them.
 			 * When asked to do "count", this still show
diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index d8fde18..4f5e74f 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -33,6 +33,24 @@ test_expect_success 'git grep -c ina a' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'git grep -l ina a' '
+	echo a >expect &&
+	git grep -l ina a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git grep -L bar a' '
+	echo a >expect &&
+	git grep -L bar a >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git grep -q ina a' '
+	: >expect &&
+	git grep -q ina a >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git grep -F ile a' '
 	git grep -F ile a
 '
--=20
1.7.1
