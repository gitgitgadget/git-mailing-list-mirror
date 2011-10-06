From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v2] revert.c: defer writing CHERRY_PICK_HEAD till it is
 safe to do so
Date: Thu, 6 Oct 2011 13:58:01 -0400
Message-ID: <CAG+J_Dw8w9UGBzq4xK+i+QtA4ZuwJ5w1+mPg15mPNcGLuRaXyg@mail.gmail.com>
References: <1317923315-54940-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jay Soffian <jaysoffian@gmail.com>, nicolas.dichtel@6wind.com,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 19:58:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBsCz-0000Gw-IN
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 19:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965245Ab1JFR6D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 13:58:03 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41629 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940Ab1JFR6C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 13:58:02 -0400
Received: by yxl31 with SMTP id 31so2857040yxl.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 10:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7lzUmof/GwGW3eRFNygAdiZ3sPpkt1i5yDEUxWh8dWU=;
        b=NiPSG+CA1BpEGz0I5czfiyVZSjDVoDXUo6mCAuM+IfgliRy3SdLHkcV3gXdwOCPAdG
         vruGu1uRjWOVyy5kp/3sRoSeAk1ejd+pW0p9X49retMzj+eIOOs0XBah1ki5x1UuPIo2
         LFUES8ty8WiP5LWsZPS3nceTG4sGKzI7ZMrcc=
Received: by 10.147.5.21 with SMTP id h21mr763242yai.26.1317923881594; Thu, 06
 Oct 2011 10:58:01 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Thu, 6 Oct 2011 10:58:01 -0700 (PDT)
In-Reply-To: <1317923315-54940-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183002>

On Thu, Oct 6, 2011 at 1:48 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> Note that do_recursive_merge() aborts if the merge cannot start, while
> try_merge_command() returns a non-zero value other than 1.

Maybe you want this on-top:

diff --git i/builtin/revert.c w/builtin/revert.c
index a95b255c86..7e4857530b 100644
--- i/builtin/revert.c
+++ w/builtin/revert.c
@@ -223,7 +223,7 @@ static void advise(const char *advice, ...)
 	va_end(params);
 }

-static void print_advice(void)
+static void print_advice(int show_hint)
 {
 	char *msg = getenv("GIT_CHERRY_PICK_HELP");

@@ -238,9 +238,11 @@ static void print_advice(void)
 		return;
 	}

-	advise("after resolving the conflicts, mark the corrected paths");
-	advise("with 'git add <paths>' or 'git rm <paths>'");
-	advise("and commit the result with 'git commit'");
+	if (show_hint) {
+		advise("after resolving the conflicts, mark the corrected paths");
+		advise("with 'git add <paths>' or 'git rm <paths>'");
+		advise("and commit the result with 'git commit'");
+	}
 }

 static void write_message(struct strbuf *msgbuf, const char *filename)
@@ -510,7 +512,7 @@ static int do_pick_commit(void)
 		      : _("could not apply %s... %s"),
 		      find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
 		      msg.subject);
-		print_advice();
+		print_advice(res == 1);
 		rerere(allow_rerere_auto);
 	} else {
 		if (!no_commit)


j.
