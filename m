X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC (take 2)] gitweb: New improved patchset view
Date: Sun, 29 Oct 2006 17:12:20 -0800
Message-ID: <7vr6wqy5cb.fsf@assigned-by-dhcp.cox.net>
References: <200610291122.30852.jnareb@gmail.com>
	<200610300051.37896.jnareb@gmail.com>
	<200610300134.53668.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 01:12:35 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200610300134.53668.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 30 Oct 2006 01:34:53 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30477>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeLhX-0002T9-VQ for gcvg-git@gmane.org; Mon, 30 Oct
 2006 02:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965461AbWJ3BMW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 20:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965463AbWJ3BMW
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 20:12:22 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:45799 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S965461AbWJ3BMV
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 20:12:21 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061030011221.KUZG18985.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Sun, 29
 Oct 2006 20:12:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id gRCR1V0051kojtg0000000 Sun, 29 Oct 2006
 20:12:25 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Few other questions, probably to be adressed in the future patches, and 
> not added to this one.
>
> 0. git-ls-tree and git-diff-tree without -z does quote not only ...
> also UTF-8 characters.

I've already mentioned this in an earlier message to you:

	Message-ID: <7v3b972bzq.fsf@assigned-by-dhcp.cox.net>

Let's illustrate what I mean by an untested patch; this does:

 0. Use explicitly "unsigned char" so that (ch < ' ') does not
    catch bytes in 0x80- range.  The original meant to catch the
    control characters only so this is a bugfix;

 1. We still worry about control characters in 0x80-0x9f range;
    if there are some, that is not a valid UTF-8 string (or
    other encodings that is compatible with ASCII), and quoting
    only these bytes and not quoting 0xa0- range can result
    in letters chopped in the middle, so we would quote all
    bytes in 0xa0- range when we have them;

 2. Otherwise we do not quote bytes in 0xa0- range.

-- >8 --
diff --git a/quote.c b/quote.c
index ee7d62c..4f086fb 100644
--- a/quote.c
+++ b/quote.c
@@ -199,18 +199,32 @@ static int quote_c_style_counted(const c
 
 #define EMITQ() EMIT('\\')
 
-	const char *sp;
-	int ch, count = 0, needquote = 0;
+	const unsigned char *name_u = (const unsigned char *)name;
+	const unsigned char *sp;
+	int ch, count = 0, needquote = 0, has_high_ctrl = 0;
+
+	/* Check if we have control character in 0x80-0x9f range */
+	for (sp = name_u; sp < name_u + namelen; sp++) {
+		ch = *sp;
+		if (!ch)
+			break;
+		if ((ch < ' ') || (ch == '"') || (ch == '\\') ||
+		    (ch == 0177) || (ch == 0377))
+			needquote = 1;
+		else if (0x80 <= ch && ch <= 0x9f)
+			needquote = has_high_ctrl = 1;
+	}
 
 	if (!no_dq)
 		EMIT('"');
-	for (sp = name; sp < name + namelen; sp++) {
+
+	for (sp = name_u; sp < name_u + namelen; sp++) {
 		ch = *sp;
 		if (!ch)
 			break;
 		if ((ch < ' ') || (ch == '"') || (ch == '\\') ||
-		    (ch == 0177) || (ch == 0377)) {
-			needquote = 1;
+		    (ch == 0177) ||
+		    (has_high_ctrl && 0x80 <= ch)) {
 			switch (ch) {
 			case '\a': EMITQ(); ch = 'a'; break;
 			case '\b': EMITQ(); ch = 'b'; break;
-- 8< --

> 1. Current version doesn't display empty patches (i.e. pure rename and 
> mode change combinations) and doesn't provide links to them from 
> difftree. This is legacy of old /usr/bin/diff using code, which did not 
> generated extended diff header, which is only output for "empty 
> patches". Should we change this, or leave as is?

I think this needs to be fixed.

> 2. Schould we change syntax highlighting of chunk header line, namely 
> changing slightly syntax coloring of "in which function are we" part of 
> chunk header?

Probably matching "git diff --color" would be sensible; by
following what has already been done, you do not have to think
about what to color and how yourself.

> 3. Should we make from-range/to-range in chunk header hyperlink to the 
> start of given bunch of lines in appropriate file? Or perhaps to the 
> middle of the bunch of lines? Or to first changed line (omitting 
> context)?

I do not see what usage pattern this link would help.  Care to
explain a bit better?
