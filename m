From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC 4/4 v3] Add cat-blob report fifo from fast-import to
 remote-helper.
Date: Sat, 21 Jul 2012 09:48:34 -0500
Message-ID: <20120721144834.GB19860@burratino>
References: <1338830455-3091-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <1374057.qfvOg1c6C6@flobuntu>
 <1415957.ivnctqiWQE@flobuntu>
 <2448876.O3MA5kWbuX@flobuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Michael Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 16:49:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ssaze-0006A6-Gf
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 16:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328Ab2GUOso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 10:48:44 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62725 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751318Ab2GUOsn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 10:48:43 -0400
Received: by yhmm54 with SMTP id m54so4689394yhm.19
        for <git@vger.kernel.org>; Sat, 21 Jul 2012 07:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=EiPlklS5DoHMltCfWe34g6r66dXeYVUWIjmf1PnQI2E=;
        b=JhiAIGWyIjK4D95X4V353adGxEPIXQmHEdePGyTrANLcepAvstWels6mG3xEdXSyA1
         lxOvnPaIpDmV5t2uUS7shPFm58OBPNvQUj59b3fVd3qDqv9quFkWa8MiSd81bUxE+eHl
         /CskAB8StVLISq+DyrYcJ68hfEK1+s/pdf5rABpkSdM5AhSenzHxkDV7cBDDH3U76ey0
         2TQVbFfA3ky0JqA39/2zH9IRC292jsSSgWesdX5SiOunCOn2ar2yHpeg5HerQPQnPidl
         IEMTQS0N+4LOjnQ33ycB77OSRbHA0sD+VPkc0uG+8Sr4Ludss+WPFThy4G4Ix5Q/Vk8x
         mqfQ==
Received: by 10.50.213.98 with SMTP id nr2mr6691113igc.71.1342882122708;
        Sat, 21 Jul 2012 07:48:42 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id aj5sm3483261igc.14.2012.07.21.07.48.41
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Jul 2012 07:48:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2448876.O3MA5kWbuX@flobuntu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201810>

Hi,

Florian Achleitner wrote:

> [Subject: Re: [RFC 4/4 v3] Add cat-blob report fifo from fast-import to
> remote-helper.]

Is this on top of patches 1, 2, and 3 from v2 of the series?

*checks* Looks like it doesn't overlap with any of the files from
those patches, so I don't have to understand them first.  Phew.  My
suggestion for next time would be to submit patches that can be
understood on their own independently instead of as part of a series.

> For some fast-import commands (e.g. cat-blob) an answer-channel
> is required. For this purpose a fifo (aka named pipe) (mkfifo)
> is created (.git/fast-import-report-fifo) by the transport-helper
> when fetch via import is requested. The remote-helper and
> fast-import open the ends of the pipe.

Motivation described!  But it's odd --- it seems like this is
doing at least two things:

 1) adding to the fast-import interface
 2) using the new fast-import feature in some in-tree callers

Those really want to be separate patches.  That way, the fast-import
change can be studied by other implementers of the fast-import
interface (hg-fast-import, bzr-fast-import).  As a side-benefit, it
gives an easy check that any changes to fast-import were at least
roughly backward-compatible ("did all the in-tree users still work?").

I'll focus on the new fast-import change below, since it's the most
important part.

> The filename of the fifo is passed to the remote-helper via
> it's environment, helpers that don't use fast-import can
> simply ignore it.

My first impression is that I'd rather there be a command to request
the filename instead of using the environment for the first time,
since when debugging people would already be monitoring the command
stream and responses.

> Add a new command line option --cat-blob-pipe to fast-import,
> for this purpose.

This is completely redundant next to --cat-blob-fd, right?  That's
really problematic --- adding new interfaces means new code and
gratuitous incompatibility with all existing fast-import backends,
with no benefit in return.

I imagine that there was some portability reason you were thinking
about, but the above doesn't mention it at all.  Future readers
scratching their heads at the changelog can't read your mind!  Please
please please explain what you're trying to do.

Since if we're lucky fixing that could mean not having to change
fast-import at all, I'm stopping here.

Another quick thought: any finished patch adding a new fast-import
feature should also include

 - documentation in the manpage (Documentation/fast-import.txt)
 - testcases to make sure your careful work does not get broken
   by later changes (somewhere in t/*fast-import*.sh)

But don't worry too much about that now --- sending incomplete patches
for review before then to make sure the direction is sane is a very
good idea, as long as they are marked as such (as you've already done
by marking this as RFC).

To sum up: I think we should just stick to pipes --- why all this fifo
complication?

Hope that helps,
Jonathan
