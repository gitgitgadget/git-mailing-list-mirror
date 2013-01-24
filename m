From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH v3 0/2] Make git-svn work with gitdir links
Date: Thu, 24 Jan 2013 10:14:17 +0000
Message-ID: <20130124101417.GA22138@dcvr.yhbt.net>
References: <20120308005103.GA27398@dcvr.yhbt.net>
 <1358731322-44600-1-git-send-email-barry.wardell@gmail.com>
 <20130123023235.GA24135@dcvr.yhbt.net>
 <7vehhbdu8y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Barry Wardell <barry.wardell@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 11:14:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyJpQ-0001MT-8B
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 11:14:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753104Ab3AXKOT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 05:14:19 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:36285 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752934Ab3AXKOR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 05:14:17 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B9481F6E1;
	Thu, 24 Jan 2013 10:14:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vehhbdu8y.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214424>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > diff --git a/git-svn.perl b/git-svn.perl
> > index c232798..e5bd292 100755
> > --- a/git-svn.perl
> > +++ b/git-svn.perl
> > @@ -332,11 +332,13 @@ if ($cmd && $cmd =~ /(?:clone|init|multi-init)$/) {
> >  		$ENV{GIT_DIR} = command_oneline([qw/rev-parse --git-dir/]);
> >  	} "Unable to find .git directory\n";
> >  	my $cdup = undef;
> > +	my $git_dir = delete $ENV{GIT_DIR};
> >  	git_cmd_try {
> >  		$cdup = command_oneline(qw/rev-parse --show-cdup/);
> >  		chomp $cdup if ($cdup);
> >  		$cdup = "." unless ($cdup && length $cdup);
> > -	} "Already at toplevel, but $ENV{GIT_DIR} not found\n";
> > +	} "Already at toplevel, but $git_dir not found\n";
> > +	$ENV{GIT_DIR} = $git_dir;
> >  	chdir $cdup or die "Unable to chdir up to '$cdup'\n";
> >  	$_repository = Git->repository(Repository => $ENV{GIT_DIR});
> >  }
> 
> This does not look quite right, though.
> 
> Can't the user have his own $GIT_DIR when this command is invoked?
> The first command_oneline() runs rev-parse with that environment and
> get the user specified value of GIT_DIR in $ENV{GIT_DIR}, but by
> doing a "delete" before running --show-cdup, you are not honoring
> that GIT_DIR (and GIT_WORK_TREE if exists) the user gave you.  You
> already used that GIT_DIR when you asked rev-parse --git-dir to find
> what the GIT_DIR value should be, so you would be operating with
> values of $git_dir and $cdup that you discovered in an inconsistent
> way, no?
> 
> Shouldn't it be more like this instead?
> 
> 	my ($git_dir, $cdup) = undef;
>         try {
> 		$git_dir = command_oneline(qw(rev-parse --git-dir));
> 	} "Unable to ...";
>         try {
> 		$cdup = command_oneline(qw(rev-parse --show-cdup));
> 		... tweak $cdup ...
> 	} "Unable to ...";
> 	if (defined $git_dir) { $ENV{GIT_DIR} = $git_dir; }
> 	chdir $cdup;

Thanks, I'll squash the following and push a new branch.  I don't
believe the (defined $git_dir) check is necessary since we already
checked for errors with git_cmd_try.

diff --git a/git-svn.perl b/git-svn.perl
index e5bd292..b46795f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -324,19 +324,18 @@ for (my $i = 0; $i < @ARGV; $i++) {
 	}
 };
 
 # make sure we're always running at the top-level working directory
 if ($cmd && $cmd =~ /(?:clone|init|multi-init)$/) {
 	$ENV{GIT_DIR} ||= ".git";
 } else {
+	my ($git_dir, $cdup);
 	git_cmd_try {
-		$ENV{GIT_DIR} = command_oneline([qw/rev-parse --git-dir/]);
+		$git_dir = command_oneline([qw/rev-parse --git-dir/]);
 	} "Unable to find .git directory\n";
-	my $cdup = undef;
-	my $git_dir = delete $ENV{GIT_DIR};
 	git_cmd_try {
 		$cdup = command_oneline(qw/rev-parse --show-cdup/);
 		chomp $cdup if ($cdup);
 		$cdup = "." unless ($cdup && length $cdup);
 	} "Already at toplevel, but $git_dir not found\n";
 	$ENV{GIT_DIR} = $git_dir;
 	chdir $cdup or die "Unable to chdir up to '$cdup'\n";

-- 
Eric Wong
