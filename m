From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] revert: Make commit descriptions in insn sheet
 optional
Date: Wed, 12 Oct 2011 14:05:25 -0700
Message-ID: <7vwrc97wfe.fsf@alter.siamese.dyndns.org>
References: <1318095407-26429-1-git-send-email-artagnon@gmail.com>
 <1318095407-26429-5-git-send-email-artagnon@gmail.com>
 <7vwrccn34l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 23:05:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE5za-0001P8-O6
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 23:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754160Ab1JLVF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 17:05:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63848 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753912Ab1JLVF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 17:05:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EFEB36EDB;
	Wed, 12 Oct 2011 17:05:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M+jgn6o3o7+sNmC8g8qbkSkk1yk=; b=QyY8Tt
	iEAkpmehinLwXgUWA4bS/h/d/AZ/4Kkd/TyvyjflTeF5N7N4BsGBNrahvQNN3cgL
	T7pMtKBMjCcVz3feyOWm3rDs2ryyTt4Kx5inQ3OD9w5fN/Fewkm0jr3PV+hjbqPx
	0qsoZPtdPz4okoRWwufq7fyhENIUnnz9p9kPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bzx5SuHJTISKbP8gwQXP4zWP5X14iyG0
	/JDhzlMQNFmegicdI3LuQiTuaxsdGzMajGOS8h2QnMH6k+oBBxGBVbpHa3/Vh9Qp
	7uykJHeI+RLeKn1Rzy8OMgZbXh3yY+3OcDIvq5KhZbPCbG+4QM1qOzrn8TxsDktw
	6qZs2aoyKAE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6A546EDA;
	Wed, 12 Oct 2011 17:05:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2777C6ED7; Wed, 12 Oct 2011
 17:05:27 -0400 (EDT)
In-Reply-To: <7vwrccn34l.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 10 Oct 2011 10:54:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8E7BEC4-F515-11E0-8F88-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183415>

Junio C Hamano <gitster@pobox.com> writes:

> Since this is a part of clean-up series...
>
> Do you even need to have a sha1_abbrev[] local array that is limited to 40
> bytes here? The incoming _line_ is not "const char *start", so you should
> at least be able to temporarily terminate the commit object name with NUL
> (while remembering what byte there was before), give it to get_sha1(), and
> then restore the byte at the end before returning from this function.

Like this, perhaps.  I did this on top of the whole series only as a
demonstration but the change should be squashed into this step when the
series is rerolled.

 builtin/revert.c |   47 +++++++++++++++++++----------------------------
 1 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index b28c3ca..170a6c1 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -691,42 +691,34 @@ static int format_todo(struct strbuf *buf, struct replay_insn_list *todo_list)
 	return 0;
 }
 
-static int parse_insn_line(char *start, struct replay_insn_list *item)
+static int parse_insn_line(char *bol, char *eol, struct replay_insn_list *item)
 {
 	unsigned char commit_sha1[20];
-	char sha1_abbrev[40];
-	const char *p, *q;
+	char *end_of_object_name;
+	int saved, status;
 
-	p = start;
-	if (!prefixcmp(start, "pick ")) {
+	if (!prefixcmp(bol, "pick ")) {
 		item->action = REPLAY_PICK;
-		p += strlen("pick ");
-	} else if (!prefixcmp(start, "revert ")) {
+		bol += strlen("pick ");
+	} else if (!prefixcmp(bol, "revert ")) {
 		item->action = REPLAY_REVERT;
-		p += strlen("revert ");
+		bol += strlen("revert ");
 	} else {
-		size_t len = strchrnul(p, '\n') - p;
-		if (len > 255)
-			len = 255;
-		return error(_("Unrecognized action: %.*s"), (int)len, p);
+		return error(_("Unrecognized action: %s"), bol);
 	}
 
-	q = p + strcspn(p, " \n");
-	if (q - p + 1 > sizeof(sha1_abbrev)) {
-		size_t len = q - p;
-		if (len > 255)
-			len = 255;
-		return error(_("Object name too large: %.*s"), (int)len, p);
-	}
-	memcpy(sha1_abbrev, p, q - p);
-	sha1_abbrev[q - p] = '\0';
+	end_of_object_name = bol + strcspn(bol, " \n");
+	saved = *end_of_object_name;
+	*end_of_object_name = '\0';
+	status = get_sha1(bol, commit_sha1);
+	*end_of_object_name = saved;
 
-	if (get_sha1(sha1_abbrev, commit_sha1) < 0)
-		return error(_("Malformed object name: %s"), sha1_abbrev);
+	if (status < 0)
+		return error(_("Malformed object name: %s"), bol);
 
 	item->operand = lookup_commit_reference(commit_sha1);
 	if (!item->operand)
-		return error(_("Not a valid commit: %s"), sha1_abbrev);
+		return error(_("Not a valid commit: %s"), bol);
 
 	item->next = NULL;
 	return 0;
@@ -740,12 +732,11 @@ static int parse_insn_buffer(char *buf, struct replay_insn_list **todo_list)
 	int i;
 
 	for (i = 1; *p; i++) {
-		if (parse_insn_line(p, &item) < 0)
+		char *eol = strchrnul(p, '\n');
+		if (parse_insn_line(p, eol, &item) < 0)
 			return error(_("on line %d."), i);
 		next = replay_insn_list_append(item.action, item.operand, next);
-		p = strchrnul(p, '\n');
-		if (*p)
-			p++;
+		p = *eol ? eol + 1 : eol;
 	}
 	if (!*todo_list)
 		return error(_("No commits parsed."));
