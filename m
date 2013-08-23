From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-commit: search author pattern against mailmap
Date: Fri, 23 Aug 2013 12:03:16 -0700
Message-ID: <xmqqwqncnsaz.fsf@gitster.dls.corp.google.com>
References: <1377265711-11492-1-git-send-email-apelisse@gmail.com>
	<xmqqbo4opajg.fsf@gitster.dls.corp.google.com>
	<20130823183541.GB30130@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 23 21:03:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCwds-00072O-Hz
	for gcvg-git-2@plane.gmane.org; Fri, 23 Aug 2013 21:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755916Ab3HWTDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 15:03:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62791 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754711Ab3HWTDV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 15:03:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33DD63B0F8;
	Fri, 23 Aug 2013 19:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FcIIiN3nIMAzN/HTNMsCvbpeenU=; b=Yk3iKs
	4NTjEOhW+63amonub7RvlS8jocIzpUbWhv3b+HZgmUsxZC6q5ZAQ4R8egM+t6JvF
	1nARMnn7JnfLgp7WmaJk+MectCeC5rTHGpYADX42dzk/wGhm5avMqPxShMhkww3n
	pPN5IN8aFHarHath222GmD1dgpBvumsj3o/5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bL8gCAPt07Iu7jaBRztLIFTGg0vB2oua
	fd1OwT4pP7YCWbFN/t+I/ZFg6ItBUWCfJ/yeJPFnoEUGQ1giidvupD/5pcQLzKH8
	TqdjpOWFP1x7hDEDMde990xuy9baguR41MebztzH1wP6ODysYvsP4XdQHgzZ0KHz
	wwpksVhj0tM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2727B3B0F7;
	Fri, 23 Aug 2013 19:03:20 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1CDBD3B0F3;
	Fri, 23 Aug 2013 19:03:19 +0000 (UTC)
In-Reply-To: <20130823183541.GB30130@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 23 Aug 2013 14:35:41 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AC5C9658-0C26-11E3-8BFA-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232825>

Jeff King <peff@peff.net> writes:

>> But for that old and established "--author parameter that does not
>> use the standard format guesses" feature to be useful, I agree that
>> it should honor the mailmap.
>> 
>> I wonder if it would hurt anybody if we made this unconditional, not
>> even with "--no-mailmap" override? Opinions?
>
> I think it would be OK. You can always override by giving the actual
> full address you want instead of a partial one.

OK, so how about labelling it as a bugfix, like this perhaps?  We
obviously need a test or two, though.

-- >8 --
From: Antoine Pelisse <apelisse@gmail.com>
Date: Fri, 23 Aug 2013 15:48:31 +0200
Subject: [PATCH] commit: search author pattern against mailmap

"git commit --author=$name" sets the author to one whose name
matches the given string from existing commits, when $name is not in
the "Name <e-mail>" format. However, it does not honor the mailmap
to use the canonical name for the author found this way.

Fix it by telling the logic to find a matching existing author to
honor the mailmap, and use the name and email after applying the
mailmap.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/commit.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 10acc53..5b7d969 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -30,6 +30,7 @@
 #include "column.h"
 #include "sequencer.h"
 #include "notes-utils.h"
+#include "mailmap.h"
 
 static const char * const builtin_commit_usage[] = {
 	N_("git commit [options] [--] <pathspec>..."),
@@ -945,13 +946,16 @@ static const char *find_author_by_nickname(const char *name)
 	av[++ac] = buf.buf;
 	av[++ac] = NULL;
 	setup_revisions(ac, av, &revs, NULL);
+	revs.mailmap = xcalloc(1, sizeof(struct string_list));
+	read_mailmap(revs.mailmap, NULL);
+
 	prepare_revision_walk(&revs);
 	commit = get_revision(&revs);
 	if (commit) {
 		struct pretty_print_context ctx = {0};
 		ctx.date_mode = DATE_NORMAL;
 		strbuf_release(&buf);
-		format_commit_message(commit, "%an <%ae>", &buf, &ctx);
+		format_commit_message(commit, "%aN <%aE>", &buf, &ctx);
 		return strbuf_detach(&buf, NULL);
 	}
 	die(_("No existing author found with '%s'"), name);
-- 
1.8.4-rc4-299-g7e07a8d
