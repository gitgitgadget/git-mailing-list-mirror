From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [SUPERSEDES PATCH 2/7] nfv?asprintf are broken without va_copy, workaround them.
Date: Thu, 20 Sep 2007 23:17:12 -0700
Message-ID: <7vejgsk0ev.fsf@gitster.siamese.dyndns.org>
References: <1190241736-30449-1-git-send-email-madcoder@debian.org>
	<1190241736-30449-2-git-send-email-madcoder@debian.org>
	<1190241736-30449-3-git-send-email-madcoder@debian.org>
	<7vwsumkll8.fsf@gitster.siamese.dyndns.org>
	<20070920082701.GA2053@artemis.corp>
	<20070920084311.GB2053@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Fri Sep 21 08:17:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYbpS-00005D-GC
	for gcvg-git-2@gmane.org; Fri, 21 Sep 2007 08:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbXIUGRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 02:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750895AbXIUGRT
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 02:17:19 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:56689 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbXIUGRS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 02:17:18 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 863E41390D3;
	Fri, 21 Sep 2007 02:17:36 -0400 (EDT)
In-Reply-To: <20070920084311.GB2053@artemis.corp> (Pierre Habouzit's message
	of "Thu, 20 Sep 2007 10:43:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58827>

Pierre Habouzit <madcoder@debian.org> writes:

> This reinstates the trace_argv_printf API. The implementation is
> stupid, but is rewritten in a latter commit. I didn't wanted to bother
> optimizing it.
> ...
>  cache.h           |    2 -
>  imap-send.c       |   13 ++++++++
>  merge-recursive.c |   74 ++++++++++++++++++++-----------------------
>  trace.c           |   90 ++++++++++++++++-------------------------------------
>  4 files changed, 74 insertions(+), 105 deletions(-)
> ...
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 14b56c2..4e27549 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -85,63 +85,57 @@ struct stage_data
> +static void flush_output(void)
>  {
> +	if (obuf.len) {
> +		fputs(obuf.buf, stdout);
> +		strbuf_reset(&obuf);
>  	}
>  }

This assumes obuf.buf has necessary indentations and line
breaks, which is sensible.  However...

> +static void output(int v, const char *fmt, ...)
>  {
> +	if (show(v)) {
> +		int len;
> +		va_list ap;

Yuck, this single if statement covers the entirety of the
function.  Let's do

	if (!show(v))
	        return;

> +		strbuf_grow(&obuf, call_depth);
> +		memset(obuf.buf + obuf.len, ' ', call_depth);
> +		strbuf_setlen(&obuf, obuf.len + call_depth);

Per depth indentation used to be two whitespaces.

> +		va_start(ap, fmt);
> +		len = vsnprintf(obuf.buf, strbuf_avail(&obuf) + 1, fmt, ap);
> +		va_end(ap);

And you overwrite whatever used to be in the buffer, including
the previous buffered message and indentation you added.  Not
nice...

I'll squash this on top of yours for now.

 merge-recursive.c |   45 +++++++++++++++++++++++----------------------
 1 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 4e27549..86767e6 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -108,34 +108,35 @@ static void flush_output(void)
 
 static void output(int v, const char *fmt, ...)
 {
-	if (show(v)) {
-		int len;
-		va_list ap;
+	int len;
+	va_list ap;
 
-		strbuf_grow(&obuf, call_depth);
-		memset(obuf.buf + obuf.len, ' ', call_depth);
-		strbuf_setlen(&obuf, obuf.len + call_depth);
+	if (!show(v))
+		return;
+
+	strbuf_grow(&obuf, call_depth * 2 + 2);
+	memset(obuf.buf + obuf.len, ' ', call_depth * 2);
+	strbuf_setlen(&obuf, obuf.len + call_depth * 2);
+
+	va_start(ap, fmt);
+	len = vsnprintf(obuf.buf + obuf.len, strbuf_avail(&obuf), fmt, ap);
+	va_end(ap);
 
+	if (len < 0)
+		len = 0;
+	if (len >= strbuf_avail(&obuf)) {
+		strbuf_grow(&obuf, len + 2);
 		va_start(ap, fmt);
-		len = vsnprintf(obuf.buf, strbuf_avail(&obuf) + 1, fmt, ap);
+		len = vsnprintf(obuf.buf + obuf.len, strbuf_avail(&obuf), fmt, ap);
 		va_end(ap);
-
-		if (len < 0)
-			len = 0;
-		if (len > strbuf_avail(&obuf)) {
-			strbuf_grow(&obuf, len);
-			va_start(ap, fmt);
-			len = vsnprintf(obuf.buf, strbuf_avail(&obuf) + 1, fmt, ap);
-			va_end(ap);
-			if (len > strbuf_avail(&obuf)) {
-				die("this should not happen, your snprintf is broken");
-			}
+		if (len >= strbuf_avail(&obuf)) {
+			die("this should not happen, your snprintf is broken");
 		}
-
-		strbuf_setlen(&obuf, obuf.len + len);
-		if (!buffer_output)
-			flush_output();
 	}
+	strbuf_setlen(&obuf, obuf.len + len);
+	strbuf_add(&obuf, "\n", 1);
+	if (!buffer_output)
+		flush_output();
 }
 
 static void output_commit_title(struct commit *commit)
