From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC PATCH] git log: support "auto" decorations
Date: Thu, 29 May 2014 15:31:58 -0700 (PDT)
Message-ID: <alpine.LFD.2.11.1405291523520.8270@i7.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 30 00:32:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq8rm-0007fD-HX
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 00:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbaE2WcC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 18:32:02 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:50161 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbaE2WcB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 18:32:01 -0400
Received: by mail-pa0-f47.google.com with SMTP id ld10so962147pab.34
        for <git@vger.kernel.org>; Thu, 29 May 2014 15:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:user-agent:mime-version
         :content-type;
        bh=KhKyGrcejfixyRUYT2CKa5WsIRw/eYxu9FIj79a2AjU=;
        b=uccdvLXAEr9FUJ3pPgbeVMx+RTj6YXkC8nK1d5BUIhkeTzIg8xBOU8MaR3B3WUgt00
         AzzAjbQSoMpLsdR1J9cOcQ+/we6Uffv0U1nlTSXEK70uFQGqTpwY2/yPSHog3wu2lvhe
         osHKM1kiZ3DeqvlGDU33KJoJ1lLqjxLW2daQWWtw2WVFqtGMZ7czORA3j4OMEmTLx7iz
         fptoeYdU24blBEfP04z6YZiyeG5eA9AwXsL4tTwJ73jSxUs6TLBjnK6OmlZ8dr/w72gl
         zk+AYjCkfvQfrfbQItV9ntw52PmQAiW53LlyWZLQw/1T3trHZk+Q1tK0h4h/pBjavQMm
         1I3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=sender:date:from:to:cc:subject:message-id:user-agent:mime-version
         :content-type;
        bh=KhKyGrcejfixyRUYT2CKa5WsIRw/eYxu9FIj79a2AjU=;
        b=KR7S0yRYr5aNyepVXnKII5i4XkmCKnemUoHg3+Yhr2qQcCxkY09sv4jYCqMuikNiu/
         seTr70RtmURE/XcVssI98LGsY1XM3lY5BCF+ydhnPvlC6vL9JtO/eSpDbhh8XeBb3YUD
         Cg2ypUdhmrHK7E3sk5/G6DFStTamxtSeyMR9g=
X-Received: by 10.66.66.135 with SMTP id f7mr13202979pat.22.1401402720616;
        Thu, 29 May 2014 15:32:00 -0700 (PDT)
Received: from i7.lan (c-24-22-13-12.hsd1.or.comcast.net. [24.22.13.12])
        by mx.google.com with ESMTPSA id fk4sm8905722pab.23.2014.05.29.15.31.59
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 29 May 2014 15:31:59 -0700 (PDT)
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250410>


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 29 May 2014 15:19:40 -0700
Subject: [RFC PATCH] git log: support "auto" decorations

This works kind of like "--color=auto" - add decorations for interactive
use, but do not change defaults when scripting or when piping the output
to anything but a terminal.

You can use either

    [log]
         decorate=auto

in the git config files, or the "--decorate=auto" command line option to
choose this behavior.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

I actually like seeing decorations by default, but I do *not* think our 
current "log.decorate" options make sense, since they will change any 
random use of "git log" to have decorations. I much prefer the 
"ui.color=auto" behavior that we have for coloration. This is a trivial 
patch that tries to approximate that.

It's marked with RFC because

 (a) that "isatty(1) || pager_in_use()" test is kind of hacky, maybe we 
     would be better off sharing something with the auto-coloration?

 (b) I also think it would be nice to have the equivalent for 
     "--show-signature", but there we don't have any preexisting config 
     file option.

 (c) maybe somebody would like a way to combine "auto" and "full", 
     although personally that doesn't seem to strike me as all that useful 
     (would you really want to see the full refname when not scripting it)

but the patch is certainly simple and seems to work. Comments?

 builtin/log.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index 39e883635279..df6396c9c3d9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -63,6 +63,8 @@ static int parse_decoration_style(const char *var, const char *value)
 		return DECORATE_FULL_REFS;
 	else if (!strcmp(value, "short"))
 		return DECORATE_SHORT_REFS;
+	else if (!strcmp(value, "auto"))
+		return (isatty(1) || pager_in_use()) ? DECORATE_SHORT_REFS : 0;
 	return -1;
 }
 
-- 
2.0.0.1.g5beb60c
