From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH replacement for take 3 4/4] color-words: take an optional
 regular expression describing words
Date: Thu, 15 Jan 2009 02:36:37 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901150235122.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901142142120.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901142145200.3586@pacific.mpi-cbg.de> <200901150132.14106.trast@student.ethz.ch>
 <alpine.DEB.1.00.0901150211120.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>,
	Junio C Hamano <junio@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 15 02:37:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNHAa-0004f0-My
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 02:37:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543AbZAOBfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 20:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752407AbZAOBfr
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 20:35:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:58519 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752442AbZAOBfq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 20:35:46 -0500
Received: (qmail invoked by alias); 15 Jan 2009 01:35:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp050) with SMTP; 15 Jan 2009 02:35:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19K6Zknj0tKhZFaeRhsjXvnmnIedBNLBCPnzDeObM
	k/t1mK38/ukWX2
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901150211120.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.49
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105754>

Hi,

On Thu, 15 Jan 2009, Johannes Schindelin wrote:

> On Thu, 15 Jan 2009, Thomas Rast wrote:
> 
> > Johannes Schindelin wrote:
> > > 	This basically contains the fix I sent earlier.
> > 
> > Unfortunately I found another case where it breaks.  It even comes
> > with a fairly neat test case:
> > 
> >   $ g diff --no-index test_a test_b
> >   diff --git 1/test_a 2/test_b
> >   index 289cb9d..2d06f37 100644
> >   --- 1/test_a
> >   +++ 2/test_b
> >   @@ -1 +1 @@
> >   -(:
> >   +(
> 
> The diff of the words would look like this:
> 
> diff --git a/a1 b/a2
> index 8309acb..2d06f37 100644
> --- a/a1
> +++ b/a2
> @@ -2 +1,0 @@
> -:
> 
> 
> Notice the "+1,0"?  I fully expected this to be "+2,0", but apparently I 
> was mistaken...
> 
> Can anybody explain to me why this is so?

[PATCH to be squashed into the word regex patch] Fix for strange '@@ -2 +1,0 @@' hunk header

If a hunk header '@@ -2 +1,0 @@' is found that logically should be
'@@ -2 +2,0 @@', diff_words got confused.

It would bee squashed into 4/4.

This might be a libxdiff issue, though.

Not sure yet.
---
 diff.c                |   18 ++++++++++++++++++
 t/t4034-diff-words.sh |   16 ++++++++++++++++
 2 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index c5f7c57..3709651 100644
--- a/diff.c
+++ b/diff.c
@@ -360,6 +360,24 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 	plus_end = plus_len == 0 ? plus_begin :
 		diff_words->plus.orig[plus_first + plus_len - 1].end;
 
+	/*
+	 * since this is a --unified=0 diff, it can result in a single hunk
+	 * with a header like this: @@ -2 +1,0 @@
+	 *
+	 * This breaks the assumption that minus_first == plus_first.
+	 *
+	 * So we have to fix it: whenever we reach the end of pre and post
+	 * texts, but nothing was added, we need to shift the plus part
+	 * to the end of the buffer.
+	 *
+	 * It is only necessary for the plus part, as we show the common
+	 * words from that buffer.
+	 */
+	if (plus_len == 0 && minus_first + minus_len
+			== diff_words->minus.orig_nr)
+		plus_begin = plus_end =
+			diff_words->plus.orig[diff_words->plus.orig_nr - 1].end;
+
 	if (diff_words->current_plus != plus_begin)
 		fwrite(diff_words->current_plus,
 				plus_begin - diff_words->current_plus, 1,
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 07e48d1..817fba6 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -135,6 +135,22 @@ test_expect_success 'test parsing words for newline' '
 
 	word_diff --color-words="a+"
 
+'
+
+echo '(:' > pre
+echo '(' > post
+
+cat > expect <<\EOF
+<WHITE>diff --git a/pre b/post<RESET>
+<WHITE>index 289cb9d..2d06f37 100644<RESET>
+<WHITE>--- a/pre<RESET>
+<WHITE>+++ b/post<RESET>
+<BROWN>@@ -1 +1 @@<RESET>
+(<RED>:<RESET>
+EOF
+
+test_expect_success 'test when words are only removed at the end' '
+
 	word_diff --color-words=.
 
 '
-- 
1.6.1.300.gbc493
