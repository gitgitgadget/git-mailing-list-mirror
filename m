From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 2/3] t7800: fix tests when difftool uses --no-symlinks
Date: Fri, 22 Mar 2013 23:05:16 +0000
Message-ID: <20130322230516.GK2283@serenity.lan>
References: <20130322115352.GI2283@serenity.lan>
 <cover.1363980749.git.john@keeping.me.uk>
 <cover.1363980749.git.john@keeping.me.uk>
 <5fc134f6c4a88232c78240539084e9d35db3a6cb.1363980749.git.john@keeping.me.uk>
 <7v8v5f59n1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 23 00:05:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJB25-0004Ea-AG
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 00:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423493Ab3CVXFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 19:05:30 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:51639 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423377Ab3CVXF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 19:05:29 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id B20596064E2;
	Fri, 22 Mar 2013 23:05:28 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -10.999
X-Spam-Level: 
X-Spam-Status: No, score=-10.999 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W96uOLxsDBnd; Fri, 22 Mar 2013 23:05:27 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 96644606508;
	Fri, 22 Mar 2013 23:05:18 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7v8v5f59n1.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218865>

On Fri, Mar 22, 2013 at 03:53:38PM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > When 'git difftool --dir-diff' is using --no-symlinks (either explicitly
> > or implicitly because it's running on Windows), any working tree files
> > that have been copied to the temporary directory are copied back after
> > the difftool completes.  This includes untracked files in the working
> > tree.
> 
> Hmph.  Why do we populate the temporary directory with a copy of an
> untracked path in the first place?  I thought the point of dir-diff
> was to materialize only the relevant paths to two temporaries and
> compare these temporaries with a tool that knows how to compare two
> directories?
> 
> Even if you had path F in HEAD that you are no longer tracking in
> the working tree, a normal
> 
> 	$ git diff HEAD
> 
> would report the path F to have been deleted, so I would imagine
> that the preimage side of the temporary directory should get a copy
> of HEAD:F at path F, while the postimage side of the temporary
> directory should not even have anything at path F, when dir-diff
> runs, no?
> 
> Isn't that the real reason why the test fails?  The path 'output' is
> not being tracked at any revision or in the index that is involved
> in the test, is it?

Actually it is, which is what I missed earlier.

A couple of tests before this 'setup change in subdirectory' does 'git
add .' which is far more general than it needs.  Perhaps this is a
better change:

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index bba8a9d..561c993 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -314,7 +314,7 @@ test_expect_success PERL 'setup change in subdirectory' '
 	git commit -m "added sub/sub" &&
 	echo test >>file &&
 	echo test >>sub/sub &&
-	git add . &&
+	git add file sub/sub &&
 	git commit -m "modified both"
 '
 

> > During the tests, this means that the following sequence occurs:
> >
> > 1) the shell opens "output" to redirect the difftool output
> > 2) difftool copies the empty "output" to the temporary directory
> > 3) difftool runs "ls" which writes to "output"
> > 4) difftool copies the empty "output" file back over the output of the
> >    command
> > 5) the output files doesn't contain the expected output, causing the
> >    test to fail
> >
> > Avoid this by writing the output into .git/ which will not be copied or
> > overwritten.
> 
> It is a good idea to move these test output and expect test vectore
> files to a different place to make it easier to distinguish them
> from test input (e.g. "sub", "file", etc.) in general, but the
> description of the original problem sounds like it is just working
> around a bug to me.  What am I missing?

I think there is a bug, as described in the paragraph below, and this
test should be made independent of that.  In light of the above I think
we can drop this patch and do this with that change instead.

> > In the longer term, difftool probably needs to learn to warn the user
> > instead of overwrite any changes that have been made to the working tree
> > file.
> >
> > Signed-off-by: John Keeping <john@keeping.me.uk>
> > ---
> >  t/t7800-difftool.sh | 24 ++++++++++++------------
> >  1 file changed, 12 insertions(+), 12 deletions(-)
> >
> > diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> > index e694972..1eed439 100755
> > --- a/t/t7800-difftool.sh
> > +++ b/t/t7800-difftool.sh
> > @@ -319,29 +319,29 @@ test_expect_success PERL 'setup change in subdirectory' '
> >  '
> >  
> >  test_expect_success PERL 'difftool -d' '
> > -	git difftool -d --extcmd ls branch >output &&
> > -	grep sub output &&
> > -	grep file output
> > +	git difftool -d --extcmd ls branch >.git/output &&
> > +	grep sub .git/output &&
> > +	grep file .git/output
> >  '
> >  
> >  test_expect_success PERL 'difftool --dir-diff' '
> > -	git difftool --dir-diff --extcmd ls branch >output &&
> > -	grep sub output &&
> > -	grep file output
> > +	git difftool --dir-diff --extcmd ls branch >.git/output &&
> > +	grep sub .git/output &&
> > +	grep file .git/output
> >  '
> >  
> >  test_expect_success PERL 'difftool --dir-diff ignores --prompt' '
> > -	git difftool --dir-diff --prompt --extcmd ls branch >output &&
> > -	grep sub output &&
> > -	grep file output
> > +	git difftool --dir-diff --prompt --extcmd ls branch >.git/output &&
> > +	grep sub .git/output &&
> > +	grep file .git/output
> >  '
> >  
> >  test_expect_success PERL 'difftool --dir-diff from subdirectory' '
> >  	(
> >  		cd sub &&
> > -		git difftool --dir-diff --extcmd ls branch >output &&
> > -		grep sub output &&
> > -		grep file output
> > +		git difftool --dir-diff --extcmd ls branch >../.git/output &&
> > +		grep sub ../.git/output &&
> > +		grep file ../.git/output
> >  	)
> >  '
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
