From: Jeff King <peff@peff.net>
Subject: Re: git describe --contains doesn't work properly for a commit
Date: Wed, 4 Mar 2015 05:54:08 -0500
Message-ID: <20150304105408.GA19693@peff.net>
References: <20150226133534.GB14878@dhcp22.suse.cz>
 <20150226142314.GC14878@dhcp22.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michal Hocko <mhocko@suse.cz>
X-From: git-owner@vger.kernel.org Wed Mar 04 11:54:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT6wa-0007Me-HF
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 11:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934346AbbCDKyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 05:54:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:56187 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933617AbbCDKyL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 05:54:11 -0500
Received: (qmail 3832 invoked by uid 102); 4 Mar 2015 10:54:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Mar 2015 04:54:11 -0600
Received: (qmail 29361 invoked by uid 107); 4 Mar 2015 10:54:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Mar 2015 05:54:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Mar 2015 05:54:08 -0500
Content-Disposition: inline
In-Reply-To: <20150226142314.GC14878@dhcp22.suse.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264749>

On Thu, Feb 26, 2015 at 03:23:14PM +0100, Michal Hocko wrote:

> The commit in the middle was ammended to have committer date in the
> past.
> $ git describe --contains d63972e4e4e7eda0444e56739ad09bfbc476b9bd
> tag~1
> 
> but
> $ git describe --contains 108a0d5972fd2e5f25b2f38cfd2fee73031ff9d3
> fatal: cannot describe '108a0d5972fd2e5f25b2f38cfd2fee73031ff9d3'
> 
> I guess this is the same issue reported previously here:
> http://git.661346.n2.nabble.com/git-describe-contains-fails-on-given-tree-td5448286.html

Yes, the "describe --contains" algorithm uses timestamps to cut off the
traversal, so it can do the wrong thing if there's clock skew. It has a
"slop" margin of one day, but skew larger than that can fool it.

> Can this be fixed somehow or it would lead to other kind of issues?

The options are basically:

  1. Stop cutting off the traversal based on timestamps. This will make
     the common case of valid timestamps much slower, though, as it will
     have to walk all the way to the roots.

  2. Use a different slop mechanism. For example, keep walking up to 5
     commits past a commit suspected to be past the cutoff. This is
     relatively easy to do (we do it for "--since" checks), and would
     catch your case above. But of course it does not catch all cases of
     skew.

  3. Introduce a more trust-worthy mechanism for ordering commits. The
     timestamp here is really just a proxy for the oft-discussed
     "generation number" of the commit within the graph. We've avoided
     adding generation numbers because of the storage/complexity issues.

-Peff
