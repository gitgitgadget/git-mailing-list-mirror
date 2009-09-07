From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] grep: fix exit status if external_grep() returns error
Date: Mon, 7 Sep 2009 10:48:01 +0200
Message-ID: <20090907084801.GB10797@localhost>
References: <20090902080305.GA11549@neumann> <20090902081917.GA5447@coredump.intra.peff.net> <20090904070216.GA3996@darc.dnsalias.org> <20090905061804.GB29863@coredump.intra.peff.net> <7v8wgt98ms.fsf@alter.siamese.dyndns.org> <20090905072017.GA5152@coredump.intra.peff.net> <7v3a717rgl.fsf@alter.siamese.dyndns.org> <20090905123117.GA3099@darc.dnsalias.org> <7v3a6zu1dk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 10:48:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkZtb-0001FB-0X
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 10:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260AbZIGIsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 04:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752175AbZIGIsJ
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 04:48:09 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:38250 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbZIGIsI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 04:48:08 -0400
Received: by bwz19 with SMTP id 19so1429021bwz.37
        for <git@vger.kernel.org>; Mon, 07 Sep 2009 01:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:bcc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=LqvenmHvJGqA65TK2afpWc27JRHvrk2CtGkkWfzTUk4=;
        b=fV3xMm/3z+ar1DMOO2xxIk1oa1MuuvsXBouGDN+B2EqIMu8zsTfmMX6dFNd5xK9MyB
         RTXCrVb9Fj+N2hPG1QTWW7isRnl2CTTUnnDnuzyjVXAN4TpF7ltnnm8fk1rLlwHKs+Z0
         R/75k4uBHskHH44oA3GVkMcN82qh1/IRfxiv0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=v6lLioKm2M9q570vkmRhWU33K2okuU6t+SBi38W+R7RfQuQiR1RSUBbW8fz3FX2hxJ
         ZHWPgzYpN4G9dfAeLCaryo3tdLnyC4WufDgslKm3RkegaBAoRgB/cuGq+XHDZSsABoSi
         dpo9EwpNsaHiKCSKxPBSTiB1JgIPRZG3haFqE=
Received: by 10.204.7.220 with SMTP id e28mr11821822bke.210.1252313289983;
        Mon, 07 Sep 2009 01:48:09 -0700 (PDT)
Received: from darc.lan (p549A55B4.dip.t-dialin.net [84.154.85.180])
        by mx.google.com with ESMTPS id 2sm628350bwz.93.2009.09.07.01.48.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Sep 2009 01:48:09 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MkZtJ-0003p1-FO; Mon, 07 Sep 2009 10:48:01 +0200
Content-Disposition: inline
In-Reply-To: <7v3a6zu1dk.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127908>

On Sun, Sep 06, 2009 at 03:58:15PM -0700, Junio C Hamano wrote:

> Your patch is queued in 'pu', but it seems to break the exit status in a
> strange way with my limited test.
[...]
> The command should not give different exit status depending on the
> destination of standard output stream.

I could also reproduce this in master using

	:~/git/t$ git grep --no-color not-going-to-match .; echo $?

The problem is a small bug in grep_cache(), which is triggered here because
external_grep() cannot deal with relative paths (not sure why that's the
case though). Fix below.

Clemens
--o<--

If external_grep() is called and returns an error, grep_cache() mistakenly
reported a hit, even if there were none. The bug can be triggered by
calling "git grep --no-color" from a subdirectory.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 builtin-grep.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index ad0e0a5..b577738 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -500,9 +500,9 @@ static int grep_cache(struct grep_opt *opt, const char **paths, int cached,
 	 * be a lot more optimized
 	 */
 	if (!cached && external_grep_allowed) {
-		hit = external_grep(opt, paths, cached);
-		if (hit >= 0)
-			return hit;
+		int ret = external_grep(opt, paths, cached);
+		if (ret >= 0)
+			return ret;
 	}
 #endif
 
-- 
1.6.4.2.266.gbaa17
