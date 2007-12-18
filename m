From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Fix segfault in diff-delta.c when FLEX_ARRAY is 1
Date: Mon, 17 Dec 2007 20:46:55 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712172032090.21557@woody.linux-foundation.org>
References: <1197941997-11421-1-git-send-email-madcoder@debian.org> <20071218014455.GB14981@artemis.madism.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-2022-JP
Cc: gitster@pobox.com, spearce@spearce.org, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Dec 18 05:48:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4UN6-0001u6-H0
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 05:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbXLRErh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 23:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753402AbXLRErh
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 23:47:37 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42669 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751838AbXLRErg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2007 23:47:36 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBI4kudM020538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Dec 2007 20:46:57 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBI4ktfC019458;
	Mon, 17 Dec 2007 20:46:56 -0800
In-Reply-To: <20071218014455.GB14981@artemis.madism.org>
X-Spam-Status: No, hits=-4.712 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68697>



On Tue, 18 Dec 2007, Pierre Habouzit wrote:
> 
>   I wonder if we could teach sparse to prevent us from using pointer
> arithmetics on some types… because I obviously didn't read all the git
> code, and I wouldn't be surprised an instance of this still remains
> somehwere.

This should do it.

What this does is:
 - make flex structures not have a size at all (so "sizeof()" will fail)
 - add warnings for trying to add or subtract unsized pointers

so now you can try it on git with

	make CC=cgcc

and while it finds a fair number of "sizeof(..)" things and complains 
about them, the only invalid pointer arithmetic it finds is the 

	mem = index + 1;

line in diff-delta.c.

Whether it is worth fixing all the "sizeof()" calls too, I dunno. They 
result in a slight waste of memory (ie we allocate too much memory), but 
I guess they should be harmless.

However, one indication that there may still be something wrong is that if 
you re-make git with FLEX_ARRAY set to some big insane value (say, 1234), 
then git will still fail the test-suite. So maybe there's a "sizeof()" 
that isn't just used for allocation sizes. I didn't check them all, 
there's something like 44 complaints like

	builtin-fetch.c:306:21: error: cannot size expression

from sparse with this patch.

		Linus

---
 evaluate.c |    8 ++++++++
 symbol.c   |    2 ++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/evaluate.c b/evaluate.c
index 54fcd3f..cd816a8 100644
--- a/evaluate.c
+++ b/evaluate.c
@@ -576,6 +576,10 @@ static struct symbol *evaluate_ptr_add(struct expression *expr, struct symbol *i
 		expression_error(expr, "arithmetics on pointers to functions");
 		return NULL;
 	}
+	if (base->bit_size & 7) {
+		expression_error(expr, "arithmetic on unsized pointers");
+		return NULL;
+	}
 
 	/* Get the size of whatever the pointer points to */
 	multiply = base->bit_size >> 3;
@@ -820,6 +824,10 @@ static struct symbol *evaluate_ptr_sub(struct expression *expr)
 		expression_error(expr, "subtraction of functions? Share your drugs");
 		return NULL;
 	}
+	if (lbase->bit_size & 7) {
+		expression_error(expr, "subtracting unsized pointers");
+		return NULL;
+	}
 
 	expr->ctype = ssize_t_ctype;
 	if (lbase->bit_size > bits_in_char) {
diff --git a/symbol.c b/symbol.c
index 7539817..8b390ac 100644
--- a/symbol.c
+++ b/symbol.c
@@ -124,8 +124,10 @@ static void lay_out_struct(struct symbol *sym, struct struct_union_info *info)
 	 * structure size
 	 */
 	if (base_size < 0) {
+		info->bit_size = -1;
 		info->align_size = 0;
 		base_size = 0;
+		return;
 	}
 
 	align_bit_mask = (sym->ctype.alignment << 3) - 1;
