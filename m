From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] The images from picon and gravatar are always used over
 http://, and browsers give mixed contents warning when gitweb is served over
 https://.
Date: Tue, 29 Jan 2013 10:33:48 -0800
Message-ID: <7va9rrq1o3.fsf@alter.siamese.dyndns.org>
References: <1359416492-8597-1-git-send-email-admin@andrej-andb.ru>
 <7vtxq0u1v3.fsf@alter.siamese.dyndns.org>
 <CAGyf7-GJkKDWdykq8iv90tU3TUR5ZKUf2bQc9sJokbq-RFYBYg@mail.gmail.com>
 <20130129041206.GA15442@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bryan Turner <bturner@atlassian.com>, git@vger.kernel.org,
	Andrej E Baranov <admin@andrej-andb.ru>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 19:34:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0G0c-0005rr-43
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 19:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016Ab3A2Sdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 13:33:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56355 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750853Ab3A2Sdv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 13:33:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E88B7C6B0;
	Tue, 29 Jan 2013 13:33:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dyfb3x5SBnGesZPB3M22vFNDZeQ=; b=vn/vBb
	RsjbMUewvKIEYpkT76RFJgG9GxIa8w7PR3t3JFSpT6hNDKmaqAEWvLlhzuXEr7y6
	PhTsgcjT4ezulhuM+bY6FUaASHiT6Inae0hBMrQ3wVeioyX4wgw2x9hGqzuSOMb3
	qoD3tIg4vLW+TuCvamCJPG8qQobwXWW10Ut58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LMmX1P+sX4/vTHSmnIhmgbdGlVbqADd4
	HgIXw9E0nHjp3bCg8N5CpK0MylqMPgYP5zpZfYwMlKePrqDov1uOpU5E95kWnTT8
	5MMT4vK4yoYj1JxWW26EksEXvc+xbicYEE/KXDBGLB9zcKrhhmQgpGO2vJ+yCGlT
	fZmgNQY4vMg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDE51C6AF;
	Tue, 29 Jan 2013 13:33:50 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 289CFC6AA; Tue, 29 Jan 2013
 13:33:50 -0500 (EST)
In-Reply-To: <20130129041206.GA15442@google.com> (Jonathan Nieder's message
 of "Mon, 28 Jan 2013 20:12:06 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6CE3333C-6A42-11E2-B838-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214954>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Odd.  "https://www.gravatar.com/" also seems to work.  I've put in a
> technical support query to find out what the Gravatar admins prefer.

Thanks; will hold onto Andrej's patch until we hear what the story
is.

Of course we could do something like this (untested).

 gitweb/gitweb.perl | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c6bafe6..b59773b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -313,6 +313,14 @@ sub evaluate_uri {
 		'override' => 0,
 		'default' => [0]},
 
+	# Use https:// URL for embedded picons/gravatar images, to be used
+	# on installations that server gitweb over https://
+	'subcontentssl' => {
+		'sub' => sub { feature_bool('subcontentssl', @_) },
+		'override' => 0,
+		'default' => [0]},
+	}
+
 	# Enable the 'snapshot' link, providing a compressed archive of any
 	# tree. This can potentially generate high traffic if you have large
 	# project.
@@ -1111,6 +1119,7 @@ sub evaluate_git_dir {
 }
 
 our (@snapshot_fmts, $git_avatar);
+our ($gravatar_base_url, $picon_base_url);
 sub configure_gitweb_features {
 	# list of supported snapshot formats
 	our @snapshot_fmts = gitweb_get_feature('snapshot');
@@ -1121,10 +1130,17 @@ sub configure_gitweb_features {
 	# if the provider name is invalid or the dependencies are not met,
 	# reset $git_avatar to the empty string.
 	our ($git_avatar) = gitweb_get_feature('avatar');
+	my $use_https = gitweb_check_feature('subcontentssl');
+
 	if ($git_avatar eq 'gravatar') {
 		$git_avatar = '' unless (eval { require Digest::MD5; 1; });
+		$gravatar_base_url = $use_https ?
+		    "https://secure.gravatar.com/avatar/" :
+		    "http://www.gravatar.com/avatar/";
 	} elsif ($git_avatar eq 'picon') {
-		# no dependencies
+		$picon_base_url = $use_https ?
+		    "http://www.cs.indiana.edu/cgi-pub/kinzler/piconsearch.cgi/" :
+		    "https://www.cs.indiana.edu/cgi-pub/kinzler/piconsearch.cgi/";
 	} else {
 		$git_avatar = '';
 	}
@@ -2068,7 +2084,7 @@ sub picon_url {
 	if (!$avatar_cache{$email}) {
 		my ($user, $domain) = split('@', $email);
 		$avatar_cache{$email} =
-			"http://www.cs.indiana.edu/cgi-pub/kinzler/piconsearch.cgi/" .
+			$picon_base_url .
 			"$domain/$user/" .
 			"users+domains+unknown/up/single";
 	}
@@ -2082,9 +2098,7 @@ sub picon_url {
 sub gravatar_url {
 	my $email = lc shift;
 	my $size = shift;
-	$avatar_cache{$email} ||=
-		"http://www.gravatar.com/avatar/" .
-			Digest::MD5::md5_hex($email) . "?s=";
+	$avatar_cache{$email} ||= $gravatar_base_url . Digest::MD5::md5_hex($email) . "?s=";
 	return $avatar_cache{$email} . $size;
 }
 
