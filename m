From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Teach "a=blob" action to be more lenient about blob/file mime type
Date: Sat, 08 Dec 2007 19:34:34 -0800
Message-ID: <7vk5notub9.fsf@gitster.siamese.dyndns.org>
References: <1197114913-15626-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 04:35:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1Cwk-0000rp-3M
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 04:35:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbXLIDev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Dec 2007 22:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbXLIDev
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Dec 2007 22:34:51 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:36431 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbXLIDev (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Dec 2007 22:34:51 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B1E7412F;
	Sat,  8 Dec 2007 22:34:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5148D412E;
	Sat,  8 Dec 2007 22:34:41 -0500 (EST)
In-Reply-To: <1197114913-15626-1-git-send-email-jnareb@gmail.com> (Jakub
	Narebski's message of "Sat, 8 Dec 2007 12:55:13 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67593>

Jakub Narebski <jnareb@gmail.com> writes:

> Since 930cf7dd7cc6b87d173f182230763e1f1913d319 'blob' action knows the
> file type; if the file type is not "text/*" or one of common network
> image formats/mimetypes (gif, png, jpeg) then the action "blob"
> defaulted to "blob_plain".  This caused the problem if mimetypes file
> was not well suited for web, for example returning "application/x-sh"
> for "*.sh" shell scripts, instead of "text/plain" (or other "text/*").
>
> Now "blob" action defaults to "blob_plain" ('raw' view) only if file
> is of type which is neither "text/*" nor "image/{gif,png,jpeg}"
> AND it is binary file.  Otherwise it assumes that it can be displayed
> either in <img> tag ("image/*" mimetype), or can be displayed line by
> line (otherwise).

Ok, the intent sounds sane.  Let's see if the implementation is also
sane.

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index eac7e16..b833327 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4302,7 +4302,7 @@ sub git_blob {
>  	open my $fd, "-|", git_cmd(), "cat-file", "blob", $hash
>  		or die_error(undef, "Couldn't cat $file_name, $hash");
>  	my $mimetype = blob_mimetype($fd, $file_name);
> -	if ($mimetype !~ m!^(?:text/|image/(?:gif|png|jpeg)$)!) {
> +	if ($mimetype !~ m!^(?:text/|image/(?:gif|png|jpeg)$)! && -B $fd) {
>  		close $fd;
>  		return git_blob_plain($mimetype);
>  	}

"If not text or image and binary go blob_plain" -- Ok.

> @@ -4343,16 +4343,7 @@ sub git_blob {
>  	}
>  	git_print_page_path($file_name, "blob", $hash_base);
>  	print "<div class=\"page_body\">\n";
> +	if ($mimetype =~ m!^image/!) {
>  		print qq!<img type="$mimetype"!;
>  		if ($file_name) {
>  			print qq! alt="$file_name" title="$file_name"!;
> @@ -4361,7 +4352,16 @@ sub git_blob {
>  		      href(action=>"blob_plain", hash=>$hash,
>  		           hash_base=>$hash_base, file_name=>$file_name) .
>  		      qq!" />\n!;
> +	} else {
> +		my $nr;
> +		while (my $line = <$fd>) {
> +			chomp $line;
> +			$nr++;
> +			$line = untabify($line);
> +			printf "<div class=\"pre\"><a id=\"l%i\" href=\"#l%i\" class=\"linenr\">%4i</a> %s</div>\n",
> +			       $nr, $nr, $nr, esc_html($line, -nbsp=>1);
> +		}
> +	} els

"If image, do image, but otherwise show line-by-line" -- Ok.

There is a "Huh?" on the last line, though.

> P.S. BTW is there some plumbing for scripts to help with
> gitattributes, for example showing all gitattributes (or status of
> selected attributes) for given path?

$ git grep gitattributes Documentation | grep -i display
