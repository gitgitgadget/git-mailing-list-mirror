From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Issue 356 in msysgit: 'git describe --always' doesn't work
Date: Fri, 23 Oct 2009 11:46:52 -0700
Message-ID: <7v1vkuc5ib.fsf@alter.siamese.dyndns.org>
References: <0016367b63e60b2cdb0476969d11@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 23 20:47:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1PAI-0003tB-0w
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 20:47:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752794AbZJWSqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 14:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752646AbZJWSqz
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 14:46:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52134 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752268AbZJWSqy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 14:46:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4395764F38;
	Fri, 23 Oct 2009 14:46:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=PaWMUl8p0mkoA/FmLD6GTa1XXPo=; b=VSwZhOzc45jVxQxqEXe8X19
	OsLUy+/8X0c+0BU76Pvd7FvBy6DaFrNKaGdJhS5e8fJV/7tWTlZ8U4PgoVeJSxr+
	dRNrNRjjLaHbeO7Ui+rf10J1nolsuzoLhQUpD1XEnsdkVSaedQ3VbSH+m6iHWyke
	EvLkvewgnd0eow96lNMs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=IMBJvA3FdWEgCutr8FroBdn7/YfOELaRIPln7bDpU1c6amd31
	QUB+fYGHolv4FrZoYqMHMbC2nbALWFi22l/t48rBJjjizmTbow/0i45zk87qF/nN
	LWU482BemhkXK1tZDVxhq1sE6IwnzG78JhHCrmgWKDqWLxWu0lrBYfeCa4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 25F4564F37;
	Fri, 23 Oct 2009 14:46:57 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7846664F36; Fri, 23 Oct
 2009 14:46:54 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 70B85D16-C004-11DE-A133-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131115>

msysgit@googlecode.com writes:

> Comment #1 on issue 356 by snaury: 'git describe --always' doesn't work
> http://code.google.com/p/msysgit/issues/detail?id=356
>
> This is not msysgit fault, the same happens on Mac OS X with
> 1.6.5.1. I  guess --always doesn't work anymore...

Thanks for noticing.  I think it is a regression in d68dc34 (git-describe:
Die early if there are no possible descriptions, 2009-08-06)

-- >8 --
Subject: [PATCH] Do not fail "describe --always" in a tag-less repository

This fixes a regression introduce by d68dc34 (git-describe: Die early if
there are no possible descriptions, 2009-08-06).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-describe.c  |    2 +-
 t/t6120-describe.sh |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index df67a73..7542b57 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -197,7 +197,7 @@ static void describe(const char *arg, int last_one)
 		for_each_ref(get_name, NULL);
 	}
 
-	if (!found_names)
+	if (!found_names && !always)
 		die("cannot describe '%s'", sha1_to_hex(sha1));
 
 	n = cmit->util;
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 8c7e081..f5a1b61 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -34,6 +34,8 @@ test_expect_success setup '
 	echo one >file && git add file && git commit -m initial &&
 	one=$(git rev-parse HEAD) &&
 
+	git describe --always HEAD &&
+
 	test_tick &&
 	echo two >file && git add file && git commit -m second &&
 	two=$(git rev-parse HEAD) &&
