From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 02/10 v2] parse-options: clearer reporting of API misuse
Date: Thu, 2 Dec 2010 00:01:18 -0600
Message-ID: <20101202060118.GB32125@burratino>
References: <20101201232728.GA31815@burratino>
 <20101201232923.GC31815@burratino>
 <20101202045707.GA32125@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 07:12:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO2PX-00028C-Ln
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 07:12:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757197Ab0LBGMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 01:12:50 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:33010 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756966Ab0LBGMu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 01:12:50 -0500
Received: by gwj20 with SMTP id 20so3908187gwj.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 22:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=c7/hYAL3p+0DJOROx1vbm+IkITePm9qpzTl1S/yQ0xg=;
        b=gKPpHEwAqK8IVr3WeWh5m6wYnwYPa7ylvuoqlAu/ug/drHEbqsZdR9+S/Fj/k6XUOn
         KZMeLtMJOoKSCCyGwuFO61H+MtAMn2kc8P9+ERDpnikvQUNnf7zM5m44O1GqoQL3Prcn
         +vpdyzacSQNzTIC4XdWQ+a41w/gHC7nxvOe/g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FIYIU/muRAh516Rzr4sj06p/yu6I382i2GuBkXoaCOFHZibb3njlo/OhJzgiZaVmNS
         XWMxg6pNkNQZIJM/f4i0WovcW/t5Xl6L8shYlBFRKqOtW0I57Sk0wMnsDIhK6boXSCrU
         IuDa4PUoJWPWS8FKREAjX1F3pdlppddyPmMIM=
Received: by 10.100.44.9 with SMTP id r9mr165126anr.10.1291269690016;
        Wed, 01 Dec 2010 22:01:30 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.ameritech.net [68.255.109.73])
        by mx.google.com with ESMTPS id c24sm151121ana.10.2010.12.01.22.01.26
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 01 Dec 2010 22:01:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101202045707.GA32125@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162675>

The PARSE_OPT_LASTARG_DEFAULT flag is meant for options like
--contains that (1) traditionally had a mandatory argument and
(2) have some better behavior to use when appearing in the final
position.  It makes no sense to combine this with OPTARG, so ever
since v1.6.4-rc0~71 (parse-options: add parse_options_check to
validate option specs, 2009-07-09) this mistake is flagged with

	error: `--option` uses incompatible flags LASTARG_DEFAULT and OPTARG

and an exit status representing an error in commandline usage.

Unfortunately that which might confuse scripters calling such an
erroneous program into thinking the _script_ contains an error.
Clarify that it is an internal error by dying with a message beginning
"error: BUG: ..." and status 128.

While at it, clean up parse_options_check to prepare for more checks.

Long term, it would be nicer to make such checks happen at compile
time.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Jonathan Nieder wrote:
> Jonathan Nieder wrote:

>> --- a/parse-options.c
>> +++ b/parse-options.c
>> @@ -316,24 +323,12 @@ static void check_typos(const char *arg, const struct option *options)
[...]
>> +		    (opts->flags & PARSE_OPT_OPTARG))
>> +			optbug(opts, "uses incompatible flags "
>> +				"LASTARG_DEFAULT and OPTARG");
>>  	}
>> -
>> -	if (err)
>> -		exit(129);
>
> Hmph, this is simpler but it does not report all errors any more.
> So it would be better to do:

Like this.  (Looks okay now.  Famous last words...)

 parse-options.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 196ba71..97d7ff7 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -11,6 +11,13 @@ static int parse_options_usage(struct parse_opt_ctx_t *ctx,
 #define OPT_SHORT 1
 #define OPT_UNSET 2
 
+static int optbug(const struct option *opt, const char *reason)
+{
+	if (opt->long_name)
+		return error("BUG: option '%s' %s", opt->long_name, reason);
+	return error("BUG: switch '%c' %s", opt->short_name, reason);
+}
+
 static int opterror(const struct option *opt, const char *reason, int flags)
 {
 	if (flags & OPT_SHORT)
@@ -320,20 +327,12 @@ static void parse_options_check(const struct option *opts)
 
 	for (; opts->type != OPTION_END; opts++) {
 		if ((opts->flags & PARSE_OPT_LASTARG_DEFAULT) &&
-		    (opts->flags & PARSE_OPT_OPTARG)) {
-			if (opts->long_name) {
-				error("`--%s` uses incompatible flags "
-				      "LASTARG_DEFAULT and OPTARG", opts->long_name);
-			} else {
-				error("`-%c` uses incompatible flags "
-				      "LASTARG_DEFAULT and OPTARG", opts->short_name);
-			}
-			err |= 1;
-		}
+		    (opts->flags & PARSE_OPT_OPTARG))
+			err |= optbug(opts, "uses incompatible flags "
+					"LASTARG_DEFAULT and OPTARG");
 	}
-
 	if (err)
-		exit(129);
+		exit(128);
 }
 
 void parse_options_start(struct parse_opt_ctx_t *ctx,
-- 
1.7.2.3
