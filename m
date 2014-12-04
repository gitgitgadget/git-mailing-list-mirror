From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] disabling terminal prompts
Date: Wed, 3 Dec 2014 22:42:07 -0500
Message-ID: <20141204034206.GA1493@peff.net>
References: <20141203000310.GE90134@vauxhall.crustytoothpaste.net>
 <20141203005953.GB6527@google.com>
 <20141203012148.GB29427@peff.net>
 <20141204004231.GA200195@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Dec 04 04:42:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwNJ7-0003Yb-Gf
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 04:42:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbaLDDmK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 22:42:10 -0500
Received: from cloud.peff.net ([50.56.180.127]:48122 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751302AbaLDDmJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 22:42:09 -0500
Received: (qmail 9218 invoked by uid 102); 4 Dec 2014 03:42:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Dec 2014 21:42:09 -0600
Received: (qmail 2888 invoked by uid 107); 4 Dec 2014 03:42:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Dec 2014 22:42:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Dec 2014 22:42:07 -0500
Content-Disposition: inline
In-Reply-To: <20141204004231.GA200195@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260723>

On Thu, Dec 04, 2014 at 12:42:31AM +0000, brian m. carlson wrote:

> I'll probably submit a patch to disable the terminal prompting this
> weekend.

Too late. You got me thinking about it, so I wrote the following series.

  [1/2]: credential: let helpers tell us to quit
  [2/2]: prompt: respect GIT_TERMINAL_PROMPT to disable terminal prompts

Technically the second one is redundant with the first. You could just
define a credential helper which bails before we get to the prompts. But
for simple cases, I think that:

  GIT_TERMINAL_PROMPT=0 git ...

is a lot more intuitive than:

  git -c credential.helper='!f() { echo quit=1; }; f' ...

and is also easier to set at the top of a non-interactive script. The
first is not redundant with the second, because it is a lot more
flexible. E.g., you can abort only after seeing that we match a specific
URL, or after running any arbitrary code you like (e.g., checking out
some characteristics of the tty and deciding it is not a good idea to
access it).

There is one thing this _doesn't_ handle, which is that of preventing
existing configured credential-helpers from running (even a helper you
define with "git -c" runs after the others). But I think that is a
separate issue.

-Peff
