From: "Marco Costalba" <mcostalba@gmail.com>
Subject: [PATCH] Teach 'git-apply --whitespace=strip' to remove empty lines at the end of file
Date: Sun, 20 May 2007 11:51:41 +0200
Message-ID: <e5bfff550705200251j3dd9b377je7ae5bafac988060@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 11:52:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpi50-00016X-SB
	for gcvg-git@gmane.org; Sun, 20 May 2007 11:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755679AbXETJvn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 05:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755578AbXETJvn
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 05:51:43 -0400
Received: from nz-out-0506.google.com ([64.233.162.227]:58934 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755650AbXETJvm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 05:51:42 -0400
Received: by nz-out-0506.google.com with SMTP id z3so24994nzf
        for <git@vger.kernel.org>; Sun, 20 May 2007 02:51:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=s6H6bKEzEy8eZhmj70W7JlRyNGFe6hdMyBar6Yv61cqcB/hqAcd+taSaPdnkDSoailWyrTL3P1CpnQTsMwIUUJee6kvoUHsWSme5ch0FWkIrxk/v7iB+ZuQdVZfyFVZwp1CB9tNQqzsIOfrpDpFe5sVrr5lin5QkCGk9suj2MRk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=iQxVELBB1GlzJm9yhWEDroa/ysmWxvYxxooKEKEKkOOxZ0XaepgXGU7ftUWJraiu7aUxO4j930QCJU6FxW2k8Zz79NsOodfCoXREQFZ9JcY7Lqg935b6PNDlCR0QG2U/wl5r7GAeFbUR2D86BDY0ze2a3ctfnHZx9uMWQvZOIOw=
Received: by 10.114.144.1 with SMTP id r1mr1938233wad.1179654701179;
        Sun, 20 May 2007 02:51:41 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sun, 20 May 2007 02:51:41 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47806>

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---

This one seems to pass all the tests.

 builtin-apply.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 0399743..a96f669 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1671,6 +1671,7 @@ static int apply_one_fragment(struct buffer_desc *desc,
 	char *new = xmalloc(size);
 	const char *oldlines, *newlines;
 	int oldsize = 0, newsize = 0;
+	int trailing_added_lines = 0;
 	unsigned long leading, trailing;
 	int pos, lines;

@@ -1699,6 +1700,15 @@ static int apply_one_fragment(struct buffer_desc *desc,
 			else if (first == '+')
 				first = '-';
 		}
+		/*
+		 * Only fragments that add lines at the bottom
+		 * of a file end with a list of '+' lines
+		*/
+		if (first == '+')
+			trailing_added_lines++;
+		else
+			trailing_added_lines = 0;
+
 		switch (first) {
 		case '\n':
 			/* Newer GNU diff, empty context line */
@@ -1738,6 +1748,18 @@ static int apply_one_fragment(struct buffer_desc *desc,
 		newsize--;
 	}

+	if (new_whitespace == strip_whitespace) {
+		/* Any added empty lines is already cleaned-up here
+		 * becuase of 'strip_whitespace' flag, so just count '\n'
+		*/
+		int empty = 0;
+		while (   empty < trailing_added_lines
+		       && newsize - empty - 2 > 0
+		       && new[newsize - empty - 2] == '\n')
+			empty++;
+
+		newsize -= empty;
+	}
 	oldlines = old;
 	newlines = new;
 	leading = frag->leading;
-- 
1.5.2.rc3.90.gf33e-dirty
