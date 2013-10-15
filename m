From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] split_ident: parse timestamp from end of line
Date: Tue, 15 Oct 2013 10:52:55 -0700
Message-ID: <xmqqob6qe808.fsf@gitster.dls.corp.google.com>
References: <20131014202734.GA7007@sigill.intra.peff.net>
	<xmqqwqlfebhi.fsf@gitster.dls.corp.google.com>
	<20131014223137.GA12744@sigill.intra.peff.net>
	<xmqqsiw3eajt.fsf@gitster.dls.corp.google.com>
	<20131014232949.GA10415@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 15 19:53:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VW8oL-0003SA-P3
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 19:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933641Ab3JORxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 13:53:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35425 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933013Ab3JORxd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 13:53:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B08D4A5E1;
	Tue, 15 Oct 2013 17:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zeFMSpCi/GTyhZgxEXFWLaRc+g4=; b=HBu0II
	wtUQm3rwg/oeb2drg1beHxlP5MHKzkqoDC+tunegx8gm6IwgbNyu8fADyP3bY2xC
	XnvSiaJ1HrrJSOMlWUIIkMbLZ5ZpsD/TstVpf/CRFV8H10o6M5zFylwMzIshRIKu
	DzzrfVd2Y9IIodRapDhbBVQMODDorbNLxCxIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QwXlmQE3UIzsNcb0xFCOmbwo6e1m+I3N
	Kp8nevUx83Zlo9UwZnFCBbeaK30TSVFw29HeRfBrGRwMNHlMMHXyiElZCERlgr5s
	VN9fqIhIEvkk6BH4TNvy7rioSaBy24FNJzxb0oaIUp0yyx1w57rAFjlzMduqn/ak
	t/o7eDyCGe8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3577A4A5AD;
	Tue, 15 Oct 2013 17:53:08 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 365A04A579;
	Tue, 15 Oct 2013 17:52:59 +0000 (UTC)
In-Reply-To: <20131014232949.GA10415@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 14 Oct 2013 19:29:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A565804C-35C2-11E3-B914-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236190>

Jeff King <peff@peff.net> writes:

>> Yeah, unrolling the loop is probably better.  You may even be able
>> to do so in a single pass with an extra "last > seen" pointer
>> variable without too much additional code complexity, I would think.
>
> I'm not sure what you mean here.

> If you mean doing a single pass to find the final ">", that is easy,
> because we know the length of the line already and can jump past and
> start from the back.

I meant a single forward pass, like this.

 ident.c | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/ident.c b/ident.c
index 7d1c79c..ff29779 100644
--- a/ident.c
+++ b/ident.c
@@ -200,7 +200,7 @@ static void strbuf_addstr_without_crud(struct strbuf *sb, const char *src)
  */
 int split_ident_line(struct ident_split *split, const char *line, int len)
 {
-	const char *cp;
+	const char *cp, *last_ket;
 	size_t span;
 	int status = -1;
 
@@ -225,29 +225,22 @@ int split_ident_line(struct ident_split *split, const char *line, int len)
 		split->name_end = split->name_begin;
 	}
 
-	for (cp = split->mail_begin; cp < line + len; cp++)
-		if (*cp == '>') {
+	for (cp = split->mail_begin, last_ket = NULL; cp < line + len; cp++) {
+		if (*cp != '>')
+			continue;
+		if (!last_ket)
 			split->mail_end = cp;
-			break;
-		}
+		last_ket = cp;
+	}
 	if (!split->mail_end)
 		return status;
 
 	/*
-	 * Look from the end-of-line to find the trailing ">" of the mail
-	 * address, even though we should already know it as split->mail_end.
-	 * This can help in cases of broken idents with an extra ">" somewhere
-	 * in the email address.  Note that we are assuming the timestamp will
-	 * never have a ">" in it.
-	 *
-	 * Note that we will always find some ">" before going off the front of
-	 * the string, because will always hit the split->mail_end closing
-	 * bracket.
+	 * Typically, last_ket is the same as split_mail_end, but with
+	 * a broken identity line, there may be multiple closing ket '>';
+	 * read the timestamp after the last one.
 	 */
-	for (cp = line + len - 1; *cp != '>'; cp--)
-		;
-
-	for (cp = cp + 1; cp < line + len && isspace(*cp); cp++)
+	for (cp = last_ket + 1; cp < line + len && isspace(*cp); cp++)
 		;
 	if (line + len <= cp)
 		goto person_only;
