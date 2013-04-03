From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http-backend: respect GIT_NAMESPACE with dumb clients
Date: Wed, 3 Apr 2013 12:16:01 -0400
Message-ID: <20130403161600.GC16885@sigill.intra.peff.net>
References: <CAAvHm8N8Sm-EuA5ofPp1qNJrZGqcRbzA3LFX5s0-g8oCnB8bhw@mail.gmail.com>
 <1365004329-15264-1-git-send-email-jkoleszar@google.com>
 <20130403161038.GB16885@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Josh Triplett <josh@joshtriplett.org>
To: John Koleszar <jkoleszar@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 03 18:16:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNQMY-0004Qf-55
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 18:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759656Ab3DCQQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 12:16:09 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53580 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759408Ab3DCQQI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 12:16:08 -0400
Received: (qmail 25394 invoked by uid 107); 3 Apr 2013 16:17:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Apr 2013 12:17:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Apr 2013 12:16:01 -0400
Content-Disposition: inline
In-Reply-To: <20130403161038.GB16885@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219954>

On Wed, Apr 03, 2013 at 12:10:38PM -0400, Jeff King wrote:

> Hmm. This is testing just the ref advertisement. It would be nice to see
> a complete transaction tested with namespaces turned on. Something like
> this (squashed into your patch) seems to work for me:

Actually, I guess the point of your patch was to fix the
dumb-via-http-backend transport. So this would be more complete:

diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index 47eb769..b5032bd 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -162,6 +162,28 @@ test_expect_success 'invalid Content-Type rejected' '
 	grep "not valid:" actual
 '
 
+test_expect_success 'create namespaced refs' '
+	test_commit namespaced &&
+	git push public HEAD:refs/namespaces/ns/refs/heads/master
+'
+
+test_expect_success 'smart clone respects namespace' '
+	git clone --bare "$HTTPD_URL/smart_namespace/repo.git" ns-smart.git &&
+	echo namespaced >expect &&
+	git --git-dir=ns-smart.git log -1 --format=%s >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'dumb clone via http-backend respects namespace' '
+	git --git-dir="$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
+		config http.getanyfile true &&
+	GIT_SMART_HTTP=0 git clone --bare \
+		"$HTTPD_URL/smart_namespace/repo.git" ns-dumb.git &&
+	echo namespaced >expect &&
+	git --git-dir=ns-dumb.git log -1 --format=%s >actual &&
+	test_cmp expect actual
+'
+
 test -n "$GIT_TEST_LONG" && test_set_prereq EXPENSIVE
 
 test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '
