From: Jeff King <peff@peff.net>
Subject: Re: serious performance issues with images, audio files, and other
 "non-code" data
Date: Tue, 18 May 2010 15:27:58 -0400
Message-ID: <20100518192758.GC2383@coredump.intra.peff.net>
References: <4BEAF941.6040609@puckerupgames.com>
 <20100514051049.GF6075@coredump.intra.peff.net>
 <4BED47EA.9090905@puckerupgames.com>
 <20100517231642.GB12092@coredump.intra.peff.net>
 <AANLkTikAoZgvYXN-iGPGjMP-vdgrOuKp3_gJzGYaojec@mail.gmail.com>
 <20100518190706.GA2383@coredump.intra.peff.net>
 <AANLkTiltNPIR5gAWMOqZ2Y_azFUU93kH54ddHuCFFeCp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John <john@puckerupgames.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 18 21:28:12 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OESSX-0007xB-Sv
	for gcvg-git-2@lo.gmane.org; Tue, 18 May 2010 21:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757918Ab0ERT2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 May 2010 15:28:04 -0400
Received: from peff.net ([208.65.91.99]:52268 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241Ab0ERT2B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 May 2010 15:28:01 -0400
Received: (qmail 20730 invoked by uid 107); 18 May 2010 19:28:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 18 May 2010 15:28:28 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 18 May 2010 15:27:58 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTiltNPIR5gAWMOqZ2Y_azFUU93kH54ddHuCFFeCp@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147300>

On Tue, May 18, 2010 at 09:10:58PM +0200, Sverre Rabbelier wrote:

> On Tue, May 18, 2010 at 21:07, Jeff King <peff@peff.net> wrote:
> > No, not to my knowledge. Even the "binary" attribute just says "this
> > file is binary, don't text diff it". I think we will always still do
> > rewrite-detection for operations like "git status" and the diff summary
> > of "git commit".
> 
> Would that not be a very sensible optimization that would help John
> (and other users of big files) a lot?

It might help some, but I worry about overloading the meaning of
"-delta". Right now it has a very clear meaning: don't delta for
packfiles. But that doesn't mean I might not want to see break detection
(or inexact rename detection, for that matter) at some time.

Large binary files shouldn't be taxing on regular diffs.  If you have
marked a file as "binary" and we are not creating a binary diff (i.e.,
just printing "binary files differ"), then we shouldn't even need to
pull the blob from storage (since we can tell from the sha1 that it is
different). I haven't checked to see if we do that simple optimization
(if you haven't marked it with a binary attribute, then obviously we do
have to look at the blob to find out that it is binary).

So:

  1. I think it would need a separate attribute that is about diffing
     (possibly even just options to a custom diff filter).

  2. I am not clear exactly what options would work best. Do you want to
     disable diffing entirely? Disable just inexact rename detection and
     break detection? If break detection is disabled, do you assume it
     is _always_ a rewrite, or never?

So I am open to the idea, but I think we would need a more concrete
proposal and some timings to show how it is a benefit.

-Peff
