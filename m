From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v4] quickfetch(): Prevent overflow of the rev-list command
 line
Date: Thu, 09 Jul 2009 18:20:17 +0200
Message-ID: <4A5618C1.70106@viscovery.net>
References: <alpine.DEB.2.00.0906181310400.23400@ds9.cixit.se> <4A55FCD5.2020908@viscovery.net> <20090709143203.GA31138@coredump.intra.peff.net> <200907091649.26575.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Peter Krefting <peter@softwolves.pp.se>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Jul 09 18:20:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOwMJ-0000rU-TK
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 18:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760780AbZGIQUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 12:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760618AbZGIQUY
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 12:20:24 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:39237 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760202AbZGIQUX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2009 12:20:23 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MOwM7-0000WF-2t; Thu, 09 Jul 2009 18:20:21 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0B4DF6B7; Thu,  9 Jul 2009 18:20:18 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <200907091649.26575.johan@herland.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122988>

With this fixup the patch is good, I think.

-- Hannes

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 34ba878..7547631 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -446,14 +446,16 @@ static int quickfetch(struct ref *ref_map)
 		return err;
 	}

-	/* If rev-list --stdin encounters an unknown commit, it terminates,
-	 * which will cause SIGPIPE in the write loop below. */
+	/*
+	 * If rev-list --stdin encounters an unknown commit, it terminates,
+	 * which would cause SIGPIPE in the write loop below.
+	 */
 	sigchain_push(SIGPIPE, SIG_IGN);

 	for (ref = ref_map; ref; ref = ref->next) {
 		if (write_in_full(revlist.in, sha1_to_hex(ref->old_sha1), 40) < 0 ||
 		    write_in_full(revlist.in, "\n", 1) < 0) {
-			if (err != EPIPE && err != EINVAL)
+			if (errno != EPIPE && errno != EINVAL)
 				error("failed write to rev-list: %s", strerror(errno));
 			err = -1;
 			break;
