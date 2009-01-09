From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] allow 8bit data in email body sent by send-email
Date: Fri, 9 Jan 2009 02:28:14 -0500
Message-ID: <20090109072814.GA21180@coredump.intra.peff.net>
References: <1231422657-15305-1-git-send-email-andre.przywara@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Andre Przywara <andre.przywara@amd.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 08:29:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLBoL-0000oW-0V
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 08:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768AbZAIH2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 02:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752760AbZAIH2Q
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 02:28:16 -0500
Received: from peff.net ([208.65.91.99]:49683 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752288AbZAIH2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 02:28:16 -0500
Received: (qmail 17043 invoked by uid 107); 9 Jan 2009 07:28:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 09 Jan 2009 02:28:49 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Jan 2009 02:28:14 -0500
Content-Disposition: inline
In-Reply-To: <1231422657-15305-1-git-send-email-andre.przywara@amd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104986>

On Thu, Jan 08, 2009 at 02:50:57PM +0100, Andre Przywara wrote:

> when sending patch files via git send-email, the perl script assumes
> 7bit characters only. If there are other bytes in the body (foreign language
> characters in names or translations), some servers (like vger.kernel.org)
> reject the mail because of th?t. This patch always adds an 8bit header line
> to each mail.

This should be done already by git-format-patch when you generate the
patch to feed to send-email. What exactly is the workflow you use to
generate this problem? Does it matter where the non-ascii characters are
(commit versus patch, etc)? What version of git are you using?

> diff --git a/git-send-email.perl b/git-send-email.perl
> index 77ca8fe..68a462c 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -793,6 +793,7 @@ To: $to${ccline}
>  Subject: $subject
>  Date: $date
>  Message-Id: $message_id
> +Content-Transfer-Encoding: 8bit
>  X-Mailer: git-send-email $gitversion
>  ";

This fix isn't right anyway. For one thing, if you're going to include
C-T-E, you should also include a MIME-Version header. But more
importantly, we are already handling encoding elsewhere. So
unconditionally adding this means that you may conflict with existing
MIME headers in the @xh variable.

-Peff
