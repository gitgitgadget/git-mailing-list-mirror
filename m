From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC PATCH 1/6] gitweb: Hyperlink committags in a commit
 message by regex matching
Date: Wed, 18 Nov 2009 09:20:24 +0100
Message-ID: <20091118082024.GD12890@machine.or.cz>
References: <200906221318.19598.jnareb@gmail.com>
 <1258525350-5528-1-git-send-email-marcel@oak.homeunix.org>
 <1258525350-5528-2-git-send-email-marcel@oak.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Francis Galiegue <fge@one2team.net>
To: "Marcel M. Cary" <marcel@oak.homeunix.org>
X-From: git-owner@vger.kernel.org Wed Nov 18 09:20:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAfmG-0003RH-Ak
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 09:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbZKRIUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Nov 2009 03:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbZKRIUW
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Nov 2009 03:20:22 -0500
Received: from w241.dkm.cz ([62.24.88.241]:44340 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706AbZKRIUV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Nov 2009 03:20:21 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 06A7486201C; Wed, 18 Nov 2009 09:20:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1258525350-5528-2-git-send-email-marcel@oak.homeunix.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133152>

On Tue, Nov 17, 2009 at 10:22:25PM -0800, Marcel M. Cary wrote:
> One additional thing that occured to me is that maybe the hyperlinks
> added by committags should have 'rel="nofollow"' by default?  And if
> so, maybe that needs to be configurable?  On the other hand, I'm not
> sure how useful it is to hide real URLs in the commit messages from
> search engines... ?

I don't think rel="nofollow" is necessary.

BTW, wouldn't it be useful to do the matching in blob bodies as well?
And is it sensible to call these "committags" at all then? I already
made the mistake of calling content tags "ctags" and I regret it; I
think calling yet another thing tags after git tags and ctags is almost
unbearable.

> diff --git a/gitweb/INSTALL b/gitweb/INSTALL
> index b76a0cf..9081ed8 100644
> --- a/gitweb/INSTALL
> +++ b/gitweb/INSTALL
> @@ -132,6 +132,11 @@ adding the following lines to your $GITWEB_CONFIG:
>  	$known_snapshot_formats{'zip'}{'disabled'} = 1;
>  	$known_snapshot_formats{'tgz'}{'compressor'} = ['gzip','-6'];
>  
> +To add a committag to the default list of commit tags, for example to
> +enable hyperlinking of bug numbers to a bug tracker for all projects:
> +
> +	push @{$feature{'committags'}{'default'}}, 'bugzilla';
> +
>  
>  Gitweb repositories
>  -------------------

I think this is not useful at all, since:

	(i) The user will also *always* need to override the URL.
	(ii) More importantly, the user has no idea what on earth commit
	tags are.

Could you please prepend this paragraph with a short committags
description, e.g.:

	"Gitweb can rewrite certain snippets of text in commit messages
	to hyperlinks, e.g. URL addresses or bug tracker references - we
	call these snippets 'committags'."

And you should also add

	$committags{'buzilla'}{'options'}{'url'} = ...

to the explanation, together with a reference to the appropriate part of
gitweb.perl for more details.

> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index e4cbfc3..2d72202 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -213,6 +213,97 @@ our %avatar_size = (
>  	'double'  => 32
>  );
>  
> +# In general, the site admin can enable/disable per-project
> +# configuration of each committag.  Only the 'options' part of the
> +# committag is configurable per-project.

  The exact same problem here - it is not explained what committag
actually is and where it applies.

> +# The site admin can of course add new tags to this hash or override
> +# the 'sub' key if necessary.  But such changes may be fragile; this
> +# is not designed as a full-blown plugin architecture.  The 'sub' must
> +# return a list of strings or string refs.  The strings must contain
> +# plain text and the string refs must contain HTML.  The string refs
> +# will not be processed further.
> +#
> +# For any committag, set the 'override' key to 1 to allow individual
> +# projects to override entries in the 'options' hash for that tag.
> +# For example, to match only commit hashes given in lowercase in one
> +# project, add this to the $GITWEB_CONFIG:
> +#
> +#     $committags{'sha1'}{'override'} = 1;
> +#
> +# And in the project's config:
> +#
> +#     gitweb.committags.sha1.pattern = \\b([0-9a-f]{8,40})\\b
> +#
> +# Some committags have additional options whose interpretation depends
> +# on the implementation of the 'sub' key.  The hyperlink_committag
> +# value appends the first captured group to the 'url' option.
> +our %committags = (
> +	# Link Git-style hashes to this gitweb
> +	'sha1' => {
> +		'options' => {
> +			'pattern' => qr/\b([0-9a-fA-F]{8,40})\b/,
> +		},
> +		'override' => 0,
> +		'sub' => sub {
> +			my ($opts, @match) = @_;
> +			return \$cgi->a({-href => href(action=>"object", hash=>$match[1]),
> +			                 -class => "text"},
> +			                esc_html($match[0], -nbsp=>1));
> +		},
> +	},

Ideally, a link should be made only in case the object exists, but this
is not trivial to implement without overhead of 1 exec per object, so I
guess it's fine to leave this for later (after all this feature was
already present). In that case, I think it would be useful to start
matching ids from 5 characters up - I use these quite frequently ;) -
but until then it would probably make for too much false positives.

