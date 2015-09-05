From: Junio C Hamano <gitster@pobox.com>
Subject: Re: More builtin git-am issues..
Date: Sat, 05 Sep 2015 09:10:39 -0700
Message-ID: <xmqqk2s4deyo.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
	<CA+55aFw2bnhSQYk4FaHfp4ED0Y611NWyQs05TMQtFj=2As1=nA@mail.gmail.com>
	<xmqqh9n9ele4.fsf@gitster.mtv.corp.google.com>
	<55EA9A13.2050108@kdbg.org>
	<20150905080325.GA25039@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 05 18:11:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYG3U-0000Dl-CO
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 18:11:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbbIEQKm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 12:10:42 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35052 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbbIEQKl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 12:10:41 -0400
Received: by pacfv12 with SMTP id fv12so53901193pac.2
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 09:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=wv6X8htXpVVWHTwPBN9DBoDJDaZml8VcbsKJwQFzphM=;
        b=1JpfJdUbk3E1vJP5KH6EXhmH884I+UY+zrGJ1g44tQ5GaWEus5yX+QF5+/Wz1xpvT+
         73KocJQPVZay9QuouJpjmbSwY0D6OpVB666iFkbqfJ3hmJ+FyHPhi6U6ymdRMyW+M2Zg
         GML0/WwDLoVo10SWgkQaGEPY+g//AHd9L1gsVtIHXMziUG7WVLIIgkhBSl3jKJ0Qhq9L
         +mBb9oQDjWBIUagTf2qzzEJUHyJf6rlbd8rJ3KltbMjVJCERFeXU45XPWjB9nw7VNBJW
         ilnQO09vvbrOFtTEkoOCP7NZ268HqB1mmeLkb4lyCim4t1jIrz3Yt2WJxTtoqh6WQ54X
         +kMA==
X-Received: by 10.68.135.161 with SMTP id pt1mr22362037pbb.47.1441469441179;
        Sat, 05 Sep 2015 09:10:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:20fa:dab1:6d64:e4c9])
        by smtp.gmail.com with ESMTPSA id if9sm6252985pbc.89.2015.09.05.09.10.40
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Sat, 05 Sep 2015 09:10:40 -0700 (PDT)
In-Reply-To: <20150905080325.GA25039@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 5 Sep 2015 04:03:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277387>

Jeff King <peff@peff.net> writes:

> [1] I think part of the reason people are interested in "fancy" here is
>     that this topic extends beyond "git am". There's "commit -s", of
>     course, but there's also the generic "interpret-trailers" command,
>     which is supposed to be a generalization of the "--signoff" option.
>     It would be nice if the rules remained consistent for when we add a
>     trailer to an existing block, rather than special-casing signoffs.
>
>     But again, I think that's something to shoot for in the long run.
>     It's more important in the short term not to regress "am".

Yes.  I personally think the global append_signoff() everybody else
uses can and should implement the same logic (whichever the exact
logic is) as whatever is used by "am" because the caller that makes
a call to that function knows it is adding a "Signed-off-by:" line,
so existing "Signed-off-by" lines are already special in that context.

But for the purpose of 2.6-rc period, I think we should start from
doing a separate implementation inside builtin/am.c without touching
append_signoff().

We can do a more thoughtful refactoring for append_signoff() in the
next cycle.  Another thing that needs consideration is the other
user of the has_conforming_footer() helper append_signoff() uses,
which is the codepath to add "cherry-picked-from"; it is less
obvious that "find Signed-off-by: anywhere in the text to decide if
the new footer needs its own paragraph" is a good logic in that
context.

To salvage "interpret-trailers" needs a lot more, as we are
realizing that the definition that led to its external design does
not match the way users use footers in the real world.  This affects
the internal data representation and the whole thing needs to be
rethought.

Here is a quick attempt to do the "just fix am regression without
changing anything else".


 builtin/am.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 83b3d86..c63d238 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1213,9 +1213,24 @@ static void NORETURN die_user_resolve(const struct am_state *state)
 static void am_append_signoff(struct am_state *state)
 {
 	struct strbuf sb = STRBUF_INIT;
+	char *cp;
 
 	strbuf_attach(&sb, state->msg, state->msg_len, state->msg_len);
-	append_signoff(&sb, 0, 0);
+	strbuf_complete_line(&sb);
+
+	for (cp = sb.buf;
+	     cp && *cp && (cp = strstr(cp, sign_off_header)) != NULL;
+	     cp = strchr(cp, '\n')) {
+		if (sb.buf < cp && cp[-1] == '\n')
+			break;
+	}
+	if (!cp)
+		strbuf_addch(&sb, '\n');
+	strbuf_addf(&sb, "%s%s\n",
+		    sign_off_header,
+		    fmt_name(getenv("GIT_COMMITTER_NAME"),
+			     getenv("GIT_COMMITTER_EMAIL")));
+	strbuf_addch(&sb, '\n');
 	state->msg = strbuf_detach(&sb, &state->msg_len);
 }
 
