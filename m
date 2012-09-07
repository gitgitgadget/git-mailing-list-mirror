From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Binary file-friendly merge -Xours or -Xtheirs?
Date: Fri, 07 Sep 2012 14:47:09 -0700
Message-ID: <7v392twlnm.fsf@alter.siamese.dyndns.org>
References: <1799969825.275125.1347028392272.JavaMail.root@genarts.com>
 <1265473388.275309.1347029328407.JavaMail.root@genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 23:47:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA6OW-0001mN-22
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 23:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755107Ab2IGVrN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 17:47:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58350 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101Ab2IGVrM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 17:47:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44DA98E54;
	Fri,  7 Sep 2012 17:47:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3NlqahcOs5RvQUpR9PwZqc7iWFE=; b=Q/Sod1
	71vjEKkb1j5wYDBsgbVYHd6JJOUgkGlXaGZf+OygMIhQQt0FqnC9/m5drjYqx5Cu
	ibUiraZiHIiF4K8J4hcErsYMyQO6ogMRPlIkWpDze50Q2huHK98dnfM43WTjpLiD
	xjW4OwOaYJbD2meGiKU6qSelF1j+IT8bqizKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=juRad68qZBmMsQyj3kBh/5TNmopSae2G
	JeoRYWWYmghAOH7FQ/+X8wycl7qRlvdFXpdHdVuXZcSGvbtxce5PTJgYDfjF5K+B
	kFe1hN5aKFWxSGv+BYfIzUPdwCcrJ733HXtmYU90oR+pdZqJaYGeGXFf9YCnIq8r
	sAbeDOw4T8M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 309478E52;
	Fri,  7 Sep 2012 17:47:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 83E148E4F; Fri,  7 Sep 2012
 17:47:10 -0400 (EDT)
In-Reply-To: <1265473388.275309.1347029328407.JavaMail.root@genarts.com>
 (Stephen Bash's message of "Fri, 7 Sep 2012 10:48:48 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 93C3A910-F935-11E1-8BE3-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205002>

Stephen Bash <bash@genarts.com> writes:

> From reading the docs it's obvious the current -Xours and -Xtheirs
> expect to work on hunks, so I (mostly) understand the current
> behavior, but as a user it feels like "I'm telling you how to
> resolve conflicts, please do the same thing for binary files".

Even though merge-recursive accepts -Xours/-Xtheirs, I do not think
the low-level merge machinery for anything but the text merge is
aware of the option.

It may be just the matter of something like this, though (completely
untested).



 ll-merge.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git i/ll-merge.c w/ll-merge.c
index f3f7692..fee578f 100644
--- i/ll-merge.c
+++ w/ll-merge.c
@@ -46,16 +46,31 @@ static int ll_binary_merge(const struct ll_merge_driver *drv_unused,
 	assert(opts);
 
 	/*
-	 * The tentative merge result is "ours" for the final round,
-	 * or common ancestor for an internal merge.  Still return
-	 * "conflicted merge" status.
+	 * The tentative merge result is the or common ancestor for an internal merge.
 	 */
-	stolen = opts->virtual_ancestor ? orig : src1;
+	if (opts->virtual_ancestor) {
+		stolen = orig;
+	} else {
+		switch (opts->variant) {
+		default:
+		case XDL_MERGE_FAVOR_OURS:
+			stolen = src1;
+			break;
+		case XDL_MERGE_FAVOR_THEIRS:
+			stolen = src2;
+			break;
+		}
+	}
 
 	result->ptr = stolen->ptr;
 	result->size = stolen->size;
 	stolen->ptr = NULL;
-	return 1;
+
+	/*
+	 * With -Xtheirs or -Xours, we have cleanly merged;
+	 * otherwise we got a conflict.
+	 */
+	return (opts->variant ? 0 : 1);
 }
 
 static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
