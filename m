From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: refactor input parameters parse/validation
Date: Tue, 7 Oct 2008 12:57:36 +0200
Message-ID: <200810071257.38423.jnareb@gmail.com>
References: <1223054356-17643-1-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Matthias Lederhofer <matled@gmx.net>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 12:59:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnAHa-0006U0-Ua
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 12:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880AbYJGK5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 06:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752877AbYJGK5z
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 06:57:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:59394 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbYJGK5y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 06:57:54 -0400
Received: by ug-out-1314.google.com with SMTP id k3so191949ugf.37
        for <git@vger.kernel.org>; Tue, 07 Oct 2008 03:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version
         :content-disposition:content-type:content-transfer-encoding
         :message-id;
        bh=EJozGPwyohP9hT//6YcUZjerhEhnTv4Id0tbjvZiwv0=;
        b=uj3MnGlXQ2RcLs4qybKRoSx9+1VB6ZcjwJgdKF7Yk1zDYEOCL1B9NxYGVHF799Lzqr
         eMIp65mVRrb8uW4sw11wZ6ZauZIFNzgGfMiOFlFynGz6hW4+DhNRsSIi0DjkHA6GNwQ7
         xkLQ0np9gNjsCnhLPTlqrUTIL64oOF+mm2Hpw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-disposition:content-type
         :content-transfer-encoding:message-id;
        b=k3px9MHA/stW/WR48JnuDUh0P/IN34ibBm6gapOWSkqMIo8UrMl6yXz7e831fEOgct
         sENwr4QgdqVbtAfrLAcW9G26/+pANNknI5lmwsk4UWn3RzuKQssKig3I68xp0nSOE4aP
         SI21gB2Xg8ZJ088lWkGqXnLsYMz+zsazwP5Pk=
Received: by 10.67.24.13 with SMTP id b13mr778448ugj.40.1223377071496;
        Tue, 07 Oct 2008 03:57:51 -0700 (PDT)
Received: from ?192.168.1.11? (abvf55.neoplus.adsl.tpnet.pl [83.8.203.55])
        by mx.google.com with ESMTPS id m1sm1715419uge.51.2008.10.07.03.57.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Oct 2008 03:57:49 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1223054356-17643-1-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97689>

On Fri, 3 Oct 2008, Giuseppe Bilotta wrote:

> Since input parameters can be obtained both from CGI parameters and
> PATH_INFO, we would like most of the code to be agnostic about the way
> parameters were retrieved. We thus collect all the parameters into the
> new %input_params hash, delaying validation after the collection is
> completed.
> 
> Although the kludge removal is minimal at the moment, it makes life much
> easier for future expansions such as more extensive PATH_INFO use or
> other form of input (e.g. command-line support).

Looks good, beside double validation of parameters taken from path_info
(once in evaluate_path_info(), and once when setting 'action' variables).
 
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
> 
> As recommended by Jakub, I reworked the input parameter collection refactoring
> into a separate patch preluding to rather than intermixed with the PATH_INFO
> enhancement work.

Thanks.
 
>  gitweb/gitweb.perl |  304 +++++++++++++++++++++++++++++-----------------------
>  1 files changed, 171 insertions(+), 133 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 83f810a..329f789 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -29,7 +29,9 @@ our $my_uri = $cgi->url(-absolute => 1);
>  
>  # if we're called with PATH_INFO, we have to strip that
>  # from the URL to find our real URL
> -if (my $path_info = $ENV{"PATH_INFO"}) {
> +# we make $path_info global because it's also used later on
> +my $path_info = $ENV{"PATH_INFO"};
> +if ($path_info) {
>  	$my_url =~ s,\Q$path_info\E$,,;
>  	$my_uri =~ s,\Q$path_info\E$,,;
>  }

I think we could have left it as it was, i.e. have $path_info be
a local variable.  Unless there is something I don't see.

[...]
> +# input parameters are stored with the long parameter name as key, so we need
> +# the name -> CGI key mapping here. This will also be used in the href
> +# subroutine to convert parameters to their CGI equivalent.

Actually href() subroutine would be called many times, while parsing of
input params happens only once; that is why it is longname => shortname
hash, and not the reverse (shortname => longname).  Also it does not
result in loss of performance as we parse all input params anyway.

This explanation might be obvious, or could be put in comment
(increasing comment to code count ;-))

