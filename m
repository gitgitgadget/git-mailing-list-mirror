From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: terminate state files with a newline
Date: Sun, 23 Aug 2015 12:05:32 -0700
Message-ID: <xmqqy4h16d1f.fsf@gitster.dls.corp.google.com>
References: <20150820152247.Horde.3yFLIbhFFocB99yz8o1iwg1@webmail.informatik.kit.edu>
	<xmqqa8tl7qi3.fsf@gitster.dls.corp.google.com>
	<20150823055053.GA15849@yoshi.chippynet.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 21:05:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTaaY-0005lX-1H
	for gcvg-git-2@plane.gmane.org; Sun, 23 Aug 2015 21:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbbHWTFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2015 15:05:36 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35016 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399AbbHWTFf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2015 15:05:35 -0400
Received: by pacdd16 with SMTP id dd16so79796018pac.2
        for <git@vger.kernel.org>; Sun, 23 Aug 2015 12:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Gzcw+y7oOeUAXb9in8hENqBhyXLCa719Vvg7M7HYSkU=;
        b=WhKXMS6mBn5TMVTTkgxMpZMkcsOM/SHnItbGhR+U7UxTdQAq+eBH/2NMKWjpYR2rFO
         ley0SkJj6/5YsT3fEgidregmRXYf2HcjjU3qanOXORss06+LYca3JI3bPDfGls2fD7Ka
         4RZ79Rprk959oyJuPdOxXfvYq8KXIoAdcmCHgFK4ynbNDICJXssUm0RRp9hZAQeXZNr0
         mR/o/pLigna2xGVzcPXV/wdmunyjYAuz8iNiMLnNB5b5CXQOSwEVNArJ75QQcaMYRDl1
         I+cHnYzTdoIoGo/MYvNJymFvYdBegXFsnyOXIknxEy0q2L903jMKzGwcYnDaBGG9/LkZ
         2pSQ==
X-Received: by 10.66.139.6 with SMTP id qu6mr24513085pab.77.1440356734374;
        Sun, 23 Aug 2015 12:05:34 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e53a:1155:f7f9:400e])
        by smtp.gmail.com with ESMTPSA id f5sm14744661pas.23.2015.08.23.12.05.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 23 Aug 2015 12:05:33 -0700 (PDT)
In-Reply-To: <20150823055053.GA15849@yoshi.chippynet.com> (Paul Tan's message
	of "Sun, 23 Aug 2015 13:50:53 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276424>

Paul Tan <pyokagan@gmail.com> writes:

> Did we ever explictly allow external programs to poke around the
> contents of the .git/rebase-apply directory?

We tell users to take a peek into it when "am" fails, don't we, by
naming $GIT_DIR/rebase-apply/patch?

> -	write_file(am_path(state, "threeway"), 1, state->threeway ? "t" : "f");
> +	write_file(am_path(state, "threeway"), 1, "%s\n", state->threeway ? "t" : "f");

Stepping back a bit, after realizing that "write_file()" is a
short-hand for "I have all information necessary to produce the full
contents of a file, now go ahead and create and write that and
close", I have to wonder what caller even wants to create a file
with an incomplete line at the end.

All callers outside builtin/am.c except one caller uses it to
produce a single line file.  The oddball is "git branch" that uses
it to prepare a temporary file used to edit branch description.  

builtin/branch.c:	if (write_file(git_path(edit_description), 0, "%s", buf.buf)) {

The payload it prepares in buf.buf ends with a canned comment that
ends with LF.  So in that sense it is not even an oddball.

The above analysis makes me wonder if this is a simpler and more
future proof approach.

Or did I miss any caller or a reasonable potential future use case
that wants to create a binary file or a text file that ends with an
incomplete line?

 wrapper.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/wrapper.c b/wrapper.c
index e451463..7a92298 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -621,6 +621,13 @@ char *xgetcwd(void)
 	return strbuf_detach(&sb, NULL);
 }
 
+/*
+ * Create a TEXT file by specifying its full contents via fmt and the
+ * remainder of args that are used like "printf".  A terminating LF is
+ * added at the end of the file if it is missing (it is simpler for
+ * the callers because the function is often used to create a
+ * single-liner file).
+ */
 int write_file(const char *path, int fatal, const char *fmt, ...)
 {
 	struct strbuf sb = STRBUF_INIT;
@@ -634,6 +641,9 @@ int write_file(const char *path, int fatal, const char *fmt, ...)
 	va_start(params, fmt);
 	strbuf_vaddf(&sb, fmt, params);
 	va_end(params);
+	if (sb.len)
+		strbuf_complete_line(&sb);
+
 	if (write_in_full(fd, sb.buf, sb.len) != sb.len) {
 		int err = errno;
 		close(fd);
