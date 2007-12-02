From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Corrupted (?) commit 6e6db85e confusing gitk
Date: Sun, 2 Dec 2007 13:25:12 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712021322580.8458@woody.linux-foundation.org>
References: <5F1A20CC-7427-4E7A-AB95-E89C9FA17951@zib.de> <7vir3hx70y.fsf@gitster.siamese.dyndns.org> <20071202193918.GQ6212@lavos.net> <7vmyssvn55.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brian Downing <bdowning@lavos.net>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 02 22:26:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IywKg-0001DV-Dd
	for gcvg-git-2@gmane.org; Sun, 02 Dec 2007 22:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbXLBV0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 16:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbXLBV0P
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 16:26:15 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:37513 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750713AbXLBV0O (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Dec 2007 16:26:14 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB2LPDla014421
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 2 Dec 2007 13:25:14 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB2LPC0C000643;
	Sun, 2 Dec 2007 13:25:13 -0800
In-Reply-To: <7vmyssvn55.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: No, hits=-2.726 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66819>



On Sun, 2 Dec 2007, Junio C Hamano wrote:
>
> The next issue would be to find who could pass an empty GIT_AUTHOR_DATE
> without noticing...

In the meantime, here's a not-very-well-tested patch to fsck to at least 
notice this.

Of course, in the name of containment it would probably be even better if 
parse_commit() did it, because then people would be unable to pull from 
such a corrupt repository! But this would seem to be at least a slight 
step in the right direction.

		Linus

---
 builtin-fsck.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/builtin-fsck.c b/builtin-fsck.c
index e4874f6..309212c 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -351,8 +351,48 @@ static int fsck_tree(struct tree *item)
 	return retval;
 }
 
+static int parse_commit_line(struct commit *commit, const char *expect, const char *buffer)
+{
+	char *end;
+	const char *p;
+	int len = strlen(expect);
+	int saw_lt = 0;
+
+	if (memcmp(buffer, expect, len))
+		goto bad;
+	p = (char *)buffer + len;
+	if (*p != ' ')
+		goto bad;
+	while (*++p != '>') {
+		if (*p == '<')
+			saw_lt++;
+		if (!*p)
+			goto bad;
+	}
+	if (saw_lt != 1)
+		goto bad;
+	if (*++p != ' ')
+		goto bad;
+
+	/* Date in seconds since the epoch (UTC) */
+	if (strtoul(p, &end, 10) == ULONG_MAX)
+		goto bad;
+	if (*end++ != ' ')
+		goto bad;
+
+	/* TZ that date was done in */
+	if (strtoul(end, &end, 10) == ULONG_MAX)
+		goto bad;
+	if (*end++ != '\n')
+		goto bad;
+	return end - buffer;
+bad:
+	return objerror(&commit->object, "invalid format - missing or corrupt '%s'", expect);
+}
+
 static int fsck_commit(struct commit *commit)
 {
+	int len;
 	char *buffer = commit->buffer;
 	unsigned char tree_sha1[20], sha1[20];
 
@@ -370,8 +410,21 @@ static int fsck_commit(struct commit *commit)
 			return objerror(&commit->object, "invalid 'parent' line format - bad sha1");
 		buffer += 48;
 	}
-	if (memcmp(buffer, "author ", 7))
-		return objerror(&commit->object, "invalid format - expected 'author' line");
+
+	/*
+	 * We check the author/committer lines for completeness.
+	 * But errors here aren't fatal to the rest of the parsing.
+	 */
+	len = parse_commit_line(commit, "author", buffer);
+	if (len >= 0) {
+		buffer += len;
+		len = parse_commit_line(commit, "committer", buffer);
+		if (len >= 0) {
+			buffer += len;
+			if (*buffer != '\n')
+				objerror(&commit->object, "invalid format - missing or corrupt end-of-headers");
+		}
+	}
 	free(commit->buffer);
 	commit->buffer = NULL;
 	if (!commit->tree)
