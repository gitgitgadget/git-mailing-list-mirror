From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5] format-patch --signature-file <file>
Date: Tue, 20 May 2014 04:27:40 -0400
Message-ID: <20140520082740.GB27590@sigill.intra.peff.net>
References: <1400572806-21092-1-git-send-email-jmmahler@gmail.com>
 <1400572806-21092-2-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 10:42:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmfOm-00045z-K0
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 10:27:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbaETI1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 04:27:43 -0400
Received: from cloud.peff.net ([50.56.180.127]:55597 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751598AbaETI1m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 04:27:42 -0400
Received: (qmail 14417 invoked by uid 102); 20 May 2014 08:27:42 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 20 May 2014 03:27:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 May 2014 04:27:40 -0400
Content-Disposition: inline
In-Reply-To: <1400572806-21092-2-git-send-email-jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249655>

On Tue, May 20, 2014 at 01:00:06AM -0700, Jeremiah Mahler wrote:

> Added option that allows a signature file to be used with format-patch
> so that signatures with newlines and other special characters can be
> easily included.
> 
>   $ git format-patch --signature-file ~/.signature -1
> 
> The config variable format.signaturefile is also provided so that it
> can be added by default.
> 
>   $ git config format.signaturefile ~/.signature
> 
>   $ git format-patch -1
> 
> Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>

Thanks for keeping at it. This looks good, but I have one question:

> +test_expect_success 'format-patch --signature-file=file' '
> +	git format-patch --stdout --signature-file=expect -1 >output &&
> +	check_patch output &&
> +	sed -n -e "/^-- $/,\$p" <output | sed -e "1 d" | sed -e "\$d" | sed -e "\$d" >output2 &&
> +	test_cmp expect output2
> +'

Here we drop two final lines from the email output. But if I just use
vanilla git and try this, I get nothing:

  $ git format-patch -1 --stdout |
    sed -n -e "/^-- $/,\$p" | sed -e "1 d" | sed -e "\$d" | sed -e "\$d"

Removing the second dropped line works:

  $ git format-patch -1 --stdout |
    sed -n -e "/^-- $/,\$p" | sed -e "1 d" | sed -e "\$d"
  2.0.0.rc1.436.g03cb729

I guess the signature code is adding its own newline, so that the
default signature (or "--signature=foo") works. But it adds it
unconditionally, which is probably not what we want for signatures read
from a file.

Do we maybe want something like this right before your patch?

-- >8 --
Subject: format-patch: make newline after signature conditional

When we print an email signature, we print the divider "--
\n", then the signature string, then two newlines.
Traditionally the signature is a one-liner (and the default
is just the git version), so the extra newline makes sense.

But one could easily specify a longer, multi-line signature,
like:

  git format-patch --signature='
  this is my long signature

  it has multiple lines
  ' ...

We should notice that it already has its own trailing
newline, and suppress one of ours.

Signed-off-by: Jeff King <peff@peff.net>
---
In the example above, there's also a newline before the signature
starts. Should we suppress the first one, too?

Also, I'm not clear on the purpose of the extra trailing line in the
first place. Emails now end with (">" added to show blanks):

  > -- 
  > 2.0.0-rc3...
  >

Is there are a reason for that final blank line?

 builtin/log.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 39e8836..5acc048 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -844,8 +844,13 @@ static void gen_message_id(struct rev_info *info, char *base)
 
 static void print_signature(void)
 {
-	if (signature && *signature)
-		printf("-- \n%s\n\n", signature);
+	if (!signature || !*signature)
+		return;
+
+	printf("-- \n%s", signature);
+	if (signature[strlen(signature)-1] != '\n')
+		putchar('\n');
+	putchar('\n');
 }
 
 static void add_branch_description(struct strbuf *buf, const char *branch_name)
-- 
2.0.0.rc1.436.g03cb729
