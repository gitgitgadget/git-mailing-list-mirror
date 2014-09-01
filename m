From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v8 1/4] cache-tree: Create/update cache-tree on checkou
Date: Mon, 1 Sep 2014 23:13:57 +0100
Message-ID: <20140901221357.GD1240@serenity.lan>
References: <1405140276-32162-1-git-send-email-dturner@twitter.com>
 <20140831120703.GA1240@serenity.lan>
 <1409604568.3057.8.camel@leckie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 00:14:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOZrm-0008Ru-5I
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 00:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763AbaIAWOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2014 18:14:12 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:50780 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbaIAWOI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2014 18:14:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id C0DB1CDA487;
	Mon,  1 Sep 2014 23:14:07 +0100 (BST)
X-Quarantine-ID: <R-r7FbU01oaP>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -0.2
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id R-r7FbU01oaP; Mon,  1 Sep 2014 23:14:07 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id DB14CCDA550;
	Mon,  1 Sep 2014 23:13:59 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1409604568.3057.8.camel@leckie>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256313>

On Mon, Sep 01, 2014 at 04:49:28PM -0400, David Turner wrote:
> On Sun, 2014-08-31 at 13:07 +0100, John Keeping wrote:
> > On Fri, Jul 11, 2014 at 09:44:33PM -0700, David Turner wrote:
> > > When git checkout checks out a branch, create or update the
> > > cache-tree so that subsequent operations are faster.
> > > 
> > > update_main_cache_tree learned a new flag, WRITE_TREE_REPAIR.  When
> > > WRITE_TREE_REPAIR is set, portions of the cache-tree which do not
> > > correspond to existing tree objects are invalidated (and portions which
> > > do are marked as valid).  No new tree objects are created.
> > > 
> > > Signed-off-by: David Turner <dturner@twitter.com>
> > > ---
> > 
> > This causes an incorrect error message to be printed when switching
> > branches with staged changes in a subdirectory.  The test case is pretty
> > simple:
> <snip>
> 
> I tried to reproduce this problem, but I could not.  I tried to
> reproduce against just this patch 1/4, and also against all 4 of the
> patches.  Can you reproduce this on Junio's 'next' branch, which
> includes this series of patches?
> 
> Do you have some sort of unusual configuration that might cause
> different results? 

I don't think so.  I wondered if "status.branch=true" in the config
could do it, but there's no difference turning that off.  The rest of
the config looks like this:

-- >8 --
core.excludesfile=~/.gitexcludes
push.default=upstream
color.ui=auto
[snip alias.*]
[snip user.*]
[snip url.*.insteadof]
[snip sendemail.*]
rebase.autosquash=true
mailinfo.scissors=true
format.thread=true
rerere.enabled=true
status.branch=true
pull.ff=true
credential.helper=cache
diff.tool=vimdiff
merge.tool=vimdiff
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
-- 8< --

The following script (run from the Git source directory) bisects down
to:

	aecf567cbfb6ab46e82f7f5df36fb6a2dd5bee69 is the first bad commit
	commit aecf567cbfb6ab46e82f7f5df36fb6a2dd5bee69
	Author: David Turner <dturner@twopensource.com>
	Date:   Sat Jul 5 21:06:56 2014 -0700

	    cache-tree: create/update cache-tree on checkout

-- >8 --
#!/bin/sh
git init test &&
(
	cd test &&
	mkdir sub &&
	echo one >sub/one &&
	git add sub/one &&
	git commit -m one &&
	echo two >sub/two &&
	git add sub/two &&
	git branch other
) &&
cat >BISECT.sh <<\EOF &&
#!/bin/sh
make -j4 &&
cd test &&
../bin-wrappers/git checkout other 2>&1 | grep 'error:'
result=$?
git checkout master
if test $result = 0
then
	exit 1
else
	exit 0
fi
EOF
chmod +x BISECT.sh &&
git bisect start origin/next origin/master &&
git bisect run ./BISECT.sh
