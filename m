From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] list-objects: mark fewer commits as edges for non-shallow clones
Date: Thu, 11 Dec 2014 11:13:30 -0800
Message-ID: <xmqqvblidmp1.fsf@gitster.dls.corp.google.com>
References: <20141211030948.GA137226@vauxhall.crustytoothpaste.net>
	<1418269615-139571-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Dec 11 20:14:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xz9Bo-00057I-1B
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 20:14:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758327AbaLKTOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 14:14:12 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51846 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753269AbaLKTOL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2014 14:14:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B62B23F60;
	Thu, 11 Dec 2014 14:14:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ykp5aoNgVpsFR/7O8Hy4/vYn7EY=; b=NEnXv5
	OwUK7JfiI6j8WawOiXvhJDWa0yj3C4bDY00D+OO3b96yoGuVz9om+ZBm1YPWKZ2r
	AT6B0RmWpCVslrxNXuGQZYp4sGSYyBr6IxZEyt+CPhohV55jk2CyZ1v+6Ybs3Gej
	MuG1ifrkU7q42IHIWTdginQbztCKvgkjVwTi0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NcF9Zlfy7qzEPw3pSd+3h9s7GqSa4xva
	SS7sNFh6/0RBv20rbyl9eNKbeWr5DH8Er+XktCVTHBD8adS9YIEgjRjk2fjbBAPs
	ivf/TYS2hTWSv5/ye7My8AQfk5BqVkne+ZJZ3L1X0i+R9+jKRKg7m3vZ6LETt4qr
	8axrBH8W3yk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0297A23F5D;
	Thu, 11 Dec 2014 14:14:05 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9B2D523F1D;
	Thu, 11 Dec 2014 14:13:31 -0500 (EST)
In-Reply-To: <1418269615-139571-1-git-send-email-sandals@crustytoothpaste.net>
	(brian m. carlson's message of "Thu, 11 Dec 2014 03:46:55 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CBAA69E0-8169-11E4-A7A7-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261287>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> In commit fbd4a70 (list-objects: mark more commits as edges in
> mark_edges_uninteresting - 2013-08-16), we made --thin much more
> aggressive by reading lots more trees.  This produces much smaller packs
> for shallow clones; however, it causes a significant performance
> regression for non-shallow clones with lots of refs (23.322 seconds vs.
> 4.785 seconds with 22400 refs).  Limit this extra edge-marking to
> shallow clones to avoid poor performance.

This change affects non-clone/fetch uses of object listing depending
on the shallowness of the repository, and does not even care if it
is driven as part of the pack-object codepath, if I am reading it
correctly.  It smells wrong.

The problematic fbd4a70 already had unintended fallout that needed
to be corrected with 200abe74 (list-objects: only look at cmdline
trees with edge_hint, 2014-01-20).  The current code with the fix,
the decision to use the more expensive marking is tied to
"edge_hint". I notice that edge_hint is turned on only if the caller
of rev-list passes the "--objects-edge" option, and currently that
only happens in the pack-objects codepath when "thin" is given.
Perhaps that part should decide if it really wants to do edge_hint
depending on the shallowness of the repository perhaps?

That is, something like this instead?

 builtin/pack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3f9f5c7..a9ebf56 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2709,7 +2709,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		usage_with_options(pack_usage, pack_objects_options);
 
 	argv_array_push(&rp, "pack-objects");
-	if (thin) {
+	if (thin && is_repository_shallow()) {
 		use_internal_rev_list = 1;
 		argv_array_push(&rp, "--objects-edge");
 	} else
