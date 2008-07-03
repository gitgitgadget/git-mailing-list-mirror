From: Abhijit Menon-Sen <ams@toroid.org>
Subject: Re: git describe --tags --long barfs on new tags?
Date: Thu, 3 Jul 2008 08:19:56 +0530
Message-ID: <20080703024956.GA1080@toroid.org>
References: <237967ef0807021256j3e67bceaoecbb8f37112db2ab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Burton <markb@ordern.com>, Mikael Magnuson <mikachu@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 03 10:25:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEK7f-0002yW-OS
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 10:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213AbYGCG71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2008 02:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753546AbYGCG5m
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 02:57:42 -0400
Received: from fugue.toroid.org ([85.10.196.113]:53289 "EHLO fugue.toroid.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753739AbYGCCt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 22:49:59 -0400
Received: from penne.toroid.org (penne-vpn [10.8.0.6])
	by fugue.toroid.org (Postfix) with ESMTP id 806AB55838D;
	Thu,  3 Jul 2008 04:49:57 +0200 (CEST)
Received: by penne.toroid.org (Postfix, from userid 1000)
	id E2210ADC305; Thu,  3 Jul 2008 08:19:56 +0530 (IST)
Content-Disposition: inline
In-Reply-To: <237967ef0807021256j3e67bceaoecbb8f37112db2ab@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87238>

(Sorry for the broken References. I deleted the message before realising
that I wanted to reply to it; and I couldn't easily find an mbox archive
to snarf the whole message from.)

> ~/git[master]$ git tag mb
> ~/git[master]$ git describe
> v1.5.6.1-156-ge903b40
> ~/git[master]$ git describe --tags
> mb
> ~/git[master]$ git describe --tags --long
> Segmentation fault (core dumped)

Not on new tags, but on un-annotated ones (which the --tags brings into
consideration). The appended patch fixes the problem for me, but I'd be
grateful if someone could confirm that it's the right thing to do.

-- ams

diff --git a/builtin-describe.c b/builtin-describe.c
index 3da99c1..7ed4757 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -203,8 +203,12 @@ static void describe(const char *arg, int last_one)
 		 * Exact match to an existing ref.
 		 */
 		display_name(n);
-		if (longformat)
-			show_suffix(0, n->tag->tagged->sha1);
+		if (longformat) {
+			const unsigned char *sha1 = n->sha1;
+			if (n->tag)
+				sha1 = n->tag->tagged->sha1;
+			show_suffix(0, sha1);
+		}
 		printf("\n");
 		return;
 	}
