From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: [PATCH 2/2] builtin-prune.c: fix object parsing and use parse_options()
Date: Mon, 24 Mar 2008 13:31:17 +0100
Message-ID: <200803241331.17986.barra_cuda@katamail.com>
References: <200803232150.29971.barra_cuda@katamail.com> <alpine.LSU.1.00.0803232319130.4353@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 13:21:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdlg6-0005In-2T
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 13:21:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754668AbYCXMUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 08:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754654AbYCXMUn
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 08:20:43 -0400
Received: from smtp.katamail.com ([62.149.157.154]:43315 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1753746AbYCXMUm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 08:20:42 -0400
Received: (qmail 11926 invoked by uid 89); 24 Mar 2008 12:17:06 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=RDNS_NONE autolearn=disabled
	version=3.2.3
Received: from unknown (HELO host45-56-static.104-80-b.business.telecomitalia.it) (barra?cuda@katamail.com@80.104.56.45)
  by smtp2-pc with SMTP; 24 Mar 2008 12:17:05 -0000
User-Agent: KMail/1.9.7
In-Reply-To: <alpine.LSU.1.00.0803232319130.4353@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78026>

On Sunday 23 March 2008, Johannes Schindelin wrote:
> On Sun, 23 Mar 2008, Michele Ballabio wrote:
> 
> > -static const char prune_usage[] = "git-prune [-n]";
> > +static const char * const prune_usage[] = {
> > +	"git-prune [-n] [--expire <time>] [--] [<head>...]",
> > +	NULL
> > +};
> 
> As you already use parse-options, should this not be rather
> 
> static const char * const prune_usage[] = {
> 	"git-prune [options] [--] [<commit>...]",
> 
> Hmm?

Ok, but the usage string is quite short anyway... and other commands
show a similar quite detailed usage string. Not that I care strongly
about this, though.

> > +static int parse_opt_expire(const struct option *opt, const char *arg,
> > +		int unset)
> > +{
> > +	expire = approxidate(arg);
> > +	return 0;
> > +}
> 
> This would probably be a good candidate to live in parse-options.[ch], no?

Uhm, probably, yes. See the patch below.

> But yes, the patch is good!

Thank you.

-- >8 --
parse-options.c: introduce callback function for approxidate()

There are quite a few places that will need to call approxidate(),
when they'll adopt the parse-options system, so this patch adds the
function parse_opt_approxidate_cb(), to be used within
OPT_CALLBACK, and converts the only user so far.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 builtin-prune.c |    9 +--------
 parse-options.c |    7 +++++++
 parse-options.h |    2 ++
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/builtin-prune.c b/builtin-prune.c
index 7b3e15d..a5d6fe5 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -125,13 +125,6 @@ static void remove_temporary_files(void)
 	closedir(dir);
 }
 
-static int parse_opt_expire(const struct option *opt, const char *arg,
-		int unset)
-{
-	expire = approxidate(arg);
-	return 0;
-}
-
 int cmd_prune(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
@@ -141,7 +134,7 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
 				"do not remove, show only"),
 		OPT_CALLBACK(0, "expire", &expire, "time",
 				"expire objects older than <time>",
-				parse_opt_expire),
+				parse_opt_approxidate_cb),
 		OPT_END()
 	};
 
diff --git a/parse-options.c b/parse-options.c
index 8e64316..6ec7fe8 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -409,3 +409,10 @@ int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
 	*(int *)(opt->value) = v;
 	return 0;
 }
+
+int parse_opt_approxidate_cb(const struct option *opt, const char *arg,
+		int unset)
+{
+	*(unsigned int *)(opt->value) = approxidate(arg);
+	return 0;
+}
diff --git a/parse-options.h b/parse-options.h
index 1af62b0..e6976ed 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -110,6 +110,8 @@ extern NORETURN void usage_with_options(const char * const *usagestr,
 
 /*----- some often used options -----*/
 extern int parse_opt_abbrev_cb(const struct option *, const char *, int);
+extern int parse_opt_approxidate_cb(const struct option *, const char *,
+		int);
 
 #define OPT__VERBOSE(var)  OPT_BOOLEAN('v', "verbose", (var), "be verbose")
 #define OPT__QUIET(var)    OPT_BOOLEAN('q', "quiet",   (var), "be quiet")
-- 
1.5.4.3