> @@ -417,6 +508,21 @@ our %feature = (
>  		'sub' => \&feature_avatar,
>  		'override' => 0,
>  		'default' => ['']},
> +
> +	# The selection and ordering of committags that are enabled.
> +	# Committag transformations will be applied to commit log messages
> +	# in the order listed here if listed here.

You should add something like "See %committags definition above for
explanation of committags and pre-defined committag classes."

> +	# To disable system wide have in $GITWEB_CONFIG
> +	# $feature{'committags'}{'default'} = [];
> +	# To have project specific config enable override in $GITWEB_CONFIG
> +	# $feature{'committags'}{'override'} = 1;
> +	# and in project config gitweb.committags = sha1, url, bugzilla
> +	# to enable those three committags for that project
> +	'committags' => {
> +		'sub' => sub { feature_list('committags', @_) },
> +		'override' => 0,
> +		'default' => ['sha1']},
>  );

Would people consider it harmful to add 'url' to the default set?

> @@ -463,16 +569,16 @@ sub feature_bool {
>  	}
>  }
>  
> -sub feature_snapshot {
> -	my (@fmts) = @_;
> +sub feature_list {
> +	my ($key, @defaults) = @_;
>  
> -	my ($val) = git_get_project_config('snapshot');
> +	my ($cfg) = git_get_project_config($key);
>  
> -	if ($val) {
> -		@fmts = ($val eq 'none' ? () : split /\s*[,\s]\s*/, $val);
> +	if ($cfg) {
> +		return ($cfg eq 'none' ? () : split(/\s*[,\s]\s*/, $cfg));
>  	}
>  
> -	return @fmts;
> +	return @defaults;
>  }
>  
>  sub feature_patches {
> @@ -886,6 +992,35 @@ if ($git_avatar eq 'gravatar') {
>  	$git_avatar = '';
>  }
>  
> +# ordering of committags
> +our @committags = gitweb_get_feature('committags');
> +
> +# whether we've loaded committags for the project yet
> +our $loaded_project_committags = 0;
> +
> +# Load committag configs from the repository config file and and
> +# incorporate them into the gitweb defaults where permitted by the
> +# site administrator.
> +sub gitweb_load_project_committags {
> +	return if (!$git_dir || $loaded_project_committags);

When can it happen that this is called and !$git_dir? In case it could
ever happen, why not allow the configuration at least in global gitweb
file?

> +	my %project_config = ();
> +	my %raw_config = git_parse_project_config('gitweb\.committag');
> +	foreach my $key (keys(%raw_config)) {
> +		next if ($key !~ /gitweb\.committag\.[^.]+\.[^.]/);
> +		my ($gitweb_prefix, $committag_prefix, $ctname, $option) =
> +			split(/\./, $key, 4);
> +		$project_config{$ctname}{$option} = $raw_config{$key};
> +	}
> +	foreach my $ctname (keys(%committags)) {
> +		next if (!$committags{$ctname}{'override'});
> +		foreach my $optname (keys %{$project_config{$ctname}}) {
> +			$committags{$ctname}{'options'}{$optname} =
> +				$project_config{$ctname}{$optname};
> +		}
> +	}
> +	$loaded_project_committags = 1;
> +}

For the next-conditions, I'd prefer unless formulation, but I guess
that's purely a matter of taste.

> +sub push_or_append (\@@) {
> +	my $fragments = shift;
> +
> +	if (ref $_[0] || ! @$fragments || ref $fragments->[-1]) {
> +		push @$fragments, @_;
> +	} else {
> +		my $a = pop @$fragments;
> +		my $b = shift @_;
> +
> +		push @$fragments, $a . $b, @_;
> +	}
> +	# imitate push
> +	return scalar @$fragments;

This looks *quite* cryptic, a comment would be rather helpful.

-- 
				Petr "Pasky" Baudis
A lot of people have my books on their bookshelves.
That's the problem, they need to read them. -- Don Knuth
