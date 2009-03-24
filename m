From: Jeff King <peff@peff.net>
Subject: Re: checkout/update boiler plate for --filter-index?
Date: Tue, 24 Mar 2009 03:43:01 -0400
Message-ID: <20090324074301.GB32400@coredump.intra.peff.net>
References: <580660BE-FDAB-4947-B409-1E8D5CBEF8EE@earth.care2.com> <49C889E2.2080208@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marcel Cary <marcel@earth.care2.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 24 08:44:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm1JV-0001N9-2E
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 08:44:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756267AbZCXHnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 03:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756498AbZCXHnL
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 03:43:11 -0400
Received: from peff.net ([208.65.91.99]:52103 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756044AbZCXHnK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 03:43:10 -0400
Received: (qmail 27499 invoked by uid 107); 24 Mar 2009 07:43:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 24 Mar 2009 03:43:21 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Mar 2009 03:43:01 -0400
Content-Disposition: inline
In-Reply-To: <49C889E2.2080208@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114408>

On Tue, Mar 24, 2009 at 08:21:06AM +0100, Johannes Sixt wrote:

> You cannot do that with the index filter because you need actual blob
> contents to operate on, but the index filter doesn't give you an
> opportunity to do that. The tree filter is the right filter to use. But
> you neither need 'git checkout' nor 'git update-index' in the filter -
> filter-branch calls them for you. (Oh, and get rid of that useless use of
> cat.)

Well, you _could_ do it as an index-filter, which has the potential to
be much faster if you are only operating only on a small subset of the
files.  But it's much less readable. Something like (totally untested):

  git filter-branch --index-filter '
    for i in `cat /path/to/files`; do
      hash=$(git cat-file :$i |
             sed 's/foo/bar/' |
             git hash-object -w --stdin)
      git update-index --add --cacheinfo 100644 $hash $i
    done
  '

I'm sure you could do even do it with a constant number of processes per
commit by using update-index --index-info, hash-object --stdin-paths,
and cat-file --batch. But it would probably be even less readable. ;)

Personally, I would probably just do a tree-filter for simplicity unless
the repo size made it prohibitively slow.

-Peff
