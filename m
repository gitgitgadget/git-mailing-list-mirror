From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] rev-parse --namespace
Date: Tue, 19 Jan 2010 12:06:12 -0800
Message-ID: <7v3a21amh7.fsf@alter.siamese.dyndns.org>
References: <1263798952-27624-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <201001191839.27090.trast@student.ethz.ch> <20100119183736.GA24204@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Jan 19 21:06:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXKLP-00066C-Ca
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 21:06:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754297Ab0ASUGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 15:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754263Ab0ASUGY
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 15:06:24 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44087 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039Ab0ASUGX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 15:06:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 58E2792268;
	Tue, 19 Jan 2010 15:06:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=uozoO5kwPLr/sNN+7aAeto7Qsco=; b=sKHM1N48M147NrZo3NKwLAH
	dCNWmP1fGu6IVkc/hMwa7MGvICHgpyKNgqjH8L8NpH/gNwPWyMY50hVfH/daHlV3
	yF7A3sIYUgoNKaz3n9qsDciQX1lNhWkgQEJTM/Q4Qs7nP/1fUnB6/17NkINlZVrY
	gU7I2Ds2nJrNIYjgTuI0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=wd+YbWM+aFZYVruOZ1SZ9EEx4Buncjdd8KzoDc7GjQi2ZqY/K
	WihSNvPBmhhiC69ad58Rl7QFE8d17zKZWLOtszoI45nKOoD/byhO8Jdyg9xPEqn8
	b0bWjf4yc1ApqWeC8PflxsAmoUR4PMVoWPjxNe4e6/NKqgssfQW8gibavY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 24C0292264;
	Tue, 19 Jan 2010 15:06:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 369C49225C; Tue, 19 Jan
 2010 15:06:14 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1AD89B96-0536-11DF-834E-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137492>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> ..., if matching power would be extended,
> probably the easiest extension would be full-blown extended regular
> expressions.

As refs behave like a filesystem path and we try to use fnmatch() for
anything that behave like a filesystem path, that would break consistency.

But a patch to add fnmatch() shouldn't be too bad; something like this
(not even compile tested)?

 refs.c |   45 +++++++++++++++++++++++++++++++++++++--------
 1 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 5583f4b..0494c75 100644
--- a/refs.c
+++ b/refs.c
@@ -674,19 +674,48 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
 	return do_for_each_ref("refs/replace/", fn, 13, 0, cb_data);
 }
 
+struct ref_glob_filter {
+	each_ref_fn *user_callback;
+	void *user_cb_data;
+	const char *pattern;
+	int pattern_len;
+};
+
+static int ref_glob_filter_cb(const char *refname,
+			      const unsigned char *sha1,
+			      int flags, void *cb_data)
+{
+	struct ref_glob_filter *cb = cb_data;
+
+	/*
+	 * Reject if it does not produce a prefix match and
+	 * it doesn't pass fnmatch().
+	 */
+	if (!(cb->pattern_len <= strlen(refname)
+	      && !memcmp(cb->pattern, refname, cb->pattern_len)) &&
+	    fnmatch(cb->pattern, refname, 0))
+		return 0;
+	return cb->user_callback(refname, sha1, flags, cb->user_cb_data);
+}
+
 int for_each_namespace_ref(each_ref_fn fn, const char *ns_name, void *cb_data)
 {
-	struct strbuf real_prefix = STRBUF_INIT;
+	struct ref_glob_filter filter;
+	struct strbuf pattern = STRBUF_INIT;
 	int ret;
 
 	if (prefixcmp(ns_name, "refs/"))
-		strbuf_addstr(&real_prefix, "refs/");
-	strbuf_addstr(&real_prefix, ns_name);
-	if (real_prefix.buf[real_prefix.len - 1] != '/')
-		strbuf_addch(&real_prefix, '/');
-
-	ret = for_each_ref_in(real_prefix.buf, fn, cb_data);
-	strbuf_release(&real_prefix);
+		strbuf_addstr(&pattern, "refs/");
+	strbuf_addstr(&pattern, ns_name);
+	if (pattern.buf[pattern.len - 1] != '/')
+		strbuf_addch(&pattern, '/');
+	filter.pattern = pattern.buf;
+	filter.pattern_len = pattern.len;
+	filter.user_callback = fn;
+	filter.user_cb_data = cb_data;
+
+	ret = for_each_ref(ref_glob_filter_cb, &filter);
+	strbuf_release(&pattern);
 	return ret;
 }
 
