From: Johan Herland <johan@herland.net>
Subject: [PATCHv4 5/6] Allow specifying --dirstat cut-off percentage as a floating point number
Date: Wed, 27 Apr 2011 12:29:25 +0200
Message-ID: <201104271229.25478.johan@herland.net>
References: <1303870359-26083-1-git-send-email-johan@herland.net> <1303892653-3958-6-git-send-email-johan@herland.net> <BANLkTi=xJXFKwzu4cCZAW_T2dXQ8wOq70w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Apr 27 12:31:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF21l-0005UD-CX
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 12:31:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237Ab1D0KaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 06:30:23 -0400
Received: from smtp.opera.com ([213.236.208.81]:41426 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754522Ab1D0KaU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 06:30:20 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p3RATPbD028302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 27 Apr 2011 10:29:27 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <BANLkTi=xJXFKwzu4cCZAW_T2dXQ8wOq70w@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172214>

Only the first digit after the decimal point is kept, as the dirstat
calculations all happen in permille.

Selftests verifying floating-point percentage input has been added.

Improved-by: Junio C Hamano <gitster@pobox.com>
Improved-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Johan Herland <johan@herland.net>
---

On Wednesday 27 April 2011, Linus Torvalds wrote:
> On Wed, Apr 27, 2011 at 1:24 AM, Johan Herland <johan@herland.net> wrote:
> > +                       options->dirstat_permille = strtoul(p, &end, 10) * 10;
> > +                       p = end;
> > +                       if (*p == '.' && isdigit(*(++p))) {
> > +                               int permille = strtoul(p, &end, 10);
> > +                               p = end;
> > +                               while (permille >= 10)
> > +                                       permille /= 10; /* only use first digit */
> > +                               options->dirstat_permille += permille;
> > +                       }
>
> Heh. That's both unnecessarily complicated, and doesn't work.
>
> It gets the wrong answer for something like "0.0001", since
> 'permille' in that case ends up starting out as '0001', ie just 1, so
> you never actually do that whole while-loop.

*facepalm* Of course. That'll teach me not to code before breakfast...

> So the right approach is just something like
>
>   if (*p == '.' && isdigit(*++p)) {
>     /* only use first digit */
>     options->dirstat_permille += *p - '0';
>     /* .. and ignore any further digits */
>     while (isdigit(*++p))
>       /* nothing */;
>   }
>
> (totally untested, of course)

Here it is, tested and everything. :)


Thanks! :)

...Johan

 diff.c                  |   26 +++++++++++-------
 diff.h                  |    2 +-
 t/t4046-diff-dirstat.sh |   64 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index 1b6e8c0..2cd815c 100644
--- a/diff.c
+++ b/diff.c
@@ -31,7 +31,7 @@ static const char *external_diff_cmd_cfg;
 int diff_auto_refresh_index = 1;
 static int diff_mnemonic_prefix;
 static int diff_no_prefix;
-static int diff_dirstat_percent_default = 3;
+static int diff_dirstat_permille_default = 30;
 static struct diff_options default_diff_options;
 
 static char diff_colors[][COLOR_MAXLEN] = {
@@ -95,8 +95,15 @@ static void parse_dirstat_params(struct diff_options *options, const char *param
 		}
 		else if (isdigit(*p)) {
 			char *end;
-			options->dirstat_percent = strtoul(p, &end, 10);
+			options->dirstat_permille = strtoul(p, &end, 10) * 10;
 			p = end;
+			if (*p == '.' && isdigit(*++p)) {
+				/* only use first digit */
+				options->dirstat_permille += *p - '0';
+				/* .. and ignore any further digits */
+				while (isdigit(*++p))
+					/* nothing */;
+			}
 		}
 		else
 			die("Unknown --dirstat parameter '%s'", p);
@@ -190,9 +197,9 @@ int git_diff_basic_config(const char *var, const char *value, void *cb)
 	}
 
 	if (!strcmp(var, "diff.dirstat")) {
-		default_diff_options.dirstat_percent = diff_dirstat_percent_default;
+		default_diff_options.dirstat_permille = diff_dirstat_permille_default;
 		parse_dirstat_params(&default_diff_options, value);
-		diff_dirstat_percent_default = default_diff_options.dirstat_percent;
+		diff_dirstat_permille_default = default_diff_options.dirstat_permille;
 		return 0;
 	}
 
