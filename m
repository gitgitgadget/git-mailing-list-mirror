From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: [PATCH v2] git tag --contains : avoid stack overflow
Date: Thu, 24 Apr 2014 14:20:29 +0200
Organization: <)><
Message-ID: <20140424122029.GA8168@camelia.ucw.cz>
References: <alpine.DEB.1.00.1404171902010.14982@s15462909.onlinehome-server.info> <20140417213238.GA14792@sigill.intra.peff.net> <alpine.DEB.1.00.1404172347440.14982@s15462909.onlinehome-server.info> <20140417215817.GA822@sigill.intra.peff.net> <20140423075325.GA7268@camelia.ucw.cz> <xmqqeh0nzwq9.fsf@gitster.dls.corp.google.com> <20140423191628.GA20596@sigill.intra.peff.net> <xmqqk3afydq2.fsf@gitster.dls.corp.google.com> <20140423205533.GA20582@sigill.intra.peff.net> <xmqqfvl3ycwk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Jean-Jacques Lafay <jeanjacques.lafay@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 14:20:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdIdp-0000Dh-Az
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 14:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753352AbaDXMUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 08:20:33 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:43401 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753175AbaDXMUc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 08:20:32 -0400
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id CE9371C00C3;
	Thu, 24 Apr 2014 14:20:30 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s3OCKUTC008184;
	Thu, 24 Apr 2014 14:20:30 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s3OCKT1G008183;
	Thu, 24 Apr 2014 14:20:29 +0200
Content-Disposition: inline
In-Reply-To: <xmqqfvl3ycwk.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246964>

Thanks for all suggestions and explanations.
The diff against PATCH v2 is below, PATCH v3 follows.

Have a nice day,
	Stepan

Subject: [PATCH] fixup! git tag --contains : avoid stack overflow

---
 t/t7004-tag.sh | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index db82f6d..a911df0 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1423,12 +1423,15 @@ EOF
 	test_cmp expect actual
 '
 
-ulimit_stack="ulimit -s 64"
-test_lazy_prereq ULIMIT 'bash -c "'"$ulimit_stack"'"'
+run_with_limited_stack () {
+	(ulimit -s 64 && "$@")
+}
+
+test_lazy_prereq ULIMIT 'run_with_limited_stack true'
 
->expect
 # we require bash and ulimit, this excludes Windows
 test_expect_success ULIMIT '--contains works in a deep repo' '
+	>expect &&
 	i=1 &&
 	while test $i -lt 4000
 	do
@@ -1442,7 +1445,7 @@ EOF"
 	done | git fast-import &&
 	git checkout master &&
 	git tag far-far-away HEAD^ &&
-	bash -c "'"$ulimit_stack"' && git tag --contains HEAD >actual" &&
+	run_with_limited_stack git tag --contains HEAD >actual &&
 	test_cmp expect actual
 '
 
-- 
1.9.0.msysgit.0.119.g722efef
