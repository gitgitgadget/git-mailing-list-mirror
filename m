From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] log --decorate: do not leak "commit" color into the next item
Date: Wed, 18 Feb 2015 13:44:54 -0800
Message-ID: <xmqqpp9628tl.fsf@gitster.dls.corp.google.com>
References: <xmqqzj8b0w6t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 22:45:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOCQY-0002Uj-Rp
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 22:45:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752318AbbBRVo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 16:44:58 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61923 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750976AbbBRVo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 16:44:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ED5C438713;
	Wed, 18 Feb 2015 16:44:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DuQx6VVdG4ezmWZB41Pbj582NsM=; b=cVrAzK
	NRIhjrqBmBYIkiORuiC+E61YXxALLs04imfwwE4BXr2gPB+dUkHeOacS1Il1V8vv
	i27bEfqp42GWfiyXjIOOzRUsAbEkIRVknwFcTL/fs1Nk+IYlBAw03I7qSBZTXvKe
	jU0qzp4xjAnL0ySxF6L9mRXiW8vZdOWUQa5xE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LwMVIEYpCZ6ha1cHoiMk4fiJ6hALdwUq
	aEaUYVB7ZQQ+Kxv/PEY3Y46EBrZ7hda9f102qH03uM9RDkCe6XUyamxvoUpDMIvy
	Ph9qNn/45jvJe3LjappGYleldIfVTOoDml6m3t9s9/RGFSTpN3+uCr41DfNEHqcR
	v8fjgNqTXI4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E496F38712;
	Wed, 18 Feb 2015 16:44:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 19A463870E;
	Wed, 18 Feb 2015 16:44:56 -0500 (EST)
In-Reply-To: <xmqqzj8b0w6t.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 18 Feb 2015 13:03:06 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 60EF4132-B7B7-11E4-B62B-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264065>

If you wanted to paint the HEAD and local branch name in the same
color as the body text (perhaps because cyan and green are too faint
on a black-on-white terminal to be readable), you would not want to
have to say

    [color "decorate"]
        head = black
        branch = black

because that you would not be able to reuse same configuration on a
white-on-black terminal.  You would naively expect

    [color "decorate"]
        head = normal
	branch = normal

to work, but unfortunately it does not.  It paints the string "HEAD"
and the branch name in the same color as the opening parenthesis or
comma between the decoration elements when showing output like this:

    $ git show -s --decorate
    commit f3f407747c1cce420ae4b4857c4a6806efe38680 (HEAD, master)
    ...

This is because the code forgets to reset the color after printing
the "prefix" in its own color.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Answering to myself ...

 log-tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/log-tree.c b/log-tree.c
index 7f0890e..53bb526 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -195,6 +195,7 @@ void format_decorations_extended(struct strbuf *sb,
 	while (decoration) {
 		strbuf_addstr(sb, color_commit);
 		strbuf_addstr(sb, prefix);
+		strbuf_addstr(sb, color_reset);
 		strbuf_addstr(sb, decorate_get_color(use_color, decoration->type));
 		if (decoration->type == DECORATION_REF_TAG)
 			strbuf_addstr(sb, "tag: ");
