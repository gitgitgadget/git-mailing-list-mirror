From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv4] gitweb: refactor input parameters parse/validation
Date: Fri, 3 Oct 2008 03:36:30 +0200
Message-ID: <200810030336.31469.jnareb@gmail.com>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com> <1222906234-8182-2-git-send-email-giuseppe.bilotta@gmail.com> <1222906234-8182-3-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 03:50:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlZnz-0005EL-Ne
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 03:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753811AbYJCBsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 21:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753796AbYJCBsu
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 21:48:50 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:11631 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753781AbYJCBst (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 21:48:49 -0400
Received: by ey-out-2122.google.com with SMTP id 6so466206eyi.37
        for <git@vger.kernel.org>; Thu, 02 Oct 2008 18:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=RY8vy0K6+c4DqyV40iRG8AvHGa6B9woXBEHkMAvzTfg=;
        b=UFdykN84GOApFhIa2K3CIyko4IfCFOb7ewxGrhgeDFcz1YWQMbkaRlnuuOzISM/Cny
         YneTA47S7L/ivw90QKSzEiG3LukSEczZAN5oMHoHVi/gYE91gdztVcbUCXAeRSCSv06U
         /vnWYkMAD8HasDM5mdXRNr2rtryt6bVWAR8S8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=YKilwWTLcIKv9fQgw/v9t0Liw07btvBEOL6g8yXX7dmebI1ZCk2HcvuXqDHX7a/dj5
         iayHkq64eStT7jfYAudKwcN72A4+bstRbIpPslTRWRp735EljPqUd6Zn45NC77U+bpOJ
         NOzN6iGiQzAwzEWxvdNHXzEBqCUJ0Pk6sSMhc=
Received: by 10.210.111.4 with SMTP id j4mr432775ebc.182.1222998526945;
        Thu, 02 Oct 2008 18:48:46 -0700 (PDT)
Received: from ?192.168.1.11? (abvs210.neoplus.adsl.tpnet.pl [83.8.216.210])
        by mx.google.com with ESMTPS id 5sm3442182eyf.8.2008.10.02.18.48.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Oct 2008 18:48:45 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1222906234-8182-3-git-send-email-giuseppe.bilotta@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97387>

On Thu, 2 Oct 2008, Giuseppe Bilotta wrote:

> Since input parameters can now be obtained both from CGI parameters and
> PATH_INFO, we would like most of the code to be agnostic about the way
> parameters were retrieved.
> 

I'd prefer that this cleanup/refactoring patch was _first_ patch in
the series, as we were able to obtain parameters both from CGI query
parameters and from PATH_INFO ($project, $hash or $hash_base+$file_name)
_before_ first patch in this series.  So it correct not only issue
introduced by first patch (and fixed somewhat there), but what was
outstanding (but rare because gitweb did not generate such links)
issue.


> We thus collect all the parameters into the new %input_params hash,
> removing the need for ad-hoc kludgy code in href(). 

Alternate solution would be push data from PATH_INFO in query params
data using (for example)

  $cgi->param('a', $action);

or, naming parameters explicitely

  $cgi->param(-name=>'a', -value=>$action);

This avoids need for additional variable, reuses current code, and
nicely sidesteps issue whether to use long names for keys ('action',
'file_name') or short ones from CGI query ('a', 'f').


It would probably has to be at least partially written to check which
of those two solutions (%input_params or $cgi->param('a', $a)))
is better.

> As much of the 
> parameters validation code is now shared between CGI and PATH_INFO,
> although this requires PATH_INFO parsing to be interleaved into the main
> code instead of being factored out into its own routine.

I'm not sure if it is worth it then to unify parameters validation,
with such drawback.

> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
>  gitweb/gitweb.perl |  336 ++++++++++++++++++++++++++++------------------------
>  1 files changed, 183 insertions(+), 153 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index f088681..ec4326f 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -28,8 +28,10 @@ our $my_url = $cgi->url();
>  our $my_uri = $cgi->url(-absolute => 1);
>  
>  # if we're called with PATH_INFO, we have to strip that
> -# from the URL to find our real URL
> -if (my $path_info = $ENV{"PATH_INFO"}) {
> +# from the URL to find our real URL. PATH_INFO is kept
> +# as it's used later on for parameter extraction
> +my $path_info = $ENV{"PATH_INFO"};
> +if ($path_info) {
>  	$my_url =~ s,\Q$path_info\E$,,;
>  	$my_uri =~ s,\Q$path_info\E$,,;
>  }

This might be separate patch, if you wanted to increase your commit
count ;-)  More seriously I think it should be at least briefly
mentioned in commit message (make $path_info global).

> @@ -390,15 +392,111 @@ $projects_list ||= $projectroot;
>  
>  # ======================================================================
>  # input validation and dispatch
> -our $action = $cgi->param('a');
> -if (defined $action) {
> -	if ($action =~ m/[^0-9a-zA-Z\.\-_]/) {
> -		die_error(400, "Invalid action parameter");
> +
> +# input parameters can be collected from a variety of sources (presently, CGI
> +# and PATH_INFO), so we define an %input_params hash that collects them all
> +# together during validation: this allows subsequent uses (e.g. href()) to be
> +# agnostic of the parameter origin
> +
> +my %input_params = ();
> +
> +# input parameters are stored with the long parameter name as key, so we need
> +# the name -> CGI key mapping here. This will also be used in the href
> +# subroutine to convert parameters to their CGI equivalent.
> +#
> +# XXX: Warning: If you touch this, check the search form for updating,
> +# too.
> +
> +my @cgi_param_mapping = (
> +	project => "p",
> +	action => "a",
> +	file_name => "f",
> +	file_parent => "fp",
> +	hash => "h",
> +	hash_parent => "hp",
> +	hash_base => "hb",
> +	hash_parent_base => "hpb",
> +	page => "pg",
> +	order => "o",
> +	searchtext => "s",
> +	searchtype => "st",
> +	snapshot_format => "sf",
> +	extra_options => "opt",
> +	search_use_regexp => "sr",
> +);
> +my %cgi_param_mapping = @cgi_param_mapping;
> +
> +# we will also need to know the possible actions, for validation
> +my %actions = (
> +	"blame" => \&git_blame,
> +	"blobdiff" => \&git_blobdiff,
> +	"blobdiff_plain" => \&git_blobdiff_plain,
> +	"blob" => \&git_blob,
> +	"blob_plain" => \&git_blob_plain,
> +	"commitdiff" => \&git_commitdiff,
> +	"commitdiff_plain" => \&git_commitdiff_plain,
> +	"commit" => \&git_commit,
> +	"forks" => \&git_forks,
> +	"heads" => \&git_heads,
> +	"history" => \&git_history,
> +	"log" => \&git_log,
> +	"rss" => \&git_rss,
> +	"atom" => \&git_atom,
> +	"search" => \&git_search,
> +	"search_help" => \&git_search_help,
> +	"shortlog" => \&git_shortlog,
> +	"summary" => \&git_summary,
> +	"tag" => \&git_tag,
> +	"tags" => \&git_tags,
> +	"tree" => \&git_tree,
> +	"snapshot" => \&git_snapshot,
> +	"object" => \&git_object,
> +	# those below don't need $project
> +	"opml" => \&git_opml,
> +	"project_list" => \&git_project_list,
> +	"project_index" => \&git_project_index,
> +);

Nice, although I'm not sure if [%@]cgi_param_mapping has to global.
If we use long parameters names as keys, I think it has to, somewhat.
See also comment below.

> +
> +# fill %input_params with the CGI parameters. All values except for 'opt'
> +# should be single values, but opt can be an array. We should probably
> +# build an array of parameters that can be multi-valued, but since for the time
> +# being it's only this one, we just single it out
> +while (my ($name, $symbol) = each %cgi_param_mapping) {
> +	if ($symbol eq 'opt') {
> +		$input_params{$name} = [$cgi->param($symbol)];
> +	} else {
> +		$input_params{$name} = $cgi->param($symbol);
>  	}
>  }

If it was chosen to use short (CGI query) parameter names, the above
loop could be replaced by simple

  %input_params = $cgi->Vars;

or to be more exact, if we want to have multi-valued parameters stored
as array ref

  %input_params = map { [ split /\0/ ] if /\0/; } $cgi->Vars;


See CGI(3pm):

    When using this [Vars], the thing you must watch out for are multivalued CGI
    parameters.  Because a hash cannot distinguish between scalar and list con-
    text, multivalued parameters will be returned as a packed string, separated
    by the "\0" (null) character.  You must split this packed string in order
    to get at the individual values.
  
> -# parameters which are pathnames
> -our $project = $cgi->param('p');
> +# next, we want to parse PATH_INFO (which was already stored in $path_info at
> +# the beginning). This is a little hairy because PATH_INFO parsing needs some
> +# form of parameter validation, so we interleave parsing and validation.

I don't think it is a good idea. In my opinion, for my taste, it would
be better to separate evaluating path_info from the rest.

We could instead introduce convention that if variable (like $project)
is set, then it is assumed to be validated; if it is present only in
the %input_params hash, then it has to be validated.


On the other hand this ordering, first by parameter, then by method
of extraction could be seem quite equally valid.  Nevertheless I think
that previous flow with separate evaluate_path_info() and what should
be evaluate_CGI_query() has better encapsulation.

> +#
> +# The accepted PATH_INFO syntax is $project/$action/$hash or
> +# $project/$action/$hash_base:$file_name, where $action may be missing (mostly for
> +# backwards compatibility), so we need to parse and validate the parameters in
> +# this same order.
> +
> +# clear $path_info of any leading /
> +$path_info =~ s,^/+,,;
> +
> +our $project = $input_params{'project'};
> +if ($path_info && !defined $project) {
> +	# if $project was not defined by CGI, we try to extract it from
> +	# $path_info
> +	$project = $path_info;
> +	$project =~ s,/+$,,;
> +	while ($project && !check_head_link("$projectroot/$project")) {
> +		$project =~ s,/*[^/]*$,,;
> +	}
> +	$input_params{'project'} = $project;
> +} else {
> +	# otherwise, we suppress $path_info parsing altogether
> +	$path_info = undef;
> +}
> +
> +# project name validation
>  if (defined $project) {
>  	if (!validate_pathname($project) ||
>  	    !(-d "$projectroot/$project") ||

Note that this code does less checking if $project is in path_info than
for the case where it is set by CGI query. Perhaps there should be base
fast check in a loop, and more extensive test later.

> @@ -408,16 +506,66 @@ if (defined $project) {
>  		undef $project;
>  		die_error(404, "No such project");
>  	}
> +
> +	# we purge the $project name from the $path_info, preparing it for
> +	# subsequent parameters extraction
> +	$path_info =~ s,^\Q$project\E/*,, if defined $path_info;
> +} else {
> +	# we also suppress $path_info parsing if no project was defined
> +	$path_info = undef;
> +}

In evaluate_path_info it was simply 'return if...'; here with mentioned
interleaving it is harder and a bit hacky.

[cut]

> @@ -615,43 +676,12 @@ sub href (%) {
>  	# default is to use -absolute url() i.e. $my_uri
>  	my $href = $params{-full} ? $my_url : $my_uri;

[cut removed, or rather moved to beginning, @mapping]
  
>  	$params{'project'} = $project unless exists $params{'project'};
>  
>  	if ($params{-replay}) {
> -		while (my ($name, $symbol) = each %mapping) {
> -			if (!exists $params{$name}) {
> -				# the parameter we want to recycle may be either part of the
> -				# list of CGI parameter, or recovered from PATH_INFO
> -				if ($cgi->param($symbol)) {
> -					# to allow for multivalued params we use arrayref form
> -					$params{$name} = [ $cgi->param($symbol) ];
> -				} else {
> -					no strict 'refs';
> -					$params{$name} = $$name if $$name;
> -				}
> -			}
> +		while (my ($name, $val) = each %input_params) {
> +			$params{$name} = $input_params{$name}
> +				unless (exists $params{$name});

Very nice, short code.  Should be something like that from
the very beginning.

-- 
Jakub Narebski
Poland
