From: Adam Brewster <adambrewster@gmail.com>
Subject: [PATCH] Teach git-bundle to read revision arguments from stdin like
Date: Sun,  6 Jul 2008 10:28:58 -0400
Message-ID: <1215354538-1469-3-git-send-email-adambrewster@gmail.com>
References: <7v63rjrfqz.fsf@gitster.siamese.dyndns.org>
 <1215354538-1469-1-git-send-email-adambrewster@gmail.com>
 <1215354538-1469-2-git-send-email-adambrewster@gmail.com>
Cc: gitster@pobox.com, mdl123@verizon.net, Johannes.Schindelin@gmx.de,
	jnareb@gmail.com, vmiklos@frugalware.org,
	Adam Brewster <adambrewster@gmail.com>,
	Adam Brewster <asb@bu.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 06 16:30:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFVFd-0003Td-Rc
	for gcvg-git-2@gmane.org; Sun, 06 Jul 2008 16:30:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756619AbYGFO3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2008 10:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756563AbYGFO3J
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jul 2008 10:29:09 -0400
Received: from an-out-0708.google.com ([209.85.132.243]:28579 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756309AbYGFO3F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2008 10:29:05 -0400
Received: by an-out-0708.google.com with SMTP id d40so354229and.103
        for <git@vger.kernel.org>; Sun, 06 Jul 2008 07:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=2ChMx+qBi7H0Z6SvA+844CwizozQGNYBJ96eSMN1Sic=;
        b=StEwuj2KqhmKMkkvRx2StRWzVDzBpMLi3+bgGi9oNLKALMJwRosgisLHg9IwddOcJr
         QmsqnraD+8CcUEaiB3jBBqfkpKKSzbeIsG04CyqtHbL7vyDgZt3HybH8r2pfb7Lr37Yk
         qxlfc7Rmw13iZWMVxjZvREIuY36ee761XUDW0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DFmeNK6nvpRfYXmbkw24R37Knk5vUcSy0kypCM475il/VHJ69T70lfAH2qzb3v4ckL
         VXcTGWWsBrQPySFuqYS7D49R3fTwjbzbc/SDtbwneZOzLm9BE7Nw7oBujoiwKER6wmeD
         tTLubGEgpTttipbR1MI5YoVkDBFViPETy4drE=
Received: by 10.100.108.20 with SMTP id g20mr2186542anc.105.1215354543051;
        Sun, 06 Jul 2008 07:29:03 -0700 (PDT)
Received: from MBE.internal ( [65.96.169.255])
        by mx.google.com with ESMTPS id 9sm3568534yxs.5.2008.07.06.07.28.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 06 Jul 2008 07:28:59 -0700 (PDT)
Received: by MBE.internal (Postfix, from userid 1000)
	id 83799104A20; Sun,  6 Jul 2008 10:28:58 -0400 (EDT)
X-Mailer: git-send-email 1.5.5.1.211.g65ea3.dirty
In-Reply-To: <1215354538-1469-2-git-send-email-adambrewster@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87532>

This patch allows the caller to feed the revision parameters to
git-bundle from its standard input.  This way, a script do not have to
worry about limitation of the length of command line.

Documentation/git-bundle.txt says that git-bundle takes arguments
acceptable to git-rev-list.  Obviously some arguments that git-rev-list
handles don't make sense for git-bundle (e.g. --bisect) but --stdin is
pretty reasonable.

Signed-off-by: Adam Brewster <asb@bu.edu>
---
 bundle.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/bundle.c b/bundle.c
index 0ba5df1..8d486f3 100644
--- a/bundle.c
+++ b/bundle.c
@@ -227,8 +227,14 @@ int create_bundle(struct bundle_header *header, const char *path,
 
 	/* write references */
 	argc = setup_revisions(argc, argv, &revs, NULL);
-	if (argc > 1)
-		return error("unrecognized argument: %s'", argv[1]);
+
+	for (i = 1; i < argc; i++) {
+		if (!strcmp(argv[i], "--stdin")) {
+			read_revisions_from_stdin(&revs);
+			continue;
+		}
+		return error("unrecognized argument: %s'", argv[i]);
+	}
 
 	for (i = 0; i < revs.pending.nr; i++) {
 		struct object_array_entry *e = revs.pending.objects + i;
-- 
1.5.5.1.211.g65ea3.dirty
