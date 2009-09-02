From: Jeff King <peff@peff.net>
Subject: Re: diff-files inconsistency with touched files
Date: Wed, 2 Sep 2009 15:28:20 -0400
Message-ID: <20090902192820.GE6900@coredump.intra.peff.net>
References: <4A9EAAF3.3000002@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: James Spencer <jss43@cam.ac.uk>
X-From: git-owner@vger.kernel.org Wed Sep 02 21:28:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MivVQ-00036t-62
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 21:28:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752454AbZIBT2V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 15:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752411AbZIBT2V
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 15:28:21 -0400
Received: from peff.net ([208.65.91.99]:39850 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751709AbZIBT2U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 15:28:20 -0400
Received: (qmail 8569 invoked by uid 107); 2 Sep 2009 19:28:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 02 Sep 2009 15:28:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Sep 2009 15:28:20 -0400
Content-Disposition: inline
In-Reply-To: <4A9EAAF3.3000002@cam.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127628>

On Wed, Sep 02, 2009 at 06:27:15PM +0100, James Spencer wrote:

> $ git diff-files
> $ touch test
> $ git diff-files
> :100644 100644 9daeafb9864cf43055ae93beb0afd6c7d144bfa4
> 0000000000000000000000000000000000000000 M  test
> $ git diff
> $ git diff-files
> $
> 
> I don't understand why git diff-files reports a file is changed when
> that file is touched nor why running git diff changes this to (what I
> think is) the correct behaviour.

Git uses the stat information of a file to know whether what we have
cached in the index is up-to-date or not. So in the first diff-files, we
don't even have to look at the contents of "test"; we see that it hasn't
changed since the last time we looked at the contents, and that its
sha-1 matches what's in the index, so there is no diff.

By running "touch", you have changed the stat information, so we believe
there may be a difference. But we don't actually know what's _in_ the
new side, so we just print the null sha1 instead of the actual sha1
contents.

Diff-files _could_ refresh the cache each time it runs, but we
intentionally do not do that. Doing so is a little bit expensive, and
because diff-files is intended as a low-level tool for scripts, we give
the script the flexibility (and responsibility) of refreshing the cache
when it wants to. So you could do:

  $ git update-index --refresh
  $ git diff-files

and get clean output.

You see different behavior from "git diff" because it is meant for user
consumption and therefore refreshes the cache automatically at the
beginning of every run.

-Peff
