From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 1/7] Git.pm: Introduce ident() and ident_person() methods
Date: Sun, 25 Jun 2006 03:54:21 +0200
Message-ID: <20060625015421.29906.50002.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 25 03:54:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuJpS-00068g-Dy
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 03:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751347AbWFYByY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 21:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWFYByY
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 21:54:24 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63913 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751347AbWFYByX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 21:54:23 -0400
Received: (qmail 29916 invoked from network); 25 Jun 2006 03:54:21 +0200
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1)
  by localhost with SMTP; 25 Jun 2006 03:54:21 +0200
To: Junio C Hamano <junkio@cox.net>
User-Agent: StGIT/0.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22570>

These methods can retrieve/parse the author/committer ident.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 git-send-email.perl |   11 ++---------
 perl/Git.pm         |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index e794e44..79e82f5 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -84,15 +84,8 @@ foreach my $entry (@bcclist) {
 
 # Now, let's fill any that aren't set in with defaults:
 
-sub gitvar_ident {
-    my ($name) = @_;
-    my $val = $repo->command('var', $name);
-    my @field = split(/\s+/, $val);
-    return join(' ', @field[0...(@field-3)]);
-}
-
-my ($author) = gitvar_ident('GIT_AUTHOR_IDENT');
-my ($committer) = gitvar_ident('GIT_COMMITTER_IDENT');
+my ($author) = $repo->ident_person('author');
+my ($committer) = $repo->ident_person('committer');
 
 my %aliases;
 my @alias_files = $repo->config('sendemail.aliasesfile');
diff --git a/perl/Git.pm b/perl/Git.pm
index 2e1241b..08f56c0 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -520,6 +520,56 @@ sub config {
 }
 
 
+=item ident ( TYPE | IDENTSTR )
+
+=item ident_person ( TYPE | IDENTSTR | IDENTARRAY )
+
+This suite of functions retrieves and parses ident information, as stored
+in the commit and tag objects or produced by C<var GIT_type_IDENT> (thus
+C<TYPE> can be either I<author> or I<committer>; case is insignificant).
+
+The C<ident> method retrieves the ident information from C<git-var>
+and either returns it as a scalar string or as an array with the fields parsed.
+Alternatively, it can take a prepared ident string (e.g. from the commit
+object) and just parse it.
+
+C<ident_person> returns the person part of the ident - name and email;
+it can take the same arguments as C<ident> or the array returned by C<ident>.
+
+The synopsis is like:
+
+	my ($name, $email, $time_tz) = ident('author');
+	"$name <$email>" eq ident_person('author');
+	"$name <$email>" eq ident_person($name);
+	$time_tz =~ /^\d+ [+-]\d{4}$/;
+
+Both methods must be called on a repository instance.
+
+=cut
+
+sub ident {
+	my ($self, $type) = @_;
+	my $identstr;
+	if (lc $type eq lc 'committer' or lc $type eq lc 'author') {
+		$identstr = $self->command_oneline('var', 'GIT_'.uc($type).'_IDENT');
+	} else {
+		$identstr = $type;
+	}
+	if (wantarray) {
+		return $identstr =~ /^(.*) <(.*)> (\d+ [+-]\d{4})$/;
+	} else {
+		return $identstr;
+	}
+}
+
+sub ident_person {
+	my ($self, @ident) = @_;
+	$#ident == 0 and @ident = $self->ident($ident[0]);
+	return "$ident[0] <$ident[1]>";
+}
+
+
+
 =item hash_object ( FILENAME [, TYPE ] )
 
 =item hash_object ( FILEHANDLE [, TYPE ] )
