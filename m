From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/6] parse-options: make resuming easier after
 PARSE_OPT_STOP_AT_NON_OPTION
Date: Mon, 29 Nov 2010 21:09:33 -0600
Message-ID: <20101130030933.GE5326@burratino>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-4-git-send-email-pclouds@gmail.com>
 <20101022063837.GA6081@burratino>
 <20101022064258.GB6081@burratino>
 <7v8w1qnkr1.fsf@alter.siamese.dyndns.org>
 <20101024072032.GA23455@burratino>
 <20101024081316.GA29630@burratino>
 <20101130025223.GA5326@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 04:09:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNGbF-0003RI-SZ
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 04:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544Ab0K3DJo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 22:09:44 -0500
Received: from mail-vw0-f66.google.com ([209.85.212.66]:38523 "EHLO
	mail-vw0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473Ab0K3DJo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 22:09:44 -0500
Received: by vws15 with SMTP id 15so467504vws.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 19:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=Aapt9E3opQl9aHfsRU3jCYNwRUjwi6OY2SGvcBIzJOs=;
        b=dTK9mPSFqX7x8XKO/BAI7TTvAq1wYhyrRTlaGlY4lrcfnrviC+oMMDqe5R+U8Ba2J6
         vojqMTxvONCbLwYu4BKvTzlwclTUWiQgciFVurdFSCwqQfsv/+sfx/RSzAnx3UvWMxi8
         /ijrupmIC5RmDSAhqPgfjhGYZCBGPFYE6B2D8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=t8GRswTwPtGMsDQjOF7PzwLaUlRnZN0WD2Pl8A8PE0ahUqlqqSbd6DXNotLzJ3Obme
         Q6eEGwbyozfDe2xkBkfgRT396lP+2g+odxy1wcPX4Cxy8IndN1tgWlwUrCZ3IKez8Iom
         RSkcZId+E7pu6ATWSghtVveZl4eTo3CoVprCI=
Received: by 10.220.189.136 with SMTP id de8mr1707600vcb.30.1291086583253;
        Mon, 29 Nov 2010 19:09:43 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id q3sm903735vcr.27.2010.11.29.19.09.41
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 19:09:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101130025223.GA5326@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162467>

Introduce a PARSE_OPT_NON_OPTION state, so parse_option_step()
callers can easily distinguish between non-options and other
reasons for option parsing termination (like "--").

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
As before.

 parse-options.c |    3 ++-
 parse-options.h |    1 +
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 38c8fd3..df8299c 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -384,7 +384,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 			if (parse_nodash_opt(ctx, arg, options) == 0)
 				continue;
 			if (ctx->flags & PARSE_OPT_STOP_AT_NON_OPTION)
-				break;
+				return PARSE_OPT_NON_OPTION;
 			ctx->out[ctx->cpidx++] = ctx->argv[0];
 			continue;
 		}
@@ -466,6 +466,7 @@ int parse_options(int argc, const char **argv, const char *prefix,
 	switch (parse_options_step(&ctx, options, usagestr)) {
 	case PARSE_OPT_HELP:
 		exit(129);
+	case PARSE_OPT_NON_OPTION:
 	case PARSE_OPT_DONE:
 		break;
 	default: /* PARSE_OPT_UNKNOWN */
diff --git a/parse-options.h b/parse-options.h
index bd0fe16..2cd23af 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -167,6 +167,7 @@ extern NORETURN void usage_msg_opt(const char *msg,
 enum {
 	PARSE_OPT_HELP = -1,
 	PARSE_OPT_DONE,
+	PARSE_OPT_NON_OPTION,
 	PARSE_OPT_UNKNOWN
 };
 
-- 
1.7.2.3
