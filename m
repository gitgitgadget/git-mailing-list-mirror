From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/(3/4)] test: does pre-commit-hook learn authorship?
Date: Sun, 11 Mar 2012 04:08:20 -0700
Message-ID: <7v1uozz97f.fsf_-_@alter.siamese.dyndns.org>
References: <CAGc=MuCQoQ711uXnB8J80RqsY+pqbaeCOXHjy0-mjq7a_ESdyA@mail.gmail.com>
 <4F5BAE5E.5030407@gmail.com> <7vboo415rn.fsf@alter.siamese.dyndns.org>
 <4F5BDDAC.4050700@gmail.com> <7v62ebz9c0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Neal Kreitzinger <nkreitzinger@gmail.com>,
	Adrian Cornish <git@bluedreamer.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 11 12:08:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6gdX-0003d0-ES
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 12:08:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977Ab2CKLIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Mar 2012 07:08:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47332 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751622Ab2CKLIW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2012 07:08:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E712F6E31;
	Sun, 11 Mar 2012 07:08:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RRlb79vfiDqyJsHbJSvYw+7x06o=; b=UkVFxY
	0EQ0x8cSwwt2ZUczobEXsQ/XpNShopPd5oPRGSRXGShC9IkA7sZ/JhOUGD1NbNq0
	fcFLdAcfJUp4LgsOevNcFTE/pYvn9OHVx9+o3Km0+i8rVdgZwbUNcioRYIPO0GZS
	mPKR4J1tBXT3CurNPqdvQLwcG4sucP0ivYTSA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UoJmUSO+C5+eifE5divusBVFudFA4vcL
	7N0lafsO584dNjOlwOMz5cXar/PSj8qJBh3sb8ZQUZ5LlItP2/csRM71NOy1I/xd
	Utr+aIF8NeaogopZgXCgRlO1nrjc+v+Yo2l9Vns9edL9KjTCKa7bQA+1BswjMo3F
	3VDrBW9Xt60=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE9916E30;
	Sun, 11 Mar 2012 07:08:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 700736E2F; Sun, 11 Mar 2012
 07:08:21 -0400 (EDT)
In-Reply-To: <7v62ebz9c0.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 11 Mar 2012 04:05:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 837F5E9A-6B6A-11E1-AD82-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192803>

When "--author" option is used to lie the authorship to "git commit"
command, hooks should learn the author name and email just like when
GIT_AUTHOR_NAME and GIT_AUTHOR_EMAIL environment variables are used
to lie the authorship.  Test this.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * This is the first one of two patches that are shread by two
   approaches. What it tests should be obvious---the current code
   fails with the last piece that use --author.

 t/t7503-pre-commit-hook.sh |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
index ee7f0cd..fc6de5b 100755
--- a/t/t7503-pre-commit-hook.sh
+++ b/t/t7503-pre-commit-hook.sh
@@ -118,4 +118,22 @@ test_expect_success 'with failing hook requiring GIT_PREFIX' '
 	git checkout -- file
 '
 
+test_expect_failure 'check the author in hook' '
+	cat >"$HOOK" <<-\EOF &&
+	test "$GIT_AUTHOR_NAME" = "New Author" &&
+	test "$GIT_AUTHOR_EMAIL" = "newauthor@example.com"
+	EOF
+	test_must_fail git commit --allow-empty -m "by a.u.thor" &&
+	(
+		GIT_AUTHOR_NAME="New Author" &&
+		GIT_AUTHOR_EMAIL="newauthor@example.com" &&
+		export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL &&
+		git commit --allow-empty -m "by new.author via env" &&
+		git show -s
+	) &&
+	git commit --author="New Author <newauthor@example.com>" \
+		--allow-empty -m "by new.author via command line" &&
+	git show -s
+'
+
 test_done
-- 
1.7.10.rc0.33.g8866af
