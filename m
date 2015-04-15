From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fmt-merge-msg: plug small leak of commit buffer
Date: Wed, 15 Apr 2015 18:14:32 -0400
Message-ID: <20150415221431.GA27566@peff.net>
References: <xmqqegnljd80.fsf@gitster.dls.corp.google.com>
 <xmqqa8y9jd06.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 00:14:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiVZv-0006WQ-Vx
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 00:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756414AbbDOWOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 18:14:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:45953 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753780AbbDOWOf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 18:14:35 -0400
Received: (qmail 27510 invoked by uid 102); 15 Apr 2015 22:14:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Apr 2015 17:14:34 -0500
Received: (qmail 19559 invoked by uid 107); 15 Apr 2015 22:14:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 15 Apr 2015 18:14:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 15 Apr 2015 18:14:32 -0400
Content-Disposition: inline
In-Reply-To: <xmqqa8y9jd06.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267242>

On Wed, Apr 15, 2015 at 02:30:17PM -0700, Junio C Hamano wrote:

> I spoke too soon.  There are two error-exit paths in this function.
> 
> -- >8 --
> A broken or badly formatted commit might not record author or
> committer lines or we may not find a valid name on them.  The
> function record_person() returned after calling get_commit_buffer()
> without calling unuse_commit_buffer() on the memory it obtained in
> such cases, potentially leaking it.

Looks good. Thanks for cleaning my mess. I looked over the offending
bc6b8fc1, and the other changed spots all look OK.

I note that record_person does not seem to care about the commit at all,
so an alternative fix would be:

diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 1d962dc..9f0e608 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -223,16 +223,14 @@ static void add_branch_desc(struct strbuf *out, const char *name)
 
 #define util_as_integral(elem) ((intptr_t)((elem)->util))
 
-static void record_person(int which, struct string_list *people,
-			  struct commit *commit)
+static void record_person_from_buf(int which, struct string_list *people,
+				   const char *buffer)
 {
-	const char *buffer;
 	char *name_buf, *name, *name_end;
 	struct string_list_item *elem;
 	const char *field;
 
 	field = (which == 'a') ? "\nauthor " : "\ncommitter ";
-	buffer = get_commit_buffer(commit, NULL);
 	name = strstr(buffer, field);
 	if (!name)
 		return;
@@ -245,7 +243,6 @@ static void record_person(int which, struct string_list *people,
 	if (name_end < name)
 		return;
 	name_buf = xmemdupz(name, name_end - name + 1);
-	unuse_commit_buffer(commit, buffer);
 
 	elem = string_list_lookup(people, name_buf);
 	if (!elem) {
@@ -256,6 +253,14 @@ static void record_person(int which, struct string_list *people,
 	free(name_buf);
 }
 
+static void record_person(int which, struct string_list *people,
+			  struct commit *commit)
+{
+	const char *buf = get_commit_buffer(commit, NULL);
+	record_person_from_buf(which, people, buf);
+	unuse_commit_buffer(commit, buf);
+}
+
 static int cmp_string_list_util_as_integral(const void *a_, const void *b_)
 {
 	const struct string_list_item *a = a_, *b = b_;


This has the slight advantage that it adapts naturally if record_person
grows more exits, but I don't think it is a big deal either way (it only
matters if the new exit fails to copy the surrounding code and use "goto
leave").

-Peff
