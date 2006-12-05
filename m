X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Theodore Tso <tytso@mit.edu>
Subject: Re: [RFC] Two conceptually distinct commit commands
Date: Mon, 4 Dec 2006 22:51:23 -0500
Message-ID: <20061205035123.GA8831@thunk.org>
References: <87d56z32e1.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 03:51:43 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <87d56z32e1.wl%cworth@cworth.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33294>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrRLF-0002Sk-4A for gcvg-git@gmane.org; Tue, 05 Dec
 2006 04:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968071AbWLEDv3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 22:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968072AbWLEDv3
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 22:51:29 -0500
Received: from thunk.org ([69.25.196.29]:36886 "EHLO thunker.thunk.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S968071AbWLEDv1
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 22:51:27 -0500
Received: from root (helo=candygram.thunk.org) by thunker.thunk.org with
 local-esmtps  (tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1
 (Debian)) id 1GrROm-0001C7-3j; Mon, 04 Dec 2006 22:55:16 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
 (envelope-from <tytso@thunk.org>) id 1GrRL2-0004ov-6e; Mon, 04 Dec 2006
 22:51:24 -0500
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

On Mon, Dec 04, 2006 at 11:08:22AM -0800, Carl Worth wrote:
>
> Here are the two commit commands I would like to see in git:
> 
>   commit-index-content [paths...]
> 
>     Commits the content of the index for the given paths, (or all
>     paths in the index). The index content can be manipulated with
>     "git add", "git rm", "git mv", and "git update-index".
> 
>   commit-working-tree-content [paths...]
> 
>     Commits the content of the working tree for the given paths, (or
>     all tracked paths). Untracked files can be committed for the first
>     time by specifying their names on the command-line or by using
>     "git add" to add them just prior to the commit. Any rename or
>     removal of a tracked file will be detected and committed
>     automatically.

I think this is a very interesting proposal, although I think I
disagree with the last part:

      Any [rename or] removal of a tracked file will be detected and
      committed automatically.

If adds aren't going done automatically (because otherwise you have
problems with foo.c~ accidentally getting checked it), then it's
non-symmetric to expect that deletes will also happen automatically.
It's relatively rare that files are removed or renamed, and sometimes
files accidentally disappear.  

So in the case where there are no pathnames given to "git
commit-working-tree-content", I would argue that it does not do any
implicit "git add" on new files NOR any implicit "git rm" on missing
files unless the user actually specifies an --implicit-add or
--implicit-delete option, respectively.  If users want to make
--implicit-add and/or --implicit-delete the default, that could be a
configuration option, but I don't think it should be a default.


A second issue which you left unspecified is what should
commit-working-tree-content do if the index != HEAD.  In particular,
in this case:

edit foo.c
git update-index
edit foo.c
git commit-working-tree-content foo.c

What should happen to foo.c in the index?  Should it be stay the same?
Should the contents be replaced with version of foo.c that has just
been commited?  The latter seems to make sense, but runs the risk of
losing the data (what was in the index).  The former has the downside
that the index might have a version of foo.c which is older than what
has been just commited, which could be confusing.  Or should git
commit-working-tree abort with an error message if index != HEAD?

