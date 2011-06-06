From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [BUG] "git checkout -b" erronously thinks a branch already
 exists
Date: Sun, 05 Jun 2011 18:38:14 -0700
Message-ID: <7v62ojbuyh.fsf@alter.siamese.dyndns.org>
References: <201106051305.13723.stefano.lattarini@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefano Lattarini <stefano.lattarini@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 03:38:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTOm7-0006IY-RE
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 03:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754788Ab1FFBiW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2011 21:38:22 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36883 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130Ab1FFBiV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2011 21:38:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 424C56BA1;
	Sun,  5 Jun 2011 21:40:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DXdKyfyAaR2gvVGQh9usYW8PSVI=; b=HjVjM/
	r9Nj3bzc3lTDz5RLI2JhhvJhNm1OCM5f0kyeCDfIBkKlTR+pi8CHEiYZQgp8R9v3
	uyfxFo5wnG2k0RAn4FvlIZmgl5zM2DM9H3POBU7Y3q7axk31GnE9gEpD3pTtJpdN
	zsPVayZxbMIM/g49vVBkGyAtWUFuQGqFuPUo8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YOmyM4yub2vLF6kONQEtbMvVJsQc0LsJ
	c87M3Bf990U+6Ux/rKnNX7D7pvEmDCHcAUDCF3DKZZJeoUmFMWoFmwocrBWX4/Eb
	8xYhUJaZ8TBlPgikD/on68ZiB8ivh3bgAd3I4fyAqxLDqsYKwYpMOKjzMt/Zs2wh
	+Ng+2ZLxwYk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 219A96BA0;
	Sun,  5 Jun 2011 21:40:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 17CE76B9F; Sun,  5 Jun 2011
 21:40:25 -0400 (EDT)
In-Reply-To: <201106051305.13723.stefano.lattarini@gmail.com> (Stefano
 Lattarini's message of "Sun, 5 Jun 2011 13:05:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F5818E8C-8FDD-11E0-91A1-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175090>

Interesting.

This is because "git checkout -b <name>" tries to make sure that
"refs/heads/<name>" does not exist, and the way it does it to pass it
to get_sha1() and make sure it fails.

It almost always works, except when that string is passed from get_sha1()
to get_describe_name(), which takes "ANYTHING-g<hexstring>" and as long as
hexstring names an existing object, it says "Yup, I found one."

I think the right fix is to make sure that "refs/heads/<name>" does not
exist by checking exactly that.

Perhaps something like this.  I am not sure if we want to use the "yield
non zero to signal not an error but an early return" trick like I did in
this patch, though.

---

 builtin/checkout.c |    2 +-
 refs.c             |   14 ++++++++++++++
 refs.h             |    1 +
 3 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 28cdc51..af1e7b5 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1071,7 +1071,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		if (strbuf_check_branch_ref(&buf, opts.new_branch))
 			die(_("git checkout: we do not like '%s' as a branch name."),
 			    opts.new_branch);
-		if (!get_sha1(buf.buf, rev)) {
+		if (ref_exists(buf.buf)) {
 			opts.branch_exists = 1;
 			if (!opts.new_branch_force)
 				die(_("git checkout: branch %s already exists"),
diff --git a/refs.c b/refs.c
index e3c0511..138b1a0 100644
--- a/refs.c
+++ b/refs.c
@@ -1826,6 +1826,20 @@ int update_ref(const char *action, const char *refname,
 	return 0;
 }
 
+static int compare_ref_name(const char *refname,
+			    const unsigned char *sha1, int flag,
+			    void *cb_data)
+{
+	if (!strcmp(cb_data, refname))
+		return -1; /* early return */
+	return 0;
+}
+
+int ref_exists(char *refname)
+{
+	return for_each_ref(compare_ref_name, refname) != 0;
+}
+
 struct ref *find_ref_by_name(const struct ref *list, const char *name)
 {
 	for ( ; list; list = list->next)
diff --git a/refs.h b/refs.h
index 5e7a9a5..5839487 100644
--- a/refs.h
+++ b/refs.h
@@ -35,6 +35,7 @@ extern int for_each_ref_in_submodule(const char *submodule, const char *prefix,
 extern int for_each_tag_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
 extern int for_each_branch_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
 extern int for_each_remote_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data);
+extern int ref_exists(char *);
 
 static inline const char *has_glob_specials(const char *pattern)
 {
