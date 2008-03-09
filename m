From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Parsing diff --git lines
Date: Sat, 8 Mar 2008 20:04:28 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0803081955110.5896@woody.linux-foundation.org>
References: <F4D3B820-CCF4-4212-BF32-700EFD448143@mac.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Simon Fraser <smfr@mac.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 05:05:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYCn8-0007kk-8U
	for gcvg-git-2@gmane.org; Sun, 09 Mar 2008 05:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbYCIEEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Mar 2008 23:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbYCIEEi
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Mar 2008 23:04:38 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49653 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751922AbYCIEEh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Mar 2008 23:04:37 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m29454ok012483
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 8 Mar 2008 20:05:05 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2944TwA015531;
	Sat, 8 Mar 2008 20:04:30 -0800
In-Reply-To: <F4D3B820-CCF4-4212-BF32-700EFD448143@mac.com>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.422 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76634>



On Sat, 8 Mar 2008, Simon Fraser wrote:
> 
> However, I don't see a reliable way to identify the two files
> from a "diff --git" line. Here's a (deliberately pathological)
> example:

See how "git-apply" does it.

The rule is:

 - if the filenames are different, you should ignore the filenames on the 
   "diff --git" line, and trust the ones on the "renamed from/to" ones 
   (which are unambiguous because they only have one filename per line)

 - if the filenames aren't different, then you can unambiguously know how 
   to parse it by simply making sure they are the same.

So to take your example:

> diff --git a/a / b/file with spaces.txt b/a / b/file with spaces.txt

Here, you can *know* that the filename is "a / b/file with spaces.txt", 
because it must match the pattern "a/$filename b/$filename", and no other 
split at a space would ever do that!

See in particular "git_header_name()" in builtin-apply.c. See the comments 
both at the top of the function and there in the middle to reflect the 
above rule:

/*
 * This is to extract the same name that appears on "diff --git"
 * line.  We do not find and return anything if it is a rename
 * patch, and it is OK because we will find the name elsewhere.
 * We need to reliably find name only when it is mode-change only,
 * creation or deletion of an empty file.  In any of these cases,
 * both sides are the same name under a/ and b/ respectively.
 */
...
        /*
         * Accept a name only if it shows up twice, exactly the same
         * form.
         */

> What would make this possible would be either to always quote
> file paths containing spaces, or use a character other than
> a space (e.g. a \t) between the two file names.

Well, git didn't originally ever quote filenames at all, and I actually 
wanted the "diff --git" line to look as much like a regular "diff -urN" 
line as possible (which has spaces between the names)

These days, we could quote, but hey, anybody who parses diff lines needs 
to be able to handle the non-quoted form *anyway*, so quoting doesn't 
really help anybody in the end.

			Linus
