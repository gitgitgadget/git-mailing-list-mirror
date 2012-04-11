From: Jeff King <peff@peff.net>
Subject: Re: GSoC - Some questions on the idea of
Date: Wed, 11 Apr 2012 18:09:55 -0400
Message-ID: <20120411220955.GB28199@sigill.intra.peff.net>
References: <loom.20120328T131530-717@post.gmane.org>
 <CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com>
 <20120330203430.GB20376@sigill.intra.peff.net>
 <CA+M5ThR6jtxqs0-Kz-8fcRuOFRbLr-GvsJcTmrOQ7_geNspDLg@mail.gmail.com>
 <4F76E430.6020605@gmail.com>
 <4F772E48.3030708@gmail.com>
 <20120402210708.GA28926@sigill.intra.peff.net>
 <4F84DD60.20903@gmail.com>
 <20120411060357.GA15805@burratino>
 <4F85B17E.4080005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Sergio Callegari <sergio.callegari@gmail.com>,
	Bo Chen <chen@chenirvine.org>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 00:10:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SI5jn-0000yR-BU
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 00:10:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761346Ab2DKWJ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 18:09:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57012
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761289Ab2DKWJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 18:09:57 -0400
Received: (qmail 18678 invoked by uid 107); 11 Apr 2012 22:10:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 11 Apr 2012 18:10:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Apr 2012 18:09:55 -0400
Content-Disposition: inline
In-Reply-To: <4F85B17E.4080005@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195274>

On Wed, Apr 11, 2012 at 11:29:50AM -0500, Neal Kreitzinger wrote:

> How do I check the history size of a binary?  IOW, how to I check the
> size of the sum of all the delta-compressions and root blob of a binary?
>  That way I can sample different binary types to get a symptomatic idea
> of how well they are delta compressing.  I suspect that compiled
> binaries will compress well (efficient history) and graphics files may
> not compress well (large history).

I don't think there is a simple command to do it. You have to correlate
blobs at a given path with objects in the packs yourself. You can script
it like:

  # get the delta stats from every pack; you only need to do this part
  # once for a given history state. And obviously you would want to
  # repack before doing it.
  for i in .git/objects/pack/*.pack; do
    git verify-pack -v $i;
  done |
  perl -lne '
    # format is: sha1 type size size-in-pack offset; pick out only the
    # thing we care about: size in pack
    /^([0-9a-f]{40}) \S+\s+\d+ (\d+)/ and print "$1 $2";
  ' |
  sort >delta-stats


  # then you can do this for every path you are interested in.

  # First, get the list of blobs at that path (and follow renames, too).
  # The second line is picking the "after" sha1 from the --raw output.
  git log --follow --raw --no-abbrev $path |
  perl -lne '/:\S+ \S+ \S{40} (\S{40})/ and print $1' |
  sort -u >blobs

  # Then find the delta stats for those blobs
  join blobs delta-stats

which should give you the stored size of each version of a file.

-Peff
