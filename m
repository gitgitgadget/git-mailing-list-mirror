From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH] Teach 'git-apply --whitespace=strip' to remove empty lines at the end of file
Date: Sun, 20 May 2007 14:45:59 +0200
Message-ID: <e5bfff550705200545kcf1f7f9n4f3f6d7d25955e1@mail.gmail.com>
References: <e5bfff550705200251j3dd9b377je7ae5bafac988060@mail.gmail.com>
	 <7vabvzq0bb.fsf@assigned-by-dhcp.cox.net>
	 <e5bfff550705200334pef694cn1a7842c23e2672f5@mail.gmail.com>
	 <7vabvzoij8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 14:46:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpknV-00005i-3H
	for gcvg-git@gmane.org; Sun, 20 May 2007 14:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755054AbXETMqB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 08:46:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755125AbXETMqA
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 08:46:00 -0400
Received: from nz-out-0506.google.com ([64.233.162.226]:46763 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755054AbXETMqA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 08:46:00 -0400
Received: by nz-out-0506.google.com with SMTP id z3so46162nzf
        for <git@vger.kernel.org>; Sun, 20 May 2007 05:45:59 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I1HaB1CcdUc0qylsqCu1yCqDsmjSCV0hAc4T/6/b2RXruVc0VcAlP89AqF/54y5l0jG63grrHfKHz4Ih23bVuakUQJ2y+r7+2Me6zK4Pt2bvpsz7hjUPJTcKwQYILKIXsSfAL6WnGdryLRgIsQf8M+rRZRW03sWrcj8bOG0x2bI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q33KF5BiWYgHDaTUcslidAZ0//2yPX1G5a8aIdfjB2OetMFAx5YPb3fc9yMDPdqUDsYtsFHDw/aPFVWX5/tnn0ivyshqAgXtoxcIg3JP30U0fzChkKKxqrFDVaG82tXlZa9iQSRpWBcIUgV8bwNK+fFKN5S0XNcfrqjKEh3+vjA=
Received: by 10.114.171.1 with SMTP id t1mr1978502wae.1179665159192;
        Sun, 20 May 2007 05:45:59 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Sun, 20 May 2007 05:45:59 -0700 (PDT)
In-Reply-To: <7vabvzoij8.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47833>

On 5/20/07, Junio C Hamano <junkio@cox.net> wrote:
>
> I was starting to suspect that I misunderstood what you were
> trying to do.  I thought you were trying to avoid a patch that
> adds (one or more) blank line(s) at the end of the file, but is
> it that you do not want to have a hunk that adds more than one
> blank line anywhere?  However, the comment "Only fragments that
> add lines at the bottom ends with '+' lines" suggests otherwise.
>

No, you understand right.

>
> Because we had the same mistake in our earlier code as you made
> in this patch, which assumed that a hunk that ends with '+' only
> apply at the end (and we still assume that by default), if you
> apply this with patch git-apply without --unidiff-zero option,
> you get an error.  If you use the option this patch can be
> applied correctly.
>

Ok. This is take 3. It works correctly on standard patches and also on
u0 example that you gave above.

This patch is on top of git 1.5.2

Please check it.

builtin-apply.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 0399743..6032f78 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1671,6 +1671,7 @@ static int apply_one_fragment(struct buffer_desc *desc,
 	char *new = xmalloc(size);
 	const char *oldlines, *newlines;
 	int oldsize = 0, newsize = 0;
+	int trailing_added_lines = 0;
 	unsigned long leading, trailing;
 	int pos, lines;

@@ -1699,6 +1700,17 @@ static int apply_one_fragment(struct buffer_desc *desc,
 			else if (first == '+')
 				first = '-';
 		}
+		/*
+		 * Count lines added at the end of the file.
+		 * This is not enough to get things right in case of
+		 * patches generated with --unified=0, but it's a
+		 * useful upper bound.
+		*/
+		if (first == '+')
+			trailing_added_lines++;
+		else
+			trailing_added_lines = 0;
+
 		switch (first) {
 		case '\n':
 			/* Newer GNU diff, empty context line */
@@ -1738,6 +1750,24 @@ static int apply_one_fragment(struct buffer_desc *desc,
 		newsize--;
 	}

+	if (new_whitespace == strip_whitespace) {
+		/* Any added empty lines is already cleaned-up here
+		 * becuase of 'strip_whitespace' flag, so just count '\n'
+		*/
+		int empty = 0;
+		while (   empty < trailing_added_lines
+		       && newsize - empty > 0
+		       && new[newsize - empty - 1] == '\n')
+			empty++;
+
+		if (empty < trailing_added_lines)
+			empty--;
+
+		/* these are the empty lines added at
+		 * the end of the file, modulo u0 patches.
+		 */
+		trailing_added_lines = empty;
+	}
 	oldlines = old;
 	newlines = new;
 	leading = frag->leading;
@@ -1770,6 +1800,10 @@ static int apply_one_fragment(struct buffer_desc *desc,
 		if (match_beginning && offset)
 			offset = -1;
 		if (offset >= 0) {
+
+			if (desc->size - oldsize - offset == 0) /* end of file? */
+				newsize -= trailing_added_lines;
+
 			int diff = newsize - oldsize;
 			unsigned long size = desc->size + diff;
 			unsigned long alloc = desc->alloc;
