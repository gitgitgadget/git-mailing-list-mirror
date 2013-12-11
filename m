From: Jeff King <peff@peff.net>
Subject: Re: [BUG] "echo HEAD | git cat-file --batch=''" fails
 catastrophically
Date: Wed, 11 Dec 2013 19:54:58 +0800
Message-ID: <20131211115458.GA10561@sigill.intra.peff.net>
References: <CAJYzjmdHdLZaBijahepOQDJtDd_TdojT4ivNxGrcerRfEuHQEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Samuel Bronson <naesten@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 11 12:55:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqiNt-00031g-Ly
	for gcvg-git-2@plane.gmane.org; Wed, 11 Dec 2013 12:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674Ab3LKLzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Dec 2013 06:55:17 -0500
Received: from cloud.peff.net ([50.56.180.127]:34794 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751345Ab3LKLzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Dec 2013 06:55:16 -0500
Received: (qmail 10829 invoked by uid 102); 11 Dec 2013 11:55:16 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (123.127.199.235)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 11 Dec 2013 05:55:16 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Dec 2013 19:54:58 +0800
Content-Disposition: inline
In-Reply-To: <CAJYzjmdHdLZaBijahepOQDJtDd_TdojT4ivNxGrcerRfEuHQEg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239186>

On Tue, Dec 10, 2013 at 11:37:14PM -0500, Samuel Bronson wrote:

> % echo HEAD | git cat-file --batch=
> 
> fatal: object fde075cb72fc0773d8e8ca93d55a35d77bb6688b changed type!?
> 
> Without the =, it works fine; with a string that has both
> "%(objecttype)" and "%(objectsize)", it's fine; but when you don't
> include both, it complains about one of the values that you did not
> mention having changed.
> 
> jrnieder fingered v1.8.4-rc0~7^2~15 as the (likely?) culprit here.

It's not actually that commit itself, but rather that commit in
conjunction with further optimizations in that patch series.

The rest of the series tries hard to avoid looking up items that we
aren't going to print, for --batch-check. But I didn't think about the
fact that "--batch" got the same custom-header feature, but was relying
on the values from the default header to do its consistency checks.

The following patches should fix it.

  [1/2]: cat-file: pass expand_data to print_object_or_die
  [2/2]: cat-file: handle --batch format with missing type/size

Doing "--batch=" is somewhat pointless. If you do not get the size, you
cannot know when the object content ends, so it only makes sense with a
single object. At which point using --batch is pointless. Doing
"--batch=%(objectsize)" is reasonable, though, and that is broken, too.

v1.8.4 has the breakage, though it's not a regression (doing
"--batch=anything" did not exist before that). This can probably just go
to the regular "maint" track for v1.8.5).

-Peff
