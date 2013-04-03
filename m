From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http-backend: respect GIT_NAMESPACE with dumb clients
Date: Wed, 3 Apr 2013 12:10:38 -0400
Message-ID: <20130403161038.GB16885@sigill.intra.peff.net>
References: <CAAvHm8N8Sm-EuA5ofPp1qNJrZGqcRbzA3LFX5s0-g8oCnB8bhw@mail.gmail.com>
 <1365004329-15264-1-git-send-email-jkoleszar@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Josh Triplett <josh@joshtriplett.org>
To: John Koleszar <jkoleszar@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 03 18:11:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNQHI-0000nB-Cu
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 18:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758736Ab3DCQKo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 12:10:44 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53565 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754857Ab3DCQKn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 12:10:43 -0400
Received: (qmail 25308 invoked by uid 107); 3 Apr 2013 16:12:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Apr 2013 12:12:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Apr 2013 12:10:38 -0400
Content-Disposition: inline
In-Reply-To: <1365004329-15264-1-git-send-email-jkoleszar@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219952>

On Wed, Apr 03, 2013 at 08:52:09AM -0700, John Koleszar wrote:

> +	SMART=smart
> +	git ls-remote public >expected &&  
> +	grep /$NS/ expected >/dev/null &&
> +	GET_BODY "info/refs" >actual &&
> +	test_cmp expected actual &&
> +	GET_BODY "info/refs?service=git-upload-pack" | grep /$NS/ >/dev/null &&
> +
> +	SMART=smart_namespace &&
> +	GIT_NAMESPACE=$NS && export GIT_NAMESPACE &&
> +	git ls-remote public >expected &&  
> +	! grep /$NS/ expected>/dev/null &&
> +	GET_BODY "info/refs" >actual &&
> +	test_cmp expected actual &&
> +	! (GET_BODY "info/refs?service=git-upload-pack" | grep /$NS/ >/dev/null)
> +)'

Hmm. This is testing just the ref advertisement. It would be nice to see
a complete transaction tested with namespaces turned on. Something like
this (squashed into your patch) seems to work for me:

diff --git a/t/t5551-http-fetch.sh b/t/t5551-http-fetch.sh
index 47eb769..9fd8bbf 100755
--- a/t/t5551-http-fetch.sh
+++ b/t/t5551-http-fetch.sh
@@ -162,6 +162,18 @@ test_expect_success 'invalid Content-Type rejected' '
 	grep "not valid:" actual
 '
 
+test_expect_success 'create namespaced refs' '
+	test_commit namespaced &&
+	git push public HEAD:refs/namespaces/ns/refs/heads/master
+'
+
+test_expect_success 'clone respects namespace' '
+	git clone --bare "$HTTPD_URL/smart_namespace/repo.git" ns.git &&
+	echo namespaced >expect &&
+	git --git-dir=ns.git log -1 --format=%s >actual &&
+	test_cmp expect actual
+'
+
 test -n "$GIT_TEST_LONG" && test_set_prereq EXPENSIVE
 
 test_expect_success EXPENSIVE 'create 50,000 tags in the repo' '

-Peff
