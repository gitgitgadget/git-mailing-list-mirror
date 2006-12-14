X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: Re: git-svnimport breakage as of git-1.4.4
Date: Thu, 14 Dec 2006 04:25:49 +0200
Message-ID: <20061214022549.GB14521@sashak.voltaire.com>
References: <1165505193.26874.13.camel@systems03.lan.brontes3d.com> <20061208203230.GA9193@sashak.voltaire.com> <4b3406f0612091949qc75cb10x13f09e2017d71d91@mail.gmail.com> <20061210114735.GA11107@sashak.voltaire.com> <4b3406f0612111200o65352771r454d5ced0ac99f08@mail.gmail.com> <20061211205006.GD1003@sashak.voltaire.com> <4b3406f0612111301m302dfe3dm81b09a432e67163d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 02:29:43 +0000 (UTC)
Cc: Daniel Drake <ddrake@brontes3d.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 852 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 21:29:29 EST
Content-Disposition: inline
In-Reply-To: <4b3406f0612111301m302dfe3dm81b09a432e67163d@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 14 Dec 2006 02:19:21.0340 (UTC) FILETIME=[43FFBBC0:01C71F26]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34274>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GugLr-0003ZY-PB for gcvg-git@gmane.org; Thu, 14 Dec
 2006 03:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751916AbWLNC3a (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 21:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751919AbWLNC3a
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 21:29:30 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:7337 "EHLO
 taurus.voltaire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751916AbWLNC33 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 21:29:29 -0500
Received: from sashak ([172.25.5.176]) by taurus.voltaire.com with Microsoft
 SMTPSVC(6.0.3790.1830); Thu, 14 Dec 2006 04:19:21 +0200
Received: by sashak (sSMTP sendmail emulation); Thu, 14 Dec 2006 04:25:49
 +0200
To: Dongsheng Song <dongsheng.song@gmail.com>
Sender: git-owner@vger.kernel.org

On 05:01 Tue 12 Dec     , Dongsheng Song wrote:
> 
>    git-svnimport -v -i -r -o master -l $mr -C $WC_ROOT/$REPO_NAME
> http://tortoisesvn.tigris.org/svn/tortoisesvn

Thanks.

I'm running now git-svnimport against
http://tortoisesvn.tigris.org/svn/tortoisesvn with follow patch:


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


And it works up to now.

This is the same patch as recently posted to Daniel. Could you try?

