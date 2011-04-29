From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] blame: Improve parsing for emails with spaces
Date: Fri, 29 Apr 2011 09:11:03 -0400
Message-ID: <20110429131103.GB4540@sigill.intra.peff.net>
References: <1303423656-32002-1-git-send-email-jistone@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Josh Stone <jistone@redhat.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 15:11:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFnTU-0000J9-Fr
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 15:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970Ab1D2NLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 09:11:07 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48069
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751510Ab1D2NLG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 09:11:06 -0400
Received: (qmail 12718 invoked by uid 107); 29 Apr 2011 13:12:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Apr 2011 09:12:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Apr 2011 09:11:03 -0400
Content-Disposition: inline
In-Reply-To: <1303423656-32002-1-git-send-email-jistone@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172453>

On Thu, Apr 21, 2011 at 03:07:36PM -0700, Josh Stone wrote:

> One of my git repositories has some old commits where the authors
> obfuscated their email address as <author at example dot com>.  To
> handle this, blame needs to look for the leading '<' when scanning
> to split the "name <email>", rather then only a space delimiter.

Hmm. That address seems bogus, and I wonder if we should be rejecting it
at commit time. Still, it is something we may run across in existing
repositories, so handling it more gracefully makes sense.

> diff --git a/builtin/blame.c b/builtin/blame.c
> index f6b03f7..41525f1 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -1377,7 +1377,7 @@ static void get_ac_line(const char *inbuf, const char *what,
>  	timepos = tmp;
>  
>  	*tmp = 0;
> -	while (person < tmp && *tmp != ' ')
> +	while (person < tmp && !(*tmp == ' ' && tmp[1] == '<'))
>  		tmp--;
>  	if (tmp <= person)
>  		return;

The fix looks fine. It's a little gross that we are parsing the commit
headers ourselves here, as opposed to using some library function
provided for commits. I think we could eliminate some code by using
the parser in pretty.c, but it might need some refactoring to do so
efficiently.

Looking over the other places we parse author info, I don't think the
same problem exists elsewhere. Most other places parse from left to
right, and just go to the closing ">".

-Peff
