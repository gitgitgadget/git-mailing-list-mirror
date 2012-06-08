From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv1] Export file in git-remote-mediawiki
Date: Fri, 08 Jun 2012 16:07:23 +0200
Message-ID: <vpqwr3hrj6s.fsf@bauges.imag.fr>
References: <1339162024-3120-1-git-send-email-nguyenkimthuat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, nguyenkimthuat <nguyenkimthuat@gmail.com>,
	VOLEK Pavel <Pavel.Volek@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
To: Kim Thuat NGUYEN <kim-thuat.nguyen@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 08 16:07:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sczqk-0007Tm-PD
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 16:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757256Ab2FHOHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jun 2012 10:07:33 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40940 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756555Ab2FHOHc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2012 10:07:32 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q58DweuX026244
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 8 Jun 2012 15:58:40 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SczqW-0006t3-SO; Fri, 08 Jun 2012 16:07:24 +0200
In-Reply-To: <1339162024-3120-1-git-send-email-nguyenkimthuat@gmail.com> (Kim
	Thuat NGUYEN's message of "Fri, 8 Jun 2012 15:27:04 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 08 Jun 2012 15:58:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q58DweuX026244
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1339768721.13022@8KgKYPlgHlrtKtzc/YdP2g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199491>

> Subject: Re: [PATCHv1] Export file in git-remote-mediawiki

We usually write commit subject lines as "subsystem: description", hence

git-remote-mediawiki: export "File:" attachments

Kim Thuat NGUYEN <kim-thuat.nguyen@ensimag.imag.fr> writes:

> From: nguyenkimthuat <nguyenkimthuat@gmail.com>
>
> This patch adds the functionnality to export the file attachements from the local git's repository using the API of mediawiki. It also provides the possibility for
> an user to delete a page in the local repository Git which means the page  will be deleted in the wiki site after user do the 'push'.

Please, avoid long lines (> 80 characters).

> +	open(my $g,"-|","git " . $_[0]); 

Space after , please.

> +	my %hashFiles = get_file_extensions_maybe($complete_file_name);

What does this function do? My first understanding was that it queried
the wiki for allowed file extensions, but why does it need the file
name? It does nothing if $complete_file_name ends with .mw, but then why
do you run it before entering the following if() statement?

>  	if (substr($complete_file_name,-3) eq ".mw") {
>  		my $title = substr($complete_file_name,0,-3);

> @@ -653,39 +666,74 @@ sub mw_push_file {
>  			# special priviledges. A common
>  			# convention is to replace the page
>  			# with this content instead:
> -			$file_content = DELETED_CONTENT;
> +			mw_connect_maybe();
> +			my $re = $mediawiki->edit( {
> +				action => 'delete',
> +				title => $title,
> +				reason => $summary 
> +				} )|| die $mediawiki-> {error}->{code} . ':' . $mediawiki->{error}->{details};

This is an unrelated topic, and should not appear in this patch.

If you want to propagate page deletions, then you also need to deal with
the case where the user is not allowed to do so (very common on
MediaWiki). Also, if you change the code corresponding to the comment
right above, you should update the comment too.

> +	elsif (exists($hashFiles{$extension}))      
> +	{

Brace on the same line as else please.

> +			} else {
> +				print STDERR "Empty file. Can not upload \n ";
> +				}

Broken indentation.

>  	} else {
>  		print STDERR "$complete_file_name not a mediawiki file (Not pushable on this version of git-remote-mediawiki).\n"
>  	}

Isn't the very point of this patch to remove this error message?

> @@ -825,3 +873,25 @@ sub mw_push_revision {
>  	print STDOUT "ok $remote\n";
>  	return 1;
>  }
> +
> +sub get_file_extensions_maybe {
> +	my $file_name = shift;
> +	my $est_mw_page = substr($file_name,-3) eq ".mw";

English please. "est" is french ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
