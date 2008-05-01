From: Jeff King <peff@peff.net>
Subject: Re: detecting rename->commit->modify->commit
Date: Thu, 1 May 2008 11:20:35 -0400
Message-ID: <20080501152035.GB11145@sigill.intra.peff.net>
References: <4819CF50.2020509@tikalk.com> <20080501144524.GA10876@sigill.intra.peff.net> <4819DCF1.7090504@tikalk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ittay Dror <ittayd@tikalk.com>
X-From: git-owner@vger.kernel.org Thu May 01 17:21:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrab6-0000xK-1v
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 17:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756095AbYEAPUg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 11:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753182AbYEAPUg
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 11:20:36 -0400
Received: from peff.net ([208.65.91.99]:1113 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756095AbYEAPUf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 11:20:35 -0400
Received: (qmail 13501 invoked by uid 111); 1 May 2008 15:20:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 01 May 2008 11:20:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 May 2008 11:20:35 -0400
Content-Disposition: inline
In-Reply-To: <4819DCF1.7090504@tikalk.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80918>

On Thu, May 01, 2008 at 06:08:33PM +0300, Ittay Dror wrote:

> But it doesn't work across directories :-(.

Yes, it does.

> Try:
> >mkdir foo
> >echo "hello" > foo/A
> >git add foo/A
> >git commit -m 'foo/A'
> >mkdir bar
> >git mv foo/A bar
> >git commit -m 'bar/A'
> >echo "world" >> bar/A
> >git add bar/A
> >git commit -m 'bar/A world'
> >git diff HEAD^^..HEAD^ | cat
> diff --git a/foo/A b/bar/A
> similarity index 100%
> rename from foo/A
> rename to bar/A

See, it just worked across directories.

> > git diff HEAD^^.. | cat
> diff --git a/bar/A b/bar/A
> new file mode 100644
> index 0000000..94954ab
> --- /dev/null
> +++ b/bar/A
> @@ -0,0 +1,2 @@
> +hello
> +world
> diff --git a/foo/A b/foo/A
> deleted file mode 100644
> index ce01362..0000000
> --- a/foo/A
> +++ /dev/null
> @@ -1 +0,0 @@
> -hello

Of course it doesn't work here. You have two files, one containing
"hello\n" and one containing "hello\nworld\n". Their similarity is 50%,
which is not enough to consider it a rename. And I would argue that's
reasonable, since the files have only one line in common. The problem is
that you are using a toy example (which is why my example used
/usr/share/dict/words, which has enough content to definitively call it
a rename).

...

Hmm, looking at the code, though, 50% is supposed to be the default
minimum. So there might actually be a bug.

-Peff