@@ -1504,7 +1511,7 @@ struct dirstat_file {
 
 struct dirstat_dir {
 	struct dirstat_file *files;
-	int alloc, nr, percent, cumulative;
+	int alloc, nr, permille, cumulative;
 };
 
 static long gather_dirstat(struct diff_options *opt, struct dirstat_dir *dir,
@@ -1553,10 +1560,9 @@ static long gather_dirstat(struct diff_options *opt, struct dirstat_dir *dir,
 	if (baselen && sources != 1) {
 		if (this_dir) {
 			int permille = this_dir * 1000 / changed;
-			int percent = permille / 10;
-			if (percent >= dir->percent) {
+			if (permille >= dir->permille) {
 				fprintf(opt->file, "%s%4d.%01d%% %.*s\n", line_prefix,
-					percent, permille % 10, baselen, base);
+					permille / 10, permille % 10, baselen, base);
 				if (!dir->cumulative)
 					return 0;
 			}
@@ -1582,7 +1588,7 @@ static void show_dirstat(struct diff_options *options)
 	dir.files = NULL;
 	dir.alloc = 0;
 	dir.nr = 0;
-	dir.percent = options->dirstat_percent;
+	dir.permille = options->dirstat_permille;
 	dir.cumulative = DIFF_OPT_TST(options, DIRSTAT_CUMULATIVE);
 
 	changed = 0;
@@ -2937,7 +2943,7 @@ void diff_setup(struct diff_options *options)
 	options->line_termination = '\n';
 	options->break_opt = -1;
 	options->rename_limit = -1;
-	options->dirstat_percent = diff_dirstat_percent_default;
+	options->dirstat_permille = diff_dirstat_permille_default;
 	options->context = 3;
 
 	options->change = diff_change;
diff --git a/diff.h b/diff.h
index 0083d92..08b4fe0 100644
--- a/diff.h
+++ b/diff.h
@@ -111,7 +111,7 @@ struct diff_options {
 	int rename_score;
 	int rename_limit;
 	int warn_on_too_large_rename;
-	int dirstat_percent;
+	int dirstat_permille;
 	int setup;
 	int abbrev;
 	const char *prefix;
diff --git a/t/t4046-diff-dirstat.sh b/t/t4046-diff-dirstat.sh
index fa1885c..b3062b4 100755
--- a/t/t4046-diff-dirstat.sh
+++ b/t/t4046-diff-dirstat.sh
@@ -768,4 +768,68 @@ test_expect_success 'diff.dirstat=10,cumulative,files' '
 	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
 '
 
+cat <<EOF >expect_diff_dirstat
+  27.2% dst/copy/
+  27.2% dst/move/
+  54.5% dst/
+  27.2% src/move/
+EOF
+
+cat <<EOF >expect_diff_dirstat_M
+  42.8% dst/copy/
+  28.5% dst/move/
+  71.4% dst/
+EOF
+
+cat <<EOF >expect_diff_dirstat_CC
+  33.3% dst/copy/
+  33.3% dst/move/
+  66.6% dst/
+EOF
+
+test_expect_success '--dirstat=files,cumulative,16.7' '
+	git diff --dirstat=files,cumulative,16.7 HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git diff --dirstat=files,cumulative,16.7 -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git diff --dirstat=files,cumulative,16.7 -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
+test_expect_success 'diff.dirstat=16.7,cumulative,files' '
+	git -c diff.dirstat=16.7,cumulative,files diff --dirstat HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git -c diff.dirstat=16.7,cumulative,files diff --dirstat -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git -c diff.dirstat=16.7,cumulative,files diff --dirstat -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
+test_expect_success 'diff.dirstat=16.70,cumulative,files' '
+	git -c diff.dirstat=16.70,cumulative,files diff --dirstat HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git -c diff.dirstat=16.70,cumulative,files diff --dirstat -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git -c diff.dirstat=16.70,cumulative,files diff --dirstat -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
+test_expect_success '--dirstat=files,cumulative,27.2' '
+	git diff --dirstat=files,cumulative,27.2 HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git diff --dirstat=files,cumulative,27.2 -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git diff --dirstat=files,cumulative,27.2 -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
+test_expect_success '--dirstat=files,cumulative,27.09' '
+	git diff --dirstat=files,cumulative,27.09 HEAD^..HEAD >actual_diff_dirstat &&
+	test_cmp expect_diff_dirstat actual_diff_dirstat &&
+	git diff --dirstat=files,cumulative,27.09 -M HEAD^..HEAD >actual_diff_dirstat_M &&
+	test_cmp expect_diff_dirstat_M actual_diff_dirstat_M &&
+	git diff --dirstat=files,cumulative,27.09 -C -C HEAD^..HEAD >actual_diff_dirstat_CC &&
+	test_cmp expect_diff_dirstat_CC actual_diff_dirstat_CC
+'
+
 test_done
-- 
1.7.5.rc1
