From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCHv4 2/2] gitweb: gravatar support
Date: Wed, 24 Jun 2009 22:44:30 +0900
Message-ID: <20090624224430.6117@nanako3.lavabit.com>
References: <1245710999-17763-1-git-send-email-giuseppe.bilotta@gmail.com>
	<1245710999-17763-2-git-send-email-giuseppe.bilotta@gmail.com>
	<1245710999-17763-3-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Aaron Crane <git@aaroncrane.co.uk>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 15:45:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJSmv-0007Nm-9g
	for gcvg-git-2@gmane.org; Wed, 24 Jun 2009 15:45:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbZFXNpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2009 09:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbZFXNpD
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jun 2009 09:45:03 -0400
Received: from karen.lavabit.com ([72.249.41.33]:35421 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751301AbZFXNpC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2009 09:45:02 -0400
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 264D011B7F0;
	Wed, 24 Jun 2009 08:45:05 -0500 (CDT)
Received: from 7073.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id DNJ9HMO8YTWX; Wed, 24 Jun 2009 08:45:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=fazAyhtZEkzCuIeD8GXNjsHOVB4zUMZbPPt/GlQrrEdzj3CdjnO+nhIzD0JNmjYFHjwS+S7nSgnepr1kUQLpy3BkKp7uCNMBtUWhG3FcR2qcqDgY8U7/1KxSxVoV+avrTOQY6gBVtNDldvjCzckecTSmQVJIKur+Ld86Kph3pF0=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <1245710999-17763-3-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122138>

Quoting Giuseppe Bilotta <giuseppe.bilotta@gmail.com>:

> diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
> index 68b22ff..ddf982b 100644
> ........
> +img.avatar {
> +	vertical-align:middle;
> +}
> +
> .........
> +# Pixel sizes for avatars. If the default font sizes or lineheights
> +# are changed, it may be appropriate to change these values too via
> +# $GITWEB_CONFIG.
> +our %avatar_size = (
> +	'default' => 16,
> +	'double'  => 32
> +) ;
> ........

Early parts of the patch talk about "avatars"; compared with "icons" Junio
suggested, I think that is a better generic word to use for this purpose.

> +	# Gravatar support. When this feature is enabled, views such as
> ........
> +	'gravatar' => {
> +		'sub' => sub { feature_bool('gravatar', @_) },
> +		'override' => 0,
> +		'default' => [0]},
>  );

And this "feature" is about getting such avatars from "gravatar" service;
it is good to use such a specific word here.

> +# check if gravatars are enabled and dependencies are satisfied
> +our $git_gravatar_enabled = gitweb_check_feature('gravatar') &&
> +	(eval { require Digest::MD5; 1; });

The same.

> @@ -1474,7 +1501,7 @@ sub format_author_html {
>  	my $tag = shift;
>  	my $co = shift;
>  	my $author = chop_and_escape_str($co->{'author_name'}, @_);
> -	return "<$tag class=\"author\">" . $author . "</$tag>\n";
> +	return "<$tag class=\"author\">" . git_get_gravatar($co->{'author_email'}, 'space_after' => 1) . $author . "</$tag>\n";
>  }

But the function that returns a string suitable for embedding in the HTML
page, given an e-mail address, is called get_gravatar(), not get_avatar()? 

I expected from an earlier review message by Junio that get_avatar() will
look like this:

sub git_get_avatar {
	my $url = undef;
	if ($git_gravatar_enabled) {
		my $md5 = .......;
		$url = "http://www.gravatar.com/avatar.php?gravatar_id=$md5";
	} else if ($git_picons_enabled) {
		my $userpath = .......;
		$url = "http://www.cs.indiana.edu/picons/db/users/$userpath/face.xpm";
	}
	return "" unless (defined $url);
	return $pre_white . "<img ... src=\"$url\" size=$size />" . $post_white;
}

(without "picons" part, of course).

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
