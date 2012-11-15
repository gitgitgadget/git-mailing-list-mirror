From: Jeff King <peff@peff.net>
Subject: [PATCHv2 7/8] Git.pm: teach "ident" to query explicitness
Date: Wed, 14 Nov 2012 16:36:28 -0800
Message-ID: <20121115003628.GG17819@sigill.intra.peff.net>
References: <20121115003029.GA17550@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 01:36:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYnRl-0004mj-O5
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 01:36:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835Ab2KOAgd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 19:36:33 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48851 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755499Ab2KOAgb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 19:36:31 -0500
Received: (qmail 9340 invoked by uid 107); 15 Nov 2012 00:37:20 -0000
Received: from 204-16-157-26-static.ipnetworksinc.net (HELO sigill.intra.peff.net) (204.16.157.26)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Nov 2012 19:37:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Nov 2012 16:36:28 -0800
Content-Disposition: inline
In-Reply-To: <20121115003029.GA17550@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209773>

"git var" recently learned to report on whether an ident we
fetch from it was configured explicitly or implicitly. Let's
make that information available to callers of the ident
function.

Because evaluating "ident" in an array versus scalar context
already has a meaning, we cannot return our extra value in a
backwards compatible way. Instead, we require the caller to
add an extra "explicit" flag to request the information.
The ident_person function, on the other hand, always returns
a scalar, so we are free to overload it in an array context.

Signed-off-by: Jeff King <peff@peff.net>
---
 perl/Git.pm | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 497f420..28075a9 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -737,7 +737,7 @@ sub remote_refs {
 }
 
 
-=item ident ( TYPE | IDENTSTR )
+=item ident ( TYPE | IDENTSTR [, options] )
 
 =item ident_person ( TYPE | IDENTSTR | IDENTARRAY )
 
@@ -750,8 +750,16 @@ and either returns it as a scalar string or as an array with the fields parsed.
 Alternatively, it can take a prepared ident string (e.g. from the commit
 object) and just parse it.
 
+If the C<explicit> option is set to 1, we are in an array context, and we are
+using C<git var> to lookup the ident, the returned array will contain an
+additional boolean element specifying whether the ident was configured
+explicitly by the user. See the description of GIT_*_EXPLICIT in git-var(1) for
+details.
+
 C<ident_person> returns the person part of the ident - name and email;
 it can take the same arguments as C<ident> or the array returned by C<ident>.
+In an array context, C<ident_person> returns both the person string and the
+C<explicit> boolean.
 
 The synopsis is like:
 
@@ -763,17 +771,22 @@ The synopsis is like:
 =cut
 
 sub ident {
-	my ($self, $type) = _maybe_self(@_);
-	my $identstr;
+	my ($self, $type, %options) = _maybe_self(@_);
+	my ($identstr, $explicit);
 	if (lc $type eq lc 'committer' or lc $type eq lc 'author') {
-		my @cmd = ('var', 'GIT_'.uc($type).'_IDENT');
+		my $uc = uc($type);
+		my @cmd = ('var', "GIT_${uc}_IDENT", "GIT_${uc}_EXPLICIT");
 		unshift @cmd, $self if $self;
-		$identstr = command_oneline(@cmd);
+		($identstr, $explicit) = command(@cmd);
 	} else {
 		$identstr = $type;
 	}
 	if (wantarray) {
-		return $identstr =~ /^(.*) <(.*)> (\d+ [+-]\d{4})$/;
+		my @ret = $identstr =~ /^(.*) <(.*)> (\d+ [+-]\d{4})$/;
+		if ($options{explicit} && defined $explicit) {
+			push @ret, $explicit;
+		}
+		return @ret;
 	} else {
 		return $identstr;
 	}
@@ -781,8 +794,11 @@ sub ident {
 
 sub ident_person {
 	my ($self, @ident) = _maybe_self(@_);
-	$#ident == 0 and @ident = $self ? $self->ident($ident[0]) : ident($ident[0]);
-	return "$ident[0] <$ident[1]>";
+	$#ident == 0 and @ident = $self ?
+				  $self->ident($ident[0], explicit => 1) :
+				  ident($ident[0], explicit => 1);
+	my $ret = "$ident[0] <$ident[1]>";
+	return wantarray ? ($ret, @ident[3]) : $ret;
 }
 
 
-- 
1.8.0.207.gdf2154c
