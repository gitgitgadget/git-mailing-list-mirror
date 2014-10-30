From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Regression and failure to clone/fetch with new code Re: git-svn
 performance
Date: Thu, 30 Oct 2014 08:46:19 +0000
Message-ID: <20141030084619.GA12697@dcvr.yhbt.net>
References: <20141030002801.GB31920@dcvr.yhbt.net>
 <1414636504.45506.YahooMailBasic@web172304.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: stoklund@2pi.dk, fabian.schmied@gmail.com, git@vger.kernel.org,
	sam@vilain.net, stevenrwalter@gmail.com, waste.manager@gmx.de,
	amyrick@apple.com
To: Hin-Tak Leung <htl10@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Oct 30 09:46:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjlNB-0001Kk-LM
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 09:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758072AbaJ3IqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 04:46:21 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59073 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753575AbaJ3IqT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 04:46:19 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4147F1F7C9;
	Thu, 30 Oct 2014 08:46:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1414636504.45506.YahooMailBasic@web172304.mail.ir2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hin-Tak Leung <htl10@users.sourceforge.net> wrote:
> Here is the data dumper info . I tried the dumper code on the R repo
> as well, and saw that against the virtual box repo, there is one 
> curious difference - $self->{last_rev} is a string rather than a number.
> I tried hacking around doing "$x += 0;" to coerce last_rev
> to a number at various places but didn't get very far. There seems to be some caching
> code in RA->get_dir so presumably that's why the same code run
> on one repo gives it as string while on another gives it a number. Hope
> you can figure where the coersion to string happened.

Thanks, I'm not able to reproduce the issue, but can you try the
following?

diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index 75cdac9..82d6108 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -153,6 +153,7 @@ sub url {
 sub check_path {
 	my ($self, $path, $r) = @_;
 	my $cache = $self->{cache}->{check_path};
+	$r = int($r);
 	if ($r == $cache->{r} && exists $cache->{data}->{$path}) {
 		return $cache->{data}->{$path};
 	}
@@ -169,6 +170,7 @@ sub check_path {
 sub get_dir {
 	my ($self, $dir, $r) = @_;
 	my $cache = $self->{cache}->{get_dir};
+	$r = int($r);
 	if ($r == $cache->{r}) {
 		if (my $x = $cache->{data}->{$dir}) {
 			return wantarray ? @$x : $x->[0];
---
The above should apply to my current master which has some
minor cleanups (which I hope to send to Junio tomorrow).

The following changes since commit fbecd99861ea5795aeba46faf2ac7a8c1b70d485:

  Update draft release notes to 2.2 (2014-10-24 15:02:17 -0700)

are available in the git repository at:

  git://bogomips.org/git-svn.git master

for you to fetch changes up to da0bc948ac2e01652a150fd4a57cebad6143242c:

  git-svn: add space after "W:" prefix in warning (2014-10-30 08:31:28 +0000)

----------------------------------------------------------------
Eric Wong (11):
      git-svn: reduce check_cherry_pick cache overhead
      git-svn: cache only mergeinfo revisions
      git-svn: remove mergeinfo rev caching
      git-svn: reload RA every log-window-size
      git-svn: remove unnecessary DESTROY override
      git-svn: save a little memory as fetch progresses
      git-svn: disable _rev_list memoization
      Git.pm: add specified name to tempfile template
      git-svn: prepare SVN::Ra config pieces once
      git-svn: (cleanup) remove editor param passing
      git-svn: add space after "W:" prefix in warning

Jakob Stoklund Olesen (2):
      git-svn: only look at the new parts of svn:mergeinfo
      git-svn: only look at the root path for svn:mergeinfo

Sveinung Kvilhaugsvik (1):
      git-svn.txt: advertise pushurl with dcommit

 Documentation/git-svn.txt |   4 ++
 perl/Git.pm               |   5 +-
 perl/Git/SVN.pm           | 125 ++++++++++++++++++++++++++++------------------
 perl/Git/SVN/Ra.pm        |  90 ++++++++++++++++++---------------
 4 files changed, 134 insertions(+), 90 deletions(-)
