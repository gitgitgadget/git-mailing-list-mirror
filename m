From: Junio C Hamano <gitster@pobox.com>
Subject: Re: More builtin git-am issues..
Date: Sat, 05 Sep 2015 09:57:31 -0700
Message-ID: <xmqq7fo4dcsk.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
	<CA+55aFw2bnhSQYk4FaHfp4ED0Y611NWyQs05TMQtFj=2As1=nA@mail.gmail.com>
	<xmqqh9n9ele4.fsf@gitster.mtv.corp.google.com>
	<55EA9A13.2050108@kdbg.org>
	<20150905080325.GA25039@sigill.intra.peff.net>
	<xmqqk2s4deyo.fsf@gitster.mtv.corp.google.com>
	<xmqqbndgddy0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 05 18:57:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYGmX-0001yp-Cn
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 18:57:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752855AbbIEQ5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 12:57:34 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36805 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbbIEQ5d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 12:57:33 -0400
Received: by pacwi10 with SMTP id wi10so53428300pac.3
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 09:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=GZGYaMX72BCFnw5yNh9MnzAB85TvhwdJwi2pl/ilzcQ=;
        b=KejPBKdEjzAhAjyU5HV8PzMuuHBeWJI/bjza684oaTj3KNSZmrR9tdTS3EHzvyILN4
         F9JwQvR3Sz+QcGK1/tiMe/CVHHB1k6I9/Kgn90RjLq3OFvZsCMsTFoxoqKmaaqi3Rhyg
         QsoNkd/7Q2OO8ozLskq6tcpB3m2saUguVMp/ixoCuzShpho8Ypi9QNn8E2iGvhhS8UlI
         ZbxAV3/KrqrZmJVBZPrBJdI7NM3krJOugfhKK39aCwmNAy8zPKOfEVHX5oTfBWzRxlQY
         lRUC/4qYrVrxoa6MXNF7fQJBQa+Qtrt1outzebuRP0EUGzNYGUoDajQbLkt5OYMPyVx/
         e+ZA==
X-Received: by 10.68.249.66 with SMTP id ys2mr23134595pbc.82.1441472252999;
        Sat, 05 Sep 2015 09:57:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:20fa:dab1:6d64:e4c9])
        by smtp.gmail.com with ESMTPSA id rt6sm6357976pbb.62.2015.09.05.09.57.32
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Sat, 05 Sep 2015 09:57:32 -0700 (PDT)
In-Reply-To: <xmqqbndgddy0.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sat, 05 Sep 2015 09:32:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277390>

Junio C Hamano <gitster@pobox.com> writes:

> And a quick attempt without even compilation testing has flaws as
> expected X-<.
>
> Second attempt.

... and I forget the de-dup logic.  The third attempt.

 builtin/am.c | 32 ++++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 83b3d86..30ffdde 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1207,6 +1207,34 @@ static void NORETURN die_user_resolve(const struct am_state *state)
 	exit(128);
 }
 
+static void am_signoff(struct strbuf *sb)
+{
+	char *cp;
+	struct strbuf mine = STRBUF_INIT;
+
+	/* Does it end with our own sign-off? */
+	strbuf_addf(&mine, "%s%s\n",
+		    sign_off_header,
+		    fmt_name(getenv("GIT_COMMITTER_NAME"),
+			     getenv("GIT_COMMITTER_EMAIL")));
+	if (mine.len < sb->len &&
+	    !strcmp(mine.buf, sb->buf + sb->len - mine.len))
+		goto exit; /* no need to duplicate */
+
+	/* Does it have any Signed-off-by: in the text */
+	for (cp = sb->buf;
+	     cp && *cp && (cp = strstr(cp, sign_off_header)) != NULL;
+	     cp = strchr(cp, '\n')) {
+		if (sb->buf == cp || cp[-1] == '\n')
+			break;
+	}
+	if (!cp)
+		strbuf_addch(sb, '\n');
+	strbuf_addbuf(sb, &mine);
+exit:
+	strbuf_release(&mine);
+}
+
 /**
  * Appends signoff to the "msg" field of the am_state.
  */
@@ -1215,7 +1243,7 @@ static void am_append_signoff(struct am_state *state)
 	struct strbuf sb = STRBUF_INIT;
 
 	strbuf_attach(&sb, state->msg, state->msg_len, state->msg_len);
-	append_signoff(&sb, 0, 0);
+	am_signoff(&sb);
 	state->msg = strbuf_detach(&sb, &state->msg_len);
 }
 
@@ -1319,7 +1347,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 	stripspace(&msg, 0);
 
 	if (state->signoff)
-		append_signoff(&msg, 0, 0);
+		am_signoff(&msg);
 
 	assert(!state->author_name);
 	state->author_name = strbuf_detach(&author_name, NULL);
