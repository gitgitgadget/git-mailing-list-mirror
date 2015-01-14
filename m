From: Jeff King <peff@peff.net>
Subject: Re: Big repo not shrinking on repack or gc?
Date: Wed, 14 Jan 2015 07:49:36 -0500
Message-ID: <20150114124936.GC30383@peff.net>
References: <20150114115130.GA5677@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 14 13:49:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBNOJ-0002aO-Ez
	for gcvg-git-2@plane.gmane.org; Wed, 14 Jan 2015 13:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285AbbANMtj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2015 07:49:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:34313 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751995AbbANMti (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2015 07:49:38 -0500
Received: (qmail 25600 invoked by uid 102); 14 Jan 2015 12:49:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jan 2015 06:49:38 -0600
Received: (qmail 2787 invoked by uid 107); 14 Jan 2015 12:49:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 14 Jan 2015 07:49:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Jan 2015 07:49:36 -0500
Content-Disposition: inline
In-Reply-To: <20150114115130.GA5677@inner.h.apk.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262384>

On Wed, Jan 14, 2015 at 12:51:30PM +0100, Andreas Krey wrote:

> I have a repo here that is 130G, but when I clone --mirror it, the result
> is only 25G big.  Because of the --mirror I don't think that I missed
> any refs that keep objects only in the source repo.

Perhaps some objects are mentioned by reflogs, but not by the refs? They
would not be transferred as part of a clone. Try:

  git rev-list --objects --all | cut -d' ' -f1 | sort >reachable
  git rev-list --objects --reflog | cut -d' ' -f1 | sort >reflogs
  comm -13 reachable reflogs |
  git cat-file --batch-check='%(objectsize:disk)' |
  perl -lne '$total += $_; END { print $total }'

That should print the size, in bytes, that reflog-only objects are using
on disk.  You can use "git reflog expire --expire-unreachable=now --all"
to get rid of them (and then repack).

> I already tried 'git repack -fad' and 'git gc' to shrink the original repo,

You don't need the "-f" here. Just "git repack -ad" should be enough
(and the "-f" probably makes it _way_ slower).

-Peff
