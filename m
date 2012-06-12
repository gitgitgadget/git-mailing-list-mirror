From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv2] git-remote-mediawiki: export File: attachments
Date: Tue, 12 Jun 2012 14:52:34 +0200
Message-ID: <vpqvciwu1yl.fsf@bauges.imag.fr>
References: <1339505176-2962-1-git-send-email-nguyenkimthuat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, nguyenkimthuat <nguyenkimthuat@gmail.com>,
	VOLEK Pavel <Pavel.Volek@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
To: Kim Thuat NGUYEN <kim-thuat.nguyen@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Tue Jun 12 14:52:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeQac-0006h4-1q
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 14:52:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884Ab2FLMwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 08:52:50 -0400
Received: from mx1.imag.fr ([129.88.30.5]:42956 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751168Ab2FLMwt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 08:52:49 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q5CChdbT001294
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 12 Jun 2012 14:43:39 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SeQaJ-0004Qq-HQ; Tue, 12 Jun 2012 14:52:35 +0200
In-Reply-To: <1339505176-2962-1-git-send-email-nguyenkimthuat@gmail.com> (Kim
	Thuat NGUYEN's message of "Tue, 12 Jun 2012 14:46:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 12 Jun 2012 14:43:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q5CChdbT001294
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1340109820.81115@JNixsl9PjSWSkoPaVg+hBg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199782>

Kim Thuat NGUYEN <kim-thuat.nguyen@ensimag.imag.fr> writes:

> From: nguyenkimthuat <nguyenkimthuat@gmail.com>

Please use your @ensimag email for Ensimag-related things. This adress
is the one used in the commit itself, i.e. ~/.gitconfig. "git commit
--reset-author" can help.

> @@ -644,6 +652,10 @@ sub mw_push_file {
>  	my $page_deleted = ($new_sha1 eq NULL_SHA1);
>  	$complete_file_name = mediawiki_clean_filename($complete_file_name);
>  
> +	my $path = "File:".$complete_file_name;
> +	my @extensions = split(/\./, $complete_file_name);
> +	my $extension = pop(@extensions);
> +
>  	if (substr($complete_file_name,-3) eq ".mw") {
>  		my $title = substr($complete_file_name,0,-3);

If you extract the extension explicitely, then you don't need these
"substr(...)" anymore.

> +		my %hashFiles = get_file_extensions();
> +		if (exists($hashFiles{$extension})) {
> +			# Deleting and uploading a file require the priviledge of the user
> +			if ($page_deleted) {
> +				mw_connect_maybe();
> +				my $res = $mediawiki->edit( {
> +					action => 'delete',
> +					title => $path,
> +					reason => $summary
> +					} )|| die $mediawiki-> {error}->{code} . ':' . $mediawiki->{error}->{details};

Here and below: you still have too long lines.

> +						ignorewarnings=>1,

Spaces around =>.

> +						}, {
> +								skip_encoding => 1 # Helps with names with accentuated characters
> +							} )  || die $mediawiki-> {error}->{code} . ':' . $mediawiki->{error}->{details};

Weird indentation.

> +				} else {
> +					print STDERR "Empty file. Can not upload \n ";
> +				}

No space, but a "." before \n.

> +		} else {
> +			print STDERR "$complete_file_name not a mediawiki file (Not pushable on this version of git-remote-mediawiki).\n";
> +		}

Why does this message keep reappearing?

> +sub get_file_extensions {
> +	mw_connect_maybe();
> +
> +	my $query = {
> +		action => 'query',
> +		meta => 'siteinfo',
> +		siprop => 'fileextensions'
> +		};
> +	my $result = $mediawiki->api($query);
> +	my @file_extensions= map $_->{ext},@{$result->{query}->{fileextensions}};
> +	my %hashFile = map {$_ => 1}@file_extensions;
> +
> +	return %hashFile;
> +}

I like the new function much more than the previous one.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
