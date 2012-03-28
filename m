From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add -p: skip conflicted paths
Date: Wed, 28 Mar 2012 15:14:31 -0700
Message-ID: <7v62dotltk.fsf@alter.siamese.dyndns.org>
References: <7viphov839.fsf@alter.siamese.dyndns.org>
 <1332966017-6100-1-git-send-email-kusmabite@gmail.com>
 <7viphotng8.fsf@alter.siamese.dyndns.org>
 <7vaa30tmk9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, matthieu.moy@grenoble-inp.fr,
	hellmuth@ira.uka.de
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 00:14:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD18a-0005pb-1U
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 00:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758752Ab2C1WOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 18:14:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43340 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758083Ab2C1WOe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 18:14:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCEA67901;
	Wed, 28 Mar 2012 18:14:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Zx825Bpcn1bAmzpRVuxczm0tuTE=; b=gXLYcU
	lkc2EvT558y++wyMFT497Y3Rauijb/lAwnPr3oeuAZctUsLlvvLQJGBAYCM2gyNC
	7Ej5oxWFCIQwPMZnLAgJ2PLdxvF8j6lCdnGtlih5kvpg8lnxx2EbmwMY58G8U7rA
	Zn6XRdMrDEQwvpLy3nIU9X9ZEpaXiSVNkHnOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ij0rbf3dchbiIDZvKowJgPkVX/mVlWrz
	1KuDBJb3UVnwPzYO/Bj9q+ckfwxOD+eSXbjv6pIBeiV/R1nTX9wTKzBPYymY3IXN
	aPPsF5blaCpkhl5EY6FWQ5LNCrxPWMC/RYJCeo0YhthX2XsTi3PMZejXXHZci89m
	LYD3DQiktLs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C04E87900;
	Wed, 28 Mar 2012 18:14:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 23B3E78FF; Wed, 28 Mar 2012
 18:14:33 -0400 (EDT)
In-Reply-To: <7vaa30tmk9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 28 Mar 2012 14:58:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6580A838-7923-11E1-879A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194209>

Junio C Hamano <gitster@pobox.com> writes:

>> Totally untested, but something along this line...
>
> Well, probably along that line but not there.  I think the patch would be
> a lot cleaner to keep the part I touched intact, and instead add an extra
> "ls-files -u" that creates %unmerged hash in the way this patch does,
> immediately before the last for() loop in the function.  And then the loop
> can use %unmerged hash to filter the elements.

That is, something like this.

 git-add--interactive.perl |   23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 8f0839d..ddb2e77 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -270,7 +270,7 @@ sub get_empty_tree {
 # FILE_ADDDEL:	is it add/delete between index and file?
 
 sub list_modified {
-	my ($only) = @_;
+	my ($only, $filter_unmerged) = @_;
 	my (%data, @return);
 	my ($add, $del, $adddel, $file);
 	my @tracked = ();
@@ -348,9 +348,26 @@ sub list_modified {
 		}
 	}
 
+	my %unmerged;
+	if ($filter_unmerged) {
+		for (run_cmd_pipe(qw(git ls-files -u --), @ARGV)) {
+			chomp $_;
+			if (/^[0-7]+ [0-9a-f]{40} [0-3]	(.*)/) {
+				my $path = unquote_path($1);
+				$unmerged{$path} = 1;
+			}
+		}
+		if (%unmerged) {
+			for (sort keys %unmerged) {
+				print colored $error_color, "ignoring unmerged: $_\n";
+			}
+		}
+	}
+
 	for (sort keys %data) {
-		my $it = $data{$_};
+		next if exists $unmerged{$_};
 
+		my $it = $data{$_};
 		if ($only) {
 			if ($only eq 'index-only') {
 				next if ($it->{INDEX} eq 'unchanged');
@@ -1189,7 +1206,7 @@ sub apply_patch_for_checkout_commit {
 }
 
 sub patch_update_cmd {
-	my @all_mods = list_modified($patch_mode_flavour{FILTER});
+	my @all_mods = list_modified($patch_mode_flavour{FILTER}, 'filter-unmerged');
 	my @mods = grep { !($_->{BINARY}) } @all_mods;
 	my @them;
 
