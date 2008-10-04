From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv4] gitweb: parse parent..current syntax from pathinfo
Date: Sat, 4 Oct 2008 03:31:27 +0200
Message-ID: <200810040331.27605.jnareb@gmail.com>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com> <1222906234-8182-5-git-send-email-giuseppe.bilotta@gmail.com> <1222906234-8182-6-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 04 03:33:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Klw0t-00057b-2Q
	for gcvg-git-2@gmane.org; Sat, 04 Oct 2008 03:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753606AbYJDBbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 21:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753603AbYJDBbl
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 21:31:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:23111 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753559AbYJDBbk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 21:31:40 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1370195ugf.37
        for <git@vger.kernel.org>; Fri, 03 Oct 2008 18:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=BPZxPmn8YEhEp/+o7CiHE0scrLzFQ3b424HN1X4MZeU=;
        b=BPF997ocnoeAkMY2rZ7EFDmo1wBkRO5Kwx2EM/BaJDzQh3XYgTWqyowl9LJPral0Ha
         gflB/U7Fn7Eua93aUQzmwxhKuKS52exrQpQOLqMje4k04kzxfJ67wk5bEhAuuhoPXJE1
         gzkJQs8C4BkJtgXnKynsvaa+QPM/JU1LpAWC0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=xuEuQwc/wMnyAEWECuDg7soIk6+5fA69SybNvtIAeIn557nk4qZREvcaGzfdTc494p
         ALPiyoyRnT1zP6BtClMNRr2/Y1udFqAOr/ng9vdfG2qcjT4WrAKuI8nUt9wQK271nLxh
         7nBSV9AIFc0c4OiYW4sizvRn6jmKcZx2r7uhU=
Received: by 10.66.243.2 with SMTP id q2mr5967056ugh.13.1223083898886;
        Fri, 03 Oct 2008 18:31:38 -0700 (PDT)
Received: from ?192.168.1.11? (abwi176.neoplus.adsl.tpnet.pl [83.8.232.176])
        by mx.google.com with ESMTPS id y7sm16918944ugc.2.2008.10.03.18.31.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Oct 2008 18:31:37 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1222906234-8182-6-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97460>

On Thu, 2 Oct 2008, Giuseppe Bilotta wrote:

> This makes it possible to use an URL such as
> $project/somebranch..otherbranch:/filename to get a diff between
> different version of a file. Paths like
> $project/$action/somebranch:/somefile..otherbranch:/otherfile are parsed
> as well.
>

In short, it allows to have link to '*diff' views using path_info URL,
or in general to pass $hash_[parent_]base and $file_parent using
path_info.
 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |   26 ++++++++++++++++++++++++--
>  1 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 3e5b2b7..89e360f 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -534,7 +534,9 @@ if ($path_info && !defined $action) {
>  
>  # we can now parse ref and pathnames in PATH_INFO
>  if ($path_info) {
> -	my ($refname, $pathname) = split(/:/, $path_info, 2);
> +	$path_info =~ /^((.+?)(:(.+))?\.\.)?(.+?)(:(.+))?$/;
> +	my ($parentrefname, $parentpathname, $refname, $pathname) = (
> +		$2, $4, $5, $7);

Style: I would use (but that is perhaps matter of taste)

+	my ($parentrefname, $parentpathname, $refname, $pathname) =
+		($2, $4, $5, $7);

Also it would be I think simpler to use instead non-catching grouping,
i.e. (?: xxx ) extended pattern (see perlre(1)), and use 
($1, $2, $3, $4), or even simpler  'list = (string =~ regexp)'  form.  


I also think that the situation is more complicated than that, if we
want to be more correct.  

The following path_info layouts with '..' make sense:

  hpb:fp..hb:f
  hpb..hb:f     == hpb:f..hb:f
  hp..h

And the layout below can be though to make sense, but it is just
plain weird.

  hpb:fp..f     == hpb:fp..HEAD:f
  

>  	if (defined $pathname) {
>  		# we got "project.git/action/branch:filename" or "project.git/action/branch:dir/"
>  		# we could use git_get_type(branch:pathname), but it needs $git_dir
> @@ -543,7 +545,11 @@ if ($path_info) {
>  			$input_params{'action'} ||= "tree";
>  			$pathname =~ s,/$,,;
>  		} else {
> -			$input_params{'action'}  ||= "blob_plain";
> +			if ($parentrefname) {
> +				$input_params{'action'} ||= "blobdiff_plain";
> +			} else {
> +				$input_params{'action'} ||= "blob_plain";
> +			}

Good catch.

>  		}
>  		$input_params{'hash_base'} ||= $refname;
>  		$input_params{'file_name'} ||= $pathname;
> @@ -553,6 +559,22 @@ if ($path_info) {
>  		$input_params{'hash'}      ||= $refname;
>  		$input_params{'hash_base'} ||= $refname;
>  	}
> +	# the parent part might be missing the pathname, in which case we use the $file_name, if present
> +	if (defined $parentrefname) {
> +		$input_params{'hash_parent_base'} ||= $parentrefname;
> +		if ($parentpathname) {
> +			$parentpathname =~ s,^/+,,;
> +			$parentpathname =~ s,/$,,;
> +			$input_params{'file_parent'} ||= $parentpathname;
> +		} else {
> +			$input_params{'file_parent'} ||= $input_params{'file_name'};
> +		}
> +		if (defined $input_params{'file_parent'}) {
> +			$input_params{'hash_parent'} ||= git_get_hash_by_path($input_params{'hash_parent_base'}, $input_params{'file_parent'});

This line is bit long, and I think it should be wrapped..

> +		} else {
> +			$input_params{'hash_parent'} ||= $parentrefname;
> +		}
> +	}
>  }

-- 
Jakub Narebski
Poland
