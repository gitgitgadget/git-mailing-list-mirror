From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] graph: output padding for merge subsequent parents
Date: Fri, 08 Feb 2013 18:52:34 +0100
Message-ID: <vpqtxpmae1p.fsf@grenoble-inp.fr>
References: <201302051700.r15H0GXx031004@freeze.ariadne.com>
	<7vtxpqslpm.fsf@alter.siamese.dyndns.org>
	<vpqmwvia2n7.fsf@grenoble-inp.fr>
	<201302061503.r16F30UA016375@freeze.ariadne.com>
	<20130206151447.GZ1342@serenity.lan> <vpqbobxwavv.fsf@grenoble-inp.fr>
	<20130206195702.GA1342@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Dale R. Worley" <worley@alum.mit.edu>, gitster@pobox.com,
	git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Feb 08 18:53:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3s8P-00048g-CS
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 18:53:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946845Ab3BHRwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 12:52:50 -0500
Received: from mx1.imag.fr ([129.88.30.5]:43692 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946833Ab3BHRwu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 12:52:50 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r18HqXUR013252
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 8 Feb 2013 18:52:33 +0100
Received: from anie.imag.fr ([129.88.7.32] helo=anie)
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1U3s7n-0003H7-7K; Fri, 08 Feb 2013 18:52:35 +0100
In-Reply-To: <20130206195702.GA1342@serenity.lan> (John Keeping's message of
	"Wed, 6 Feb 2013 19:57:02 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 08 Feb 2013 18:52:34 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r18HqXUR013252
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1360950756.00494@3d4gwstp9h6LVwROuvh4AQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215791>

John Keeping <john@keeping.me.uk> writes:

> diff --git a/graph.c b/graph.c
> index 391a712..2a3fc5c 100644
> --- a/graph.c
> +++ b/graph.c
> @@ -1227,6 +1227,16 @@ void graph_show_commit(struct git_graph *graph)
>  	if (!graph)
>  		return;
>  
> +	/*
> +	 * When showing a diff of a merge against each of its parents, we
> +	 * are called once for each parent without graph_update having been
> +	 * called.  In this case, simply output a single padding line.
> +	 */
> +	if (graph_is_commit_finished(graph)) {
> +		graph_show_padding(graph);
> +		shown_commit_line = 1;
> +	}
> +
>  	while (!shown_commit_line && !graph_is_commit_finished(graph)) {

This works, but if we know we're not going to enter the while loop, it
seams even easier to do this:

--- a/graph.c
+++ b/graph.c
@@ -1227,7 +1227,17 @@ void graph_show_commit(struct git_graph *graph)
        if (!graph)
                return;
 
-       while (!shown_commit_line && !graph_is_commit_finished(graph)) {
+       /*
+        * When showing a diff of a merge against each of its parents, we
+        * are called once for each parent without graph_update having been
+        * called.  In this case, simply output a single padding line.
+        */
+       if (graph_is_commit_finished(graph)) {
+               graph_show_padding(graph);
+               return;
+       }
+
+       while (!shown_commit_line) {
                shown_commit_line = graph_next_line(graph, &msgbuf);
                fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
                if (!shown_commit_line)


-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
