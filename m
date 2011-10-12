From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] Restrict ref-like names immediately below $GIT_DIR
Date: Wed, 12 Oct 2011 10:49:41 -0700
Message-ID: <7vvcru9k22.fsf_-_@alter.siamese.dyndns.org>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
 <1316121043-29367-20-git-send-email-mhagger@alum.mit.edu>
 <20111011161652.GA15629@sigill.intra.peff.net>
 <7vr52jfm8i.fsf@alter.siamese.dyndns.org>
 <7vmxd7flkw.fsf@alter.siamese.dyndns.org>
 <7v39ezffq5.fsf_-_@alter.siamese.dyndns.org>
 <20111011230749.GA29785@sigill.intra.peff.net>
 <7vehyjcckp.fsf@alter.siamese.dyndns.org>
 <20111012021128.GA32149@sigill.intra.peff.net>
 <7v39eyddoc.fsf@alter.siamese.dyndns.org>
 <20111012045004.GA22413@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	cmn@elego.de, A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 12 19:49:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE2w8-0004b0-Ik
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 19:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759Ab1JLRto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 13:49:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43559 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751612Ab1JLRtn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 13:49:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E70F54CD;
	Wed, 12 Oct 2011 13:49:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aguaSypj5gmn6PWdGRO+vRSH6u0=; b=dV5m55
	3g+Vy88gijJr2D8aFIy6GhBQvKVGcMebH08/dDqknzeFzRAHmUKkhxp+m5y8c+j+
	fgI43Qp+Uwd3SrqCuIMAcHCAaXae4FdTlKknlGo5DSB/fNJu+27GxZUcR/mpJ55n
	qlIdM1mqx0Q7zJcIJpor93PSrdLxwYwyKpjDk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ad+e28k4S0qgIpm1dieBtLV6Aq9nlWT7
	Ytsc7M5mLz0tiz3jDDC4nxW+7r5dreH+pkgQeq3zLEoj/PPrztuweOTslouN2+rf
	+wXe2yvuxIezrW2hGdHKIEVp8oICmymz58QCLZM9DWCm7VRRPziY4hb8j/Zy0ssu
	zB6FrYqUaA0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4621354CC;
	Wed, 12 Oct 2011 13:49:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B9C654C8; Wed, 12 Oct 2011
 13:49:42 -0400 (EDT)
In-Reply-To: <20111012045004.GA22413@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 12 Oct 2011 00:50:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 909F6764-F4FA-11E0-8F8C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183380>

We have always dwimmed the user input $string into a ref by first looking
directly inside $GIT_DIR, and then in $GIT_DIR/refs, $GIT_DIR/refs/tags,
etc., and that is what made

    git log HEAD..MERGE_HEAD

work correctly. This however means that

    git rev-parse config
    git log index

would look at $GIT_DIR/config and $GIT_DIR/index and see if they are valid
refs.

To reduce confusion, let's not dwim a path immediately below $GIT_DIR that
is not all-caps.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * And this adds coverage to refname_match() and shorten_unambiguous_ref()
   on top of the one from yesterday.
 
 refs.c |   36 ++++++++++++++++++++++++++++++++++--
 1 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index e3692bd..e54c482 100644
--- a/refs.c
+++ b/refs.c
@@ -994,12 +994,34 @@ const char *ref_fetch_rules[] = {
 	NULL
 };
 
+static int refname_ok_at_root_level(const char *str, int len)
+{
+	int seen_non_root_char = 0;
+
+	while (len--) {
+		char ch = *str++;
+
+		if (ch == '/')
+			return 1;
+		/*
+		 * Only accept likes of .git/HEAD, .git/MERGE_HEAD at
+		 * the root level as a ref.
+		 */
+		if (ch != '_' && (ch < 'A' || 'Z' < ch))
+			seen_non_root_char = 1;
+	}
+	return !seen_non_root_char;
+}
+
 int refname_match(const char *abbrev_name, const char *full_name, const char **rules)
 {
 	const char **p;
 	const int abbrev_name_len = strlen(abbrev_name);
 
 	for (p = rules; *p; p++) {
+		if (p == rules &&
+		    !refname_ok_at_root_level(abbrev_name, abbrev_name_len))
+			continue;
 		if (!strcmp(full_name, mkpath(*p, abbrev_name_len, abbrev_name))) {
 			return 1;
 		}
@@ -1100,6 +1122,8 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 		unsigned char *this_result;
 		int flag;
 
+		if (p == ref_rev_parse_rules && !refname_ok_at_root_level(str, len))
+			continue;
 		this_result = refs_found ? sha1_from_ref : sha1;
 		mksnpath(fullref, sizeof(fullref), *p, len, str);
 		r = resolve_ref(fullref, this_result, 1, &flag);
@@ -1128,6 +1152,8 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 		char path[PATH_MAX];
 		const char *ref, *it;
 
+		if (p == ref_rev_parse_rules && !refname_ok_at_root_level(str, len))
+			continue;
 		mksnpath(path, sizeof(path), *p, len, str);
 		ref = resolve_ref(path, hash, 1, NULL);
 		if (!ref)
@@ -2045,12 +2071,14 @@ char *shorten_unambiguous_ref(const char *ref, int strict)
 	/* buffer for scanf result, at most ref must fit */
 	short_name = xstrdup(ref);
 
-	/* skip first rule, it will always match */
-	for (i = nr_rules - 1; i > 0 ; --i) {
+	for (i = nr_rules - 1; i >= 0; i--) {
 		int j;
 		int rules_to_fail = i;
 		int short_name_len;
 
+		if (!i && !refname_ok_at_root_level(ref, strlen(ref)))
+			continue;
+
 		if (1 != sscanf(ref, scanf_fmts[i], short_name))
 			continue;
 
@@ -2076,6 +2104,10 @@ char *shorten_unambiguous_ref(const char *ref, int strict)
 			if (i == j)
 				continue;
 
+			if (!j &&
+			    !refname_ok_at_root_level(short_name, short_name_len))
+				continue;
+
 			/*
 			 * the short name is ambiguous, if it resolves
 			 * (with this previous rule) to a valid ref
-- 
1.7.7.213.g8b0e1
