From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] log --oneline: put decoration at the end of the line
Date: Wed, 19 Sep 2012 14:20:40 -0400
Message-ID: <20120919182039.GE11699@sigill.intra.peff.net>
References: <1348055540-13774-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 19 20:20:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEOtH-0003Ex-Eq
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 20:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753372Ab2ISSUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 14:20:43 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49806 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753187Ab2ISSUm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 14:20:42 -0400
Received: (qmail 3029 invoked by uid 107); 19 Sep 2012 18:21:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Sep 2012 14:21:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Sep 2012 14:20:40 -0400
Content-Disposition: inline
In-Reply-To: <1348055540-13774-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205969>

On Wed, Sep 19, 2012 at 06:52:20PM +0700, Nguyen Thai Ngoc Duy wrote:

> I find it easier to read "git log --oneline" when the subject lines
> align, which they don't when the log is decorated because the
> decoration stands before the subject line.

I like it. I turned on log.decorate some time ago, and I always felt
that --oneline was a little bit messy. But for some reason I never
thought of this simple change.

> I'm on colored output so moving decoration to the end of line does not
> make it harder to recognize refs. What about black-and-white people?

Like you, I use colors. I think the decorations would be much harder to
see if not for the color.

We should also consider briefly whether anybody is relying on --oneline
for machine parsing. I think "log --oneline" is fair game, but I wonder
if people calling "rev-list --decorate --oneline" should be considered.
It seems kind of unlikely to me, considering that the decorate output is
ambiguous to parse anyway (if you see parentheses, you cannot tell if it
is decorate output or part of the commit subject).

I did not look too carefully at your patch, but I did notice an odd
behavior with it. Try "git log --graph --oneline" in git.git. With stock
git, I see this several lines down (apologies for the long lines):

  * | | | | | | | | | | | | | | | | | | | | | | | |   b1379ba Merge branch 'sb/send-email-reconfirm-fix'
  |\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \  
  | | |_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|/ / / /  
  | |/| | | | | | | | | | | | | | | | | | | | | | |   
  | * | | | | | | | | | | | | | | | | | | | | | | | 6183749 (origin/sb/send-email-reconfirm-fix) send-email: initial_to and initial_reply_to are both optional

In other words, 6183749 looks fine: graph, decorations, then subject,
all on the same line.  But with your patch, I see:

  * | | | | | | | | | | | | | | | | | | | | | | | |   b1379ba Merge branch 'sb/send-email-reconfirm-fix'
  |\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \  
  | | |_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|/ / / /  
  | |/| | | | | | | | | | | | | | | | | | | | | | |   
  | * | | | | | | | | | | | | | | | | | | | | | | | 6183749 send-email: initial_to and initial_reply_to are both optional
  | | |_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|_|/ / / /  
  | |/| | | | | | | | | | | | | | | | | | | | | |    (origin/sb/send-email-reconfirm-fix)

The decoration is broken onto a separate line (with a newline in
between). Oddly, if I start my log right at b1379ba, it looks OK. Which
makes me think we are hitting some kind of line-wrapping code related to
the width of the graph.

-Peff
