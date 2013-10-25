From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] finding the fork point from reflog entries
Date: Thu, 24 Oct 2013 19:46:57 -0700
Message-ID: <xmqqeh7akqxq.fsf@gitster.dls.corp.google.com>
References: <xmqqhac6o5hj.fsf@gitster.dls.corp.google.com>
	<1382641884-14756-1-git-send-email-gitster@pobox.com>
	<20131024205434.GC10779@serenity.lan>
	<xmqqa9hymkma.fsf@gitster.dls.corp.google.com>
	<20131024213134.GD10779@serenity.lan>
	<20131024214007.GE10779@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin von Zweigbergk <martinvonz@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Oct 25 04:47:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZXQp-00014Z-7k
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 04:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754310Ab3JYCrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 22:47:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60178 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754056Ab3JYCrF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 22:47:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AADC43BBB;
	Fri, 25 Oct 2013 02:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VBuanxgJOmw1MyBRNcQRGTW+0Vk=; b=VvF2oF
	CcZPY0vJvzZbVCRQI7w75muZWaF+yOxLmaANgSlY2qhur34k+wCOVh7GG0rOn61O
	roNF4C6n3wh0iKWNHN3Pjtcx+wYSyUuLmi0MZNpuJRAhiKZO3Zxh8kLpv31Ap7xX
	Aa/qiJUMgA3t/AfFsmDAd6pPIL6Sqj4VLwtnM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oSFo2C4kxO6EGtr5RO0a80ZBbCcxV7qW
	8KahfFSm3axMJEuZ2I8WTDp+/GOMZl1SBDi2q2iC3FsTDTy6+ScUgroHOxGVeQzu
	I3qdfT9untVVb+IPTslewPzkzz/gDetLmDwuSXs0Ku1sRXjemO9u4nt1JH7wH9Jx
	uRcgsBv5X88=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1732043BBA;
	Fri, 25 Oct 2013 02:47:02 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3542043B9D;
	Fri, 25 Oct 2013 02:47:00 +0000 (UTC)
In-Reply-To: <20131024214007.GE10779@serenity.lan> (John Keeping's message of
	"Thu, 24 Oct 2013 22:40:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B8A3DDF2-3D1F-11E3-8039-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236643>

John Keeping <john@keeping.me.uk> writes:

> To clarify: the particular commit in the calls above happens to be the
> oldest entry in the reflog, if I pick a newer entry then it works.
>
> It seems that for_each_reflog_ent isn't returning the oldest entry;
> revs.nr is 62 whereas "git rev-list -g origin/master | wc -l" gives 63.

Perhaps this on top.

One thing I somehow feel dirty about this change is that we have to
include diff.h only to include revision.h only to get the definition
of TMP_MARK. Perhaps object.h should be the header that defines the
bit assignment for objects.flags bit-field.

 builtin/merge-base.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 7b9bc15..7fdc3de 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -2,6 +2,8 @@
 #include "cache.h"
 #include "commit.h"
 #include "refs.h"
+#include "diff.h"
+#include "revision.h"
 #include "parse-options.h"
 
 static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
@@ -91,18 +93,32 @@ struct rev_collect {
 	struct commit **commit;
 	int nr;
 	int alloc;
+	unsigned int initial : 1;
 };
 
+static void add_one_commit(unsigned char *sha1, struct rev_collect *revs)
+{
+	struct commit *commit = lookup_commit(sha1);
+
+	if (!commit || (commit->object.flags & TMP_MARK))
+		return;
+
+	ALLOC_GROW(revs->commit, revs->nr + 1, revs->alloc);
+	revs->commit[revs->nr++] = commit;
+	commit->object.flags |= TMP_MARK;
+}
+
 static int collect_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 				  const char *ident, unsigned long timestamp,
 				  int tz, const char *message, void *cbdata_)
 {
 	struct rev_collect *revs = cbdata_;
-	struct commit *commit = lookup_commit(nsha1);
-	if (commit) {
-		ALLOC_GROW(revs->commit, revs->nr + 1, revs->alloc);
-		revs->commit[revs->nr++] = commit;
+
+	if (revs->initial) {
+		add_one_commit(osha1, revs);
+		revs->initial = 0;
 	}
+	add_one_commit(nsha1, revs);
 	return 0;
 }
 
@@ -131,8 +147,12 @@ static int handle_reflog(int argc, const char **argv)
 
 	derived = lookup_commit_reference(sha1);
 	memset(&revs, 0, sizeof(revs));
+	revs.initial = 1;
 	for_each_reflog_ent(refname, collect_one_reflog_ent, &revs);
 
+	for (i = 0; i < revs.nr; i++)
+		revs.commit[i]->object.flags &= ~TMP_MARK;
+
 	bases = get_merge_bases_many(derived, revs.nr, revs.commit, 0);
 
 	/*
