From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] OPT__QUIET(): switch from count-up to true bool
Date: Tue,  6 Aug 2013 16:31:26 -0700
Message-ID: <1375831889-9610-2-git-send-email-gitster@pobox.com>
References: <7viozihh26.fsf@alter.siamese.dyndns.org>
 <1375831889-9610-1-git-send-email-gitster@pobox.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 07 01:31:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6qjF-0003DW-WF
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 01:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756203Ab3HFXbf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 19:31:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52083 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756073Ab3HFXbe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 19:31:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B972A36D24;
	Tue,  6 Aug 2013 23:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=8Ay6
	dS6aChiBGDhcNECOj5iTMkM=; b=NsP6MD4rmNL022rp6N8GQU4fy53DBa+KCmV3
	GTd/TYXxayBCQrQSpqXN2dWjQPLN/eW30SOm0sChBmO6WZlbnO//VF+3sX66Rs5U
	NwTHTEFdUQpgwlV9zCiQZDNyaT5CrXM9SOPzqU/ztTOax7AqFOgNBgeT4qgH3ETX
	i99XAXA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	c4G7d1N/TRBTiAkGNTRAMtO9EgBTyCbxItvC1K4uhVHIwSr60rDDG6v0hEWjvZES
	SS/9gbl4i3rLmWI2JmUTaZXGYgTXjkDlB/8MqrqJOTs8zpIsEzDLCNFH+OsZaRr7
	vT8QysKWWzrPRmK5iywFku6B7MtifDFuHvQUHSBpjTk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B07A036D23;
	Tue,  6 Aug 2013 23:31:33 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ECDEC36D1F;
	Tue,  6 Aug 2013 23:31:32 +0000 (UTC)
X-Mailer: git-send-email 1.8.4-rc1-210-gf6d87e2
In-Reply-To: <1375831889-9610-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 540534A8-FEF0-11E2-A378-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231796>

The parseopt parsing for OPT__QUIET() is implemented in terms of
OPT_BOOLEAN aka OPT_COUNTUP, so a user _could_ theoretically have
used it to make "git cmd -q -q" and "git cmd -q" behave differently.

However, no existing user does so (a summary of the audit at the
end).  Use OPT_BOOL to make sure our choices are either 0 or 1.

    builtin/branch.c:

	quiet is passed to create_branch() in branch.c and
	delete_branches().  The former passes it to setup_tracking()
	which is used as a bool to decide use of BRANCH_CONFIG_VERBOSE.
	The latter uses it as a bool to give a single printf() for
	reporting the names of deleted branches.

    builtin/check-ignore.c:

	all users of quiet use it as a bool.

    builtin/checkout-index.c:

	quiet is assigned to state.quite and only the latter is used
	throughout the program.  It is a single-bit bitfield.

    builtin/checkout.c:

	quiet is stored in checkout_opts.quiet which is of type int.  It
	is used in many places:

	- reset_tree() uses it as a bool;

	- merge_working_tree() uses it twice, as a bool at both
	  places;

	- update_refs_for_switch() uses it three times, all as a bool.
	  It also passes it to create_branch() which we already verified
	  above.

	- switch_branches() and switch_unborn_to_new_branch() use it
	  once each, as a bool at both places.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 parse-options.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.h b/parse-options.h
index c378b75..f2b01ee 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -231,7 +231,7 @@ extern int parse_opt_string_list(const struct option *, const char *, int);
 extern int parse_opt_noop_cb(const struct option *, const char *, int);
 
 #define OPT__VERBOSE(var, h)  OPT_BOOLEAN('v', "verbose", (var), (h))
-#define OPT__QUIET(var, h)    OPT_BOOLEAN('q', "quiet",   (var), (h))
+#define OPT__QUIET(var, h)    OPT_BOOL('q', "quiet",   (var), (h))
 #define OPT__VERBOSITY(var) \
 	{ OPTION_CALLBACK, 'v', "verbose", (var), NULL, N_("be more verbose"), \
 	  PARSE_OPT_NOARG, &parse_opt_verbosity_cb, 0 }, \
-- 
1.8.4-rc1-210-gf6d87e2
