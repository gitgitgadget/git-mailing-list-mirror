X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 5/5] git-svn: re-map repository URLs and UUIDs on SVK mirror paths
Date: Tue, 5 Dec 2006 00:58:04 -0800
Message-ID: <20061205085804.GB27236@soma>
References: <20061205051738.16552.8987.stgit@localhost> <20061205051738.16552.22494.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 08:58:17 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061205051738.16552.22494.stgit@localhost>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33319>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrW7w-000622-UQ for gcvg-git@gmane.org; Tue, 05 Dec
 2006 09:58:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968111AbWLEI6J (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 03:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968110AbWLEI6J
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 03:58:09 -0500
Received: from hand.yhbt.net ([66.150.188.102]:43091 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S968111AbWLEI6G
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 03:58:06 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 0915A2DC034; Tue,  5 Dec 2006 00:58:05 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue,  5 Dec 2006
 00:58:04 -0800
To: Sam Vilain <sam@vilain.net>
Sender: git-owner@vger.kernel.org

Sam Vilain <sam@vilain.net> wrote:
> From: Sam Vilain <sam@vilain.net>
> 
> If an SVN revision has a property, "svm:headrev", it is likely that
> the revision was created by "svk sync".  The property contains a
> repository UUID and a revision.  We want to make it look like we are
> mirroring the original URL, so introduce a helper function that
> returns the original identity trio, and use it when generating commit
> messages and dummy e-mail domains.

Upon further review, this would make 'git svn rebuild' behave
unexpectedly (it would make the git-svn metadata, including .rev_db
entries point to the original repo and not the SVK one).  This may not
necessarily be a big deal, however.

Also, incremental fetches (or fetching more than 1k sequential
revisions) would probably fail.  To fix this, read the offset of last
entry in .rev_db instead of git-svn-id: from the last commit to get the
last revision.  But since rebuild won't work as expected; losing the
.rev_db file means you wouldn't be able to fetch from the SVK repo
anymore (but the original upstream one will be fine).

One last thing: feature should be made optional.  I actually work
day-to-day on a repository that was created with svm/SVN::Mirror,
the original repository no longer exists; but the mirrored one
still has these properties (I suppose I could remove the props
server-side, but some people may not have the permissions).

-- 
