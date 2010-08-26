From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] Fix compat/regex ANSIfication on MinGW
Date: Thu, 26 Aug 2010 09:58:26 +0200
Message-ID: <4C761EA2.2060904@viscovery.net>
References: <201008191805.o7JI5Aw0002340@localhost.localdomain> <1282242601-2630-1-git-send-email-avarab@gmail.com> <7vtymq74mp.fsf@alter.siamese.dyndns.org> <AANLkTikod-o3GHqyFSu7yKJZMc1pgZUQm+pEb-ErAYDB@mail.gmail.com> <7vlj8271mm.fsf@alter.siamese.dyndns.org> <7v39uadxx3.fsf_-_@alter.siamese.dyndns.org> <loom.20100825T200539-742@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: Karsten Blees <blees@dcon.de>
X-From: git-owner@vger.kernel.org Thu Aug 26 09:58:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoXM5-0000bT-6e
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 09:58:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692Ab0HZH6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 03:58:33 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:21181 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab0HZH6c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 03:58:32 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OoXLv-0006Vg-0C; Thu, 26 Aug 2010 09:58:27 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 9BB3F1660F;
	Thu, 26 Aug 2010 09:58:26 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.11) Gecko/20100711 Thunderbird/3.0.6
In-Reply-To: <loom.20100825T200539-742@post.gmane.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154530>

From: Johannes Sixt <j6t@kdbg.org>

compat/regexec.c had a weird combination of function declaration in ANSI
style and function definition in K&R style, for example:

 static unsigned
 re_copy_regs (struct re_registers *regs, regmatch_t *pmatch,
      int nregs, int regs_allocated) internal_function;

 static unsigned
 re_copy_regs (regs, pmatch, nregs, regs_allocated)
     struct re_registers *regs;
     regmatch_t *pmatch;
     int nregs, regs_allocated;
 { ... }

with this #define:

 #ifndef _LIBC
 # ifdef __i386__
 #  define internal_function   __attribute ((regparm (3), stdcall))
 # else
 #  define internal_function
 # endif
 #endif

The original version as shown above was fine, but with the ANSIfied
function definition and in the case where internal_function is not empty,
gcc identifies the declaration and definition as different and bails out.

Adding internal_function to the definition doesn't help (it results in
a syntax error); hence, remove it from the subset of declarations that gcc
flags as erroneous.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 8/25/2010 20:24, schrieb Karsten Blees:
> this doesn't compile if internal_function is #defined non-empty (e.g. on
> mingw/msysgit). The old-style definitions work.
> 
> In file included from compat/regex/regex.c:78:
> compat/regex/regexec.c:357: error: conflicting types for 're_search_2_stub'
> compat/regex/regexec.c:44: note: previous declaration of 're_search_2_stub' was
> here

Here's a fix.

 compat/regex/regexec.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/compat/regex/regexec.c b/compat/regex/regexec.c
index b49585a..0194965 100644
--- a/compat/regex/regexec.c
+++ b/compat/regex/regexec.c
@@ -40,20 +40,19 @@ static reg_errcode_t re_search_internal (const regex_t *preg,
 					 const char *string, int length,
 					 int start, int range, int stop,
 					 size_t nmatch, regmatch_t pmatch[],
-					 int eflags) internal_function;
+					 int eflags);
 static int re_search_2_stub (struct re_pattern_buffer *bufp,
 			     const char *string1, int length1,
 			     const char *string2, int length2,
 			     int start, int range, struct re_registers *regs,
-			     int stop, int ret_len) internal_function;
+			     int stop, int ret_len);
 static int re_search_stub (struct re_pattern_buffer *bufp,
 			   const char *string, int length, int start,
 			   int range, int stop, struct re_registers *regs,
-			   int ret_len) internal_function;
+			   int ret_len);
 static unsigned re_copy_regs (struct re_registers *regs, regmatch_t *pmatch,
-			      int nregs, int regs_allocated) internal_function;
-static reg_errcode_t prune_impossible_nodes (re_match_context_t *mctx)
-     internal_function;
+			      int nregs, int regs_allocated);
+static reg_errcode_t prune_impossible_nodes (re_match_context_t *mctx);
 static int check_matching (re_match_context_t *mctx, int fl_longest_match,
 			   int *p_match_first) internal_function;
 static int check_halt_state_context (const re_match_context_t *mctx,
-- 
1.7.2.2.1305.g4e2a
