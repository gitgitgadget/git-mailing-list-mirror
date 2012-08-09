From: "Chris West (Faux)" <git@goeswhere.com>
Subject: [PATCH] gitweb: Add support for gravatar-ssl
Date: Thu, 9 Aug 2012 19:42:10 +0100
Message-ID: <20120809184210.GA27795@goeswhere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 09 20:52:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzXqB-0005Uv-7i
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 20:52:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755668Ab2HISwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 14:52:09 -0400
Received: from fau.xxx ([78.47.200.108]:53273 "EHLO reg.goeswhere.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754660Ab2HISwI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 14:52:08 -0400
X-Greylist: delayed 596 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Aug 2012 14:52:08 EDT
Received: by reg.goeswhere.com (Postfix, from userid 1000)
	id 7134B2E057F; Thu,  9 Aug 2012 19:42:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=goeswhere.com;
	s=default; t=1344537730;
	bh=yVWYFeQVwA8L15U6DJrIaqylMIyjLQKfKPyTzeUH04A=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=Q0YUIDzl9LFjjBvtoiEDJzJaODt0aMt7MLEVTCJAQqgzBhh/XFiNu6/EQ9zDVsVAC
	 nPo/lzICOOow2mcNlbEX2wvwsEZTS28/dqAoTATEKtwK8aT//lBAIZLVi26wVEkFqw
	 K98WACh6LR6iwvjbVHXQj6KDPA2kQuDLaTz5vSSU=
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203175>

Teach gitweb to allow 'avatar' to be set to 'gravatar-ssl', switching
to the https://secure.gravatar.com url form, to avoid mixed content
warnings when serving gitweb over https, with gravatar enabled.
---

I'd alternatively propose always using the https:// form of the URL,
but it seems significantly slower, so it's probably best to let people
pick to continue using the insecure version.

 gitweb/gitweb.perl |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 3d6a705..d70e8b8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -482,7 +482,7 @@ our %feature = (
 
 	# To enable system wide have in $GITWEB_CONFIG
 	# $feature{'avatar'}{'default'} = ['<provider>'];
-	# where <provider> is either gravatar or picon.
+	# where <provider> is either gravatar, gravatar-ssl or picon.
 	# To have project specific config enable override in $GITWEB_CONFIG
 	# $feature{'avatar'}{'override'} = 1;
 	# and in project config gitweb.avatar = <provider>;
@@ -1117,7 +1117,7 @@ sub configure_gitweb_features {
 	# if the provider name is invalid or the dependencies are not met,
 	# reset $git_avatar to the empty string.
 	our ($git_avatar) = gitweb_get_feature('avatar');
-	if ($git_avatar eq 'gravatar') {
+	if ($git_avatar eq 'gravatar' || $git_avatar eq 'gravatar-ssl') {
 		$git_avatar = '' unless (eval { require Digest::MD5; 1; });
 	} elsif ($git_avatar eq 'picon') {
 		# no dependencies
@@ -2079,7 +2079,10 @@ sub gravatar_url {
 	my $email = lc shift;
 	my $size = shift;
 	$avatar_cache{$email} ||=
-		"http://www.gravatar.com/avatar/" .
+		($git_avatar eq 'gravatar-ssl' ?
+			"https://secure" :
+			"http://www")
+		. ".gravatar.com/avatar/" .
 			Digest::MD5::md5_hex($email) . "?s=";
 	return $avatar_cache{$email} . $size;
 }
@@ -2093,7 +2096,7 @@ sub git_get_avatar {
 	$opts{-size} ||= 'default';
 	my $size = $avatar_size{$opts{-size}} || $avatar_size{'default'};
 	my $url = "";
-	if ($git_avatar eq 'gravatar') {
+	if ($git_avatar eq 'gravatar' || $git_avatar eq 'gravatar-ssl') {
 		$url = gravatar_url($email, $size);
 	} elsif ($git_avatar eq 'picon') {
 		$url = picon_url($email);
-- 
1.7.10
