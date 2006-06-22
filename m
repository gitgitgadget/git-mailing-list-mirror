From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb refactoring
Date: Thu, 22 Jun 2006 20:37:48 +0200
Organization: At home
Message-ID: <e7eo1r$j87$1@sea.gmane.org>
References: <e7ed1r$9ve$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Jun 22 20:39:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtU4j-0000KA-PY
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 20:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbWFVSim (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 14:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbWFVSim
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 14:38:42 -0400
Received: from main.gmane.org ([80.91.229.2]:7825 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030328AbWFVSik (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 14:38:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FtU4L-0000E5-Lx
	for git@vger.kernel.org; Thu, 22 Jun 2006 20:38:22 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 20:38:21 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 20:38:21 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22352>

Another approach to refactoring gitweb would be to look at it's output.
Currently (with the exception of summary view), we have four main types of
views:

1. 'short listing' view, using zebra tables, which list "objects", each with
some number of columns usually not hyperlinked, object name/title,
sometimes shortened, sometimes post-processed which is link to the object,
then some object related links. Actions using this type of view: shortlog,
history, tree, tags, heads, blame; files affected part of commit view.
Examples of columns:
  Age, Author, Title[*1*] (link), commit|commitdiff    for shortlog
  Mode, Filename (link), tree or blob|history          for tree

2. 'single object' view, with fixed number of blocks. Actions using this
type of view: commit, tag.

3. 'long listing' view, which list "object"; description of each object
takes more than one line. Actions using this type of view: log, search.

4. 'large object' view, in which "object", optionally with some header, is
written line by line, with some syntax highlighting, sometimes with line
numbering, with at least one div per line. Actions using this type of view:
blob, commitdiff, blobdiff. Currently diffs are not splitted into chunks at
the HTML level (chunks are not encompassed in div; perhaps they should,
perhaps not - HTML like header structure vs DocBook nesting).

5. 'other' non HTML output, including blob_plain, commitdiff_plain,
blobdiff_plain, rss, opml, git_logo; perhaps in the future commitdiff_email
(for git-am or sending to the list), snapshot (tar, tar.gz, tar.bz2),
git_favicon.


Some views have subviews of other type.


Page as whole consist of:
* page header (which includes searchbox, what is not obvious) with 
  breadcrumbs up to action, 
* two part navigation bar: 
  - first part is always single hash action listing
      summary | shortlog | log | commit | commitdiff | tree 
    with and exception of base (first) commit which doesn't have commitdiff.
  - second part is either "pager" for log and shortlog, i.e.
      HEAD . prev . next
    or "type selection" for commitdiff, blobdiff and blob, sometimes
    including head (why not HEAD?).
* sometimes empty title of current hash or hash_base (current commit),
  or empty and linking to summary page.
* path (filename) header for tree and blob
* body of the page
* page footer with project description, and RSS link.


[*1*] Processed and shortened title (first line of commit), tooltip using
title attribute of link if shortened (gitweb-xmms2 broke that with
ntroduction of committags), tags which references this commit shown (now
only for summary I think, and tag(s) length is not taken into account when
shortening title/oneline description)

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
