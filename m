From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 3/3] config: add '--show-origin' option to print the
 origin of a config value
Date: Tue, 16 Feb 2016 22:14:45 +0000
Message-ID: <56C39F55.1090903@ramsayjones.plus.com>
References: <1455531466-16617-1-git-send-email-larsxschneider@gmail.com>
 <1455531466-16617-4-git-send-email-larsxschneider@gmail.com>
 <56C244D7.1030503@ramsayjones.plus.com>
 <20160215214049.GA10094@sigill.intra.peff.net>
 <56C253B8.1070702@ramsayjones.plus.com>
 <51832840-B879-4650-9DC5-E15EAA9919B9@gmail.com>
 <56C3524F.3000504@ramsayjones.plus.com>
 <20160216173853.GA15026@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
	sschuberth@gmail.com, sunshine@sunshineco.com, hvoigt@hvoigt.net,
	sbeller@google.com, Johannes.Schindelin@gmx.de, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 23:15:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVntb-0005Oe-5C
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 23:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119AbcBPWOz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 17:14:55 -0500
Received: from avasout07.plus.net ([84.93.230.235]:54758 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755729AbcBPWOy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 17:14:54 -0500
Received: from [10.0.2.15] ([46.208.159.221])
	by avasout07 with smtp
	id KAEr1s0094mu3xa01AEsG1; Tue, 16 Feb 2016 22:14:53 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=Sp5fw55EgyGSOjouSGNDoQ==:117 a=Sp5fw55EgyGSOjouSGNDoQ==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=IkcTkHD0fZMA:10
 a=EBOSESyhAAAA:8 a=cn08owIDLzxxboPl40YA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <20160216173853.GA15026@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286442>



On 16/02/16 17:38, Jeff King wrote:
> On Tue, Feb 16, 2016 at 04:46:07PM +0000, Ramsay Jones wrote:
> 
>>> OK, I am happy to add the extra code. 
>>
>> Unless I've missed something (quite possible), this patch does not
>> need to change. (you have (both) convinced me that your current
>> solution is the best).
>>
>> The only change that I would suggest is the one-liner I already
>> suggested to the previous patch (plus the one-liner in the test,
>> of course. err ... so the two-liner!). Having said that, I didn't
>> try it out - I was just typing into my email client, so ...
> 
> I think it's more than that one-liner. This patch shows "type:name"
> verbatim from what is passed into do_config_from_file, as does the error
> message. If they are going to have different output formats (e.g.,
> "<stdin>" versus "stdin"), there needs to be logic transforming them in
> at least one of the spots.

Ugh, yes you are right.

Hmm, I just hacked something up (see below) and, since its a bit
ugly, I'm now in two minds! (it could be improved, of course). ;-)

So, I'll leave it to yourself and Lars to decide.

ATB,
Ramsay Jones

-- >8 --
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Date: Tue, 16 Feb 2016 21:39:47 +0000
Subject: [PATCH] config: fixup '<stdin>' error messages

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 config.c               | 22 ++++++++++++++++++----
 t/t1300-repo-config.sh |  2 +-
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/config.c b/config.c
index 0a35323..adc808c 100644
--- a/config.c
+++ b/config.c
@@ -417,6 +417,8 @@ static int git_parse_source(config_fn_t fn, void *data)
 	int comment = 0;
 	int baselen = 0;
 	struct strbuf *var = &cf->var;
+	const char *cftype = cf->type;
+	const char *cfname = cf->name;
 
 	/* U+FEFF Byte Order Mark in UTF8 */
 	const char *bomptr = utf8_bom;
@@ -471,10 +473,14 @@ static int git_parse_source(config_fn_t fn, void *data)
 		if (get_value(fn, data, var) < 0)
 			break;
 	}
+	if (!strcmp(cftype, "stdin")) {
+		cftype = "file";
+		cfname = "<stdin>";
+	}
 	if (cf->die_on_error)
-		die(_("bad config line %d in %s %s"), cf->linenr, cf->type, cf->name);
+		die(_("bad config line %d in %s %s"), cf->linenr, cftype, cfname);
 	else
-		return error(_("bad config line %d in %s %s"), cf->linenr, cf->type, cf->name);
+		return error(_("bad config line %d in %s %s"), cf->linenr, cftype, cfname);
 }
 
 static int parse_unit_factor(const char *end, uintmax_t *val)
@@ -589,9 +595,17 @@ static void die_bad_number(const char *name, const char *value)
 	if (!value)
 		value = "";
 
-	if (cf && cf->type && cf->name)
+	if (cf && cf->type && cf->name) {
+		const char *cftype = cf->type;
+		const char *cfname = cf->name;
+
+		if (!strcmp(cftype, "stdin")) {
+			cftype = "file";
+			cfname = "<stdin>";
+		}
 		die(_("bad numeric config value '%s' for '%s' in %s %s: %s"),
-		    value, name, cf->type, cf->name, reason);
+		    value, name, cftype, cfname, reason);
+	}
 	die(_("bad numeric config value '%s' for '%s': %s"), value, name, reason);
 }
 
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 4abbdf9..4497688 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -707,7 +707,7 @@ test_expect_success 'invalid unit' '
 '
 
 test_expect_success 'invalid stdin config' '
-	echo "fatal: bad config line 1 in stdin " >expect &&
+	echo "fatal: bad config line 1 in file <stdin>" >expect &&
 	echo "[broken" | test_must_fail git config --list --file - >output 2>&1 &&
 	test_cmp expect output
 '
-- 
2.7.0
