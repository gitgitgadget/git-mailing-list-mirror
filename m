From: Jeff King <peff@peff.net>
Subject: Re: Problem with rerere forget
Date: Thu, 14 May 2015 15:16:38 -0400
Message-ID: <20150514191637.GA9329@peff.net>
References: <CAPt1q6fMMz61aZEJB9b+K6+kHFwkm+bMYXoKBj78GNJU+dWioA@mail.gmail.com>
 <xmqq7fsbkn9z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Coppens <alex@nativetouch.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 21:16:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ysycg-0006m9-2e
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 21:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbbENTQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 15:16:41 -0400
Received: from cloud.peff.net ([50.56.180.127]:58736 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933407AbbENTQk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 15:16:40 -0400
Received: (qmail 20852 invoked by uid 102); 14 May 2015 19:16:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 14:16:40 -0500
Received: (qmail 26533 invoked by uid 107); 14 May 2015 19:16:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 15:16:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 May 2015 15:16:38 -0400
Content-Disposition: inline
In-Reply-To: <xmqq7fsbkn9z.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269071>

On Thu, May 14, 2015 at 11:49:12AM -0700, Junio C Hamano wrote:

> Alex Coppens <alex@nativetouch.com> writes:
> 
> > git rerere forget path_to_file/file.js
> >
> > fatal: BUG: attempt to commit unlocked object
> 
> That comes from commit_lock_file(); I think rerere.c:write_rr()
> has a call to that function and I suspect that is the call that is
> giving the above message.
> 
> Is there any other process that is mucking with your .git/index file
> while you are running the command?

This seems much easier to reproduce:

  $ git init -q
  $ git rerere forget foo
  fatal: BUG: attempt to commit unlocked object

It looks like we need to pay more attention to the return value of
setup_rerere, which is what is supposed to take the lock.

-Peff
