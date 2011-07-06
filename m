From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] checkout: do not write bogus reflog entry out
Date: Wed, 06 Jul 2011 16:17:43 -0700
Message-ID: <7vk4bvhuco.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 07 01:18:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QebMq-0004sa-Ag
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 01:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787Ab1GFXRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 19:17:47 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:45334 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732Ab1GFXRq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 19:17:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1663A55D8;
	Wed,  6 Jul 2011 19:17:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=e
	xhO0dogueTdU74A+l7FaFLqD/0=; b=QO4BOtHDxtGhw8CU5iIcuk/21t6zhPGFO
	WjvdYLwvU1Ms/2+Fztvew52ZObjE0TXsZuSjQWCmFip73ZXUKnpiNNfZkN6Tnupu
	YuxPltRHInG0hk2vO4oFe1P6QsA9ovtoxuPIScVppQSthAfH4Bms7DYceC8/7gwP
	W895eAYKEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Nmm
	jIF49rACWnJ3bhLPKEb1pHpYOQLaaQR34uqgWhip+7JXoI+Fg1dQHqwZN4NVak/I
	kai+hy+7hEwTH0dirrX1mdQHTaaEuYLS+KG3HrJiVcf7cS5EZDrVPrfG/woboC3z
	6M977rchUfhLKos291jOIz1JykkcAtP8TzORig+Y=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0EFED55D7;
	Wed,  6 Jul 2011 19:17:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 54DEE55D6; Wed,  6 Jul 2011
 19:17:45 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 27F2A058-A826-11E0-B479-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176734>

The code called resolve_ref("HEAD") and stored the result in old.path to
record which branch it used to be on, so that it can say between which
branches the switch took place in the reflog.

However, lookup_commit_reference_gently() is called immediately after
old.path is initialized.  This call can prime replace-object machinery
which in turn collects the loose refs, and calls resolve_ref() inside.  As
the string returned from resolve_ref() is a static buffer that is local to
it, this ended up clobbering the value of old.path. The reflog either
recorded a wrong "switched from" branch (when the last call to resolve_ref
happens to be from the branch namespace), or recorded from a detached HEAD
(otherwise). Neither is correct.

Store the returned string away with xstrdup() to avoid this.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This was present ever since checkout was rewritten in C at 782c2d6
   (Build in checkout, 2008-02-07), but probably got a lot easier to
   trigger recently due to the addition of object replacement code.

   As it depends on the order readdir() in refs.c::get_ref_dir() returns
   the entries, there is no universally reproducible test, but I found it
   in real life inside my git.git primary working repository.

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 28cdc51..48de146 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -715,10 +715,12 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 	unsigned char rev[20];
 	int flag;
 	memset(&old, 0, sizeof(old));
-	old.path = resolve_ref("HEAD", rev, 0, &flag);
+	old.path = xstrdup(resolve_ref("HEAD", rev, 0, &flag));
 	old.commit = lookup_commit_reference_gently(rev, 1);
-	if (!(flag & REF_ISSYMREF))
+	if (!(flag & REF_ISSYMREF)) {
+		free((char *)old.path);
 		old.path = NULL;
+	}
 
 	if (old.path && !prefixcmp(old.path, "refs/heads/"))
 		old.name = old.path + strlen("refs/heads/");
@@ -741,6 +743,7 @@ static int switch_branches(struct checkout_opts *opts, struct branch_info *new)
 	update_refs_for_switch(opts, &old, new);
 
 	ret = post_checkout_hook(old.commit, new->commit, 1);
+	free((char *)old.path);
 	return ret || opts->writeout_error;
 }
