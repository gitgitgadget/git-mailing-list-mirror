From: Junio C Hamano <gitster@pobox.com>
Subject: Re: More builtin git-am issues..
Date: Sat, 05 Sep 2015 09:32:39 -0700
Message-ID: <xmqqbndgddy0.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFzN4SnenchxPScn61_apzitGAPtoYEd49iLZPxgK0KQGw@mail.gmail.com>
	<CA+55aFw2bnhSQYk4FaHfp4ED0Y611NWyQs05TMQtFj=2As1=nA@mail.gmail.com>
	<xmqqh9n9ele4.fsf@gitster.mtv.corp.google.com>
	<55EA9A13.2050108@kdbg.org>
	<20150905080325.GA25039@sigill.intra.peff.net>
	<xmqqk2s4deyo.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 05 18:32:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYGOY-0003oS-R7
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 18:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254AbbIEQcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 12:32:43 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35673 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbbIEQcl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 12:32:41 -0400
Received: by pacfv12 with SMTP id fv12so54212654pac.2
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 09:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Bh0v0vOZ2lYfrQWNL5jP1eUcWYsDG1VsOYSLPDDuiD0=;
        b=Gkea36uDW+7q6KygJMRxUx+bL+1T75A5fKca7nxub9GqQhD1eYSDEioOsAys0G6jOs
         qGHicZYt4nJmyYOBatdWZ7IwzuSPbfux291+5RWUUoepUWhCP2tRHLqk9uv4J3fWuCqz
         bu9PngCm7L8yWUdxzgrG18hubn17Z2WUpQzJ547/eMFDzi+CDztXZwlCBYpg9AEZwtxC
         GVD7xZb/xoTOE2EhBCxdclOm+R4VqMm43jcgRgYbruegmahwyt7h5cRUa2f/6WWlxYZt
         qSEu2PolfwOFhN8r8O75NtlgIpnEEQzk7Je7ZGiS4s1UxwbyyLS73fdF+xoQ29ZTJ+wA
         mTQw==
X-Received: by 10.67.10.101 with SMTP id dz5mr1994915pad.13.1441470761362;
        Sat, 05 Sep 2015 09:32:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:20fa:dab1:6d64:e4c9])
        by smtp.gmail.com with ESMTPSA id ou5sm2604289pdb.51.2015.09.05.09.32.40
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Sat, 05 Sep 2015 09:32:40 -0700 (PDT)
In-Reply-To: <xmqqk2s4deyo.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sat, 05 Sep 2015 09:10:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277389>

Junio C Hamano <gitster@pobox.com> writes:

> But for the purpose of 2.6-rc period, I think we should start from
> doing a separate implementation inside builtin/am.c without touching
> append_signoff().
> ...
> Here is a quick attempt to do the "just fix am regression without
> changing anything else".

And a quick attempt without even compilation testing has flaws as
expected X-<.

Second attempt.

 builtin/am.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 83b3d86..3a65d09 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1207,6 +1207,27 @@ static void NORETURN die_user_resolve(const struct am_state *state)
 	exit(128);
 }
 
+static void am_signoff(struct strbuf *sb)
+{
+	char *cp;
+
+	strbuf_complete_line(sb);
+
+	for (cp = sb->buf;
+	     cp && *cp && (cp = strstr(cp, sign_off_header)) != NULL;
+	     cp = strchr(cp, '\n')) {
+		if (sb->buf == cp || cp[-1] == '\n')
+			break;
+	}
+	if (!cp)
+		strbuf_addch(sb, '\n');
+	strbuf_addf(sb, "%s%s\n",
+		    sign_off_header,
+		    fmt_name(getenv("GIT_COMMITTER_NAME"),
+			     getenv("GIT_COMMITTER_EMAIL")));
+	strbuf_addch(sb, '\n');
+}
+
 /**
  * Appends signoff to the "msg" field of the am_state.
  */
@@ -1215,7 +1236,7 @@ static void am_append_signoff(struct am_state *state)
 	struct strbuf sb = STRBUF_INIT;
 
 	strbuf_attach(&sb, state->msg, state->msg_len, state->msg_len);
-	append_signoff(&sb, 0, 0);
+	am_signoff(&sb);
 	state->msg = strbuf_detach(&sb, &state->msg_len);
 }
 
@@ -1319,7 +1340,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 	stripspace(&msg, 0);
 
 	if (state->signoff)
-		append_signoff(&msg, 0, 0);
+		am_signoff(&msg);
 
 	assert(!state->author_name);
 	state->author_name = strbuf_detach(&author_name, NULL);
