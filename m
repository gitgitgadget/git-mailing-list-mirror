From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2] difftool: fix dir-diff when file does not exist in
 working tree
Date: Fri, 17 May 2013 19:26:08 +0100
Message-ID: <20130517182608.GB27005@serenity.lan>
References: <de6690bea81de561747ca49893fbc77fa3eb8529.1368811736.git.john@keeping.me.uk>
 <7v38tlzdcv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kevin Bracey <kevin@bracey.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 17 20:26:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdPME-0000Tn-5p
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 20:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755099Ab3EQS0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 14:26:18 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:50229 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754823Ab3EQS0R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 14:26:17 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id ABBF2CDA5E7;
	Fri, 17 May 2013 19:26:16 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lcaWElwYPzIr; Fri, 17 May 2013 19:26:16 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id DFB83CDA60A;
	Fri, 17 May 2013 19:26:10 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7v38tlzdcv.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224728>

Commit 02c5631 (difftool --dir-diff: symlink all files matching the
working tree, 2013-03-14) does not handle the case where a file that is
being compared does not exist in the working tree.  Fix this by checking
for existence explicitly before running git-hash-object.

Reported-by: Kevin Bracey <kevin@bracey.fi>
Signed-off-by: John Keeping <john@keeping.me.uk>
---
On Fri, May 17, 2013 at 11:10:40AM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > Commit 02c5631 (difftool --dir-diff: symlink all files matching the
> > working tree, 2013-03-14) does not handle the case where a file that is
> > being compared does not exist in the working tree.  Fix this by checking
> > for existence explicitly before running git-hash-object.
> >
> > Reported-by: Kevin Bracey <kevin@bracey.fi>
> > Signed-off-by: John Keeping <john@keeping.me.uk>
> > ---
> > This fixes a regression in 1.8.3-rc0.
> >
> >  git-difftool.perl   | 9 ++++++++-
> >  t/t7800-difftool.sh | 7 +++++++
> >  2 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/git-difftool.perl b/git-difftool.perl
> > index 6780292..0a1cb0a 100755
> > --- a/git-difftool.perl
> > +++ b/git-difftool.perl
> > @@ -92,7 +92,14 @@ sub use_wt_file
> >  		return 0;
> >  	}
> >  
> > -	my $wt_sha1 = $repo->command_oneline('hash-object', "$workdir/$file");
> > +	my $wt_sha1;
> > +	if (-e "$workdir/$file") {
> > +		$wt_sha1 = $repo->command_oneline('hash-object', "$workdir/$file");
> > +	} else {
> > +		# If the file doesn't exist in the working tree, use something
> > +		# that cannot match a SHA-1.
> > +		$wt_sha1 = '';
> 
> Yuck.
> 
> "that cannot match" might be a good justification to say "this does
> not break the next line to set $use and forces it to false", but
> "when we return false in $use, the value of $wt_sha1 is not used"
> needs to be said to convince why this is a safe change.
> 
> But if $sha1 is $null_sha1, we do end up setting $use to true and
> the caller would stuff the empty $wt_sha1 to form:
> 
> 	$wtindex .= "$rmode \$dst_path\0";
> 
> Is that what we want to do here, or is it a "will never happen"
> condition?  If the latter, the reason need to be described in this
> comment (and in the log).

It can't ever happen because we only call this if the mode is non-zero
in which case the SHA-1 is only null if there are unstaged changes.

However, I think this revised version is much clearer.

 git-difftool.perl   | 6 ++++++
 t/t7800-difftool.sh | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/git-difftool.perl b/git-difftool.perl
index 6780292..8a75205 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -92,6 +92,12 @@ sub use_wt_file
 		return 0;
 	}
 
+	if (! -e "$workdir/$file") {
+		# If the file doesn't exist in the working tree, we cannot
+		# use it.
+		return (0, $null_sha1);
+	}
+
 	my $wt_sha1 = $repo->command_oneline('hash-object', "$workdir/$file");
 	my $use = ($sha1 eq $null_sha1) || ($sha1 eq $wt_sha1);
 	return ($use, $wt_sha1);
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index a6bd99e..d46f041 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -356,6 +356,13 @@ run_dir_diff_test 'difftool --dir-diff from subdirectory' '
 	)
 '
 
+run_dir_diff_test 'difftool --dir-diff when worktree file is missing' '
+	test_when_finished git reset --hard &&
+	rm file2 &&
+	git difftool --dir-diff $symlinks --extcmd ls branch master >output &&
+	grep file2 output
+'
+
 write_script .git/CHECK_SYMLINKS <<\EOF
 for f in file file2 sub/sub
 do
-- 
1.8.3.rc2.285.gfc18c2c
