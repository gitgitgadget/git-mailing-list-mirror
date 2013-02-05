From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH 3/3] apply: diagnose incomplete submodule object name
 better
Date: Tue, 05 Feb 2013 11:19:32 -0800
Message-ID: <7vpq0esh4r.fsf_-_@alter.siamese.dyndns.org>
References: <20130130224904.GB1053@book.hvoigt.net>
 <1359693125-22357-1-git-send-email-gitster@pobox.com>
 <1359693125-22357-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 20:20:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2o3m-0001ox-5X
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 20:20:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755313Ab3BETTj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 14:19:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53105 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754785Ab3BETTi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 14:19:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A593AB211;
	Tue,  5 Feb 2013 14:19:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GdgU8gD5lwsEQhFwANLhGeGtBq4=; b=eqETC6
	7TfwdsNEKoOH6qjmw3lZsEjpi0MzpFnwp/sN/UrT6sQlrhLFDKp8i7xo0b/+ml+M
	UgNvcHgWhIArF7x/8O2XXHNp3GJkzPUIii3uiRDaDp82zd+Cf8nHq2oEqYvjpY7/
	Q1JjsdoelH2hFOxxKC1zDvS0bdLq8wZMWjqNs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qiLRL+wH0AwQunuo7s4vd7vpBYmbt6lN
	eQojdbjp63Zx8UQVTyONit3LwJEpSoNRMoP1cc/d/9QLD1nAmTNgB2aq+KOqeHx2
	D0Gabpgoo7vfGNOCw/RNB3lG63WUWrJc+HnMotRZ6RULx1OQKz0RavB1LOHY3H+x
	pbQMqaNNoyI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D3067B20D;
	Tue,  5 Feb 2013 14:19:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B543B206; Tue,  5 Feb 2013
 14:19:34 -0500 (EST)
In-Reply-To: <1359693125-22357-4-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Thu, 31 Jan 2013 20:32:05 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F9989C8C-6FC8-11E2-9338-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215527>

Junio C Hamano <gitster@pobox.com> writes:

> We could read from the payload part of the patch to learn the full
> object name of the commit, but the primary user "git rebase" has
> been fixed to give us a full object name, so this should suffice
> for now.

And the patch on top to do so looks like this.  With this patch in
place, we could drop 1/3 of this series, but there is no strong
reason to do so. After all, 1/3 is all about internal implementation
details.

-- >8 --
Subject: [PATCH 4/3] apply: verify submodule commit object name better

A textual patch also records the submodule commit object name in
full.  Make the parsing more robust by reading from there and
verifying the (possibly abbreviated) name on the index line matches.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/apply.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 1f78e2c..e0f1474 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3587,6 +3587,40 @@ static int get_current_sha1(const char *path, unsigned char *sha1)
 	return 0;
 }
 
+static int preimage_sha1_in_gitlink_patch(struct patch *p, unsigned char sha1[20])
+{
+	/*
+	 * A usable gitlink patch has only one fragment (hunk) that looks like:
+	 * @@ -1 +1 @@
+	 * -Subproject commit <old sha1>
+	 * +Subproject commit <new sha1>
+	 * or
+	 * @@ -1 +0,0 @@
+	 * -Subproject commit <old sha1>
+	 * for a removal patch.
+	 */
+	struct fragment *hunk = p->fragments;
+	static const char heading[] = "-Subproject commit ";
+	char *preimage;
+
+	if (/* does the patch have only one hunk? */
+	    hunk && !hunk->next &&
+	    /* is its preimage one line? */
+	    hunk->oldpos == 1 && hunk->oldlines == 1 &&
+	    /* does preimage begin with the heading? */
+	    (preimage = memchr(hunk->patch, '\n', hunk->size)) != NULL &&
+	    !prefixcmp(++preimage, heading) &&
+	    /* does it record full SHA-1? */
+	    !get_sha1_hex(preimage + sizeof(heading) - 1, sha1) &&
+	    preimage[sizeof(heading) + 40 - 1] == '\n' &&
+	    /* does the abbreviated name on the index line agree with it? */
+	    !prefixcmp(preimage + sizeof(heading) - 1, p->old_sha1_prefix))
+		return 0; /* it all looks fine */
+
+	/* we may have full object name on the index line */
+	return get_sha1_hex(p->old_sha1_prefix, sha1);
+}
+
 /* Build an index that contains the just the files needed for a 3way merge */
 static void build_fake_ancestor(struct patch *list, const char *filename)
 {
@@ -3607,8 +3641,10 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
 			continue;
 
 		if (S_ISGITLINK(patch->old_mode)) {
-			if (get_sha1_hex(patch->old_sha1_prefix, sha1))
-				die("submoule change for %s without full index name",
+			if (!preimage_sha1_in_gitlink_patch(patch, sha1))
+				; /* ok, the textual part looks sane */
+			else
+				die("sha1 information is lacking or useless for submoule %s",
 				    name);
 		} else if (!get_sha1_blob(patch->old_sha1_prefix, sha1)) {
 			; /* ok */
-- 
1.8.1.2.639.g9428735
