From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] Add filter-objects command
Date: Fri, 19 Jun 2015 06:10:10 -0400
Message-ID: <20150619101010.GA15802@peff.net>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
 <1434705059-2793-4-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Jun 19 12:10:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5tFc-00017R-Su
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 12:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751602AbbFSKKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 06:10:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:48693 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751633AbbFSKKP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 06:10:15 -0400
Received: (qmail 9366 invoked by uid 102); 19 Jun 2015 10:10:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Jun 2015 05:10:15 -0500
Received: (qmail 13938 invoked by uid 107); 19 Jun 2015 10:10:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Jun 2015 06:10:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Jun 2015 06:10:10 -0400
Content-Disposition: inline
In-Reply-To: <1434705059-2793-4-git-send-email-charles@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272119>

On Fri, Jun 19, 2015 at 10:10:59AM +0100, Charles Bailey wrote:

> filter-objects is a command to scan all objects in the object database
> for the repository and print the ids of those which match the given
> criteria.
> 
> The current supported criteria are object type and the minimum size of
> the object.
> 
> The guiding use case is to scan repositories quickly for large objects
> which may cause performance issues for users. The list of objects can
> then be used to guide some future remediating action.

I've had to perform this exact same task. You can already do the
"filtering" part pretty easily and efficiently with cat-file and a perl
script, like:

  magically_generate_all_objects |
  git cat-file --batch-check='%(objectsize) %(objectname)' |
  perl -alne 'print $F[1] if $F[0] > 1234'

That's not as friendly as your filter-objects, but it's a lot more
flexible (since you can ask cat-file for all sorts of information).

Obviously I've glossed over the "how to get a list of objects" part.
If you truly want all objects (not just reachable ones), or if "rev-list
--objects" is too slow, the best way is:

  objects() {
    # loose objects
    for i in objects/??/*; do
       echo $i
    done |
    sed 's,objects/\(..\)/,\1,'

    # packed objects
    for i in objects/pack/*.idx; do
      git show-index <$i
    done |
    cut -d' ' -f2
  }

Certainly I'm not opposed to doing something less horrible there (and I
am happy to see my for_each_*_object interface getting more callers!).
I kind of wonder if we should make "all objects, reachable or not" an
option for rev-list. I'm not sure if it would choke on adding them all
to the "pending" list, though; it's not really made for that. But it
would enable neat things like:

  git rev-list --all-the-objects --not --all

to show you what's unreachable.

-Peff
