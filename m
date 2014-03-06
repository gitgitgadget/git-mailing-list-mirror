From: Jeff King <peff@peff.net>
Subject: Re: Unable to shrink repository size
Date: Thu, 6 Mar 2014 10:25:50 -0500
Message-ID: <20140306152550.GA18519@sigill.intra.peff.net>
References: <CAHd499AW6nev81iVVhuoYfT0us28SSBDwbHCBa3teYB=cJR99g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 16:25:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLaBK-0007Ct-4k
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 16:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752999AbaCFPZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 10:25:54 -0500
Received: from cloud.peff.net ([50.56.180.127]:34112 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752983AbaCFPZw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 10:25:52 -0500
Received: (qmail 13480 invoked by uid 102); 6 Mar 2014 15:25:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Mar 2014 09:25:52 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Mar 2014 10:25:50 -0500
Content-Disposition: inline
In-Reply-To: <CAHd499AW6nev81iVVhuoYfT0us28SSBDwbHCBa3teYB=cJR99g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243519>

On Wed, Mar 05, 2014 at 08:55:30PM -0600, Robert Dailey wrote:

> What I'd like to do is somehow hunt down the largest commit (*not*
> blob) in the entire history of the repository to hopefully find out
> where huge directories have been checked in.
> 
> I can't do a search for largest file (which most google results seem
> to show to do) since the culprit is really thousands of unnecessary
> files checked into a single subdirectory somewhere in history.

Other people have offered scripts to look at commit sizes. But it might
also be useful to see sizes by subdirectory. Sort of a "du" across all
of history. Script is below.

Note that this script also uses cat-file's "%(objectsize:disk)". So it
is finding the actual on-disk storage, taking into account delta
storage. You will need git v1.8.5 or later to use this feature.

  git rev-list --objects --all |
  git cat-file --batch-check="%(objectsize:disk) %(rest)" |
  perl -lne '
    my ($size, $path) = split / /, $_, 2;
    next unless defined $path; # commit obj
    do {
      $sizes{$path} += $size;
    } while ($path =~ s{/[^/]+$}{});

    END { print "$sizes{$_} $_" for (keys %sizes) }
  ' |
  sort -rn

-Peff
