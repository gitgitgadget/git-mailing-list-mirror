From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/3] rev-parse: be more careful with munging arguments
Date: Fri, 6 Dec 2013 16:04:37 -0800
Message-ID: <20131207000437.GP29959@google.com>
References: <20131206220520.GA30652@sigill.intra.peff.net>
 <20131206220751.GB25620@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 07 01:04:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vp5O9-0003kB-CH
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 01:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758094Ab3LGAEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 19:04:42 -0500
Received: from mail-qa0-f41.google.com ([209.85.216.41]:38648 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396Ab3LGAEl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 19:04:41 -0500
Received: by mail-qa0-f41.google.com with SMTP id j5so1071935qaq.0
        for <git@vger.kernel.org>; Fri, 06 Dec 2013 16:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=oWH4njI0C1HlKHE5V9h9Rw9dF/qE6KTBAUTEYzHhGmc=;
        b=JEdkL83Bo1Xek9MRYwTz3worrLcvw2j6Wq6JESdoW+BOJ9V4n/P7+9//EsItJz/716
         wzI8yIMVkIagTELI3ZncILUjzJYD1ib06Mhe9VRjxlwb0KE20cYj/b6hH8jypn7QLdLb
         LhwPTbJ6TbgIyLLOGo36EKITWTAZgQWewpMc8eL9zLghA87dr3fPdLPWeYExjUHODyf9
         aaN84fSDYTzra9GlClk+hCHzq7TkaYH03piJclqRm/Q4nUk7pHN/j/3zA2tcaYI/8D/n
         6OPBf5DtCRG0nbqXVBr6YMuTIcojCxWUcZZgmZcJ3SeLyse7Xj56LCbfogsn+jGZUfoM
         G6Nw==
X-Received: by 10.224.46.8 with SMTP id h8mr64681135qaf.49.1386374680589;
        Fri, 06 Dec 2013 16:04:40 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id n7sm973597qai.1.2013.12.06.16.04.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 06 Dec 2013 16:04:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131206220751.GB25620@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238967>

Jeff King wrote:

> As an aside, this is one of those places where C's string functions do
> gross things with const.

Yes, yuck.

The fundamental grossness is that argv is semantically char **
(assuming this doesn't segfault) but passed around as const char **.
I wonder why we don't use the same trick in git_extract_argv0_path and
when handling STRIP_EXTENSION in git.c.

Alternatively, try_difference could create a new buffer for its own
use.  Originally (v0.99~273, 2005-06-13) this dotdot handling code was
pretty simple:

	for (i = 1; i < argc; i++) {
		char *arg = argv[i];

		...

		dotdot = strstr(arg, "..");
		if (dotdot) {
			unsigned char end[20];
			char *n = dotdot+2;
			*dotdot = 0;
			if (!get_sha1(arg, sha1)) {
				if (!*n)
					n = "HEAD";
				if (!get_sha1(n, end)) {
					printf("%s\n", sha1_to_hex(end));
					printf("^%s\n", sha1_to_hex(sha1));
					continue;
				}
			}
			*dotdot = '.';
		}
		printf("%s\n", arg);
	}

The 'continue' without making the argument right again was justified
because we were done with the argument.

Now it is still not much more complicated --- the function is
logically just trying to parse the argument into a "this" and "next"
part and print them.

Something like the following (untested).  Or if the allocation churn
is too much, it could use a static strbuf.

diff --git i/builtin/rev-parse.c w/builtin/rev-parse.c
index c76b89d..98262b3 100644
--- i/builtin/rev-parse.c
+++ w/builtin/rev-parse.c
@@ -234,37 +234,35 @@ static int try_difference(const char *arg)
 	unsigned char sha1[20];
 	unsigned char end[20];
 	const char *next;
-	const char *this;
+	struct strbuf this = STRBUF_INIT;
 	int symmetric;
-	static const char head_by_default[] = "HEAD";
 
 	if (!(dotdot = strstr(arg, "..")))
 		return 0;
 	next = dotdot + 2;
-	this = arg;
 	symmetric = (*next == '.');
-
-	*dotdot = 0;
 	next += symmetric;
 
-	if (!*next)
-		next = head_by_default;
-	if (dotdot == arg)
-		this = head_by_default;
-
-	if (this == head_by_default && next == head_by_default &&
-	    !symmetric) {
+	if (!*next && dotdot == arg && !symmetric)
 		/*
 		 * Just ".."?  That is not a range but the
 		 * pathspec for the parent directory.
 		 */
-		*dotdot = '.';
 		return 0;
+
+	strbuf_add(&this, arg, dotdot - arg);
+
+	if (!*next)
+		next = "HEAD";
+	if (dotdot == arg) {
+		strbuf_reset(&this);
+		strbuf_addstr(&this, "HEAD");
 	}
 
-	if (!get_sha1_committish(this, sha1) && !get_sha1_committish(next, end)) {
+	if (!get_sha1_committish(this.buf, sha1)
+	    && !get_sha1_committish(next, end)) {
 		show_rev(NORMAL, end, next);
-		show_rev(symmetric ? NORMAL : REVERSED, sha1, this);
+		show_rev(symmetric ? NORMAL : REVERSED, sha1, this.buf);
 		if (symmetric) {
 			struct commit_list *exclude;
 			struct commit *a, *b;
@@ -279,9 +277,10 @@ static int try_difference(const char *arg)
 				exclude = n;
 			}
 		}
+		strbuf_release(&this);
 		return 1;
 	}
-	*dotdot = '.';
+	strbuf_release(&this);
 	return 0;
 }
 
