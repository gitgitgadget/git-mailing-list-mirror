From: Jeff King <peff@peff.net>
Subject: Re: git-log --pretty=format:'[%x00]%w(0,0,1)' doesn't print NUL and
 "]"
Date: Thu, 29 Dec 2011 14:23:29 -0500
Message-ID: <20111229192328.GA18723@sigill.intra.peff.net>
References: <CANjopZFqiy+Ai4u6QYYnza5J7A3NAt-f17yR9AsYok-g3Hbb3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tanaka Akira <akr@fsij.org>
X-From: git-owner@vger.kernel.org Thu Dec 29 20:23:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RgLZl-0001L0-O5
	for gcvg-git-2@lo.gmane.org; Thu, 29 Dec 2011 20:23:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898Ab1L2TXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Dec 2011 14:23:33 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54036
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750941Ab1L2TXc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Dec 2011 14:23:32 -0500
Received: (qmail 12096 invoked by uid 107); 29 Dec 2011 19:30:19 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 Dec 2011 14:30:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Dec 2011 14:23:29 -0500
Content-Disposition: inline
In-Reply-To: <CANjopZFqiy+Ai4u6QYYnza5J7A3NAt-f17yR9AsYok-g3Hbb3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187783>

On Fri, Dec 30, 2011 at 03:41:20AM +0900, Tanaka Akira wrote:

> I found that git-log doesn't print characters in --pretty option as follows.
> 
>   % git log --pretty=format:'[%x00]%w(0,0,1)' |od -c
>   0000000   [  \n   [  \n   [  \n   [  \n   [  \n   [  \n   [  \n   [  \n
>   *
>   0022320   [  \n   [  \n   [  \n   [
>   0022327
> 
> I think NUL and "]" should be printed.

I think there is a bug in strbuf_add_indented_text, which uses
strchrnul, even though a strbuf may contain literal NULs. Although one
could argue that trying to wrap a NUL is questionable (after all, what
is its character width?), the current behavior seems pretty wrong.

I think the whole wrapping callchain needs to be adjusted to handle
arbitrary bytes (there are also several checks in
strbuf_add_wrapped_text for NUL terminators).

-Peff
