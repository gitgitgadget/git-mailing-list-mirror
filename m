From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: [PATCH] Improve the "diff --git" format documentation
Date: Thu, 14 Oct 2010 14:39:42 +0200
Organization: SUSE Labs, Novell Inc.
Message-ID: <201010141439.43168.agruen@suse.de>
References: <201010061823.47475.agruen@suse.de> <201010070103.17689.agruen@suse.de> <7v8w21fsgr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 14:40:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6N6b-0005V1-15
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 14:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753451Ab0JNMkL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 08:40:11 -0400
Received: from cantor.suse.de ([195.135.220.2]:48962 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751070Ab0JNMkK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 08:40:10 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id B636C8D893;
	Thu, 14 Oct 2010 14:40:09 +0200 (CEST)
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <7v8w21fsgr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159049>

On Thursday 14 October 2010 03:55:48 Junio C Hamano wrote:
> Andreas Gruenbacher <agruen@suse.de> writes:
> 
> >  The `a/` and `b/` filenames are the same unless rename/copy is
> >  involved.  Especially, even for a creation or a deletion,
> > -`/dev/null` is _not_ used in place of `a/` or `b/` filenames.
> > +`/dev/null` is _not_ used in place of the `a/` or `b/` filenames
> > +for nonexisting files (unlike in the unified diff headers).
> 
> The description in the parentheses is wrong, unless you qualify whose
> "unified diff headers" you are talking about.

I was referring to the unified diff headers that git emits, not any other
utility's output.

POSIX does not say anything about nonexisting files, and GNU diff with -rN uses an
Epoch timestamp instead of /dev/null to distinguish between missing and empty
files:

	http://www.gnu.org/software/diffutils/manual/html_node/Creating-and-Removing.html

> For example:
> 
>  http://www.opengroup.org/onlinepubs/9699919799/utilities/diff.html#tag_20_34_10_07
> 
> does not mention anything about file creation/deletion events.

Fine, let's make this clear in the "combined diff" format description too
then.

> Perhaps you are referring to cvs or svn output, but I think we can safely
> drop the parenthesized part without losing clarity.

I still believe that the documentation should make it very clear how it
handles created and deleted files; it really is not obvious to everyone.

Can you live with the attached patch?

Thanks,
Andreas

--

[PATCH] Clarify how /dev/null is used in diffs

Say where the unified diff header comes in the "git diff" format, and
make it clear that /dev/null is used there.

In the description of the "combined diff" format, do not claim that
traditional unified diffs use /dev/null to signal created or deleted files.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
---
 Documentation/diff-generate-patch.txt |   26 ++++++++++++++++++--------
 1 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 3ac2bea..21c4923 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -53,12 +53,22 @@ The index line includes the SHA-1 checksum before and after the change.
 The <mode> is included if the file mode does not change; otherwise,
 separate lines indicate the old and the new mode.
 
-3.  TAB, LF, double quote and backslash characters in pathnames
+3.  It is followed by a 'unified' diff which starts with a two-line
+    from-file/to-file header:
+
+      --- a/file1
+      +++ b/file2
++
+This header is omitted if the contents of `file1` and `file2` are identical.
+To signal created or deleted files, `/dev/null` is used instead of `a/file1`
+or `b/file2`.
+
+4.  TAB, LF, double quote and backslash characters in pathnames
     are represented as `\t`, `\n`, `\"` and `\\`, respectively.
     If there is need for such substitution then the whole
     pathname is put in double quotes.
 
-4.  All the `file1` files in the output refer to files before the
+5.  All the `file1` files in the output refer to files before the
     commit, and all the `file2` files refer to files after the commit.
     It is incorrect to apply each change to each file sequentially.  For
     example, this patch will swap a and b:
@@ -133,14 +143,14 @@ information about detected contents movement (renames and
 copying detection) are designed to work with diff of two
 <tree-ish> and are not used by combined diff format.
 
-3.   It is followed by two-line from-file/to-file header
+3.   It is followed by a two-line from-file/to-file header similar to the
+     traditional 'unified' diff format header:
 
-       --- a/file
-       +++ b/file
+       --- a/file1
+       +++ b/file2
 +
-Similar to two-line header for traditional 'unified' diff
-format, `/dev/null` is used to signal created or deleted
-files.
+To signal created or deleted files, `/dev/null` is used instead of `a/file1`
+or `b/file2`.
 
 4.   Chunk header format is modified to prevent people from
      accidentally feeding it to `patch -p1`. Combined diff format
