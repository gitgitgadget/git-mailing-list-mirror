From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/3] gitattributes: drop support for GIT_ATTR_NOGLOBAL
Date: Tue, 15 Mar 2011 04:04:15 -0500
Message-ID: <20110315090415.GB1576@elie>
References: <20110315064909.GA25738@elie>
 <20110315065643.GB29530@elie>
 <20110315071625.GA11754@sigill.intra.peff.net>
 <20110315090225.GA1576@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Petr Onderka <gsvick@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 15 10:04:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzQAz-0002yL-Ho
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 10:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247Ab1COJEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 05:04:20 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:37357 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734Ab1COJEU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 05:04:20 -0400
Received: by ywj3 with SMTP id 3so145151ywj.19
        for <git@vger.kernel.org>; Tue, 15 Mar 2011 02:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=/mtJpFuA2N7sRDCeYCl4E4qQ5zgIOPZ0MrGyBL9iN2Q=;
        b=OVMYN5N4DHk6hg9Sg8ivm3ESbOtUmn5xY+H3b/0dpgwoVCUHXHZ01EyVuynXNbJinU
         77usMhvGBRlRmLUT2ZxTMpUUxUTLLejw6BA+DbZhchwt3hH8Ir64ZpQJ70H9ZAFOG7cO
         tqS2+ptpjJoaMBv+LAQ8T8Xw9l/lXCIPOsFZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SeiPwbALFSGt+Nu/d37QVQXVwf8wFUp+SfMxFTlnXwownlI+sF5PlaESyHZeFDQQVZ
         9FPmQbP8QXfc2I6QtlBw0i4niYwgYvozl0UGvtnR1anakG37YfUEqAFytb7ljvWSJhhy
         upoY2krQGI2Y+nta+EZi46koiMpr9yedxrCns=
Received: by 10.101.128.1 with SMTP id f1mr4326110ann.132.1300179859538;
        Tue, 15 Mar 2011 02:04:19 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id w6sm343767anf.6.2011.03.15.02.04.18
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Mar 2011 02:04:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110315090225.GA1576@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169052>

test-lib sets $HOME to protect against pollution from user settings,
so setting GIT_ATTR_NOGLOBAL would be redundant.  Simplify by
eliminating support for that environment variable altogether.

GIT_ATTR_NOGLOBAL was introduced in v1.7.4-rc0~208^2 (Add global and
system-wide gitattributes, 2010-09-01) as an undocumented feature for
use by the test suite.  It never ended up being used (neither within
git.git nor in other projects).

This patch does not affect GIT_ATTR_NOSYSTEM, which should still be
useful.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 attr.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/attr.c b/attr.c
index 6aff695..0e28ba8 100644
--- a/attr.c
+++ b/attr.c
@@ -478,11 +478,6 @@ int git_attr_system(void)
 	return !git_env_bool("GIT_ATTR_NOSYSTEM", 0);
 }
 
-int git_attr_global(void)
-{
-	return !git_env_bool("GIT_ATTR_NOGLOBAL", 0);
-}
-
 static int git_attr_config(const char *var, const char *value, void *dummy)
 {
 	if (!strcmp(var, "core.attributesfile"))
@@ -511,7 +506,7 @@ static void bootstrap_attr_stack(void)
 		}
 
 		git_config(git_attr_config, NULL);
-		if (git_attr_global() && attributes_file) {
+		if (attributes_file) {
 			elem = read_attr_from_file(attributes_file, 1);
 			if (elem) {
 				elem->origin = NULL;
-- 
1.7.4.1
