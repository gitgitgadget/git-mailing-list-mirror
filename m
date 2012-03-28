From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add -p: skip conflicted paths
Date: Wed, 28 Mar 2012 14:39:19 -0700
Message-ID: <7viphotng8.fsf@alter.siamese.dyndns.org>
References: <7viphov839.fsf@alter.siamese.dyndns.org>
 <1332966017-6100-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, matthieu.moy@grenoble-inp.fr,
	hellmuth@ira.uka.de
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 23:39:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD0aW-0005cu-16
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 23:39:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933153Ab2C1VjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 17:39:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61576 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932293Ab2C1VjW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 17:39:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9981072E2;
	Wed, 28 Mar 2012 17:39:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LN7rPYnJ0viL2UFErvX3mHLdnZA=; b=ivQnJY
	OAzpK4AFGFHKnrPppBa5NtNrCAy5CdNDuLU6Xoy/PlGoUGOo6AOdT+jIrdn3gjdM
	qwRgQX872UuReC+KhRuPE6a8P8xXxaL9mvWvTuo3ddKOoRh+Bkl8q1Twv9Kb+YuU
	mi5MlpIaXpa17VyZ49h/goa8bFkMgzSDFzNfg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=enwYd2aT2W/I4IxR2sD/pTe3coHUlFtZ
	s8byyX5JicQg6ACExN2wCxzwooBiH3pU3bjQ8Huh99aS/osQOEEtKzvhrP0fkP2x
	0pprq+joFOWx8uT4KhKroDm9oAxxqqqZI/AEiA+p50CY5Pt+3O60bGA48yk8izWd
	gtQvbJt3hkU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 90D3B72E1;
	Wed, 28 Mar 2012 17:39:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C90B472E0; Wed, 28 Mar 2012
 17:39:20 -0400 (EDT)
In-Reply-To: <1332966017-6100-1-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Wed, 28 Mar 2012 22:20:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7A75DAC4-791E-11E1-8D69-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194203>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> When performing "git add -p" on a file in a conflicted state, we
> currently spew the diff and terminate the process.
>
> This is not very helpful to the user. Change the behaviour to
> skipping the file, while outputting a warning.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
>
> On Wed, Mar 28, 2012 at 9:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Perhaps teach list_modified(), which currently takes 'file-only' and
>> 'index-only', to also take an option to omit (and warn if it is
>> appropriate) unmerged paths?
>
> Good idea. This way, the path doesn't even get listed when using
> git add -i, and no warning is spewed on "git add -p" without specifying
> the path. It seems like the right thing to do.
>
> Again, I'm no Perl-guru, so apologies if the code isn't idiomatic.

I personally don't worry about Perly-ness in the early rounds of the
review.

I was hoping that we could somehow do this with a single invocation of
ls-files, instead of doing it over and over inside a loop.

Totally untested, but something along this line...

 git-add--interactive.perl |   31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 8f0839d..8bf1835 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -270,16 +270,35 @@ sub get_empty_tree {
 # FILE_ADDDEL:	is it add/delete between index and file?
 
 sub list_modified {
-	my ($only) = @_;
+	my ($only, $filter_unmerged) = @_;
 	my (%data, @return);
 	my ($add, $del, $adddel, $file);
 	my @tracked = ();
 
-	if (@ARGV) {
-		@tracked = map {
+	if (@ARGV || $filter_unmerged) {
+		my %unmerged = ();
+		for (run_cmd_pipe(qw(git ls-files -s --), @ARGV)) {
 			chomp $_;
-			unquote_path($_);
-		} run_cmd_pipe(qw(git ls-files --), @ARGV);
+			if (/^[0-7]+ [0-9a-f]{40} ([0-3])	(.*)/) {
+				my ($stage, $path) = ($1, unquote_path($2));
+				if ($stage eq '0') {
+					push @tracked, $path;
+				} else {
+					$unmerged{$path} = 1;
+				}
+			} else {
+				die "Oops: $_";
+			}
+		}
+		if (%unmerged) {
+			if ($filter_unmerged) {
+				for (sort keys %unmerged) {
+					warn "unmerged: $_";
+				}
+			} else {
+				@tracked = sort (@tracked, keys %unmerged);
+			}
+		}
 		return if (!@tracked);
 	}
 
@@ -1189,7 +1208,7 @@ sub apply_patch_for_checkout_commit {
 }
 
 sub patch_update_cmd {
-	my @all_mods = list_modified($patch_mode_flavour{FILTER});
+	my @all_mods = list_modified($patch_mode_flavour{FILTER}, 'filter-unmerged');
 	my @mods = grep { !($_->{BINARY}) } @all_mods;
 	my @them;
 
