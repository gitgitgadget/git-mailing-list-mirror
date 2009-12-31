From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Wed, 30 Dec 2009 23:09:52 -0800
Message-ID: <7vzl4zy5z3.fsf@alter.siamese.dyndns.org>
References: <1262182304-19911-1-git-send-email-pclouds@gmail.com>
 <7v637nzky0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 31 08:10:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQFAn-0007Ko-3M
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 08:10:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbZLaHKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 02:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbZLaHKE
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 02:10:04 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53931 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbZLaHKC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 02:10:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AC205ABDF6;
	Thu, 31 Dec 2009 02:09:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bV9M1RuDi6jkEXaB07oopv9lzkw=; b=eVNU9P
	MQVB0Tw0zaCVO1nkfguAqpFSLgmilr53tewpiPsvvtXCKntWrNsdnjQC6UB00sL1
	jK4Vrf56cXvyOVcDar62WBewOIrLTi+X8V680som6IyzDZthp/TR3LusMnWgBptI
	MMrP7m1q7BVvRqxk08RBa1agDDYpYriSay1Ew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IPzCNy5hyufmfyFQkFlbFkZRwA51RI56
	lyWeBkQyFDXmuwVMTgyzP4v5BszInEByFJbTq+0UVcRynQh9zE19qm8lEEDaH7/V
	J11UmfZZA70Q158IBvdvIqEF42PLDoF5DA9Al1Mc6YPMf5rRSbAXbEJJdOtF4roI
	t1t+Unh0T5Y=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8B138ABDF4;
	Thu, 31 Dec 2009 02:09:57 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 736E0ABDF2; Thu, 31 Dec 2009
 02:09:54 -0500 (EST)
In-Reply-To: <7v637nzky0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 30 Dec 2009 23\:01\:11 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 80CD5096-F5DB-11DE-BC09-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135936>

Junio C Hamano <gitster@pobox.com> writes:

> This looks a bit wrong for a couple of reasons:
>
>  - external_grep() is designed to return negative without running external
>    grep when it shouldn't be used (see the beginning of the function for
>    how it refuses to run when opt->extended is set and other conditions).
>    The new logic seems to belong there, i.e. "in addition to the existing
>    case we decline, if ce_skip_worktree() entry exists in the cache, we
>    decline";

IOW, something like this instead of your patch.  You would want to tests
to demonstrate the original breakage, perhaps?

 builtin-grep.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/builtin-grep.c b/builtin-grep.c
index 813fe97..25ee75d 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -357,6 +357,21 @@ static void grep_add_color(struct strbuf *sb, const char *escape_seq)
 		strbuf_setlen(sb, sb->len - 1);
 }
 
+static int has_skip_worktree_entry(struct grep_opt *opt, const char **paths)
+{
+	int nr;
+	for (nr = 0; nr < active_nr; nr++) {
+		struct cache_entry *ce = active_cache[nr];
+		if (!S_ISREG(ce->ce_mode))
+			continue;
+		if (!pathspec_matches(paths, ce->name, opt->max_depth))
+			continue;
+		if (ce_skip_worktree(ce))
+			return 1;
+	}
+	return 0;
+}
+
 static int external_grep(struct grep_opt *opt, const char **paths, int cached)
 {
 	int i, nr, argc, hit, len, status;
@@ -365,7 +380,8 @@ static int external_grep(struct grep_opt *opt, const char **paths, int cached)
 	char *argptr = randarg;
 	struct grep_pat *p;
 
-	if (opt->extended || (opt->relative && opt->prefix_length))
+	if (opt->extended || (opt->relative && opt->prefix_length)
+	    || has_skip_worktree_entry(opt, paths))
 		return -1;
 	len = nr = 0;
 	push_arg("grep");
