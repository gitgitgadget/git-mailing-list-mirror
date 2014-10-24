From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: reload RA every log-window-size
Date: Fri, 24 Oct 2014 22:53:52 +0000
Message-ID: <20141024225352.GB31716@dcvr.yhbt.net>
References: <20141021033912.GA27462@dcvr.yhbt.net>
 <20141024225012.GA31716@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 25 00:53:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xhnk5-0003tn-Nd
	for gcvg-git-2@plane.gmane.org; Sat, 25 Oct 2014 00:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbaJXWxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2014 18:53:54 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:36107 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754541AbaJXWxx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2014 18:53:53 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1809F1FB0B;
	Fri, 24 Oct 2014 22:53:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20141024225012.GA31716@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Despite attempting to use local memory pools everywhere we can,
(including our call to SVN::Ra::do_update and all subsequent reporter
calls), there does not appear to be a way to force the Git::SVN::Fetcher
callbacks to use a pool other than the per-SVN::Ra pool.
Git::SVN::Fetcher ends up using the main RA pool which grows
monotonically in size for the lifetime of the RA object.

Thus the only way to free that memory appears to be to destroy and
recreate the RA connection for at every --log-window-size interval.

This reduces memory usage over the course of fetching 10K revisions
using a test repository created with the script at the end of this
commit message.

As reported by time(1) on my x86-64 system:

	before: 54024k
	 after: 28680k

Unfortunately, there remains some yet-to-be-tracked-down slow memory
growth which would be evident as the `nr' parameter increases in
the repository generation script:
-----------------------------8<------------------------------
set -e
tmp=$(mktemp -d svntestrepo-XXXXXXXX)
svnadmin create "$tmp"
repo=file://"$(cd $tmp && pwd)"
svn co "$repo" "$tmp/wd"
cd "$tmp/wd"
if ! test -f a
then
	> a
	svn add a
	svn commit -m 'A'
fi

nr=10000
while test $nr -gt 0
do
	echo $nr > a
	svn commit -q -m A
	nr=$((nr - 1))
done
echo "repository created in $repo"
-----------------------------8<------------------------------

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
  Eric Wong <normalperson@yhbt.net> wrote:
  > Eric Wong <normalperson@yhbt.net> wrote:
  > > +				SVN::Core->gpool->clear;
  > 
  > Unfortunately, SVN::Core->gpool is not available in older SVN,
  > but I'm cooking a better patch which saves even more memory.

 perl/Git/SVN/Ra.pm | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
index a7b0119..1828519 100644
--- a/perl/Git/SVN/Ra.pm
+++ b/perl/Git/SVN/Ra.pm
@@ -376,10 +376,19 @@ sub longest_common_path {
 sub gs_fetch_loop_common {
 	my ($self, $base, $head, $gsv, $globs) = @_;
 	return if ($base > $head);
+	my $gpool = SVN::Pool->new_default;
+	my $ra_url = $self->url;
+	my $reload_ra = sub {
+		$_[0] = undef;
+		$self = undef;
+		$RA = undef;
+		$gpool->clear;
+		$self = Git::SVN::Ra->new($ra_url);
+		$ra_invalid = undef;
+	};
 	my $inc = $_log_window_size;
 	my ($min, $max) = ($base, $head < $base + $inc ? $head : $base + $inc);
 	my $longest_path = longest_common_path($gsv, $globs);
-	my $ra_url = $self->url;
 	my $find_trailing_edge;
 	while (1) {
 		my %revs;
@@ -449,13 +458,7 @@ sub gs_fetch_loop_common {
 				        "$g->{t}-maxRev";
 				Git::SVN::tmp_config($k, $r);
 			}
-			if ($ra_invalid) {
-				$_[0] = undef;
-				$self = undef;
-				$RA = undef;
-				$self = Git::SVN::Ra->new($ra_url);
-				$ra_invalid = undef;
-			}
+			$reload_ra->() if $ra_invalid;
 		}
 		# pre-fill the .rev_db since it'll eventually get filled in
 		# with '0' x40 if something new gets committed
@@ -472,6 +475,8 @@ sub gs_fetch_loop_common {
 		$min = $max + 1;
 		$max += $inc;
 		$max = $head if ($max > $head);
+
+		$reload_ra->();
 	}
 	Git::SVN::gc();
 }
-- 
EW
