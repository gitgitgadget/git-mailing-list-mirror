From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v5] format-patch --signature-file <file>
Date: Tue, 20 May 2014 17:42:44 -0700
Message-ID: <20140521004244.GA4927@hudson.localdomain>
References: <1400572806-21092-1-git-send-email-jmmahler@gmail.com>
 <1400572806-21092-2-git-send-email-jmmahler@gmail.com>
 <20140520082740.GB27590@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 21 02:42:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmucS-0007wt-G1
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 02:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbaEUAmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 20:42:50 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:58042 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbaEUAmt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 20:42:49 -0400
Received: by mail-pa0-f44.google.com with SMTP id ld10so836938pab.3
        for <git@vger.kernel.org>; Tue, 20 May 2014 17:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=fHnY7Qxi744qvn1R7BUtVPXztHB7GF6FqcsIvcuqqSc=;
        b=V7+KePgHDD56DgkaaXvN3BR4KI4NQbzC9lLWlu+ViGCQZlsxQq7hgvB93LmT8eih+B
         UFtu+Nd4nKr8YAbAaBtFTZNvBXstRCMegyf2nZ2uZ6B4eTzHgTWZixmz4nrEFwYlcv2x
         FrjDFvndjMBTYAwkHXTQ3E2uYMfF/YQSSQPhAqetDv2ioFOIhnUBFds4gL6/OGtuDDgC
         4xHkd1iU8MkNjjzFum1kRdjVoFvmm+CXZCDxqfd94afjFsnM6AYxuRT05gokRFfEeiij
         J9fICL3LCO82JPOhaSd/rpY4yKgBxdVysXZyZbyoa+eRVACsrcLV6BZBjHJkV4fFnWz6
         Ov9w==
X-Received: by 10.66.163.2 with SMTP id ye2mr10970918pab.110.1400632969181;
        Tue, 20 May 2014 17:42:49 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id xz7sm96887646pac.3.2014.05.20.17.42.45
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 20 May 2014 17:42:47 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Tue, 20 May 2014 17:42:44 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20140520082740.GB27590@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249765>

On Tue, May 20, 2014 at 04:27:40AM -0400, Jeff King wrote:
> On Tue, May 20, 2014 at 01:00:06AM -0700, Jeremiah Mahler wrote:
> 
...
> > +test_expect_success 'format-patch --signature-file=file' '
> > +	git format-patch --stdout --signature-file=expect -1 >output &&
> > +	check_patch output &&
> > +	sed -n -e "/^-- $/,\$p" <output | sed -e "1 d" | sed -e "\$d" | sed -e "\$d" >output2 &&
> > +	test_cmp expect output2
> > +'
> 
> Here we drop two final lines from the email output. But if I just use
> vanilla git and try this, I get nothing:
> 
>   $ git format-patch -1 --stdout |
>     sed -n -e "/^-- $/,\$p" | sed -e "1 d" | sed -e "\$d" | sed -e "\$d"
> 
> Removing the second dropped line works:
> 
>   $ git format-patch -1 --stdout |
>     sed -n -e "/^-- $/,\$p" | sed -e "1 d" | sed -e "\$d"
>   2.0.0.rc1.436.g03cb729
> 
> I guess the signature code is adding its own newline, so that the
> default signature (or "--signature=foo") works. But it adds it
> unconditionally, which is probably not what we want for signatures read
> from a file.
> 
> Do we maybe want something like this right before your patch?
> 
> -- >8 --
> Subject: format-patch: make newline after signature conditional
> 
> When we print an email signature, we print the divider "--
> \n", then the signature string, then two newlines.
> Traditionally the signature is a one-liner (and the default
> is just the git version), so the extra newline makes sense.
> 
> But one could easily specify a longer, multi-line signature,
> like:
> 
>   git format-patch --signature='
>   this is my long signature
> 
>   it has multiple lines
>   ' ...
> 
> We should notice that it already has its own trailing
> newline, and suppress one of ours.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> In the example above, there's also a newline before the signature
> starts. Should we suppress the first one, too?
> 
> Also, I'm not clear on the purpose of the extra trailing line in the
> first place. Emails now end with (">" added to show blanks):
> 
>   > -- 
>   > 2.0.0-rc3...
>   >
> 
> Is there are a reason for that final blank line?
> 
>  builtin/log.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/log.c b/builtin/log.c
> index 39e8836..5acc048 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -844,8 +844,13 @@ static void gen_message_id(struct rev_info *info, char *base)
>  
>  static void print_signature(void)
>  {
> -	if (signature && *signature)
> -		printf("-- \n%s\n\n", signature);
> +	if (!signature || !*signature)
> +		return;
> +
> +	printf("-- \n%s", signature);
> +	if (signature[strlen(signature)-1] != '\n')
> +		putchar('\n');
> +	putchar('\n');
>  }
>  
>  static void add_branch_description(struct strbuf *buf, const char *branch_name)
> -- 
> 2.0.0.rc1.436.g03cb729
> 

The simple solution, leaving things as they are, appeals to me.
For the purposes of testing just expect whatever odd number of blank
lines are produced.  Or perhaps slurp all the trailing blank lines and
then compare.

It would be nice if every signature was followed by exactly one blank line.
But if it had two it wouldn't bother me much.

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
