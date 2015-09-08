From: Jeff King <peff@peff.net>
Subject: Re: Improving auto conflict resolving while merge
Date: Tue, 8 Sep 2015 03:06:46 -0400
Message-ID: <20150908070645.GH26331@sigill.intra.peff.net>
References: <856611441646146@web13j.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: KES <kes-kes@yandex.ua>
X-From: git-owner@vger.kernel.org Tue Sep 08 09:06:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZCzV-0001oK-QY
	for gcvg-git-2@plane.gmane.org; Tue, 08 Sep 2015 09:06:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005AbbIHHGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2015 03:06:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:56145 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751464AbbIHHGs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2015 03:06:48 -0400
Received: (qmail 22392 invoked by uid 102); 8 Sep 2015 07:06:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 02:06:48 -0500
Received: (qmail 19523 invoked by uid 107); 8 Sep 2015 07:06:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Sep 2015 03:06:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Sep 2015 03:06:46 -0400
Content-Disposition: inline
In-Reply-To: <856611441646146@web13j.yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277493>

On Mon, Sep 07, 2015 at 08:15:46PM +0300, KES wrote:

> 1. git clone https://github.com/KES777/Plack
> [...]
> At this point I have same changes on master and branch.
> master head is d095870
> branch head is a3db36a
> fork point is 0a5ff84

I tried re-merging d095870 and a3db36a. I think what is happening is
that even though you have many similar hunks near each, there are still
some differences in the area, and they are close enough that the merge
isn't sure what is right. We err on the side of conservatism with
conflicts, because it's hard to say what is dependent and what is not.

For example, if you have the content:

  foo();
  bar();
  baz();

and one side makes it:

  foo();
  x = 1;
  bar();
  baz();

and the other side does:

  foo();
  bar();
  y = 2;
  baz();

you _could_ argue that those changes are independent (and write a merge
algorithm that silently merges them). They're touching two different
lines, and doing two different things. But it's close enough that
there's a good chance the two need to be reconciled, and a human should
at least take a look.

I think what further confuses things in your case is that the content
added by the two sides contains a lot of similar lines (because of the
cherry-pick), and the default "merge" conflict-markers try to shrink the
size of the conflicts.

Try running:

  git config merge.conflictstyle diff3

and re-doing the merge. It will give you a much better sense of how git
is breaking down the hunks (because it does not try to shrink the
conflicts, and because it shows the base content for each conflict).

-Peff