> +my @cgi_param_mapping = (
> +my %cgi_param_mapping = @cgi_param_mapping;
> +my %actions = (

Perhaps %allowed_options should also be there, to have everything about
input params in single place... or perhaps not...

> +# fill %input_params with the CGI parameters. All values except for 'opt'
> +# should be single values, but opt can be an array. We should probably
> +# build an array of parameters that can be multi-valued, but since for the time
> +# being it's only this one, we just single it out
> +while (my ($name, $symbol) = each %cgi_param_mapping) {
> +	if ($symbol eq 'opt') {
> +		$input_params{$name} = [$cgi->param($symbol)];

I would personally use "[ $cgi->param($symbol) ]" instead for better
(IMVHO) visibility, but this is just a matter of taste.

> +	} else {
> +		$input_params{$name} = $cgi->param($symbol);
> +	}
> +}

Nice. I guess that you have checked that you caught all
$cgi->param(...) calls, and there aren't any beside those above...


Now we don't have mdiff, following code movement; tool which was at
beginnings of content movement detection in early days of git-blame.
Therefore I have moved the original code, to easier check the changes
(separating them from code movement).

> -# now read PATH_INFO and use it as alternative to parameters
> -sub evaluate_path_info {
> -	return if defined $project;
> -	my $path_info = $ENV{"PATH_INFO"};
> -	return if !$path_info;
> -	$path_info =~ s,^/+,,;
> -	return if !$path_info;
> -	# find which part of PATH_INFO is project
> -	$project = $path_info;
> -	$project =~ s,/+$,,;
> -	while ($project && !check_head_link("$projectroot/$project")) {
> -		$project =~ s,/*[^/]*$,,;
> -	}
> -	# validate project
> -	$project = validate_pathname($project);
> -	if (!$project ||
> -	    ($export_ok && !-e "$projectroot/$project/$export_ok") ||
> -	    ($strict_export && !project_in_list($project))) {
> -		undef $project;
> -		return;
> -	}
> -	# do not change any parameters if an action is given using the query string
> -	return if $action;
> -	$path_info =~ s,^\Q$project\E/*,,;
> -	my ($refname, $pathname) = split(/:/, $path_info, 2);
> -	if (defined $pathname) {
> -		# we got "project.git/branch:filename" or "project.git/branch:dir/"
> -		# we could use git_get_type(branch:pathname), but it needs $git_dir
> -		$pathname =~ s,^/+,,;
> -		if (!$pathname || substr($pathname, -1) eq "/") {
> -			$action  ||= "tree";
> -			$pathname =~ s,/$,,;
> -		} else {
> -			$action  ||= "blob_plain";
> -		}
> -		$hash_base ||= validate_refname($refname);
> -		$file_name ||= validate_pathname($pathname);
> -	} elsif (defined $refname) {
> -		# we got "project.git/branch"
> -		$action ||= "shortlog";
> -		$hash   ||= validate_refname($refname);
> -	}
> -}
> -evaluate_path_info();


> +# now read PATH_INFO and update the parameter list for missing parameters
> +sub evaluate_path_info {
> +	return if defined $input_params{'project'};

I was 'my $path_info = $ENV{"PATH_INFO"};' there, when $path_info
wasn't global variable.  Any advantages to having it global?

(This is just a minor thing, not worth resending patch over, I think).

> +	return if !$path_info;
> +	$path_info =~ s,^/+,,;
> +	return if !$path_info;
> +

Nice adding lines to separate parts of code.

> +	# find which part of PATH_INFO is project
> +	my $project = $path_info;

Hmmm... now $project is local (lexically) here.

> +	$project =~ s,/+$,,;
> +	while ($project && !check_head_link("$projectroot/$project")) {
> +		$project =~ s,/*[^/]*$,,;
> +	}
> +	# validate project
> +	$project = validate_project($project);

I'm not sure if it is worth worrying over, but I think you repeat 
check_head_link() check here.

[After examining code further].  But I think you do double validation;
once you do it here, and once you do it copying to global variables
such as $action or $project, and double checking check_head_link()
won't be easy to avoid; fortunately it is cheap filesystem-level check
(might be slow only when stat is extremely slow, and is not cached).

> +	return unless $project;
> +	$input_params{'project'} = $project;
> +
> +	# do not change any parameters if an action is given using the query string
> +	return if $input_params{'action'};
> +	$path_info =~ s,^\Q$project\E/*,,;

Hmmm... I wonder if it is good idea. It was done in commit 645927c
(gitweb: fix warnings in PATH_INFO code and add export_ok/strict_export)
by Matthias Lederhofer, but I don't see why we do not remove project
from path_info if action is set.  But this is belongs probably to
independent code cleanup (if it is needed), so don't worry about that.

Perhaps it would be good to add empty line here before beginning of
'hash' and 'hash_base:file_name' handling.

> +	my ($refname, $pathname) = split(/:/, $path_info, 2);
> +	if (defined $pathname) {
> +		# we got "project.git/branch:filename" or "project.git/branch:dir/"
> +		# we could use git_get_type(branch:pathname), but it needs $git_dir

Additionally git_get_type(<extended sha1>) is additional call to git
(additional fork) currently; that might change with gitweb caching code,
which uses permanent connection to 'git cat-file --batch/--batch-check'
for that.

> +		$pathname =~ s,^/+,,;
> +		if (!$pathname || substr($pathname, -1) eq "/") {
> +			$input_params{'action'} = "tree";
> +			$pathname =~ s,/$,,;
> +		} else {
> +			$input_params{'action'} = "blob_plain";
> +		}
> +		$input_params{'hash_base'} ||= validate_refname($refname);
> +		$input_params{'file_name'} ||= validate_pathname($pathname);
> +	} elsif (defined $refname) {
> +		# we got "project.git/branch"
> +		$input_params{'action'} = "shortlog";
> +		$input_params{'hash'} ||= validate_refname($refname);
> +	}
> +}

Nice defensive programming with '||=' here for setting %input_params.

[After examining code further].  But I think you do double validation;
see comment below.

> +evaluate_path_info();
> +
> +our $action = $input_params{'action'};
>  if (defined $action) {
> -	if ($action =~ m/[^0-9a-zA-Z\.\-_]/) {
> +	if (!validate_action($action)) {
>  		die_error(400, "Invalid action parameter");
>  	}
>  }

Hmm... don't you do double validation now? Once in evaluate_path_info,
and once copying to global variables like $action?

Very nice moving param validation for 'a'/'action' parameter to 
validate_action() subroutine.
  
>  # parameters which are pathnames
> -our $project = $cgi->param('p');
> +our $project = $input_params{'project'};
>  if (defined $project) {
> -	if (!validate_pathname($project) ||
> -	    !(-d "$projectroot/$project") ||
> -	    !check_head_link("$projectroot/$project") ||
> -	    ($export_ok && !(-e "$projectroot/$project/$export_ok")) ||
> -	    ($strict_export && !project_in_list($project))) {
> +	if (!validate_project($project)) {
>  		undef $project;
>  		die_error(404, "No such project");
>  	}
>  }

Nice using validate_project() here.

> -our @extra_options = $cgi->param('opt');
> -if (defined @extra_options) {
> -	foreach my $opt (@extra_options) {
> -		if (not exists $allowed_options{$opt}) {
> -			die_error(400, "Invalid option parameter");
> -		}
> -		if (not grep(/^$action$/, @{$allowed_options{$opt}})) {
> -			die_error(400, "Invalid option parameter for this action");
> -		}
> +our @extra_options = @{$input_params{'extra_options'}};
> +# @extra_options is always defined, since it can only be (currently) set from
> +# CGI, and $cgi->param() returns the empty array in array context

...if param was not set.

Thanks for catching that.

> +foreach my $opt (@extra_options) {
> +	if (not exists $allowed_options{$opt}) {
> +		die_error(400, "Invalid option parameter");
> +	}
> +	if (not grep(/^$action$/, @{$allowed_options{$opt}})) {
> +		die_error(400, "Invalid option parameter for this action");
>  	}
>  }
  
> @@ -470,23 +587,23 @@ if (defined $hash_parent_base) {
>  }
>  
>  # other parameters
> -our $page = $cgi->param('pg');
> +our $page = $input_params{'page'};
>  if (defined $page) {
>  	if ($page =~ m/[^0-9]/) {

Nice, almost trivial change.

> @@ -604,35 +646,12 @@ sub href (%) {
[...]
>  	if ($params{-replay}) {
> -		while (my ($name, $symbol) = each %mapping) {
> +		while (my ($name, $symbol) = each %cgi_param_mapping) {
>  			if (!exists $params{$name}) {
> -				# to allow for multivalued params we use arrayref form
> -				$params{$name} = [ $cgi->param($symbol) ];
> +				$params{$name} = $input_params{$name};
>  			}
>  		}
>  	}

Nice cleanup.

> @@ -672,6 +691,25 @@ sub href (%) {
>  ## ======================================================================
>  ## validation, quoting/unquoting and escaping
>  
> +sub validate_action {
> +	my $input = shift || return undef;
> +	return undef unless exists $actions{$action};
> +	return $action;
> +}
> +
> +sub validate_project {
> +	my $input = shift || return undef;
> +	if (!validate_pathname($input) ||
> +		!(-d "$projectroot/$input") ||
> +		!check_head_link("$projectroot/$input") ||
> +		($export_ok && !(-e "$projectroot/$input/$export_ok")) ||
> +		($strict_export && !project_in_list($input))) {
> +		return undef;
> +	} else {
> +		return $input;
> +	}
> +}

Nice.

-- 
Jakub Narebski
Poland
