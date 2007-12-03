From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] quote_path: fix collapsing of relative paths
Date: Sun, 02 Dec 2007 21:56:54 -0800
Message-ID: <7vabosqq1l.fsf@gitster.siamese.dyndns.org>
References: <20071203053001.GA12696@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 03 07:04:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz4Pj-0005Sp-02
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 07:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbXLCF5F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 00:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbXLCF5E
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 00:57:04 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:33319 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbXLCF5B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 00:57:01 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 336322EF;
	Mon,  3 Dec 2007 00:57:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 874A09A4A6;
	Mon,  3 Dec 2007 00:57:18 -0500 (EST)
In-Reply-To: <20071203053001.GA12696@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 3 Dec 2007 00:30:01 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66870>

Jeff King <peff@peff.net> writes:

> The code tries to collapse identical leading components
> between the prefix and the path. So if we're in "dir1", the
> path "dir1/file" should become just "file". However, we were
> ending up with "../dir1/file". The included test expected
> the wrong output.
>
> Because the "len" parameter to quote_path can be passed in
> as -1 to indicate a NUL-terminated string, we have to
> consider that possibility in our loop conditional (but no
> additional checks are necessary, since we already check that
> prefix[off] and in[off] are identical, and that prefix[off]
> is not NUL.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This behavior in git-status had been bugging me, and when I went to fix
> it, I was surprised to find code already there to do it. :) Dscho,
> please confirm that the test is in fact in error, and that I've read the
> intent of your code correctly.
>
>  t/t7502-status.sh |    2 +-
>  wt-status.c       |    3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/t/t7502-status.sh b/t/t7502-status.sh
> index 269b334..d6ae69d 100755
> --- a/t/t7502-status.sh
> +++ b/t/t7502-status.sh
> @@ -68,7 +68,7 @@ cat > expect << \EOF
>  # Changed but not updated:
>  #   (use "git add <file>..." to update what will be committed)
>  #
> -#	modified:   ../dir1/modified
> +#	modified:   modified
>  #
>  # Untracked files:
>  #   (use "git add <file>..." to include in what will be committed)
> diff --git a/wt-status.c b/wt-status.c
> index e77120d..09666ec 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -90,7 +90,8 @@ static char *quote_path(const char *in, int len,
>  
>  	if (prefix) {
>  		int off = 0;
> -		while (prefix[off] && off < len && prefix[off] == in[off])
> +		while (prefix[off] && (len < 0 || off < len)
> +				&& prefix[off] == in[off])
>  			if (prefix[off] == '/') {
>  				prefix += off + 1;
>  				in += off + 1;

Somehow I feel it would be simpler and less error prone if you atually
count to set len to the length if you got negative.

The part that follows the patch, there is a line that subtracts a small
number (off+1) from len --- while it won't have a wraparound issue, it
feels a bit ugly to rely on the "magic -1" value to stay "magic
negative" if small positive integers are subtracted from it.

Also the reason the updated condition to the while loop does not have to
check NUL termination upon negative len is because both (prefix[off] !=
NUL) and (prefix[off] == in[off]) are checked there, which some may find
subtle.

So perhaps this is easier to read?

---
 wt-status.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 0e0439f..52ab41c 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -82,12 +82,13 @@ static void wt_status_print_trailer(struct wt_status *s)
 }
 
 static char *quote_path(const char *in, int len,
-		struct strbuf *out, const char *prefix)
+			struct strbuf *out, const char *prefix)
 {
-	if (len > 0)
-		strbuf_grow(out, len);
-	strbuf_setlen(out, 0);
+	if (len < 0)
+		len = strlen(in);
 
+	strbuf_grow(out, len);
+	strbuf_setlen(out, 0);
 	if (prefix) {
 		int off = 0;
 		while (prefix[off] && off < len && prefix[off] == in[off])
@@ -104,7 +105,7 @@ static char *quote_path(const char *in, int len,
 				strbuf_addstr(out, "../");
 	}
 
-	for (; (len < 0 && *in) || len > 0; in++, len--) {
+	for ( ; len > 0; in++, len--) {
 		int ch = *in;
 
 		switch (ch) {
