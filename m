From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC] gitweb: Use feed link according to current view
Date: Mon, 11 Feb 2008 19:00:12 +0100
Message-ID: <200802111900.12325.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 11 19:01:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOcyW-0002Ur-A8
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 19:01:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754348AbYBKSA2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 13:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753002AbYBKSA2
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 13:00:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:26248 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767AbYBKSA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 13:00:27 -0500
Received: by ug-out-1314.google.com with SMTP id z38so333121ugc.16
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 10:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=5+KLb+S2n7sst7vdxBrbBviluFlbe458jeHQ8G6YFDA=;
        b=c5V1TTrtJymTDjp++h6E/17Iy+tJKNP7LnH1GKJwbsEjUI7ZHbpcGqKkeiot41tPgtTooeeRC1Hufh83zgsgfSVSznrFV4ZTVPR3U7SRxSzykRlWWJNcsUFUpP2uXdlqjBikCSM760lANlg+hzdXaKp7p+bHcFGQxZGEnKMSPvg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tRogJGoGNMOi20y/BqPHGrsJr/8m27omMLRSrR+R3oln+l1Yn4lETSLXBo+P8OHwiPqk4oPvAEUDZmUs5sHFxdh484uCCgJzqNEXr8EDYT5NnjuggY9DlvTcqV43CdCPF7qq6VdFblNueRYizkmNndURE0CGoyQ9a2ffI4PiOTQ=
Received: by 10.67.30.3 with SMTP id h3mr8583743ugj.35.1202752823433;
        Mon, 11 Feb 2008 10:00:23 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.220.23])
        by mx.google.com with ESMTPS id g11sm20413102gve.6.2008.02.11.10.00.21
        (version=SSLv3 cipher=OTHER);
        Mon, 11 Feb 2008 10:00:22 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73557>

Michael G. Noll said in comments to the "Switching my code repository
from Subversion (SVN) to git" article (http://tinyurl.com/37v67l) in
his "My digital moleskine" blog, that one of the things he is missing
in gitweb from SVN::Web is an RSS feed with news/information of the
current view (including RSS feed for single file or directory).

This is not exactly true, as since refactoring feed generation in
  "gitweb: Refactor feed generation, make output prettier,
   add Atom  feed"
  commit-af6feeb229110a0fa77a179c2655fca08e72f879
gitweb can generate feeds (RSS or Atom) for history of a given branch,
history limited to a given directory, or history of a given file.
Nevertheless this required handcrafting the URL to get wanted RSS
feed.


The question is what feeds should be shown, both in <link .../> in page 
header, and in [Atom][RSS] links at the bottom of the page. Some things 
are fairly obvious:
 * projects list page has OPML feed (I'm open to suggestions for better
   format) with list of feeds, one "'summary' page" feed per project
 * 'summary' page has feed(s) starting from HEAD (default: no arguments)
 * 'tree' view should have link to feed of a history of a directory
 * 'blob' and 'blame' views should have link to feed of a history
    of file
 * 'log' and 'shortlog' views should have feed from a given commit
 * 'history' view should have link to feed of a history of pathspec

Some things needs some considerations:
 * should 'commit' and 'commitdiff' views have feed of log
   starting from given commit (positive commit in the case of diff)?
 * should 'treediff' and 'blobdiff' have feed of history of given
   directory or a file, starting from the 'to' version?

For some views it is hard to find a feed:
 * for 'forks' view we could have OPML feed limited to forks
   of a projects, like for projects list page
 * for 'heads' and 'tags' we could have OPML of log feeds for
   branches and tags
 * Should for 'tag' view if it points to a commit, have feed
   like for 'commit' view?
 * What should be (if there should be any) feed for 'search'
   page?

And there are also pesky details. Should we offer in HTML <head> also
no-merges and first-parent (and no-merges + first-parent) versions
of feeds? Should we offer also follow version of a history of a file
feed? For example for 'blob' view should we also offer full log feed,
not only limited to given path? Should we always offer full feed
staring from HEAD (default feed)?

Thanks in advance for comments and answers.
-- 
Jakub Narebski
Poland
