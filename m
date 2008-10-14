From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Puzzled by a t9500 test failure
Date: Mon, 13 Oct 2008 17:08:12 -0700
Message-ID: <20081014000812.GZ4856@spearce.org>
References: <7vljws83nd.fsf@gitster.siamese.dyndns.org> <20081013234851.GY4856@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 02:09:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpXTe-0006wE-Ae
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 02:09:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757932AbYJNAIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 20:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757810AbYJNAIO
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 20:08:14 -0400
Received: from george.spearce.org ([209.20.77.23]:52598 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756903AbYJNAIN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 20:08:13 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id CEC0F3835F; Tue, 14 Oct 2008 00:08:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20081013234851.GY4856@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98166>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Junio C Hamano <gitster@pobox.com> wrote:
> > With recent tip of 'master':
> > 
> >     $ make
> >     $ mkdir t/trash
> >     $ cd t && sh t9500-*.sh -i
> > 
> > fails at the very first test.  Can anybody figure out why?
> 
> Hmmph.  Near as I can tell its because gitweb.log has this in it:
> 
> $ cat gitweb.log
> [Mon Oct 13 23:43:36 2008] gitweb.perl: Use of uninitialized value in scalar chomp at /home/sop/local/maint-git/t/../gitweb/gitweb.perl line 1811.
> [Mon Oct 13 23:43:36 2008] gitweb.perl: Use of uninitialized value in addition (+) at /home/sop/local/maint-git/t/../gitweb/gitweb.perl line 3772.
> HASH..

bisect says its aed93de428d7d12ee23d84d27265af1e37eb348f,
"gitweb: Support for tag clouds".

This appears to fix it.  As for how I missed this, I do not know.
I usually tested topic branches pretty heavily before merging them
to next, and I tested both master and next daily.  So I thought
the topic was ready to merge into master.  Apparently it was not.
How I missed the failed merge, I don't know. :-\

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1116800..793166e 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1808,7 +1808,7 @@ sub git_get_project_ctags {
 	foreach (<$git_dir/ctags/*>) {
 		open CT, $_ or next;
 		my $val = <CT>;
-		chomp $val;
+		chomp $val if defined $val;
 		close CT;
 		my $ctag = $_; $ctag =~ s#.*/##;
 		$ctags->{$ctag} = $val;
@@ -1822,7 +1822,11 @@ sub git_populate_project_tagcloud {
 	# First, merge different-cased tags; tags vote on casing
 	my %ctags_lc;
 	foreach (keys %$ctags) {
-		$ctags_lc{lc $_}->{count} += $ctags->{$_};
+		if (defined ($ctags_lc{lc $_}->{count})) {
+			$ctags_lc{lc $_}->{count} += $ctags->{$_};
+		} else {
+			$ctags_lc{lc $_}->{count} = $ctags->{$_};
+		}
 		if (not $ctags_lc{lc $_}->{topcount}
 		    or $ctags_lc{lc $_}->{topcount} < $ctags->{$_}) {
 			$ctags_lc{lc $_}->{topcount} = $ctags->{$_};
@@ -3769,7 +3773,11 @@ sub git_project_list_body {
 		my %ctags;
 		foreach my $p (@projects) {
 			foreach my $ct (keys %{$p->{'ctags'}}) {
-				$ctags{$ct} += $p->{'ctags'}->{$ct};
+				if (defined $ctags{$ct}) {
+					$ctags{$ct} += $p->{'ctags'}->{$ct};
+				} else {
+					$ctags{$ct} = $p->{'ctags'}->{$ct};
+				}
 			}
 		}
 		my $cloud = git_populate_project_tagcloud(\%ctags);

-- 
Shawn.
