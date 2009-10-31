From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/8] Do not use VISUAL editor on dumb terminals
Date: Fri, 30 Oct 2009 20:30:39 -0500
Message-ID: <20091031013039.GC5160@progeny.tock>
References: <20091030101634.GA1610@progeny.tock>
 <20091031012050.GA5160@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ben Walton <bwalton@artsci.utoronto.ca>,
	Johannes Sixt <j.sixt@viscovery.net>,
	David Roundy <roundyd@physics.oregonstate.edu>,
	GIT List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 02:20:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N42dr-0002oe-89
	for gcvg-git-2@lo.gmane.org; Sat, 31 Oct 2009 02:20:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757593AbZJaBUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 21:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757563AbZJaBUU
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 21:20:20 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:51691 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933098AbZJaBUT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 21:20:19 -0400
Received: by yxe17 with SMTP id 17so3219108yxe.33
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 18:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=WQEKt055XVvAD6YrAjT68upsLvSE9CJXuqJ339Og5iA=;
        b=o/e1lkdlNC6kj+OKt+EAv/Gzekb3Vy6qwWpBnMmEjKQ3hcKoosv9z2lG2gM6p2rxqo
         vikhcH5YH8EUi9HAaua6Crc+EzuPpJDEW1M9vczQX/saKCMRwfCAcekhqXpOur/JIZa8
         TZ5OLh0Hdwg8becSCm51dEPWwGDFKTLi01gdM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ldQMi1sDQs9PVOVdofB3jutctJhqvnDdcn50dp2QDcp84PiBNawdo0ucWPeeR3xku2
         0YBS6wnsmNcamSb9DuX1gghTm2t1hgdlTbvri+eQOJjl18SlKGIAnYYXMnDDs4Xoqxb6
         Svx5KO4ZYWicWlAmlY0oOw0xhRB1f9rGYJnwo=
Received: by 10.151.25.21 with SMTP id c21mr4310482ybj.23.1256952023278;
        Fri, 30 Oct 2009 18:20:23 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 13sm575164gxk.5.2009.10.30.18.20.22
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 30 Oct 2009 18:20:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20091031012050.GA5160@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131815>

Refuse to use $VISUAL and fall back to $EDITOR if TERM is unset
or set to "dumb".  Traditionally, VISUAL is set to a screen
editor and EDITOR to a line-based editor, which should be more
useful in that situation.

vim, for example, is happy to assume a terminal supports ANSI
sequences even if TERM is dumb (e.g., when running from a text
editor like Acme).  git already refuses to fall back to vi on a
dumb terminal if GIT_EDITOR, core.editor, VISUAL, and EDITOR are
unset, but without this patch, that check is suppressed by
VISUAL=vi.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
This patch eases my discomfort about the error message a little.  It
is not actually needed to support any ways of working I engage in.

If stdout is redirected, this is probably still making the wrong
choice; isatty(STDOUT_FILENO) might be a more useful datum to use.
But it does not seem worth complicating the logic further.

 editor.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/editor.c b/editor.c
index 941c0b2..3f13751 100644
--- a/editor.c
+++ b/editor.c
@@ -4,19 +4,19 @@
 
 int launch_editor(const char *path, struct strbuf *buffer, const char *const *env)
 {
-	const char *editor, *terminal;
+	const char *editor = getenv("GIT_EDITOR");
+	const char *terminal = getenv("TERM");
+	int terminal_is_dumb = !terminal || !strcmp(terminal, "dumb");
 
-	editor = getenv("GIT_EDITOR");
 	if (!editor && editor_program)
 		editor = editor_program;
-	if (!editor)
+	if (!editor && !terminal_is_dumb)
 		editor = getenv("VISUAL");
 	if (!editor)
 		editor = getenv("EDITOR");
 
-	terminal = getenv("TERM");
-	if (!editor && (!terminal || !strcmp(terminal, "dumb")))
-		return error("Terminal is dumb but no VISUAL nor EDITOR defined.");
+	if (!editor && terminal_is_dumb)
+		return error("terminal is dumb, but EDITOR unset");
 
 	if (!editor)
 		editor = "vi";
-- 
1.6.5.2
