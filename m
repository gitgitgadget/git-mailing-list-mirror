From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] get_short_sha1(): correctly disambiguate type-limited abbreviation
Date: Mon,  1 Jul 2013 22:12:35 -0700
Message-ID: <1372741955-20691-3-git-send-email-gitster@pobox.com>
References: <1372741955-20691-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 02 07:12:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtstX-0004rP-13
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 07:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104Ab3GBFMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 01:12:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63433 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751477Ab3GBFMl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 01:12:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47E4827D4D
	for <git@vger.kernel.org>; Tue,  2 Jul 2013 05:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Qw6a
	SbSjCV2YSiul9/chJLR/ByI=; b=C/6yx7+VXb8JYk4H/n38bKkeAU+V0idlnNLR
	N+5gJcB3hAXTumc4aWBSVrpi7OrV/aw04xXyUxCYVJ+gUS/6ANVtACHqOJsb89ob
	1sY227AA5jho6C7R042ZHMC8JW/Wo7G2K0RVTyD6Yzvbwgdn2pvrk88ut5NtF7aq
	SCUeZ1w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=pteuJf
	u38JgwNmsJR8onu6tcPjUrj7+4bjyDzrD6y6S/turBgCYIUVOH+wz42SjNNgVNSD
	bq1SeCeBQgPruZWqJ9YQPpWoXS6E+Zk1codRjRbw0OvGGSXm/VB6gfA0jXkpE+G+
	9cAQpaVip3ipprVR4k5SsxLX9kkFGvk9CVUiU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3EFF927D4A
	for <git@vger.kernel.org>; Tue,  2 Jul 2013 05:12:41 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B8E1D27D48
	for <git@vger.kernel.org>; Tue,  2 Jul 2013 05:12:40 +0000 (UTC)
X-Mailer: git-send-email 1.8.3.2-795-g615e8f0
In-Reply-To: <1372741955-20691-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 04E6D876-E2D6-11E2-88AF-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229361>

One test in t1512 that expects a failure incorrectly passed.  The
test prepares a commit whose object name begins with ten "0"s, and
also prepares a tag that points at the commit.  The object name of
the tag also begins with ten "0"s.  There is no other commit-ish
object in the repository whose name begins with such a prefix.

Ideally, in such a repository:

    $ git rev-parse --verify 0000000000^{commit}

should yield that commit.  If 0000000000 is taken as the commit
0000000000e4f, peeling it to a commmit yields that commit itself,
and if 0000000000 is taken as the tag 0000000000f8f, peeling it to a
commit also yields the same commit, so in that twisted sense, the
extended SHA-1 expression 0000000000^{commit} is unambigous.  The
test that expects a failure is to check the above command.

The reason the test expects a failure is that we did not implement
such a "unification" of two candidate objects.  What we did (or at
least, meant to) implement was to recognise that a commit-ish is
required to expand 0000000000, and notice that there are two succh
commit-ish, and diagnose the request as ambiguous.

However, there was a bug in the logic to check the candidate
objects.  When the code saw 0000000000f8f (a tag) that shared the
shortened prefix (ten "0"s), it tried to make sure that the tag is a
commit-ish by looking at the tag object.  Because it incorrectly
used lookup_object() when the tag has not been parsed, however, we
incorrectly declared that the tag is _not_ a commit-ish, leaving the
sole commit in the repository, 0000000000e4f, that has the required
prefix as "unique match", causing the test to pass when it shouldn't.

This fixes the logic to inspect the type of the object a tag refers
to, to make the test that is expected to fail correctly fail.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_name.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1_name.c b/sha1_name.c
index 8bc20c5..13c3d75 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -241,7 +241,7 @@ static int disambiguate_committish_only(const unsigned char *sha1, void *cb_data
 		return 0;
 
 	/* We need to do this the hard way... */
-	obj = deref_tag(lookup_object(sha1), NULL, 0);
+	obj = deref_tag(parse_object(sha1), NULL, 0);
 	if (obj && obj->type == OBJ_COMMIT)
 		return 1;
 	return 0;
-- 
1.8.3.2-795-g615e8f0
