From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] describe: Refresh the index when run with --dirty
Date: Tue, 02 Aug 2011 14:59:35 -0700
Message-ID: <7v1ux3eapk.fsf@alter.siamese.dyndns.org>
References: <20110731062055.GB14384@sigill.intra.peff.net>
 <1312163561-77072-1-git-send-email-allan.caffee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Allan Caffee <allan.caffee@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 23:59:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoN09-0004dQ-KM
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 23:59:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755525Ab1HBV7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 17:59:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44321 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755415Ab1HBV7j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 17:59:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD78A4E0E;
	Tue,  2 Aug 2011 17:59:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F3RaWF6VyKOubDMzjI4mcLuLims=; b=DBGLZg
	JatVyaQ8IrsI5go/xwPwni01ztE8OmtZP06HNC36L/AJdgP9/t0tOTzWhrRERX+S
	dub7ecmoFpEuOdy3l8de+tcgvqEEELY0EHDfTf5gV0jn+tCy3i4Dgahvn28s+nQX
	KkRuEPEvu3HCgexp0m4HCAmXyQ/56t3Gv5vuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tPnH3YNildOSv8Clf8H0jlh34A2Iq/wZ
	H6ktygsuP09+jUIjnGlYEhPVpVfWsMYRnyuE78f1BTBSw9au8TAvF7kgQTHpOJlZ
	PcNADmdlRZleltm96ysR5tKfC1fkwAtASXOOFGY5JJeOZPsFkGPDyMbUDWI/uJ5G
	Zf75DmMcOI0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B39CD4E0D;
	Tue,  2 Aug 2011 17:59:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 189324E0C; Tue,  2 Aug 2011
 17:59:37 -0400 (EDT)
In-Reply-To: <1312163561-77072-1-git-send-email-allan.caffee@gmail.com>
 (Allan Caffee's message of "Sun, 31 Jul 2011 21:52:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B749595E-BD52-11E0-8A78-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178514>

Thanks.

Here is a minor fix-up on top, that can be squashed in a re-roll (if you
plan to do one).

diff --git a/builtin/describe.c b/builtin/describe.c
index 792af76..9f63067 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -24,7 +24,6 @@ static int longformat;
 static int abbrev = -1; /* unspecified */
 static int max_candidates = 10;
 static struct hash_table names;
-static struct lock_file index_lock; /* real index */
 static int have_util;
 static const char *pattern;
 static int always;
@@ -400,7 +399,6 @@ static void describe(const char *arg, int last_one)
 int cmd_describe(int argc, const char **argv, const char *prefix)
 {
 	int contains = 0;
-	int fd;
 	struct option options[] = {
 		OPT_BOOLEAN(0, "contains",   &contains, "find the tag that comes after the commit"),
 		OPT_BOOLEAN(0, "debug",      &debug, "debug search strategy on stderr"),
@@ -465,13 +463,18 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 
 	if (argc == 0) {
 		if (dirty) {
-			read_cache();
-			refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
+			static struct lock_file index_lock;
+			int fd;
+
+			read_cache_preload(NULL);
+			refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED,
+				      NULL, NULL, NULL);
 			fd = hold_locked_index(&index_lock, 0);
 			if (0 <= fd)
 				update_index_if_able(&the_index, &index_lock);
 
-			if (!cmd_diff_index(ARRAY_SIZE(diff_index_args) - 1, diff_index_args, prefix))
+			if (!cmd_diff_index(ARRAY_SIZE(diff_index_args) - 1,
+					    diff_index_args, prefix))
 				dirty = NULL;
 		}
 		describe("HEAD", 1);
