From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Introduce <branch>@{tracked} as shortcut to the
 tracked branch
Date: Thu, 10 Sep 2009 10:26:28 -0400
Message-ID: <20090910142628.GA7275@coredump.intra.peff.net>
References: <20090905140127.GA29037@atjola.homenet>
 <20090905142841.GB15631@coredump.intra.peff.net>
 <7vfxaz9wfi.fsf@alter.siamese.dyndns.org>
 <20090907084324.GB17997@coredump.intra.peff.net>
 <alpine.DEB.1.00.0909071126040.8306@pacific.mpi-cbg.de>
 <20090909104550.GA20108@coredump.intra.peff.net>
 <7vzl93cncn.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0909100941330.8306@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0909101135590.8306@pacific.mpi-cbg.de>
 <20090910141618.GB4942@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 10 16:27:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mlkc4-00039v-L0
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 16:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755782AbZIJO0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 10:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755781AbZIJO0c
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 10:26:32 -0400
Received: from peff.net ([208.65.91.99]:36651 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755763AbZIJO0b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 10:26:31 -0400
Received: (qmail 1600 invoked by uid 107); 10 Sep 2009 14:26:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 10 Sep 2009 10:26:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Sep 2009 10:26:28 -0400
Content-Disposition: inline
In-Reply-To: <20090910141618.GB4942@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128117>

On Thu, Sep 10, 2009 at 10:16:18AM -0400, Jeff King wrote:

> And we may want to add a test for HEAD, as well.
> 
> Also, I seem to be able to stimulate a segfault on a detached HEAD, but
> I haven't investigated it yet.

Found it. We should probably squash this in:

diff --git a/sha1_name.c b/sha1_name.c
index a886846..ef4ec11 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -276,7 +276,7 @@ static char *substitute_branch_name(const char **string, int *len)
 		struct branch *tracking = branch_get(*ref ? ref : NULL);
 
 		free(ref);
-		if (tracking->merge && tracking->merge[0]->dst) {
+		if (tracking && tracking->merge && tracking->merge[0]->dst) {
 			*string = xstrdup(tracking->merge[0]->dst);
 			*len = strlen(*string);
 			return (char *)*string;
diff --git a/t/t1506-rev-parse-tracked.sh b/t/t1506-rev-parse-tracked.sh
index 89193e1..2be5b75 100755
--- a/t/t1506-rev-parse-tracked.sh
+++ b/t/t1506-rev-parse-tracked.sh
@@ -61,4 +61,15 @@ test_expect_success '<branch>@{t}@{1} resolves correctly' '
 	test 5 = $(commit_subject my-side@{t}@{1})
 '
 
+test_expect_success 'HEAD@{t} dereferences HEAD' '
+	(cd clone && git checkout master) &&
+	test refs/remotes/origin/master = "$(full_name HEAD@{t})"
+'
+
+test_expect_success 'HEAD@{t} and @{t} on detached HEAD fail' '
+	(cd clone && git checkout master^0) &&
+	test_must_fail full_name @{t} &&
+	test_must_fail full_name HEAD@{t}
+'
+
 test_done
