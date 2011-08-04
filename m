From: Junio C Hamano <gitster@pobox.com>
Subject: Re* BUG?: git diff with 3 args consults work tree when it shouldn't
Date: Wed, 03 Aug 2011 19:54:20 -0700
Message-ID: <7vsjph6g4j.fsf@alter.siamese.dyndns.org>
References: <201108011935.11373.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Aug 04 04:54:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qoo4w-0004XV-Jb
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 04:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755371Ab1HDCyY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 22:54:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46715 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754713Ab1HDCyX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 22:54:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D53AE5406;
	Wed,  3 Aug 2011 22:54:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6Kkfzk0oEToEupuIPzDR5PBwCYE=; b=fFH+Z9
	PAsVV6Q5beAstCNS4xZ6Op1epNgGVJLsCDqv0pvQ3+ZgABa1W99XUjn2hwD3U9R5
	OHeTukGupxhjf+G5OwKlRrYyFbF8S8vI3Gx4mWJ+9mYBYR9yAwPau4yvw+nKBa7p
	1Mw6tGkYEQGHTUSKxGPARteVaaFsHjyPxdTv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TZvjdaXS+4L4W5m1T2D4BB9sEfTdzvRq
	sbbga6BLENBrAB9KoQas9o/IuVdCKxzA+OkBNBXe0BRFwt5yY5jIRCLsyJIShzYj
	tH7Vb837ZE+k13pnWZHy0f426dvfJ98DHJHrlalTmIcKn94eS/tq13G2jkaQqtjI
	LbU+taphob8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE1B05404;
	Wed,  3 Aug 2011 22:54:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3612F5403; Wed,  3 Aug 2011
 22:54:22 -0400 (EDT)
In-Reply-To: <201108011935.11373.johan@herland.net> (Johan Herland's message
 of "Mon, 1 Aug 2011 19:35:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0E41959E-BE45-11E0-BDEC-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178659>

What happens is that the more-than-two-ways combined diff is sometimes
used to show the difference _to_ the working tree files.

In combine-diff.c::show_patch_diff(), we try to detect that case by
checking if sha1 recorded as "the result" is null, because diff-files will
give us 0{40} as the blob object name for files in the working tree.

Unfortunately, that forgets another case where blob object is null, which
is when the merge result tree _deleted_ the path.

This patch is not tested outside your test case. IOW, I know it will get
three-tree case correctly, but I didn't test it with cases where we should
look at the working tree files, so this may introduce regressions.

See 713a11f (combine-diff: diff-files fix., 2006-02-13) if you are
interested. I suspect that we may need to add a bit to the API to tell
this function if the end result is in the working tree.

 combine-diff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index be67cfc..b4f1050 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -777,7 +777,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	struct sline *sline; /* survived lines */
 	int mode_differs = 0;
 	int i, show_hunks;
-	int working_tree_file = is_null_sha1(elem->sha1);
+	int working_tree_file = is_null_sha1(elem->sha1) && elem->mode;
 	mmfile_t result_file;
 	struct userdiff_driver *userdiff;
 	struct userdiff_driver *textconv = NULL;
