From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Subject: Re: [PATCH] Add a newline before appending "Signed-off-by: " line
Date: Tue, 29 Aug 2006 13:37:06 +0200
Message-ID: <44F426E2.7040902@innova-card.com>
References: <7vr6zkjmeq.fsf@assigned-by-dhcp.cox.net>
Reply-To: Franck <vagabon.xyz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Aug 29 13:37:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GI1uC-00021Z-SH
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 13:37:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWH2LhQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Aug 2006 07:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWH2LhQ
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 07:37:16 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:62855 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964903AbWH2LhN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Aug 2006 07:37:13 -0400
Received: by nz-out-0102.google.com with SMTP id n1so1256617nzf
        for <git@vger.kernel.org>; Tue, 29 Aug 2006 04:37:13 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=oMF+72GJUplxUjS2bewQM5W+157ZF7/cbPW0caDdej9GGifqKVcOdiubYQURCMM8Ugwq7MYE1jXFxZjr7UuA7F36g3sXBuEsEJpdkdbLigTfbYSwY5d1whSPZGjeNrqcfvG0Z6J3h/+iEUWcGiKjnIkGJ1ifvhYv8Z3hIeKLzW8=
Received: by 10.65.185.3 with SMTP id m3mr8284185qbp;
        Tue, 29 Aug 2006 04:37:12 -0700 (PDT)
Received: from ?192.168.0.24? ( [194.3.162.233])
        by mx.gmail.com with ESMTP id e18sm5010068qba.2006.08.29.04.37.10;
        Tue, 29 Aug 2006 04:37:12 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vr6zkjmeq.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26203>

Junio,

Sorry for replying sooooooo lately.

Junio C Hamano wrote:
> From: Franck Bui-Huu <vagabon.xyz@gmail.com>
> 
> Whef the last line of the commit log message does not end with
> "^[-A-Za-z]+: [^@]+@", append a newline after it to separate
> the body of the commit log message from the run of sign-off and
> ack lines. e.g. "Signed-off-by: A U Thor <au.thor@example.com>" or
> "Acked-by: Me <myself@example.org>".
> 
> Signed-off-by: Junio C Hamano <junkio@cox.net>

what about this patch on top of yours ?

		Franck

-- >8 --

Subject: log-tree.c: cleanup a bit append_signoff()

This patch clean up append_signoff() by moving specific code that
looks up for "^[-A-Za-z]+: [^@]+@" pattern into a function.

It also stops the primary search when the cursor oversteps
'buf + at' limit.

This patch changes slightly append_signoff() behaviour too. If we
detect any Signed-off-by pattern during the primary search, we
needn't to do a pattern research after.

Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
---
 log-tree.c |  116 ++++++++++++++++++++++++++++++++++--------------------------
 1 files changed, 66 insertions(+), 50 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 54cdaa4..36f0d75 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -12,10 +12,58 @@ static void show_parents(struct commit *
 	}
 }
 
+/*
+ * Search for "^[-A-Za-z]+: [^@]+@" pattern. It usually matches
+ * Signed-off-by: and Acked-by: lines.
+ */
+static int detect_any_signoff(char *letter, int size)
+{
+	char ch, *cp;
+	int seen_colon = 0;
+	int seen_at = 0;
+	int seen_name = 0;
+	int seen_head = 0;
+
+	cp = letter + size;
+	while (letter <= --cp && (ch = *cp) == '\n')
+		continue;
+
+	while (letter <= cp) {
+		ch = *cp--;
+		if (ch == '\n')
+			break;
+		
+		if (!seen_at) {
+			if (ch == '@')
+				seen_at = 1;
+			continue;
+		}
+		if (!seen_colon) {
+			if (ch == '@')
+				return 0;
+			else if (ch == ':')
+				seen_colon = 1;
+			else
+				seen_name = 1;
+			continue;
+		}
+		if (('A' <= ch && ch <= 'Z') ||
+		    ('a' <= ch && ch <= 'z') ||
+		    ch == '-') {
+			seen_head = 1;
+			continue;
+		}
+		/* no empty last line doens't match */
+		return 0;
+	}
+	return seen_head && seen_name;
+}
+
 static int append_signoff(char *buf, int buf_sz, int at, const char *signoff)
 {
-	int signoff_len = strlen(signoff);
 	static const char signed_off_by[] = "Signed-off-by: ";
+	int signoff_len = strlen(signoff);
+	int has_signoff = 0;
 	char *cp = buf;
 
 	/* Do we have enough space to add it? */
@@ -23,58 +71,26 @@ static int append_signoff(char *buf, int
 		return at;
 
 	/* First see if we already have the sign-off by the signer */
-	while (1) {
-		cp = strstr(cp, signed_off_by);
-		if (!cp)
-			break;
+	while ((cp = strstr(cp, signed_off_by))) {
+
+		has_signoff = 1;
+		
 		cp += strlen(signed_off_by);
-		if ((cp + signoff_len < buf + at) &&
-		    !strncmp(cp, signoff, signoff_len) &&
-		    isspace(cp[signoff_len]))
-			return at; /* we already have him */
+		if (cp + signoff_len >= buf + at)
+			break;
+		if (strncmp(cp, signoff, signoff_len))
+			continue;
+		if (!isspace(cp[signoff_len]))
+			continue;
+		/* we already have him */
+		return at;
 	}
 
-	/* Does the last line already end with "^[-A-Za-z]+: [^@]+@"?
-	 * If not, add a blank line to separate the message from
-	 * the run of Signed-off-by: and Acked-by: lines.
-	 */
-	{
-		char ch;
-		int seen_colon, seen_at, seen_name, seen_head, not_signoff;
-		seen_colon = 0;
-		seen_at = 0;
-		seen_name = 0;
-		seen_head = 0;
-		not_signoff = 0;
-		cp = buf + at;
-		while (buf <= --cp && (ch = *cp) == '\n')
-			;
-		while (!not_signoff && buf <= cp && (ch = *cp--) != '\n') {
-			if (!seen_at) {
-				if (ch == '@')
-					seen_at = 1;
-				continue;
-			}
-			if (!seen_colon) {
-				if (ch == '@')
-					not_signoff = 1;
-				else if (ch == ':')
-					seen_colon = 1;
-				else
-					seen_name = 1;
-				continue;
-			}
-			if (('A' <= ch && ch <= 'Z') ||
-			    ('a' <= ch && ch <= 'z') ||
-			    ch == '-') {
-				seen_head = 1;
-				continue;
-			}
-			not_signoff = 1;
-		}
-		if (not_signoff || !seen_head || !seen_name)
-			buf[at++] = '\n';
-	}
+	if (!has_signoff)
+		has_signoff = detect_any_signoff(buf, at);
+
+	if (!has_signoff)
+		buf[at++] = '\n';
 
 	strcpy(buf + at, signed_off_by);
 	at += strlen(signed_off_by);
-- 
1.4.2
