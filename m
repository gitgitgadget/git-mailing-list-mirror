From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH replacement for take 3 4/4] color-words: take an optional
 regular expression describing words
Date: Thu, 15 Jan 2009 13:54:42 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901151342300.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901141840100.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901150235122.3586@pacific.mpi-cbg.de> <200901150930.38100.trast@student.ethz.ch> <200901151140.20215.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>,
	Junio C Hamano <junio@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jan 15 13:55:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNRkt-0003cC-TS
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 13:55:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbZAOMxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 07:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbZAOMxv
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 07:53:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:51290 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751186AbZAOMxu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 07:53:50 -0500
Received: (qmail invoked by alias); 15 Jan 2009 12:53:48 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp045) with SMTP; 15 Jan 2009 13:53:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+rtx4ba/irk42JN8NHknS6B7IfRvUza2qGYITbSf
	S02iEzTvX3Q/WA
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200901151140.20215.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.47
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105787>

Hi,

On Thu, 15 Jan 2009, Thomas Rast wrote:

> Thomas Rast wrote:
> > Johannes Schindelin wrote:
> > > If a hunk header '@@ -2 +1,0 @@' is found that logically should be
> > > '@@ -2 +2,0 @@', diff_words got confused.
> > [...]
> > > This might be a libxdiff issue, though.
> > 
> > Looks like it's just bug-for-bug compatible with diff.  At least my
> > GNU diffutils 2.8.7 show the same behaviour.
> 
> I think the culprit is in
> 
>   commit ca557afff9f7dad7a8739cd193ac0730d872e282
>   Author: Davide Libenzi <davidel@xmailserver.org>
>   Date:   Mon Apr 3 18:47:55 2006 -0700
> 
>       Clean-up trivially redundant diff.
> 
>       Also corrects the line numbers in unified output when using
>       zero lines context.
> [...]
> diff --git a/xdiff/xutils.c b/xdiff/xutils.c
> [...]
>   @@ -244,7 +257,7 @@ int xdl_emit_hunk_hdr(long s1, long c1, long s2, long c2,
>           memcpy(buf, "@@ -", 4);
>           nb += 4;
> 
>   -       nb += xdl_num_out(buf + nb, c1 ? s1: 0);
>   +       nb += xdl_num_out(buf + nb, c1 ? s1: s1 - 1);

Junio mentioned some POSIX document in which this behavior is actually 
required.  So I'll fix my code thusly:

-- snipsnap --
diff --git a/diff.c b/diff.c
index 3709651..219a242 100644
--- a/diff.c
+++ b/diff.c
@@ -353,30 +353,20 @@ static void fn_out_diff_words_aux(void *priv, char *line, unsigned long len)
 			&minus_first, &minus_len, &plus_first, &plus_len))
 		return;
 
-	minus_begin = diff_words->minus.orig[minus_first].begin;
-	minus_end = minus_len == 0 ? minus_begin :
-		diff_words->minus.orig[minus_first + minus_len - 1].end;
-	plus_begin = diff_words->plus.orig[plus_first].begin;
-	plus_end = plus_len == 0 ? plus_begin :
-		diff_words->plus.orig[plus_first + plus_len - 1].end;
+	/* POSIX requires that first be decremented by one if len == 0... */
+	if (minus_len) {
+		minus_begin = diff_words->minus.orig[minus_first].begin;
+		minus_end =
+			diff_words->minus.orig[minus_first + minus_len - 1].end;
+	} else
+		minus_begin = minus_end =
+			diff_words->minus.orig[minus_first].end;
 
-	/*
-	 * since this is a --unified=0 diff, it can result in a single hunk
-	 * with a header like this: @@ -2 +1,0 @@
-	 *
-	 * This breaks the assumption that minus_first == plus_first.
-	 *
-	 * So we have to fix it: whenever we reach the end of pre and post
-	 * texts, but nothing was added, we need to shift the plus part
-	 * to the end of the buffer.
-	 *
-	 * It is only necessary for the plus part, as we show the common
-	 * words from that buffer.
-	 */
-	if (plus_len == 0 && minus_first + minus_len
-			== diff_words->minus.orig_nr)
-		plus_begin = plus_end =
-			diff_words->plus.orig[diff_words->plus.orig_nr - 1].end;
+	if (plus_len) {
+		plus_begin = diff_words->plus.orig[plus_first].begin;
+		plus_end = diff_words->plus.orig[plus_first + plus_len - 1].end;
+	} else
+		plus_begin = plus_end = diff_words->plus.orig[plus_first].end;
 
 	if (diff_words->current_plus != plus_begin)
 		fwrite(diff_words->current_plus,
-- 
1.6.1.300.gbc493
