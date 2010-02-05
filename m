From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Showing whitespace on minus lines of diff ouput
Date: Thu, 4 Feb 2010 21:54:38 -0500
Message-ID: <76718491002041854t445f0a33rf4ffe5158b9f7214@mail.gmail.com>
References: <76718491002041747t327bf2f5l85e095244f6ee1ed@mail.gmail.com>
	 <76718491002041808r6fcbf88egd1e9ce4927eb36c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 05 11:03:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdL2R-0003Bj-6m
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 11:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933263Ab0BECyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 21:54:39 -0500
Received: from mail-iw0-f189.google.com ([209.85.223.189]:61978 "EHLO
	mail-iw0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933695Ab0BECyj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 21:54:39 -0500
Received: by iwn27 with SMTP id 27so481492iwn.5
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 18:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type;
        bh=SjdEnSWiy8Dfnf74dPtZCeuDDLi6DCxr9bHjEyuEXgE=;
        b=gcF94mTEjLaj6NG7Zg+YLi6h0Sko5e5ZkT5TCB9wkhHuKsvuBi+FVk2JPuw+UvpFjk
         DYUMDKk6suAZ2zC92fYT+41o06c8InbfaBImzjD/Fh59MOhM5ZKIdjaXZtRcSt8a3+pV
         5KbJlU/hDJApr2uWWX35V/G2T3OLu2YB6NTfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=L0CjaWisqbj3CfX3hNdqwsjFnK3lzxhUJ435U348wnrTrViZz+Jk/dA5gh9EjxyFrt
         P3uMLcONqXJ0ceJbjtwDcg89gLP+VN//Kgn/4CbaE1+IESaT2mVpso10V71R8TnODLS6
         +hzK3znP//jmcsdLMrrYIqso+Sck9noMh+dT4=
Received: by 10.231.145.206 with SMTP id e14mr1274537ibv.10.1265338478300; 
	Thu, 04 Feb 2010 18:54:38 -0800 (PST)
In-Reply-To: <76718491002041808r6fcbf88egd1e9ce4927eb36c0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139022>

On Thu, Feb 4, 2010 at 9:08 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> Ah, got it. I think. Patch shortly. :-)

Bah, still need help. Here's what I tried (apologizes for the gmail
munging of long lines):

diff --git a/diff.c b/diff.c
index 381cc8d..17133cd 100644
--- a/diff.c
+++ b/diff.c
@@ -331,6 +331,23 @@ static int new_blank_line_at_eof(struct
emit_callback *ecbdata, const char *line
 	return ws_blank_line(line, len, ecbdata->ws_rule);
 }

+static void emit_sub_line(const char *reset,
+			  struct emit_callback *ecbdata,
+			  const char *line, int len)
+{
+	const char *ws = diff_get_color(ecbdata->color_diff, DIFF_WHITESPACE);
+	const char *set = diff_get_color(ecbdata->color_diff, DIFF_FILE_OLD);
+
+	if (!*ws)
+		emit_line_0(ecbdata->file, set, reset, '-', line, len);
+	else {
+		/* Emit just the prefix, then the rest. */
+		emit_line_0(ecbdata->file, set, reset, '-', "", 0);
+		ws_check_emit(line, len, ecbdata->ws_rule,
+			      ecbdata->file, set, reset, ws);
+	}
+}
+
 static void emit_add_line(const char *reset,
 			  struct emit_callback *ecbdata,
 			  const char *line, int len)
@@ -434,7 +451,6 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 {
 	const char *endp = NULL;
 	static const char *nneof = " No newline at end of file\n";
-	const char *old = diff_get_color(ecb->color_diff, DIFF_FILE_OLD);
 	const char *reset = diff_get_color(ecb->color_diff, DIFF_RESET);

 	while (0 < size) {
@@ -444,8 +460,7 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		len = endp ? (endp - data + 1) : size;
 		if (prefix != '+') {
 			ecb->lno_in_preimage++;
-			emit_line_0(ecb->file, old, reset, '-',
-				    data, len);
+			emit_sub_line(reset, ecb, data, len);
 		} else {
 			ecb->lno_in_postimage++;
 			emit_add_line(reset, ecb, data, len);
@@ -862,9 +877,12 @@ static void fn_out_consume(void *priv, char
*line, unsigned long len)
 			diff_get_color(ecbdata->color_diff,
 				       line[0] == '-' ? DIFF_FILE_OLD : DIFF_PLAIN);
 		ecbdata->lno_in_preimage++;
-		if (line[0] == ' ')
+		if (line[0] == ' ') {
 			ecbdata->lno_in_postimage++;
-		emit_line(ecbdata->file, color, reset, line, len);
+			emit_line(ecbdata->file, color, reset, line, len);
+		} else {
+			emit_sub_line(reset, ecbdata, line + 1, len - 1);
+		}
 	} else {
 		ecbdata->lno_in_postimage++;
 		emit_add_line(reset, ecbdata, line + 1, len - 1);


But for reasons I don't understand this screws up some of the diff
test cases. It's emitting "index" lines where it shouldn't, and "- No
newline at end of file" instead of "\ No newline at end of file".

I guess something is post-processing the output of the emit functions
and doesn't like the change?

Help appreciated. :-)

j.
