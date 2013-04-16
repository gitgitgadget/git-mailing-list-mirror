From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 16/33] t3210: test for spurious error messages for
 dangling packed refs
Date: Tue, 16 Apr 2013 16:22:25 -0700
Message-ID: <7vip3mhxhq.fsf@alter.siamese.dyndns.org>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
 <1365944088-10588-17-git-send-email-mhagger@alum.mit.edu>
 <7vobdfvglf.fsf@alter.siamese.dyndns.org> <516D5CC6.10505@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Heiko Voigt <hvoigt@hvoigt.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Apr 17 01:22:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USFCz-00014L-7t
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 01:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965650Ab3DPXWa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 19:22:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60688 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965609Ab3DPXW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 19:22:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F259A17A31;
	Tue, 16 Apr 2013 23:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6Hgr5ndmang9BSICkbWP3SIkkGo=; b=tfT9xu
	3WsJ3T9FAECyp9GmwHq2b39bWO3eOhGrhYroCzMwYiuZLuNQjnPVKBSwf5rN2jQ6
	wtlYDQhIv9RynWbRoIOA95ldeVsUqgyD4lNYdyZUe0hOxh1eclM86TEuPRqmyAFx
	ZUMCREUDQLqYIUkBbFcuNDD3o8sybi2GfgSwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bgDQ9Xq8VPeXabOg2lEBRsrbxE82SJog
	bYlHCULCZkvEtJhxGg4S9/aMIbohCwF3BxnSY6wBnpD8MuyaSuKS/F3qgp8rmFw5
	LzNI/t0uHOuaEeZwuILfo+GvIpnrbnbk4KrjLHZrEhdGDLiM1lDlZubH6BsHgJxG
	7fejlQ9h84I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA65D17A30;
	Tue, 16 Apr 2013 23:22:27 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 39E7517A2F; Tue, 16 Apr
 2013 23:22:27 +0000 (UTC)
In-Reply-To: <516D5CC6.10505@alum.mit.edu> (Michael Haggerty's message of
 "Tue, 16 Apr 2013 16:14:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8079D5CC-A6EC-11E2-B64B-CC48E7F0ECB6-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221488>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> would be that it expires *everything*.  But in fact it seems to only
> expire things that are at least one second old, which doesn't seem at
> all useful in the real world.  "--expire=all" is accepted without
> complaint but doesn't do what one would hope.

Perhaps that is worth fixing, independent of this topic.

Approxidate gives the current time for anything it does not
understand, and that is how --expire=all is interpreted as "anything
older than now".  For that matter, even a string "now" has long been
interpreted as the current time with the same "I do not understand
it, so I'll give you the current timestamp" logic, until we added an
official support for "now" at 93cfa7c7a85e (approxidate_careful()
reports errorneous date string, 2010-01-26) for entirely different
reasons.

A completely untested patch for your enjoyment...

 builtin/reflog.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 72a0af7..9fa0e41 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -492,15 +492,28 @@ static struct reflog_expire_cfg *find_cfg_ent(const char *pattern, size_t len)
 	return ent;
 }
 
+static void parse_expire_value(const char *value, unsigned long *expire)
+{
+	if (!strcmp(value, "never") || !strcmp(value, "false"))
+		*expire = 0;
+	else if (!strcmp(value, "all") || !strcmp(value, "now"))
+		/*
+		 * We take over "now" here, which usually translates
+		 * to the current timestamp, because the user really
+		 * means everything she has done in the past, and by
+		 * definition reflogs are the record of the past,
+		 * there is nothing from the future to be kept.
+		 */
+		*expire = ULONG_MAX;
+	else
+		*expire = approxidate(value);
+}
+
 static int parse_expire_cfg_value(const char *var, const char *value, unsigned long *expire)
 {
 	if (!value)
 		return config_error_nonbool(var);
-	if (!strcmp(value, "never") || !strcmp(value, "false")) {
-		*expire = 0;
-		return 0;
-	}
-	*expire = approxidate(value);
+	parse_expire_value(value, expire);
 	return 0;
 }
 
@@ -614,11 +627,11 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 		if (!strcmp(arg, "--dry-run") || !strcmp(arg, "-n"))
 			cb.dry_run = 1;
 		else if (!prefixcmp(arg, "--expire=")) {
-			cb.expire_total = approxidate(arg + 9);
+			parse_expire_value(arg + 9, &cb.expire_total);
 			explicit_expiry |= EXPIRE_TOTAL;
 		}
 		else if (!prefixcmp(arg, "--expire-unreachable=")) {
-			cb.expire_unreachable = approxidate(arg + 21);
+			parse_expire_value(arg + 21, &cb.expire_unreachable);
 			explicit_expiry |= EXPIRE_UNREACH;
 		}
 		else if (!strcmp(arg, "--stale-fix"))
