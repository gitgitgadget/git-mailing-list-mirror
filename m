From: Jeff King <peff@peff.net>
Subject: Re: Efficiently detecting paths that differ from each other only
 in case
Date: Fri, 8 Oct 2010 09:50:34 -0400
Message-ID: <20101008135034.GC5163@sigill.intra.peff.net>
References: <AANLkTimGAbosbD0pprROu_g-UW38faotYA2dTxj9scsP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 08 15:50:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4DLR-0000VS-0Z
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 15:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757631Ab0JHNu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 09:50:29 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:50072 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757525Ab0JHNu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 09:50:29 -0400
Received: (qmail 26355 invoked by uid 111); 8 Oct 2010 13:50:27 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 08 Oct 2010 13:50:27 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Oct 2010 09:50:34 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimGAbosbD0pprROu_g-UW38faotYA2dTxj9scsP@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158500>

On Fri, Oct 08, 2010 at 01:13:07AM -0500, Dun Peal wrote:

> Etc. I know how to do it by listing paths with ls-files, but my repo
> contains many thousands of files, so I was wondering if there was a
> more efficient way than for every commit:
> 
> 1. Get a list of all paths in the repo from ls-files.
> 2. Lowercase all paths.
> 3. Check for repeats.

You can do:

  git ls-files | tr A-Z a-z | sort | uniq -d

but:

  1. It will print only the lowercased version, not all versions.

  2. It doesn't handle filenames with embedded newlines.

You could fix both with something like:

  git ls-files -z | perl -0ne '
    push @{$h{lc($_)}}, $_;
    END {
      print join("\n", @{$h{$_}}) . "\n\n"
        foreach grep { @{$h{$_}} > 1 } keys(%h);
    }
  '

-Peff
