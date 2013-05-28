From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH v2] difftool --dir-diff: always use identical working
 tree file
Date: Tue, 28 May 2013 19:15:25 +0100
Message-ID: <20130528181525.GA17475@serenity.lan>
References: <20130526154429.GK27005@serenity.lan>
 <1369668697-1016-1-git-send-email-nitoyon@gmail.com>
 <7vbo7v0yju.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kenichi Saita <nitoyon@gmail.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 28 20:15:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhOQx-00064H-Ok
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 20:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982Ab3E1SPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 14:15:39 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:43788 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964914Ab3E1SPi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 14:15:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 255E16064CB;
	Tue, 28 May 2013 19:15:38 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WeVAAixOYi-1; Tue, 28 May 2013 19:15:37 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id D352E6064DD;
	Tue, 28 May 2013 19:15:31 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vbo7v0yju.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225679>

On Tue, May 28, 2013 at 11:06:13AM -0700, Junio C Hamano wrote:
> Kenichi Saita <nitoyon@gmail.com> writes:
> 
> > When deciding whether or not we should link a working tree file into
> > the temporary right-hand directory for a directory diff, we
> > currently behave differently in the --symlink and --no-symlink
> > cases.  If using symlinks any identical files are linked across but
> > with --no-symlink only files that contain unstaged changes are
> > copied back into the working tree.
> 
> I may have missed an earlier discussion, but I do not follow the
> last sentence.  The former part (i.e. symlinks) talks about what is
> done to populate the temporary tree (i.e. everything is linked), but
> the latter part (i.e. not symlinks) only talks about what is copied
> back, i.e. it is not a contrast between the behaviour of symlink vs
> no-symlink case wrt how the temporary tree is populated.
> 
> Confused...

Yeah, the commit message is still quite focused on the end effect of
copying files back.  But that's not what's being changed here.

In my suggested commit message I tried to make it clear that we're
changing when we decide to copy a file across to the temporary tree.
This has the beneficial (side-)effect of changing the set of files we
consider for copying back into the working tree after the diff tool has
been run.

> > Change this so that identical files are copied back as well.  This
> > is beneficial because it widens the set of circumstances in which we
> > copy changes made by the user back into the working tree.
> 
> Ah, OK, you meant that the set of files we keep in @working_tree
> array for later copying back are different between the two.
> 
> > Signed-off-by: Kenichi Saita <nitoyon@gmail.com>
> > ---
> >  git-difftool.perl   |    9 ++-------
> >  t/t7800-difftool.sh |   19 +++++++++++++++++++
> >  2 files changed, 21 insertions(+), 7 deletions(-)
> >
> > diff --git a/git-difftool.perl b/git-difftool.perl
> > index 8a75205..e57d3d1 100755
> > --- a/git-difftool.perl
> > +++ b/git-difftool.perl
> > @@ -85,13 +85,9 @@ sub exit_cleanup
> >  
> >  sub use_wt_file
> >  {
> > -	my ($repo, $workdir, $file, $sha1, $symlinks) = @_;
> > +	my ($repo, $workdir, $file, $sha1) = @_;
> >  	my $null_sha1 = '0' x 40;
> >  
> > -	if ($sha1 ne $null_sha1 and not $symlinks) {
> > -		return 0;
> > -	}
> > -
> >  	if (! -e "$workdir/$file") {
> >  		# If the file doesn't exist in the working tree, we cannot
> >  		# use it.
> > @@ -213,8 +209,7 @@ EOF
> >  
> >  		if ($rmode ne $null_mode) {
> >  			my ($use, $wt_sha1) = use_wt_file($repo, $workdir,
> > -							  $dst_path, $rsha1,
> > -							  $symlinks);
> > +							  $dst_path, $rsha1);
> >  			if ($use) {
> >  				push @working_tree, $dst_path;
> >  				$wtindex .= "$rmode $wt_sha1\t$dst_path\0";
> > diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
> > index d46f041..2418528 100755
> > --- a/t/t7800-difftool.sh
> > +++ b/t/t7800-difftool.sh
> > @@ -385,6 +385,25 @@ test_expect_success PERL,SYMLINKS 'difftool --dir-diff --symlink without unstage
> >  	test_cmp actual expect
> >  '
> >  
> > +write_script modify-right-file <<\EOF
> > +echo "new content" >"$2/file"
> > +EOF
> > +
> > +run_dir_diff_test 'difftool --dir-diff syncs worktree with unstaged change' '
> > +	test_when_finished git reset --hard &&
> > +	echo "orig content" >file &&
> > +	git difftool -d $symlinks --extcmd "$(pwd)/modify-right-file" branch &&
> > +	echo "new content" >expect &&
> > +	test_cmp expect file
> > +'
> > +
> > +run_dir_diff_test 'difftool --dir-diff syncs worktree without unstaged change' '
> > +	test_when_finished git reset --hard &&
> > +	git difftool -d $symlinks --extcmd "$(pwd)/modify-right-file" branch &&
> > +	echo "new content" >expect &&
> > +	test_cmp expect file
> > +'
> > +
> >  write_script modify-file <<\EOF
> >  echo "new content" >file
> >  EOF
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
