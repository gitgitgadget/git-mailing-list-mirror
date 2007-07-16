From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Add --show-size to git log to print message size
Date: Mon, 16 Jul 2007 19:50:58 +0200
Message-ID: <e5bfff550707161050w5751c63fnfa86312c86eaa552@mail.gmail.com>
References: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com>
	 <7vodiehko7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 16 19:51:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAUit-0006wy-GN
	for gcvg-git@gmane.org; Mon, 16 Jul 2007 19:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbXGPRvA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 13:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbXGPRvA
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 13:51:00 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:2970 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbXGPRu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 13:50:59 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1664903wah
        for <git@vger.kernel.org>; Mon, 16 Jul 2007 10:50:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EOhh4QuZ1jjfqicKl/yXY/w4azUHnzzVuS5nDqJDaZBey91IJ1ZWOEN7EdqVQtOe6gY6zaRT0KLUrX2F1Gp8EO9VT8gf7pyex5mkxWBwMAqCgyT2VubNyRfsDqkiVNRM24Bs9zH0mtAjxb4SlzB2jlCfw+AMkPQPy2+SW/EM/dM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Nh4k2jjims3Pmy29YLXrEC1L6gZim/cnPEJASaT0vFWq7Xo4+yoKCuA/b/n3AGwVuHbeivyFsbWmg+ebZk/123sBtnDeZyBr4AOhxXs4yUYp8ZV78UnVP9wwxIUl1efO12zKvWDd379P0Au5oZ4/yjHPAIRX7E5BGEeRXnz9TBw=
Received: by 10.114.66.2 with SMTP id o2mr4344953waa.1184608258266;
        Mon, 16 Jul 2007 10:50:58 -0700 (PDT)
Received: by 10.114.56.6 with HTTP; Mon, 16 Jul 2007 10:50:58 -0700 (PDT)
In-Reply-To: <7vodiehko7.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52699>

On 7/14/07, Junio C Hamano <gitster@pobox.com> wrote:
>
> The current code spits out a log message after formatting it in
> its entirety in core, so we happen to have its size upfront.
> Having to say the size upfront means we close the door for
> alternative implementations that stream the log formatting
> processing.
>

This is a better named patch that try also to easy your correct point
about alternative implementations, in particular  a value of zero is
reserved in case git is unable to satisfy the request, so that tools
can fallback on standard '\0' searching.

After inspecting diff.c code I made up my mind only log message can be
sized upfront, diff ocntent is printed by a bunch of printf, fwrite,
fputs, putchar and so on and it's impossible to know the size in
advance.

------------------- cut -------------------

Subject: [PATCH] Add --log-size to git log to print message size

Print message size just before the corresponding message.

Because git log output is normally read incrementally by
porcelain tools, if message size is ignored then an
expensive seek of a delimiting char, as example '\0'
must be done when parsing the output stream.

With this patch it is possible to avoid an otherwise
mandatory seek for '\0' starting from the beginning
of log body.

In case it is not possible to know the size upfront
size value is set to zero.

Signed-off-by: Marco Costalba <mcostalba@gmail.com>
---
 Documentation/git-log.txt |    5 +++++
 log-tree.c                |    3 +++
 revision.c                |    4 ++++
 revision.h                |    1 +
 4 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 63c1dbe..b539f50 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -64,6 +64,11 @@ include::pretty-options.txt[]
 --follow::
 	Continue listing the history of a file beyond renames.

+--log-size::
+	Before the log message print out its size in bytes. Intended
+	mainly for porcelain tools consumption. If git is unable to
+	produce a valid value size is set to zero.
+
 <paths>...::
 	Show only commits that affect the specified paths.

diff --git a/log-tree.c b/log-tree.c
index 8624d5a..2dc6b1b 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -295,6 +295,9 @@ void show_log(struct rev_info *opt,
 	if (opt->add_signoff)
 		len = append_signoff(&msgbuf, &msgbuf_len, len,
 				     opt->add_signoff);
+ 	if (opt->show_log_size)
+		printf("log size %i\n", len);
+
 	printf("%s%s%s", msgbuf, extra, sep);
 	free(msgbuf);
 }
diff --git a/revision.c b/revision.c
index 28b5f2e..f1cbb1f 100644
--- a/revision.c
+++ b/revision.c
@@ -1149,6 +1149,10 @@ int setup_revisions(int argc, const
 					die("unknown date format %s", arg);
 				continue;
 			}
+			if (!strcmp(arg, "--log-size")) {
+				revs->show_log_size = 1;
+				continue;
+			}

 			/*
 			 * Grepping the commit log
diff --git a/revision.h b/revision.h
index f46b4d5..98a0a8f 100644
--- a/revision.h
+++ b/revision.h
@@ -81,6 +81,7 @@ struct rev_info {
 	const char	*log_reencode;
 	const char	*subject_prefix;
 	int		no_inline;
+	int		show_log_size;

 	/* Filter by commit log message */
 	struct grep_opt	*grep_filter;
-- 
1.5.3.rc2-dirty
