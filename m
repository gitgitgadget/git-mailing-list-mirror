From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] http-backend: respect GIT_NAMESPACE with dumb clients
Date: Mon, 8 Apr 2013 23:25:39 +0200
Message-ID: <87wqscr9yk.fsf@linux-k42r.v.cablecom.net>
References: <CAAvHm8PCQx18Gk2S7dicG+_GksjFqVLfPNCbism1sHnPUMDNzg@mail.gmail.com>
	<1365091293-23758-1-git-send-email-jkoleszar@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	<git@vger.kernel.org>, Shawn Pearce <spearce@spearce.org>,
	Josh Triplett <josh@joshtriplett.org>
To: John Koleszar <jkoleszar@google.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 23:25:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPJZS-0001zN-Pz
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 23:25:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936222Ab3DHVZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 17:25:42 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:47147 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936202Ab3DHVZl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 17:25:41 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 8 Apr
 2013 23:25:35 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (46.126.8.85) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 8 Apr 2013 23:25:38 +0200
In-Reply-To: <1365091293-23758-1-git-send-email-jkoleszar@google.com> (John
	Koleszar's message of "Thu, 4 Apr 2013 09:01:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220521>

John Koleszar <jkoleszar@google.com> writes:

> Filter the list of refs returned via the dumb HTTP protocol according
> to the active namespace, consistent with other clients of the
> upload-pack service.
>
> Signed-off-by: John Koleszar <jkoleszar@google.com>

At the risk of repeating something that's been said already -- I only
skimmed the thread -- this test breaks in today's pu on my machine.  I
get:

expecting success: (
	log_div "namespace test"
	config http.uploadpack true &&
	config http.getanyfile true &&

	NS=ns &&
	(cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
		git update-ref refs/namespaces/$NS/refs/heads/master HEAD
	) &&

	SMART=smart
	git ls-remote public >expect &&
	grep /$NS/ expect &&
	GET_BODY "info/refs" >actual &&
	test_cmp expect actual &&
	GET_BODY "info/refs?service=git-upload-pack" >actual &&
	grep /$NS/ actual &&

	SMART=smart_namespace &&
	GIT_NAMESPACE=$NS && export GIT_NAMESPACE &&
	git ls-remote public >expect &&
	! grep /$NS/ expect &&
	GET_BODY "info/refs" >actual &&
	test_cmp expect actual &&
	GET_BODY "info/refs?service=git-upload-pack" >actual &&
	! grep /$NS/ actual
)
453190505bf07f7513bed9839da875eb3610f807	refs/namespaces/ns/refs/heads/master
--- expect	2013-04-08 21:24:36.571874540 +0000
+++ actual	2013-04-08 21:24:36.579874619 +0000
@@ -1,3 +1,2 @@
-453190505bf07f7513bed9839da875eb3610f807	HEAD
 453190505bf07f7513bed9839da875eb3610f807	refs/heads/master
 453190505bf07f7513bed9839da875eb3610f807	refs/namespaces/ns/refs/heads/master
not ok 14 - backend respects namespaces


-- 
Thomas Rast
trast@{inf,student}.ethz.ch
