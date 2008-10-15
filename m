From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH (GITK) v3 0/4] Enhance encoding support.
Date: Wed, 15 Oct 2008 23:32:06 +1100
Message-ID: <18677.58054.209169.479165@cargo.ozlabs.ibm.com>
References: <1223885554-27718-1-git-send-email-angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 14:34:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq5aW-0001jx-5r
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 14:34:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846AbYJOMdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 08:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752819AbYJOMdg
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 08:33:36 -0400
Received: from ozlabs.org ([203.10.76.45]:45877 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752766AbYJOMdf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 08:33:35 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 59073DDF70; Wed, 15 Oct 2008 23:32:11 +1100 (EST)
In-Reply-To: <1223885554-27718-1-git-send-email-angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98268>

Alexander Gavrilov writes:

> Currently GUI tools don't provide enough support for
> viewing files that contain non-ASCII characters. This set of
> patches addresses this issue. The git-gui part of the series
> is based on patches that were in the 'pu' branch of the
> git-gui repository.

Thanks.  I applied 1/4 and 2/4 as one commit and 3/4 as another.
However, it seems invoking git check-attr is quite slow, or at least,
there is a large startup cost which is not really amortized by
batching up only 30 paths per call.

As a test I tried displaying the diff in the kernel tree from 2.6.27
to Linus' master as of a day or so ago (3fa8749e) which has 5277 files
different.  With the 30-way batching this takes over 6 seconds to get
the file encodings (all of which are "unspecified" since I don't have
any .gitattributes files), which we need before we display the list of
changed files, which before only took 0.12 seconds -- so we're 50x
slower at showing the list of changed files as a result of adding the
per-file encoding support.  Also, each call to cache_gitattr was
taking 1.2 seconds, which is too long since file handlers are supposed
to limit themselves to less than 100ms (preferably less than 50ms) of
processing on any one call, and the cache_gitattr call was making
gettreediffline take way too long.

So I have added another commit which makes the per-file encoding
support optional and default to off for now.  It also increases the
amount of batching in cache_gitattr (except under windows) and reduces
the number of lines that gettreediffline does when per-file encoding
support is on.  Along the way, it also converts the new code to the
gitk coding style, cleans up a few things and adds a simple cache to
tclencoding.

If git check-attr gets the --stdin-paths flag added, that will be
good, except then getblobdiffline will need to do something clever if
it needs the encoding for a file but the result hasn't come back from
git-check-attr yet.  That could get quite tricky in fact...

Paul.
