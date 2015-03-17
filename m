From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] t5312: test object deletion code paths in a
 corrupted repository
Date: Tue, 17 Mar 2015 14:55:50 -0400
Message-ID: <20150317185550.GA14550@peff.net>
References: <20150317072750.GA22155@peff.net>
 <20150317072844.GA25191@peff.net>
 <5508739A.5030608@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Mar 17 19:56:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXwek-000780-MG
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 19:55:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753586AbbCQSzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2015 14:55:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:34175 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753108AbbCQSzx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2015 14:55:53 -0400
Received: (qmail 24587 invoked by uid 102); 17 Mar 2015 18:55:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Mar 2015 13:55:53 -0500
Received: (qmail 27243 invoked by uid 107); 17 Mar 2015 18:56:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Mar 2015 14:56:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Mar 2015 14:55:50 -0400
Content-Disposition: inline
In-Reply-To: <5508739A.5030608@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265654>

On Tue, Mar 17, 2015 at 07:34:02PM +0100, Johannes Sixt wrote:

> Am 17.03.2015 um 08:28 schrieb Jeff King:
> >+test_expect_success 'create history reachable only from a bogus-named ref' '
> >+	test_tick && git commit --allow-empty -m master &&
> >+	base=$(git rev-parse HEAD) &&
> >+	test_tick && git commit --allow-empty -m bogus &&
> >+	bogus=$(git rev-parse HEAD) &&
> >+	git cat-file commit $bogus >saved &&
> >+	echo $bogus >.git/refs/heads/bogus:name &&
> 
> This causes headaches on Windows: It creates an empty file, named "bogus",
> with all the data diverted to the alternate data stream named "name".
> Needless to say that this...

Ah, yes. Windows. Our usual workaround would be to put it straight into
packed-refs, but in this case, the test really does need the badly named
ref in the file system. But...

> >+test_expect_success 'clean up bogus ref' '
> >+	rm .git/refs/heads/bogus:name
> >+'
> 
> does not remove the file "bogus", but only the alternate data stream (if at
> all---I forgot to check). How about .git/refs/heads/bogus..nam.e?

Yes, that works. The colon is what originally brought my attention to
this case, but anything that fails git-check-ref-format is fine. I've
squashed this in:

diff --git a/t/t5312-prune-corruption.sh b/t/t5312-prune-corruption.sh
index 167031e..1001a69 100755
--- a/t/t5312-prune-corruption.sh
+++ b/t/t5312-prune-corruption.sh
@@ -21,7 +21,7 @@ test_expect_success 'create history reachable only from a bogus-named ref' '
 	test_tick && git commit --allow-empty -m bogus &&
 	bogus=$(git rev-parse HEAD) &&
 	git cat-file commit $bogus >saved &&
-	echo $bogus >.git/refs/heads/bogus:name &&
+	echo $bogus >.git/refs/heads/bogus..name &&
 	git reset --hard HEAD^
 '
 
@@ -47,7 +47,7 @@ test_expect_failure 'destructive repack keeps packed object' '
 
 # subsequent tests will have different corruptions
 test_expect_success 'clean up bogus ref' '
-	rm .git/refs/heads/bogus:name
+	rm .git/refs/heads/bogus..name
 '
 
 test_expect_success 'create history with missing tip commit' '


I assumed the final "." in your example wasn't significant (it is not to
git), but let me know if I've run afoul of another weird restriction. :)

Thanks.

-Peff
