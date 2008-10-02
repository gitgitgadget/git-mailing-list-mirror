From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv4] gitweb: parse project/action/hash_base:filename PATH_INFO
Date: Thu, 2 Oct 2008 10:59:19 +0200
Message-ID: <200810021059.19708.jnareb@gmail.com>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com> <1222906234-8182-2-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 11:00:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlK3H-0000ry-VW
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 11:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753131AbYJBI7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 04:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753070AbYJBI7l
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 04:59:41 -0400
Received: from ik-out-1112.google.com ([66.249.90.178]:61719 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbYJBI7k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 04:59:40 -0400
Received: by ik-out-1112.google.com with SMTP id c30so637981ika.5
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 01:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=cWDnKf8r609ko6TXV6cYO+tNaTxEpeX8V28nO3T1ffw=;
        b=pfqWDUHcFWKnqSCdssB/W4w8jtflYrp0K/xC53HZSTf1o1TbTcUpT/prvhuh9ScSqp
         5qCwKeUUWhwsBGGi1XMd8K4+FPHKw+qA4K8eGyvzp2jg1mgRDgQ1UOOUvSKbOAgO6hLn
         av7xXSuQTqbN/RyRmRxUoqgMjGDZtx0HrKt8I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=b6yuEELc+Vz2FEISd5Yf0hG0YgbbLyvmU8tJhMi5I+I/4SNHaWEPVtKa9ALlvOyNws
         lkz4BfKzYwHaPUFnpKIWIt0wj8uSQgD+u1UIVg8vyeXQbbcqhsx/Gfm8aSpT9jYqLXEt
         Eq2f7Wyqrp7MwhyYFHjEZYCcMOUJP5VOaddFc=
Received: by 10.210.51.10 with SMTP id y10mr3095276eby.74.1222937978276;
        Thu, 02 Oct 2008 01:59:38 -0700 (PDT)
Received: from ?192.168.1.11? (abwk221.neoplus.adsl.tpnet.pl [83.8.234.221])
        by mx.google.com with ESMTPS id c4sm5747679nfi.13.2008.10.02.01.59.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Oct 2008 01:59:37 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1222906234-8182-2-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97297>

Giuseppe Bilotta wrote:

> This patch enables gitweb to parse URLs with more information embedded
> in PATH_INFO, reducing the need for CGI parameters. The typical gitweb
> path is now $project/$action/$hash_base:$file_name or
> $project/$action/$hash
> 
> This is mostly backwards compatible with the old-style gitweb paths,
> except when $project/$branch was used to access a branch whose name
> matches a gitweb action.

Nice summary.

> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |   90 +++++++++++++++++++++++++++++++---------------------
>  1 files changed, 54 insertions(+), 36 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index e7e4d6b..f088681 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -495,6 +495,37 @@ if (defined $searchtext) {
>  	$search_regexp = $search_use_regexp ? $searchtext : quotemeta $searchtext;
>  }
>  
> +# dispatch
> +my %actions = (
> +	"blame" => \&git_blame,
[...]
> +);

I'm not sure if the '# dispatch' comment is correct here now that
%actions hash is moved away from actual dispatch (selecting action
to run)

> @@ -519,9 +550,19 @@ sub evaluate_path_info {
>  	# do not change any parameters if an action is given using the query string
>  	return if $action;
>  	$path_info =~ s,^\Q$project\E/*,,;
> +
> +	# next comes the action
> +	$action = $path_info;
> +	$action =~ s,/.*$,,;

I would use here pattern matching, but your code is also good and
doesn't need changing; just for completeness below there is alternate
solution:

+	$path_info =~ m,^(.*?)/,;
+	$action = $1;

> +	if (exists $actions{$action}) {
> +		$path_info =~ s,^$action/*,,;
> +	} else {
> +		$action  = undef;
> +	}
> +

[...]
> @@ -534,8 +575,9 @@ sub evaluate_path_info {
>  		$file_name ||= validate_pathname($pathname);
>  	} elsif (defined $refname) {
>  		# we got "project.git/branch"

You meant here

  		# we got "project.git/branch" or "project.git/action/branch"

> -		$action ||= "shortlog";
> -		$hash   ||= validate_refname($refname);
> +		$action    ||= "shortlog";
> +		$hash      ||= validate_refname($refname);
> +		$hash_base ||= validate_refname($refname);
>  	}
>  }

This hunk is IMHO incorrect.  First, $refname is _either_ $hash, or
$hash_base; it cannot be both.  Second, in most cases (like the case
of 'shortlog' action, either explicit or implicit) it is simply $hash;
I think it can be $hash_base when $file_name is not set only in
singular exception case of 'tree' view for the top tree (lack of
filename is not an error, but is equivalent to $file_name='/').

> @@ -544,37 +586,6 @@ evaluate_path_info();
>  our $git_dir;
>  $git_dir = "$projectroot/$project" if $project;
>  
> -# dispatch
> -my %actions = (
[...]
> -);
> -
>  if (!defined $action) {
>  	if (defined $hash) {
>  		$action = git_get_type($hash);

I _think_ the '# dispatch' comment should be left here, and not moved
with the %actions hash.

> @@ -631,8 +642,15 @@ sub href (%) {
>  	if ($params{-replay}) {
>  		while (my ($name, $symbol) = each %mapping) {
>  			if (!exists $params{$name}) {
> -				# to allow for multivalued params we use arrayref form
> -				$params{$name} = [ $cgi->param($symbol) ];
> +				# the parameter we want to recycle may be either part of the
> +				# list of CGI parameter, or recovered from PATH_INFO
> +				if ($cgi->param($symbol)) {
> +					# to allow for multivalued params we use arrayref form
> +					$params{$name} = [ $cgi->param($symbol) ];
> +				} else {
> +					no strict 'refs';
> +					$params{$name} = $$name if $$name;

I would _perhaps_ add here comment that multivalued parameters can come
only from CGI query string, so there is no need for something like:

+					$params{$name} = (ref($$name) ? @$name : $$name) if $$name;

> +				}
>  			}
>  		}
>  	}

This fragment is a bit of ugly code, hopefully corrected in later patch.
I think it would be better to have 'refactor parsing/validation of input
parameters' to be very fist patch in series; I am not sure but I suspect
that is a kind of bugfix for current "$project/$hash" ('shortlog' view)
and "$project/$hash_base:$file_name" ('blob_plain' and 'tree' view)
path_info.

P.S. It is a bit of pity that Mechanize test from Lea Wiemann caching
gitweb code is not in the 'master' or at least 'pu'.  Using big, single,
monolithic patch instead of patch series of small, easy reviewable
commits strikes again... ;-(

-- 
Jakub Narebski
Poland
