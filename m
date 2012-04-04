From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add -p: skip conflicted paths
Date: Wed, 4 Apr 2012 05:46:18 -0400
Message-ID: <20120404094618.GA13870@sigill.intra.peff.net>
References: <7viphov839.fsf@alter.siamese.dyndns.org>
 <1332966017-6100-1-git-send-email-kusmabite@gmail.com>
 <7viphotng8.fsf@alter.siamese.dyndns.org>
 <7vaa30tmk9.fsf@alter.siamese.dyndns.org>
 <7v62dotltk.fsf@alter.siamese.dyndns.org>
 <20120329054558.GA27604@sigill.intra.peff.net>
 <CABPQNSY8gNPZTV77AjFbHn1HA9S=fw3NC+H8bCzZOPFyLg0nHQ@mail.gmail.com>
 <7v398mgfdu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: kusmabite@gmail.com, git@vger.kernel.org,
	matthieu.moy@grenoble-inp.fr, hellmuth@ira.uka.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 11:46:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFMnP-0002Uq-3q
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 11:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756156Ab2DDJqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 05:46:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45840
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754294Ab2DDJqU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 05:46:20 -0400
Received: (qmail 7185 invoked by uid 107); 4 Apr 2012 09:46:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 Apr 2012 05:46:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Apr 2012 05:46:18 -0400
Content-Disposition: inline
In-Reply-To: <7v398mgfdu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194690>

On Mon, Apr 02, 2012 at 11:25:33AM -0700, Junio C Hamano wrote:

> >> I like that we are down to a single ls-files invocation here. But can't
> >> we determine from the diff-files output whether an entry is unmerged. In
> >> my simple tests, I see that --numstat will show two lines for such an
> >> entry. Is that reliable?
> >
> > Nice. I've observed the same thing (although I've seen three entries,
> > not two). I don't know about the reliability, but I think it kind of
> > makes sense; one entry for both parents, and one for the unmerged
> > working-copy version.
> 
> Should I be dissappointed, or should I be happy for seeing "division of
> labor" working?

The latter. I suspected something similar when writing my original
message, but didn't think too hard about it. Thanks for clarifying.

I do still think it would be nicer to pass the information out to the
caller instead of just filtering. So combining the two patches, we have
something like:

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 2ee0908..0a83f56 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -292,7 +292,7 @@ sub get_empty_tree {
 # FILE_ADDDEL:	is it add/delete between index and file?
 
 sub list_modified {
-	my ($only) = @_;
+	my ($only, $note_unmerged) = @_;
 	my (%data, @return);
 	my ($add, $del, $adddel, $file);
 	my @tracked = ();
@@ -370,6 +370,18 @@ sub list_modified {
 		}
 	}
 
+	if ($note_unmerged) {
+		for (run_cmd_pipe(qw(git ls-files -u --), @ARGV)) {
+			chomp $_;
+			if (/^[0-7]+ [0-9a-f]{40} [0-3]	(.*)/) {
+				my $path = unquote_path($1);
+				if (exists($data{$path})) {
+					$data{$path}{UNMERGED} = 1;
+				}
+			}
+		}
+	}
+
 	for (sort keys %data) {
 		my $it = $data{$_};
 
@@ -1211,10 +1223,14 @@ sub apply_patch_for_checkout_commit {
 }
 
 sub patch_update_cmd {
-	my @all_mods = list_modified($patch_mode_flavour{FILTER});
+	my @all_mods = list_modified($patch_mode_flavour{FILTER}, 'note-unmerged');
 	my @mods = grep { !($_->{BINARY}) } @all_mods;
 	my @them;
 
+	print colored $error_color, "ignoring unmerged: $_->{VALUE}\n"
+		for grep { $_->{UNMERGED} } @mods;
+	@mods = grep { !$_->{UNMERGED} } @mods;
+
 	if (!@mods) {
 		if (@all_mods) {
 			print STDERR "Only binary files changed.\n";
