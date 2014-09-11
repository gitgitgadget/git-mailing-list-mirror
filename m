From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 6/6] Make sure that index-pack --strict checks tag objects
Date: Thu, 11 Sep 2014 14:16:36 -0700
Message-ID: <xmqqoauldfij.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.1.00.1409101552250.990@s15462909.onlinehome-server.info>
	<cover.1410445430.git.johannes.schindelin@gmx.de>
	<2738eace005dce9002c1a1f5e87ad63aebdf83ef.1410445431.git.johannes.schindelin@gmx.de>
	<xmqqha0edony.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 11 23:16:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSBjQ-000480-3l
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 23:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020AbaIKVQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 17:16:41 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50413 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752144AbaIKVQj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 17:16:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DBCFB3ACA7;
	Thu, 11 Sep 2014 17:16:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qLugt9rrlB6dObxKzwJrV/sxFnA=; b=DjuHMR
	ehY0VFKvFEqsdTl0kXrBXZ9iIHKYmocPxMfn+plvbpM/9a/sRpqH6Sr3bsMO5vAe
	jDkRlHVAfL5iUgRlHGMU3gOYFDJ+PQmXDnmXK4ejgQgBx15wEhV00vGW7t2vO3+T
	oxzeT6ifS78045q4bbqaSpd6t3WK81e2qNTzE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bv50kGYGY8LnFwu7lnNQCH9eeT1q+UA0
	Rpbmhh+oCEb+/1HTk4CNMOXsV/cH4iC3UA91H/KKiRULhJqucJ6H0Mofa4jlEM7R
	IdWq0E0h63Ig0b1xpzVtKOgJtCpw/h4JS6I2ds8wWYhGo5AOqxi8OeSfha9Fgyhr
	3hxAs0WMeUI=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D200E3ACA6;
	Thu, 11 Sep 2014 17:16:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4DE263ACA5;
	Thu, 11 Sep 2014 17:16:38 -0400 (EDT)
In-Reply-To: <xmqqha0edony.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 11 Sep 2014 10:58:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EAE1FF84-39F8-11E4-B45A-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256877>

Junio C Hamano <gitster@pobox.com> writes:

> When our toolset has become too tight without leaving enough escape
> hatch to hinder further development, it is very sensible to at least
> think about adding a new "--for-debug" option to hash-object and
> pack-objects that allows us to deliberately create broken
> datastreams to test against.
>
> I think peff recently added helpers to t5303 to allow us test
> corrupt pack streams, which is a way different from what you
> envisioned above (i.e. "actively break pack-index") to test
> breakages like the ones you were trying to test here.
>
> Having said all that, I do think the series that added new warnings,
> errors and a test for the new warnings is an improvement without a
> test for the new errors.  So let's queue this, see if somebody comes
> up a way to check for these error detection codepath on top of this
> series.

It wasn't too painful to do one of them, and the result looks rather
nice.  It lets us add this patch on top of your series.

-- >8 --
Subject: [PATCH] t1450: make sure fsck detects a malformed tagger line

With "hash-object --literally", write a tag object that is not
supposed to pass one of the new checks added to "fsck", and make
sure that the new check catches the breakage.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1450-fsck.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 9118253..6ecb844 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -234,6 +234,25 @@ test_expect_success 'tag with incorrect tag name & missing tagger' '
 	grep "expected .tagger. line" out
 '
 
+test_expect_success 'tag with bad tagger' '
+	sha=$(git rev-parse HEAD) &&
+	cat >wrong-tag <<-EOF &&
+	object $sha
+	type commit
+	tag not-quite-wrong
+	tagger Bad Tagger Name
+
+	This is an invalid tag.
+	EOF
+
+	tag=$(git hash-object --literally -t tag -w --stdin <wrong-tag) &&
+	test_when_finished "remove_object $tag" &&
+	echo $tag >.git/refs/tags/wrong &&
+	test_when_finished "git update-ref -d refs/tags/wrong" &&
+	test_must_fail git fsck --tags 2>out &&
+	grep "error in tag .*: invalid author/committer" out
+'
+
 test_expect_success 'cleaned up' '
 	git fsck >actual 2>&1 &&
 	test_cmp empty actual
-- 
2.1.0-459-g1bc3b2b
