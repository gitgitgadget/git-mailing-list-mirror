From: Jeff King <peff@peff.net>
Subject: Re: git diff-tree -r -C output inexact sometimes
Date: Fri, 21 Sep 2012 02:03:39 -0400
Message-ID: <20120921060339.GA9844@sigill.intra.peff.net>
References: <2789023.yr3ihcVOhq@leto>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Cristian Tibirna <tibirna@kde.org>
X-From: git-owner@vger.kernel.org Fri Sep 21 08:03:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEwL8-0001ea-N8
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 08:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755293Ab2IUGDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 02:03:42 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:52333 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754616Ab2IUGDl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 02:03:41 -0400
Received: (qmail 29782 invoked by uid 107); 21 Sep 2012 06:04:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Sep 2012 02:04:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Sep 2012 02:03:39 -0400
Content-Disposition: inline
In-Reply-To: <2789023.yr3ihcVOhq@leto>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206110>

On Thu, Sep 20, 2012 at 11:20:31PM -0400, Cristian Tibirna wrote:

> Running the script in attachment produces a git repository in which were 
> operated a large number of file renames, in which many of the renamed files 
> (in this particular case all) have the same content but different names.
> 
> The commit data from the renaming operation (last commit in the script-
> generated history) is inexactly rendered by the command 
> 
> git diff-tree -r -C master
> 
> The logical result is correctly produced by the more restricted command
> 
> git diff-tree -r -M master
> 
> IMO for this particular last commit both the above commands should return the 
> same result.

Interesting. I get the same results from both commands. But I did have
to munge your script, as my "rename" command does not seem to work like
the one you expect in your script. So I may have misinterpreted the
intent of it.

However, I would not be surprised if one could conduct a situation in
which "-C" and "-M" produced different results. Since the content of all
the files is the same, git has to make a guess about which files match
up based on their filenames. The current heuristic is very stupid and
just tries to match basenames (e.g., moving "foo/Makefile" to
"bar/Makefile" is a better match than moving the same content to
"bar/foo.c"). But in this case, the basenames don't match at all.

By using "-C", we will typically have more rename sources available, and
we may therefore process the possible pairs in a different order. Since
our name heuristic is largely useless, our results depend on that order.

I think the real solution is to improve the name heuristic. Something
like an edit distance would make more sense (though I think it is not as
simple as an edit distance across the whole pathname, as moving a
basename across directories should probably be preferred to changing the
filename inside a directory).

Largely I think nobody has cared much because this only comes up when
you move multiple identical files. Quite often there is a minor
difference even between very similar files, and that is enough to come
up with sane results.

-Peff
