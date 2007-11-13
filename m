From: Andreas Ericsson <ae@op5.se>
Subject: [PATCH] diffcore: Allow users to decide what funcname to use
Date: Tue, 13 Nov 2007 10:15:56 +0100
Message-ID: <47396B4C.6070406@op5.se>
References: <4738208D.1080003@op5.se>	<Pine.LNX.4.64.0711120958500.4362@racer.site> <47382C84.50408@op5.se>	<7vhcjr2lte.fsf@gitster.siamese.dyndns.org> <4738E9E6.2040001@op5.se> <buomytin9dz.fsf@dhapc248.dev.necel.com> <473954F8.8070908@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Tue Nov 13 10:16:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrrsY-00027z-E4
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 10:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbXKMJQC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 04:16:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbXKMJQB
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 04:16:01 -0500
Received: from mail.op5.se ([193.201.96.20]:56071 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751306AbXKMJP7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 04:15:59 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 329291F08704;
	Tue, 13 Nov 2007 10:15:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VT6lR270JaUO; Tue, 13 Nov 2007 10:15:57 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id DF1941F08703;
	Tue, 13 Nov 2007 10:15:56 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <473954F8.8070908@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64772>

Andreas Ericsson wrote:
> Miles Bader wrote:
>> Andreas Ericsson <ae@op5.se> writes:
>>> I notice it, and I don't like it. I guess I'm just used to git being
>>> smarter than their GNU tool equivalents, especially since it only ever
>>> applies patches in full.
>>
>> It's not at all obvious that this behavior is actually wrong -- it seems
>> perfectly reasonable to use either old or new text for the hunk headers.
>>
> 
> Right, which is why I've made it configurable.
> 

My git hacking has been stalled at the office for now, and I'm swanked at
home since my girlfriend just moved in and brought temporary pandemonium
with her. Here's what I've got now. It passes all tests, but there are no
new ones added. Documentation also needs updating.

Extract with
	sed -n -e /^#CUTSTART/,/^#CUTEND/p -e /^#/d

#CUTSTART---%<---%<---%<---
From: Andreas Ericsson <ae@op5.se>
Date: Tue, 13 Nov 2007 09:47:43 +0100
Subject: [PATCH] diffcore: Allow users to decide what funcname to use

The function name being printed with the header of each
hunk is fetched from the "old" file today. Since git by
default applies patches either in full or not at all it's
arguably more correct to use the function from the "new"
file, at least when manually reviewing commits.

I stumbled upon this hunk when reviewing a series of
commits which caused the resulting code to segfault
under certain circumstances. Several hunks before, the
function declaration was changed and "status" was now
declared as an auto variable of type "int". The hunk
looks obviously bogus, and since I wasn't properly
awake, I reported this hunk to be the bogus one.

  @@ -583,75 +346,100 @@ double jitter_request(int *status){
     context
     context
     if(!syncsource_found){
  -    *status = STATE_UNKNOWN;
  +    status = STATE_WARNING;
       if(verbose) printf("warning: no sync source found\n")
     }

This is what GNU "diff -p" would have reported under the
same circumstances, but GNU diff has no notion of version
control, and as such will not know if it's being used on
content where the patch by definition will apply in full.

Git can be smarter than that, and imo it should. This
patch lets the diffcore grok a new configuration variable,
"diff.funcnames", which can be set to "new", "old", or a
boolean value, which will cause it to be "old" (for 'true')
and 'none' (for 'false').

Signed-off-by: Andreas Ericsson <ae@op5.se>
---
 diff.c           |   20 ++++++++++++++++++--
 diffcore-break.c |    4 ++--
 xdiff/xdiff.h    |    3 ++-
 xdiff/xemit.c    |    7 ++++++-
 4 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 6bb902f..057bba8 100644
--- a/diff.c
+++ b/diff.c
@@ -20,6 +20,7 @@
 static int diff_detect_rename_default;
 static int diff_rename_limit_default = 100;
 static int diff_use_color_default;
+static unsigned long xdl_emit_flags = XDL_EMIT_FUNCNAMES;
 int diff_auto_refresh_index = 1;
 
 static char diff_colors[][COLOR_MAXLEN] = {
@@ -178,6 +179,20 @@ int git_diff_ui_config(const char *var, const char *value)
                color_parse(value, var, diff_colors[slot]);
                return 0;
        }
+       if (!prefixcmp(var, "diff.funcnames")) {
+               if (!value)
+                       xdl_emit_flags = XDL_EMIT_COMMON;
+               else if (!strcasecmp(value, "new"))
+                       xdl_emit_flags = XDL_EMIT_FUNCNAMES_NEW;
+               else if (!strcasecmp(value, "old") || !strcasecmp(value, "default"))
+                       xdl_emit_flags = XDL_EMIT_FUNCNAMES;
+               else {
+                       if (git_config_bool(var, value))
+                               xdl_emit_flags = XDL_EMIT_FUNCNAMES;
+                       else
+                               xdl_emit_flags = XDL_EMIT_COMMON;
+               }
+       }
 
        return git_default_config(var, value);
 }
@@ -1332,7 +1347,8 @@ static void builtin_diff(const char *name_a,
                ecbdata.found_changesp = &o->found_changes;
                xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
                xecfg.ctxlen = o->context;
-               xecfg.flags = XDL_EMIT_FUNCNAMES;
+               xecfg.flags = xdl_emit_flags;
+
                if (funcname_pattern)
                        xdiff_set_find_func(&xecfg, funcname_pattern);
                if (!diffopts)
@@ -2844,7 +2860,7 @@ static int diff_get_patch_id(struct diff_options *options, unsigned char *sha1)
 
                xpp.flags = XDF_NEED_MINIMAL;
                xecfg.ctxlen = 3;
-               xecfg.flags = XDL_EMIT_FUNCNAMES;
+               xecfg.flags = xdl_emit_flags;
                ecb.outf = xdiff_outf;
                ecb.priv = &data;
                xdl_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
diff --git a/diffcore-break.c b/diffcore-break.c
index c71a226..048ec25 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -257,8 +257,8 @@ void diffcore_merge_broken(void)
                if (!p)
                        /* we already merged this with its peer */
                        continue;
-               else if (p->broken_pair &&
-                        !strcmp(p->one->path, p->two->path)) {
+
+               if (p->broken_pair && !strcmp(p->one->path, p->two->path)) {
                        /* If the peer also survived rename/copy, then
                         * we merge them back together.
                         */
diff --git a/xdiff/xdiff.h b/xdiff/xdiff.h
index c00ddaa..326e1df 100644
--- a/xdiff/xdiff.h
+++ b/xdiff/xdiff.h
@@ -41,7 +41,8 @@ extern "C" {
 
 #define XDL_EMIT_FUNCNAMES (1 << 0)
 #define XDL_EMIT_COMMON (1 << 1)
-
+#define XDL_EMIT_FUNCNAMES_NEW (1 << 2)
+
 #define XDL_MMB_READONLY (1 << 0)
 
 #define XDL_MMF_ATOMIC (1 << 0)
diff --git a/xdiff/xemit.c b/xdiff/xemit.c
index d3d9c84..51dd085 100644
--- a/xdiff/xemit.c
+++ b/xdiff/xemit.c
@@ -149,7 +149,12 @@ int xdl_emit_diff(xdfenv_t *xe, xdchange_t *xscr, xdemitcb_t *ecb,
                 * Emit current hunk header.
                 */
 
-               if (xecfg->flags & XDL_EMIT_FUNCNAMES) {
+               if (xecfg->flags & XDL_EMIT_FUNCNAMES_NEW) {
+                       xdl_find_func(&xe->xdf2, s2, funcbuf,
+                                     sizeof(funcbuf), &funclen,
+                                     ff, xecfg->find_func_priv);
+               }
+               else if (xecfg->flags & XDL_EMIT_FUNCNAMES) {
                        xdl_find_func(&xe->xdf1, s1, funcbuf,
                                      sizeof(funcbuf), &funclen,
                                      ff, xecfg->find_func_priv);
-- 
1.5.3.5.1527.g6161
#CUTEND---%<---%<---%<---

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
