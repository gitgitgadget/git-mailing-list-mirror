From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v13 02/11] trailer: process trailers from input message and
 arguments
Date: Sat, 16 Aug 2014 18:06:12 +0200
Message-ID: <20140816160622.18221.32137.chriscool@tuxfamily.org>
References: <20140816153440.18221.29179.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 16 18:31:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIgsg-0005Tz-Fn
	for gcvg-git-2@plane.gmane.org; Sat, 16 Aug 2014 18:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751702AbaHPQao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2014 12:30:44 -0400
Received: from gleek.ethostream.com ([66.195.129.15]:57344 "EHLO
	barracuda.ethostream.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbaHPQab (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2014 12:30:31 -0400
X-ASG-Debug-ID: 1408205475-016a7707b5114ced0001-QuoKaX
Received: from relay.ethostream.com (www1.ethostream.com [66.195.129.11]) by barracuda.ethostream.com with ESMTP id DCNsuUe9ydXXNGfG; Sat, 16 Aug 2014 11:11:15 -0500 (CDT)
X-Barracuda-Envelope-From: chriscool@tuxfamily.org
X-Barracuda-Apparent-Source-IP: 66.195.129.11
Received: from ethoserver.ezone.net (unknown [10.230.15.218])
	by relay.ethostream.com (Postfix) with ESMTPA id 6E83F891779;
	Sat, 16 Aug 2014 11:11:15 -0500 (CDT)
Received: from [127.0.1.1] (unknown [10.0.7.4])
	by ethoserver.ezone.net (Postfix) with ESMTP id 36459C548C6;
	Sat, 16 Aug 2014 11:11:15 -0500 (CDT)
X-ASG-Orig-Subj: [PATCH v13 02/11] trailer: process trailers from input message and
 arguments
X-git-sha1: e6b0d445a4822fe07b94b304f320884dabbaee15 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140816153440.18221.29179.chriscool@tuxfamily.org>
X-Barracuda-Connect: www1.ethostream.com[66.195.129.11]
X-Barracuda-Start-Time: 1408205475
X-Barracuda-URL: http://66.195.129.15:8000/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at ethostream.com
X-Barracuda-Spam-Score: 3.38
X-Barracuda-Spam-Status: No, SCORE=3.38 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=5.0 tests=FH_DATE_PAST_20XX
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.138343
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	3.38 FH_DATE_PAST_20XX      The date is grossly in the future.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255331>

Implement the logic to process trailers from the input message
and from arguments.

At the beginning trailers from the input message are in their
own "in_tok" doubly linked list, and trailers from arguments
are in their own "arg_tok" doubly linked list.

The lists are traversed and when an "arg_tok" should be "applied",
it is removed from its list and inserted into the "in_tok" list.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 trailer.c | 210 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 210 insertions(+)

diff --git a/trailer.c b/trailer.c
index 2adc1b7..4940e06 100644
--- a/trailer.c
+++ b/trailer.c
@@ -62,3 +62,213 @@ static int same_trailer(struct trailer_item *a, struct trailer_item *b)
 {
 	return same_token(a, b) && same_value(a, b);
 }
+
+static void free_trailer_item(struct trailer_item *item)
+{
+	free(item->conf.name);
+	free(item->conf.key);
+	free(item->conf.command);
+	free((char *)item->token);
+	free((char *)item->value);
+	free(item);
+}
+
+static void update_last(struct trailer_item **last)
+{
+	if (*last)
+		while ((*last)->next != NULL)
+			*last = (*last)->next;
+}
+
+static void update_first(struct trailer_item **first)
+{
+	if (*first)
+		while ((*first)->previous != NULL)
+			*first = (*first)->previous;
+}
+
+static void add_arg_to_input_list(struct trailer_item *on_tok,
+				  struct trailer_item *arg_tok,
+				  struct trailer_item **first,
+				  struct trailer_item **last)
+{
+	if (after_or_end(arg_tok->conf.where)) {
+		arg_tok->next = on_tok->next;
+		on_tok->next = arg_tok;
+		arg_tok->previous = on_tok;
+		if (arg_tok->next)
+			arg_tok->next->previous = arg_tok;
+		update_last(last);
+	} else {
+		arg_tok->previous = on_tok->previous;
+		on_tok->previous = arg_tok;
+		arg_tok->next = on_tok;
+		if (arg_tok->previous)
+			arg_tok->previous->next = arg_tok;
+		update_first(first);
+	}
+}
+
+static int check_if_different(struct trailer_item *in_tok,
+			      struct trailer_item *arg_tok,
+			      int check_all)
+{
+	enum action_where where = arg_tok->conf.where;
+	do {
+		if (!in_tok)
+			return 1;
+		if (same_trailer(in_tok, arg_tok))
+			return 0;
+		/*
+		 * if we want to add a trailer after another one,
+		 * we have to check those before this one
+		 */
+		in_tok = after_or_end(where) ? in_tok->previous : in_tok->next;
+	} while (check_all);
+	return 1;
+}
+
+static void remove_from_list(struct trailer_item *item,
+			     struct trailer_item **first,
+			     struct trailer_item **last)
+{
+	struct trailer_item *next = item->next;
+	struct trailer_item *previous = item->previous;
+
+	if (next) {
+		item->next->previous = previous;
+		item->next = NULL;
+	} else if (last)
+		*last = previous;
+
+	if (previous) {
+		item->previous->next = next;
+		item->previous = NULL;
+	} else if (first)
+		*first = next;
+}
+
+static struct trailer_item *remove_first(struct trailer_item **first)
+{
+	struct trailer_item *item = *first;
+	*first = item->next;
+	if (item->next) {
+		item->next->previous = NULL;
+		item->next = NULL;
+	}
+	return item;
+}
+
+static void apply_arg_if_exists(struct trailer_item *in_tok,
+				struct trailer_item *arg_tok,
+				struct trailer_item *on_tok,
+				struct trailer_item **in_tok_first,
+				struct trailer_item **in_tok_last)
+{
+	switch (arg_tok->conf.if_exists) {
+	case EXISTS_DO_NOTHING:
+		free_trailer_item(arg_tok);
+		break;
+	case EXISTS_REPLACE:
+		add_arg_to_input_list(on_tok, arg_tok,
+				      in_tok_first, in_tok_last);
+		remove_from_list(in_tok, in_tok_first, in_tok_last);
+		free_trailer_item(in_tok);
+		break;
+	case EXISTS_ADD:
+		add_arg_to_input_list(on_tok, arg_tok,
+				      in_tok_first, in_tok_last);
+		break;
+	case EXISTS_ADD_IF_DIFFERENT:
+		if (check_if_different(in_tok, arg_tok, 1))
+			add_arg_to_input_list(on_tok, arg_tok,
+					      in_tok_first, in_tok_last);
+		else
+			free_trailer_item(arg_tok);
+		break;
+	case EXISTS_ADD_IF_DIFFERENT_NEIGHBOR:
+		if (check_if_different(on_tok, arg_tok, 0))
+			add_arg_to_input_list(on_tok, arg_tok,
+					      in_tok_first, in_tok_last);
+		else
+			free_trailer_item(arg_tok);
+		break;
+	}
+}
+
+static void apply_arg_if_missing(struct trailer_item **in_tok_first,
+				 struct trailer_item **in_tok_last,
+				 struct trailer_item *arg_tok)
+{
+	struct trailer_item **in_tok;
+	enum action_where where;
+
+	switch (arg_tok->conf.if_missing) {
+	case MISSING_DO_NOTHING:
+		free_trailer_item(arg_tok);
+		break;
+	case MISSING_ADD:
+		where = arg_tok->conf.where;
+		in_tok = after_or_end(where) ? in_tok_last : in_tok_first;
+		if (*in_tok) {
+			add_arg_to_input_list(*in_tok, arg_tok,
+					      in_tok_first, in_tok_last);
+		} else {
+			*in_tok_first = arg_tok;
+			*in_tok_last = arg_tok;
+		}
+		break;
+	}
+}
+
+static int find_same_and_apply_arg(struct trailer_item **in_tok_first,
+				   struct trailer_item **in_tok_last,
+				   struct trailer_item *arg_tok)
+{
+	struct trailer_item *in_tok;
+	struct trailer_item *on_tok;
+	struct trailer_item *following_tok;
+
+	enum action_where where = arg_tok->conf.where;
+	int middle = (where == WHERE_AFTER) || (where == WHERE_BEFORE);
+	int backwards = after_or_end(where);
+	struct trailer_item *start_tok = backwards ? *in_tok_last : *in_tok_first;
+
+	for (in_tok = start_tok; in_tok; in_tok = following_tok) {
+		following_tok = backwards ? in_tok->previous : in_tok->next;
+		if (!same_token(in_tok, arg_tok))
+			continue;
+		on_tok = middle ? in_tok : start_tok;
+		apply_arg_if_exists(in_tok, arg_tok, on_tok,
+				    in_tok_first, in_tok_last);
+		return 1;
+	}
+	return 0;
+}
+
+static void process_trailers_lists(struct trailer_item **in_tok_first,
+				   struct trailer_item **in_tok_last,
+				   struct trailer_item **arg_tok_first)
+{
+	struct trailer_item *arg_tok;
+	struct trailer_item *next_arg;
+
+	if (!*arg_tok_first)
+		return;
+
+	for (arg_tok = *arg_tok_first; arg_tok; arg_tok = next_arg) {
+		int applied = 0;
+
+		next_arg = arg_tok->next;
+		remove_from_list(arg_tok, arg_tok_first, NULL);
+
+		applied = find_same_and_apply_arg(in_tok_first,
+						  in_tok_last,
+						  arg_tok);
+
+		if (!applied)
+			apply_arg_if_missing(in_tok_first,
+					     in_tok_last,
+					     arg_tok);
+	}
+}
-- 
2.0.1.674.ga7f57b7
