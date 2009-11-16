From: Jeff King <peff@peff.net>
Subject: Re: [RFC] format-patch: Ensure that author and commit time are not
 lost
Date: Mon, 16 Nov 2009 00:20:41 -0500
Message-ID: <20091116052041.GD14664@coredump.intra.peff.net>
References: <4B000141.5070503@gmail.com>
 <7vzl6nfqkx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?QmrDtnJu?= Gustavsson <bgustavsson@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 06:20:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9u1B-0002qB-AT
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 06:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751670AbZKPFUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2009 00:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbZKPFUh
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Nov 2009 00:20:37 -0500
Received: from peff.net ([208.65.91.99]:38035 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761AbZKPFUh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2009 00:20:37 -0500
Received: (qmail 14338 invoked by uid 107); 16 Nov 2009 05:24:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 16 Nov 2009 00:24:30 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Nov 2009 00:20:41 -0500
Content-Disposition: inline
In-Reply-To: <7vzl6nfqkx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132986>

On Sun, Nov 15, 2009 at 01:03:42PM -0800, Junio C Hamano wrote:

> I would expect the right solution would be to give send-email an ability
> to either (1) use "Sender:" to record the operator of the MUA while
> keeping "From: " taken from the payload, or (2) duplicate "From: " as an
> in-body header when it sends out.

I agree that send-email is the "right" place for this functionality in
the git toolchain. And indeed, it already does (2):

  $ sed -ne '/$author ne $sender/,+1p' git-send-email.perl
          if (defined $author and $author ne $sender) {
                          $message = "From: $author\n\n$message";

That being said, like you, I usually pull the patches directly from
format-patch into my MUA, and I fix up the headers manually. I suspect
there are many others who do the same thing. And each of us has to
either handle this case manually, or write our own munging code
ourselves for our particular setup.

So in that sense, even though format-patch is not the right place, it
may be useful for it to give tool support to people who do not use the
"format-patch to send-email" workflow. In other words, I would be
happy if my short glue shell-script became:

  git format-patch --stdout --sender-is-me "$@" >mbox &&
  mutt -f mbox

and this just handled the case properly, without me having to parse the
From header of each message and munge the messages in my script.

The arguments against it are:

  1. It is polluting format-patch with MUA cruft.

  2. --sender-is-me (besides being a terrible name) may not be
     expressive enough. You might want --sender=... depending on the
     setup of the calling script.

Honestly, though, I send few enough patches made by other people that I
have never found it to be a huge burden. This would be a minor
convenience to have.

-Peff
