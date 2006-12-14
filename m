X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: Re: git-svnimport breakage as of git-1.4.4
Date: Thu, 14 Dec 2006 04:21:42 +0200
Message-ID: <20061214022142.GA14521@sashak.voltaire.com>
References: <1165505193.26874.13.camel@systems03.lan.brontes3d.com> <20061208203230.GA9193@sashak.voltaire.com> <1165847230.13854.2.camel@systems03.lan.brontes3d.com> <20061211204904.GC1003@sashak.voltaire.com> <1166027289.21948.4.camel@systems03.lan.brontes3d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 02:29:44 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 852 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 21:29:29 EST
Content-Disposition: inline
In-Reply-To: <1166027289.21948.4.camel@systems03.lan.brontes3d.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 14 Dec 2006 02:15:14.0541 (UTC) FILETIME=[B0E531D0:01C71F25]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34275>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GugLr-0003ZY-8S for gcvg-git@gmane.org; Thu, 14 Dec
 2006 03:29:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751920AbWLNC3b (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 21:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbWLNC3b
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 21:29:31 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:7337 "EHLO
 taurus.voltaire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751920AbWLNC3a (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 21:29:30 -0500
Received: from sashak ([172.25.5.176]) by taurus.voltaire.com with Microsoft
 SMTPSVC(6.0.3790.1830); Thu, 14 Dec 2006 04:15:14 +0200
Received: by sashak (sSMTP sendmail emulation); Thu, 14 Dec 2006 04:21:42
 +0200
To: Daniel Drake <ddrake@brontes3d.com>
Sender: git-owner@vger.kernel.org

On 11:28 Wed 13 Dec     , Daniel Drake wrote:
> 
> Sorry, apparently I was using the wrong git-svnimport in my last mail.
> The above command, with or without your svn_dir patch, doesn't solve the
> problem.
> 
> With your patch:

Original patch is wrong, so only w/out this patch.

> 
> # git-svnimport -v -i -C repo -r https://server/repo
> 
> RA layer request failed: PROPFIND request failed on '/trunk/.cvsignore':
> PROPFIND of '/trunk/.cvsignore': 405 Method Not Allowed (https://svn) at
> git-svnimport line 364
> 
> Without the patch, the error is the same as the 1st case in both
> situations.

Try this please:


diff --git a/git-svnimport.perl b/git-svnimport.perl
index cbaa8ab..071777b 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -146,6 +146,7 @@ sub file {
 	print "... $rev $path ...\n" if $opt_v;
 	my (undef, $properties);
 	my $pool = SVN::Pool->new();
+	$path =~ s#^/*##;
 	eval { (undef, $properties)
 		   = $self->{'svn'}->get_file($path,$rev,$fh,$pool); };
 	$pool->clear;
@@ -181,6 +182,7 @@ sub ignore {
 	my($self,$path,$rev) = @_;
 
 	print "... $rev $path ...\n" if $opt_v;
+	$path =~ s#^/*##;
 	my (undef,undef,$properties)
 	    = $self->{'svn'}->get_dir($path,$rev,undef);
 	if (exists $properties->{'svn:ignore'}) {
@@ -197,6 +199,7 @@ sub ignore {
 
 sub dir_list {
 	my($self,$path,$rev) = @_;
+	$path =~ s#^/*##;
 	my ($dirents,undef,$properties)
 	    = $self->{'svn'}->get_dir($path,$rev,undef);
 	return $dirents;
@@ -354,6 +357,7 @@ open BRANCHES,">>", "$git_dir/svn2git";
 sub node_kind($$) {
 	my ($svnpath, $revision) = @_;
 	my $pool=SVN::Pool->new;
+	$svnpath =~ s#^/*##;
 	my $kind = $svn->{'svn'}->check_path($svnpath,$revision,$pool);
 	$pool->clear;
 	return $kind;

Thanks,
