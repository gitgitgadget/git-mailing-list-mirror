From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH v3 19/22] resolve_ref(): emit warnings for
 improperly-formatted references
Date: Tue, 11 Oct 2011 13:14:26 -0700
Message-ID: <7v39ezffq5.fsf_-_@alter.siamese.dyndns.org>
References: <1316121043-29367-1-git-send-email-mhagger@alum.mit.edu>
 <1316121043-29367-20-git-send-email-mhagger@alum.mit.edu>
 <20111011161652.GA15629@sigill.intra.peff.net>
 <7vr52jfm8i.fsf@alter.siamese.dyndns.org>
 <7vmxd7flkw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, cmn@elego.de,
	A Large Angry SCM <gitzilla@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 11 22:15:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDijR-0004rb-0j
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 22:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270Ab1JKUOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 16:14:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40497 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908Ab1JKUO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 16:14:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6EE875DE9;
	Tue, 11 Oct 2011 16:14:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rbh9bkDAAG+NpXukGLb3YY3fgTs=; b=bxV+dw
	GKbxqqfSEF8R91qNlWB3sMXYvZ62t+HvStDlZs+TVQMsRZqHz6JxpFZeyOyLRvrB
	LXjlZhXom0lGAH0LOSojIyBq+s2o/4RD9PUuva3A2fhF/d+FAqAswhxpevdxFQBO
	aFru+6790qeWdNVfckLHQrWODUKamL6jODRj8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Inyi4k13TuI+3Qs/F3WAHD5U01TBepHb
	e1vJQ/aP7aSsIAp6iM9CteRtQGVHtP7cUcBnIiDvWoNS/KWCjFs2cf91IaKfePXR
	Sa7EUSpLTzj+zAlnJvyh7jBvaxC8vvexNko8Ylc8MnKPj+mpfOVVXiaeP8xOe/dJ
	tp5o4OQY2Ng=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64A575DE8;
	Tue, 11 Oct 2011 16:14:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BAD805DE5; Tue, 11 Oct 2011
 16:14:27 -0400 (EDT)
In-Reply-To: <7vmxd7flkw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 11 Oct 2011 11:07:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9EF7F73C-F445-11E0-B9EF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183322>

Junio C Hamano <gitster@pobox.com> writes:

>> I think we've discussed tightening it a few years ago already.
>>
>> HEAD, MERGE_HEAD, FETCH_HEAD, etc. all are "^[_A-Z]*$" and it may even be
>> a good idea to insist "^[_A-Z]*HEAD$" or even "^([A-Z][A-Z]*_)?HEAD$".
>
> Perhaps like this? Only compile tested...

Not quite. There are at least three bugs in the patch.

 - Some subsystems use random refnames like NOTES_MERGE_PARTIAL that would
   not match "^([A-Z][A-Z]*_)?HEAD$". The rule needs to be relaxed;

 - dwim_ref() can be fed "refs/heads/master" and is expected to dwim it to
   the master branch.

 - These codepaths get pointer+length so that it can be told to parse only
   the first 4 bytes in "HEAD:$path".

-- >8 --
Subject: [PATCH] Restrict ref-like names immediately below $GIT_DIR

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
 sha1_name.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 143fd97..5eb19c2 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -261,6 +261,25 @@ static char *substitute_branch_name(const char **string, int *len)
 	return NULL;
 }
 
+static int ok_at_root_level(const char *str, int len)
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
 int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 {
 	char *last_branch = substitute_branch_name(&str, &len);
@@ -274,6 +293,8 @@ int dwim_ref(const char *str, int len, unsigned char *sha1, char **ref)
 		unsigned char *this_result;
 		int flag;
 
+		if (p == ref_rev_parse_rules && !ok_at_root_level(str, len))
+			continue;
 		this_result = refs_found ? sha1_from_ref : sha1;
 		mksnpath(fullref, sizeof(fullref), *p, len, str);
 		r = resolve_ref(fullref, this_result, 1, &flag);
@@ -302,6 +323,8 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
 		char path[PATH_MAX];
 		const char *ref, *it;
 
+		if (p == ref_rev_parse_rules && !ok_at_root_level(str, len))
+			continue;
 		mksnpath(path, sizeof(path), *p, len, str);
 		ref = resolve_ref(path, hash, 1, NULL);
 		if (!ref)
