From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] for-each-ref: remove multiple xstrdup() in
	get_short_ref()
Date: Tue, 7 Apr 2009 03:44:35 -0400
Message-ID: <20090407074435.GB7327@coredump.intra.peff.net>
References: <20090407070254.GA2870@coredump.intra.peff.net> <1239089599-24760-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 09:46:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lr60a-0003pd-DI
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 09:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951AbZDGHol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 03:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753830AbZDGHok
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 03:44:40 -0400
Received: from peff.net ([208.65.91.99]:54745 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753360AbZDGHoj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 03:44:39 -0400
Received: (qmail 885 invoked by uid 107); 7 Apr 2009 07:44:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 07 Apr 2009 03:44:38 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Apr 2009 03:44:35 -0400
Content-Disposition: inline
In-Reply-To: <1239089599-24760-1-git-send-email-bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115921>

On Tue, Apr 07, 2009 at 09:33:19AM +0200, Bert Wesarg wrote:

> Now that get_short_ref() always return an malloced string, consolidate to
> one xstrcpy() call.

Makes sense to squash in on top of what I have. But I think it actually
is pretty easy to always return a pointer into the existing string
(patch based on current master):

---
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index 5cbb4b0..8b24a4a 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -569,7 +569,7 @@ static void gen_scanf_fmt(char *scanf_fmt, const char *rule)
 /*
  * Shorten the refname to an non-ambiguous form
  */
-static char *get_short_ref(struct refinfo *ref)
+static const char *get_short_ref(const char *ref)
 {
 	int i;
 	static char **scanf_fmts;
@@ -598,17 +598,17 @@ static char *get_short_ref(struct refinfo *ref)
 
 	/* bail out if there are no rules */
 	if (!nr_rules)
-		return ref->refname;
+		return ref;
 
 	/* buffer for scanf result, at most ref->refname must fit */
-	short_name = xstrdup(ref->refname);
+	short_name = xstrdup(ref);
 
 	/* skip first rule, it will always match */
 	for (i = nr_rules - 1; i > 0 ; --i) {
 		int j;
 		int short_name_len;
 
-		if (1 != sscanf(ref->refname, scanf_fmts[i], short_name))
+		if (1 != sscanf(ref, scanf_fmts[i], short_name))
 			continue;
 
 		short_name_len = strlen(short_name);
@@ -637,12 +637,14 @@ static char *get_short_ref(struct refinfo *ref)
 		 * short name is non-ambiguous if all previous rules
 		 * haven't resolved to a valid ref
 		 */
-		if (j == i)
-			return short_name;
+		if (j == i) {
+			ref += strlen(ref) - strlen(short_name);
+			break;
+		}
 	}
 
 	free(short_name);
-	return ref->refname;
+	return ref;
 }
 
 
@@ -684,7 +686,7 @@ static void populate_value(struct refinfo *ref)
 			if (formatp) {
 				formatp++;
 				if (!strcmp(formatp, "short"))
-					refname = get_short_ref(ref);
+					refname = get_short_ref(ref->refname);
 				else
 					die("unknown refname format %s",
 					    formatp);
