From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: support filename prefix in git_patchset_body
Date: Mon, 26 Mar 2007 18:12:18 +0100
Message-ID: <200703261912.18549.jnareb@gmail.com>
References: <11748548622888-git-send-email-mkoegler@auto.tuwien.ac.at> <11748548623841-git-send-email-mkoegler@auto.tuwien.ac.at> <11748548622060-git-send-email-mkoegler@auto.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin Koegler <mkoegler@auto.tuwien.ac.at>
X-From: git-owner@vger.kernel.org Mon Mar 26 19:11:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVsjB-0003rL-1m
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 19:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753045AbXCZRLO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 13:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753018AbXCZRLM
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 13:11:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:59275 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022AbXCZRLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 13:11:09 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1654982uga
        for <git@vger.kernel.org>; Mon, 26 Mar 2007 10:11:08 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=LB2RUUUHKtYg2M/JnTvEJxomQmiGQKzt262OuMUVfjLjFgd40JtbG6t3M4CP7RbJO3/NW5gYYko/pgVbAVClAHcxxGwT6tOCoFcbJYRs08Fv78ygroGBk24LM0Td5fhcH2CmVJsuKTD7nZRMl1T1pY8JP5bD4vPXPfB6j72PVt0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=gbO7ftGZrfIpmWYg3if/03+YQAKg7eg3nuUznO6POFnQRL8MsmhyPoXqdfBEEr3XtRJRSXbH6tXF1EcU7eInR9lXqWOjGobQNpXQWYC9uKf28Oq7XPxVFvXMU3j0nfPpPlt55xTP75q8iBDuHXDUgqCLodmSicYNjwwxHrTTXKM=
Received: by 10.78.149.15 with SMTP id w15mr3119539hud.1174929068243;
        Mon, 26 Mar 2007 10:11:08 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id e9sm22102910muf.2007.03.26.10.11.06;
        Mon, 26 Mar 2007 10:11:07 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <11748548622060-git-send-email-mkoegler@auto.tuwien.ac.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43163>

On Sun, Mar 25, 2007, Martin Koegler wrote:

> git_treediff supports comparing subdirectories. As the output of
> git-difftree is missing the path to the compared directories,
> the links in the output would be wrong.
> 
> The patch adds two new parameters to add the missing path prefix.

Wouldn't it be better to concatenate the two "path prefix" patches
together? They are about the same thing.

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 4c371b2..4195b1a 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -2372,7 +2372,7 @@ sub git_difftree_body {
>  }
>  
>  sub git_patchset_body {
> -	my ($fd, $difftree, $hash, $hash_parent) = @_;
> +	my ($fd, $difftree, $hash, $hash_parent, $file_name, $file_parent) = @_;
>  
>  	my $patch_idx = 0;
>  	my $patch_line;

I'd rather use $from_prefix, $to_prefix here, or $basedif_name,
$basedir_parent, or $dir_name, $dir_parent (my preference is to
$from_prefix, $to_prefix variables).

> @@ -2380,6 +2380,9 @@ sub git_patchset_body {
>  	my $diffinfo;
>  	my (%from, %to);
>  
> +	$file_name = (!defined $file_name)?"":($file_name."/");
> +	$file_parent = (!defined $file_parent)?"":($file_parent."/");
> +
>  	print "<div class=\"patchset\">\n";
>  
>  	# skip to first patch

Minor nit: I'd rather write

+	$from_prefix = !defined $from_prefix ? '' : $from_prefix.'/';
+	$to_prefix   = !defined $to_prefix   ? '' : $to_prefix . '/';
+	$to_prefix ||= $from_prefix;  # to allow to pass common prefix once
+

or something like that, or just modify $from{'file'} and $to{'file'}

	$from{'file'} = (!defined $from_prefix ? '' : $from_prefix.'/') . $from{'file'};
	$to{'file'}   = (!defined $to_prefix   ? '' : $to_prefix . '/') . $to{'file'};

just after setting $from{'file'} and $to{'file'}, although the second
solution would additionally add prefix to the shown patch body itself.

> @@ -2439,14 +2442,14 @@ sub git_patchset_body {
>  			if ($diffinfo->{'status'} ne "A") { # not new (added) file
>  				$from{'href'} = href(action=>"blob", hash_base=>$hash_parent,
>  				                     hash=>$diffinfo->{'from_id'},
> -				                     file_name=>$from{'file'});
> +				                     file_name=>$file_parent.$from{'file'});
>  			} else {
>  				delete $from{'href'};
>  			}
>  			if ($diffinfo->{'status'} ne "D") { # not deleted file
>  				$to{'href'} = href(action=>"blob", hash_base=>$hash,
>  				                   hash=>$diffinfo->{'to_id'},
> -				                   file_name=>$to{'file'});
> +				                   file_name=>$file_name.$to{'file'});
>  			} else {
>  				delete $to{'href'};
>  			}

Another solution would be to not add additional parameters to
git_difftree_body and git_patchset_body subroutines (although it is nice
touch towards completeness), but modify %diffinfo in the caller, but this
would change also patch contents (in from-file / to-file diff header, etc.)
which might not be a good thing.

I'm not sure if we should not add information somewhere that paths are
prefixed/shortened, but this might be left for later patch.

-- 
Jakub Narebski
Poland
