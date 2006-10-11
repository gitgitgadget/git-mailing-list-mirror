From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn fetch fails when a file is renamed changing only case
Date: Wed, 11 Oct 2006 10:42:20 -0700
Message-ID: <20061011174220.GA32013@soma>
References: <ege016$vrb$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 11 19:42:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXi5Q-00069o-7I
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 19:41:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161168AbWJKRll (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Oct 2006 13:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161169AbWJKRll
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Oct 2006 13:41:41 -0400
Received: from hand.yhbt.net ([66.150.188.102]:7563 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1161168AbWJKRlk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Oct 2006 13:41:40 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 6B04C7DC08E;
	Wed, 11 Oct 2006 10:41:38 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 11 Oct 2006 10:42:20 -0700
To: Pazu <pazu@pazu.com.br>
Content-Disposition: inline
In-Reply-To: <ege016$vrb$1@sea.gmane.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28729>

Pazu <pazu@pazu.com.br> wrote:
> For example, if you had a file named TestFile and it's renamed to 
> TESTFILE, git-svn fails to fetch revisions after the rename.
> 
> My perl skills are close to non-existant, so I'm afraid I don't know how 
> to fix this. Attached to this message, however, is a sample svn 
> repository that can reproduce this bug. Just unpack it somewhere (let's 
> say, in /tmp) and try the following:
> 
> tar -C /tmp -xzf git-svn-rename-test.tar.gz
> mkdir test-wc
> cd test-wc
> git-svn init file:///tmp/git-svn-rename-test
> git-svn fetch
> 
> The last command will fail after fetching revision #3, where a file 
> named TestFile was renamed to TESTFILE. Here's the stack trace:
> 
> svn: 'TestFile' is not under version control
> 256 at /Users/pazu/bin/git-svn line 2015
>         main::safe_qx('svn', 'propget', 'svn:keywords', 
> 'TestFile@BASE') called at /Users/pazu/bin/git-svn line 2154
>         main::svn_propget_base('svn:keywords', 'TestFile') called at 
> /Users/pazu/bin/git-svn line 1773
>         main::do_update_index('ARRAY(0x180bd68)', 'remove', 'undef') 
> called at /Users/pazu/bin/git-svn line 1805
>         main::index_changes() called at /Users/pazu/bin/git-svn line 1875
>         main::git_commit('HASH(0x180bd98)', 
> 'c77db38dc752305ba19ebe19b22306551d0f8d52') called at 
> /Users/pazu/bin/git-svn line 346
>         main::fetch_cmd() called at /Users/pazu/bin/git-svn line 290
>         main::fetch() called at /Users/pazu/bin/git-svn line 149
 
> I'm on Mac OS X (Intel) 10.4.8

Ah, the problem is that git-svn relies on git-diff-files and
git-ls-files to track changes when using the command-line svn client.
git itself is a case-sensitive file-system, but git-svn relies on the
working tree if you didn't have the SVN libraries, and successfully
stats the 'TestFile' even though it no longer exists (and is replaced
by 'TESTFILE').

Good to know that the SVN:: libraries are working for you, though.

-- 
Eric Wong
