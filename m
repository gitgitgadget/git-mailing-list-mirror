From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] Allow emails with boundaries to work again [v2]
Date: Sun, 17 Aug 2008 22:42:02 -0700
Message-ID: <87332D4C-A77E-4D36-91B5-045D94C6B668@sb.org>
References: <1218728142-23780-1-git-send-email-dzickus@redhat.com>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Don Zickus <dzickus@redhat.com>
X-From: git-owner@vger.kernel.org Mon Aug 18 07:43:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUxWM-0005cQ-BB
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 07:43:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbYHRFmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 01:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbYHRFmJ
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 01:42:09 -0400
Received: from mailbigip.dreamhost.com ([208.97.132.5]:47456 "EHLO
	randymail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751151AbYHRFmI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Aug 2008 01:42:08 -0400
Received: from [192.168.2.8] (c-98-207-244-219.hsd1.ca.comcast.net [98.207.244.219])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by randymail-a2.g.dreamhost.com (Postfix) with ESMTP id 02601EF003;
	Sun, 17 Aug 2008 22:42:18 -0700 (PDT)
In-Reply-To: <1218728142-23780-1-git-send-email-dzickus@redhat.com>
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92681>

Is there a reason this isn't in next yet? It definitely solves a crash  
I ran into when trying to pipe a mail containing an attached patch to  
git-am.

-Kevin Ballard

On Aug 14, 2008, at 8:35 AM, Don Zickus wrote:

> Recent changes to is_multipart_boundary() caused git-mailinfo to  
> segfault.
> The reason was after handling the end of the boundary the code tried  
> to look
> for another boundary.  Because the boundary list was empty,  
> dereferencing
> the pointer to the top of the boundary caused the program to go boom.
>
> The fix is to check to see if the list is empty and if so go on its  
> merry
> way instead of looking for another boundary.
>
> I also fixed a couple of increments and decrements that didn't look  
> correct
> relating to content_top.
>
> The boundary test case was updated to catch future problems like  
> this again.
>
> Signed-Off-by: Don Zickus <dzickus@redhat.com>
>
> ---
> Junio,
>
> I modified the patch more to your liking, I think.  You inquired about
> returning after failing from find_boundary() and I gave you a not so  
> correct
> answer.  Once I re-read the code this morning (minus a screaming kid  
> in the
> background), I realized it was easy to do and more correct.
>
> I also figured out why the boundary test case didn't catch this.   
> Apparently
> find_boundary() went to read another line and found none, so it  
> returned 0.
> Adding an empty line to sample.mbox, caused git-mailinfo to segfault  
> like
> the way I saw it.  My fix allows everything to work again.
>
> Cheers,
> Don
> ---
> builtin-mailinfo.c  |    6 +++---
> t/t5100/sample.mbox |    1 +
> 2 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
> index 6ae2bf3..207d0ef 100644
> --- a/builtin-mailinfo.c
> +++ b/builtin-mailinfo.c
> @@ -175,7 +175,7 @@ static void handle_content_type(struct strbuf  
> *line)
> 		 message_type = TYPE_OTHER;
> 	if (slurp_attr(line->buf, "boundary=", boundary)) {
> 		strbuf_insert(boundary, 0, "--", 2);
> -		if (content_top++ >= &content[MAX_BOUNDARIES]) {
> +		if (++content_top > &content[MAX_BOUNDARIES]) {
> 			fprintf(stderr, "Too many boundaries to handle\n");
> 			exit(1);
> 		}
> @@ -603,7 +603,7 @@ static void handle_filter(struct strbuf *line);
> static int find_boundary(void)
> {
> 	while (!strbuf_getline(&line, fin, '\n')) {
> -		if (is_multipart_boundary(&line))
> +		if (*content_top && is_multipart_boundary(&line))
> 			return 1;
> 	}
> 	return 0;
> @@ -626,7 +626,7 @@ again:
> 		/* technically won't happen as is_multipart_boundary()
> 		   will fail first.  But just in case..
> 		 */
> -		if (content_top-- < content) {
> +		if (--content_top < content) {
> 			fprintf(stderr, "Detected mismatched boundaries, "
> 					"can't recover\n");
> 			exit(1);
> diff --git a/t/t5100/sample.mbox b/t/t5100/sample.mbox
> index d7ca79b..4bf7947 100644
> --- a/t/t5100/sample.mbox
> +++ b/t/t5100/sample.mbox
> @@ -500,3 +500,4 @@ index 3e5fe51..aabfe5c 100644
> 1.6.0.rc2
>
> --=-=-=--
> +
> -- 
> 1.5.5.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Kevin Ballard
http://kevin.sb.org
kevin@sb.org
http://www.tildesoft.com
