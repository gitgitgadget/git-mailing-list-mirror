X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sasha Khapyorsky <sashak@voltaire.com>
Subject: Re: git-svnimport breakage as of git-1.4.4
Date: Fri, 8 Dec 2006 22:32:30 +0200
Message-ID: <20061208203230.GA9193@sashak.voltaire.com>
References: <1165505193.26874.13.camel@systems03.lan.brontes3d.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 20:25:01 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <1165505193.26874.13.camel@systems03.lan.brontes3d.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-OriginalArrivalTime: 08 Dec 2006 20:24:44.0657 (UTC) FILETIME=[E60ACE10:01C71B06]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33737>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsmH7-000064-0v for gcvg-git@gmane.org; Fri, 08 Dec
 2006 21:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1947211AbWLHUYt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 15:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947213AbWLHUYt
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 15:24:49 -0500
Received: from taurus.voltaire.com ([193.47.165.240]:23480 "EHLO
 taurus.voltaire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1947211AbWLHUYt (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 15:24:49 -0500
Received: from sashak ([172.25.5.176]) by taurus.voltaire.com with Microsoft
 SMTPSVC(6.0.3790.1830); Fri, 8 Dec 2006 22:24:44 +0200
Received: by sashak (sSMTP sendmail emulation); Fri,  8 Dec 2006 22:32:30
 +0200
To: Daniel Drake <ddrake@brontes3d.com>
Sender: git-owner@vger.kernel.org

Hi,

On 10:26 Thu 07 Dec     , Daniel Drake wrote:
> 
> git-svnimport broken between git-1.4.3.5 and git-1.4.4
> 
> I have found that commit 83936a29e275bc0c04f60d3333e4951a9e16b1fc is the
> cause of this.
> 
> I am using git-svnimport to work with a repo with this layout:
> 
> https://server/repo/trunk
> https://server/repo/tags/x.y.z
> https://server/repo/branches/somebranch
> 
> Starting a fresh import:
> 
> # git-svnimport -v -i -C repo -r https://server repo

Is this 'server' public? Can I rerun this git-svnimport?

If not, please try the patch:


diff --git a/git-svnimport.perl b/git-svnimport.perl
index cbaa8ab..b9de446 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -210,6 +210,12 @@ $svn .= "/$svn_dir" if defined $svn_dir;
 my $svn2 = SVNconn->new($svn);
 $svn = SVNconn->new($svn);
 
+if($svn_dir) {
+	$svn_dir =~ s#/*$#/#;
+} else {
+	$svn_dir = "";
+}
+
 my $lwp_ua;
 if($opt_d or $opt_D) {
 	$svn_url = URI->new($svn_url)->canonical;
@@ -906,7 +912,7 @@ sub commit_all {
 	my ($changed_paths, $revision, $author, $date, $message, $pool) = @_;
 	my %p;
 	while(my($path,$action) = each %$changed_paths) {
-		$p{$path} = [ $action->action,$action->copyfrom_path, $action->copyfrom_rev, $path ];
+		$p{$path} = [ $action->action,$svn_dir$action->copyfrom_path, $action->copyfrom_rev, $svn_dir$path ];
 	}
 	$changed_paths = \%p;
 

Thanks,
