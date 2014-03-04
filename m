From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] commit.c: use skip_prefix() instead of starts_with()
Date: Tue, 04 Mar 2014 11:33:46 -0800
Message-ID: <xmqqppm1kbc5.fsf@gitster.dls.corp.google.com>
References: <1393922540-13156-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, max@quendi.de
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 20:34:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKv6G-0004Bi-Rd
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 20:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754846AbaCDTdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 14:33:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35953 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990AbaCDTdv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 14:33:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C47571EE6;
	Tue,  4 Mar 2014 14:33:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BVTz382euQXfyImDETZ48kXFivg=; b=rrN4OQ
	KcO9URhnN8ftrqZV907PbSCeSwMG9JBdOP+tn+dLjJ3jWed0T5bvOoULUMiFQAQ9
	7zfnifyzOd+8qu3slG0WZVL3LLClmGhL2fgS15/uf5DHTipmWimCS5xm5JCcvLEO
	jvNZ4kApHecpGeqGea6gJPuhNYZRIhT58+iQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B7P8EiMudRuVh0IKs+/741GKcpVhLqnm
	9ijNa8T+Vyyn0Nuo5h0XkZ+A4J7Vr5QjjfOIy+xk65AMJnW75R13BHOPruj3l1Mh
	nJ0N8crZmdksAeDn8VV6v4I6Z9bSpgA8WYmC//lNiQmrW6R0jny79FufWpIOwyKg
	8gn6qJptG3U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6165871EE5;
	Tue,  4 Mar 2014 14:33:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8320571EE1;
	Tue,  4 Mar 2014 14:33:49 -0500 (EST)
In-Reply-To: <1393922540-13156-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Tue, 4 Mar 2014 00:42:20 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E919F942-A3D3-11E3-8BA2-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243373>

Tanay Abhra <tanayabh@gmail.com> writes:

> In record_author_date() & parse_gpg_output() ,using skip_prefix() instead of
> starts_with() is a more suitable abstraction.

Thanks.  Will queue with a reworded message to clarify what exactly
"A more suitable" means.

Here is what I tentatively came up with.

-- >8 --
From: Tanay Abhra <tanayabh@gmail.com>
Date: Tue, 4 Mar 2014 00:42:20 -0800
Subject: [PATCH] commit.c: use skip_prefix() instead of starts_with()

In record_author_date() & parse_gpg_output(), the callers of
starts_with() not just want to know if the string starts with the
prefix, but also can benefit from knowing the string that follows
the prefix.

By using skip_prefix(), we can do both at the same time.

Helped-by: Max Horn <max@quendi.de>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/commit.c b/commit.c
index 6bf4fe0..6c92acb 100644
--- a/commit.c
+++ b/commit.c
@@ -548,7 +548,7 @@ define_commit_slab(author_date_slab, unsigned long);
 static void record_author_date(struct author_date_slab *author_date,
 			       struct commit *commit)
 {
-	const char *buf, *line_end;
+	const char *buf, *line_end, *ident_line;
 	char *buffer = NULL;
 	struct ident_split ident;
 	char *date_end;
@@ -566,14 +566,16 @@ static void record_author_date(struct author_date_slab *author_date,
 	     buf;
 	     buf = line_end + 1) {
 		line_end = strchrnul(buf, '\n');
-		if (!starts_with(buf, "author ")) {
+		ident_line = skip_prefix(buf, "author ");
+		if (!ident_line) {
 			if (!line_end[0] || line_end[1] == '\n')
 				return; /* end of header */
 			continue;
 		}
+		buf = ident_line;
 		if (split_ident_line(&ident,
-				     buf + strlen("author "),
-				     line_end - (buf + strlen("author "))) ||
+				     buf,
+				     line_end - buf) ||
 		    !ident.date_begin || !ident.date_end)
 			goto fail_exit; /* malformed "author" line */
 		break;
@@ -1193,10 +1195,9 @@ static void parse_gpg_output(struct signature_check *sigc)
 	for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
 		const char *found, *next;
 
-		if (starts_with(buf, sigcheck_gpg_status[i].check + 1)) {
-			/* At the very beginning of the buffer */
-			found = buf + strlen(sigcheck_gpg_status[i].check + 1);
-		} else {
+		found = skip_prefix(buf, sigcheck_gpg_status[i].check + 1);
+		/* At the very beginning of the buffer */
+		if(!found) {
 			found = strstr(buf, sigcheck_gpg_status[i].check);
 			if (!found)
 				continue;
-- 
1.9.0-186-gd464cb7
