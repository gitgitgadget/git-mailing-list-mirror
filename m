From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Git.pm: config_boolean() -> config_bool()
Date: Wed, 9 May 2007 12:49:41 +0200
Message-ID: <20070509104941.GK4489@pasky.or.cz>
References: <20070427020601.22991.13792.stgit@rover> <7v7irxko81.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 09 12:49:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hljjx-00034p-4o
	for gcvg-git@gmane.org; Wed, 09 May 2007 12:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbXEIKtp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 06:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754869AbXEIKtp
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 06:49:45 -0400
Received: from w241.dkm.cz ([62.24.88.241]:34575 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630AbXEIKto (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 06:49:44 -0400
Received: (qmail 8311 invoked by uid 2001); 9 May 2007 12:49:41 +0200
Content-Disposition: inline
In-Reply-To: <7v7irxko81.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46695>

On Sat, Apr 28, 2007 at 08:27:42AM CEST, Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > This patch renames config_boolean() to config_bool() for consistency with
> > the commandline interface and because it is shorter but still obvious. ;-)
> > It also changes the return value from some obscure string to real Perl
> > boolean, allowing for clean user code.
> 
> Doesn't this break send-email?

Oh, sorry! My grep must've been broken or something.

> > @@ -526,14 +528,16 @@ This currently wraps command('config') s
> >  
> >  =cut
> >  
> > -sub config_boolean {
> > +sub config_bool {
> >  	my ($self, $var) = @_;
> >  	$self->repo_path()
> >  		or throw Error::Simple("not a repository");
> >  
> >  	try {
> > -		return $self->command_oneline('config', '--bool', '--get',
> > +		my $var = $self->command_oneline('config', '--bool', '--get',
> >  					      $var);
> > +		return undef unless defined $var;
> > +		return $var eq 'true';
> 
> Did you mean to hide $var in the nested scope?

Hmm, I agree that having a different name for it will be more readable,
fixed.

So, I realized that I'm not sure again how to stick a mail reply and new
patch version in the same mail - originally I wanted to reply to this
mail and send the patch as another reply, but that seemed wasteful. Now
it seems that the only option is to stuff the mail reply in the diffstat
area, but I refuse to do that since that's just plainly stupid.

---

This patch renames config_boolean() to config_bool() for consistency with
the commandline interface and because it is shorter but still obvious. ;-)
It also changes the return value from some obscure string to real Perl
boolean, allowing for clean user code.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 git-remote.perl     |    4 ++--
 git-send-email.perl |    4 ++--
 perl/Git.pm         |   14 +++++++++-----
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/git-remote.perl b/git-remote.perl
index 52013fe..5763799 100755
--- a/git-remote.perl
+++ b/git-remote.perl
@@ -297,9 +297,9 @@ sub update_remote {
 	} elsif ($name eq 'default') {
 		undef @remotes;
 		for (sort keys %$remote) {
-			my $do_fetch = $git->config_boolean("remote." . $_ .
+			my $do_fetch = $git->config_bool("remote." . $_ .
 						    ".skipDefaultUpdate");
-			if (!defined($do_fetch) || $do_fetch ne "true") {
+			unless ($do_fetch) {
 				push @remotes, $_;
 			}
 		}
diff --git a/git-send-email.perl b/git-send-email.perl
index a6e3e02..404095f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -154,8 +154,8 @@ if ($@) {
 	$term = new FakeTerm "$@: going non-interactive";
 }
 
-my $def_chain = $repo->config_boolean('sendemail.chainreplyto');
-if ($def_chain and $def_chain eq 'false') {
+my $def_chain = $repo->config_bool('sendemail.chainreplyto');
+if (defined $def_chain and not $def_chain) {
     $chain_reply_to = 0;
 }
 
diff --git a/perl/Git.pm b/perl/Git.pm
index b5b1cf5..924470a 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -516,9 +516,11 @@ sub config {
 }
 
 
-=item config_boolean ( VARIABLE )
+=item config_bool ( VARIABLE )
 
-Retrieve the boolean configuration C<VARIABLE>.
+Retrieve the bool configuration C<VARIABLE>. The return value
+is usable as a boolean in perl (and C<undef> if it's not defined,
+of course).
 
 Must be called on a repository instance.
 
@@ -526,14 +528,16 @@ This currently wraps command('config') so it is not so fast.
 
 =cut
 
-sub config_boolean {
+sub config_bool {
 	my ($self, $var) = @_;
 	$self->repo_path()
 		or throw Error::Simple("not a repository");
 
 	try {
-		return $self->command_oneline('config', '--bool', '--get',
-					      $var);
+		my $val = $self->command_oneline('config', '--bool', '--get',
+					      $val);
+		return undef unless defined $val;
+		return $val eq 'true';
 	} catch Git::Error::Command with {
 		my $E = shift;
 		if ($E->value() == 1) {



-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
