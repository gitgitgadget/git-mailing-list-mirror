From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCH] gitweb: Include links to feeds in HTML header only for
 '200	OK' response
Date: Sat, 18 Dec 2010 12:10:17 -0800
Message-ID: <4D0D1529.6030806@eaglescrag.net>
References: <20101218195848.16201.67691.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 18 21:08:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PU34h-0007Ae-Hz
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 21:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158Ab0LRUIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 15:08:10 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:50397 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932135Ab0LRUIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 15:08:09 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oBIK82lN024002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Sat, 18 Dec 2010 12:08:02 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <20101218195848.16201.67691.stgit@localhost.localdomain>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Sat, 18 Dec 2010 12:08:03 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163928>

I've no objection, you can add a sign-off from me.

- John

On 12/18/2010 12:02 PM, Jakub Narebski wrote:
> To do that, generating "<link />"s to feeds were refactored into
> print_feed_meta() subroutine, to keep nesting (indent) level in
> git_header_html() low.  This has also the advantage of making code
> more clear.
> 
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
>  gitweb/gitweb.perl |   89 +++++++++++++++++++++++++++-------------------------
>  1 files changed, 47 insertions(+), 42 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index d521c93..d965cda 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3479,6 +3479,51 @@ sub get_page_title {
>  	return $title;
>  }
>  
> +sub print_feed_meta {
> +	if (defined $project) {
> +		my %href_params = get_feed_info();
> +		if (!exists $href_params{'-title'}) {
> +			$href_params{'-title'} = 'log';
> +		}
> +
> +		foreach my $format qw(RSS Atom) {
> +			my $type = lc($format);
> +			my %link_attr = (
> +				'-rel' => 'alternate',
> +				'-title' => esc_attr("$project - $href_params{'-title'} - $format feed"),
> +				'-type' => "application/$type+xml"
> +			);
> +
> +			$href_params{'action'} = $type;
> +			$link_attr{'-href'} = href(%href_params);
> +			print "<link ".
> +			      "rel=\"$link_attr{'-rel'}\" ".
> +			      "title=\"$link_attr{'-title'}\" ".
> +			      "href=\"$link_attr{'-href'}\" ".
> +			      "type=\"$link_attr{'-type'}\" ".
> +			      "/>\n";
> +
> +			$href_params{'extra_options'} = '--no-merges';
> +			$link_attr{'-href'} = href(%href_params);
> +			$link_attr{'-title'} .= ' (no merges)';
> +			print "<link ".
> +			      "rel=\"$link_attr{'-rel'}\" ".
> +			      "title=\"$link_attr{'-title'}\" ".
> +			      "href=\"$link_attr{'-href'}\" ".
> +			      "type=\"$link_attr{'-type'}\" ".
> +			      "/>\n";
> +		}
> +
> +	} else {
> +		printf('<link rel="alternate" title="%s projects list" '.
> +		       'href="%s" type="text/plain; charset=utf-8" />'."\n",
> +		       esc_attr($site_name), href(project=>undef, action=>"project_index"));
> +		printf('<link rel="alternate" title="%s projects feeds" '.
> +		       'href="%s" type="text/x-opml" />'."\n",
> +		       esc_attr($site_name), href(project=>undef, action=>"opml"));
> +	}
> +}
> +
>  sub git_header_html {
>  	my $status = shift || "200 OK";
>  	my $expires = shift;
> @@ -3528,48 +3573,8 @@ EOF
>  			print '<link rel="stylesheet" type="text/css" href="'.esc_url($stylesheet).'"/>'."\n";
>  		}
>  	}
> -	if (defined $project) {
> -		my %href_params = get_feed_info();
> -		if (!exists $href_params{'-title'}) {
> -			$href_params{'-title'} = 'log';
> -		}
> -
> -		foreach my $format qw(RSS Atom) {
> -			my $type = lc($format);
> -			my %link_attr = (
> -				'-rel' => 'alternate',
> -				'-title' => esc_attr("$project - $href_params{'-title'} - $format feed"),
> -				'-type' => "application/$type+xml"
> -			);
> -
> -			$href_params{'action'} = $type;
> -			$link_attr{'-href'} = href(%href_params);
> -			print "<link ".
> -			      "rel=\"$link_attr{'-rel'}\" ".
> -			      "title=\"$link_attr{'-title'}\" ".
> -			      "href=\"$link_attr{'-href'}\" ".
> -			      "type=\"$link_attr{'-type'}\" ".
> -			      "/>\n";
> -
> -			$href_params{'extra_options'} = '--no-merges';
> -			$link_attr{'-href'} = href(%href_params);
> -			$link_attr{'-title'} .= ' (no merges)';
> -			print "<link ".
> -			      "rel=\"$link_attr{'-rel'}\" ".
> -			      "title=\"$link_attr{'-title'}\" ".
> -			      "href=\"$link_attr{'-href'}\" ".
> -			      "type=\"$link_attr{'-type'}\" ".
> -			      "/>\n";
> -		}
> -
> -	} else {
> -		printf('<link rel="alternate" title="%s projects list" '.
> -		       'href="%s" type="text/plain; charset=utf-8" />'."\n",
> -		       esc_attr($site_name), href(project=>undef, action=>"project_index"));
> -		printf('<link rel="alternate" title="%s projects feeds" '.
> -		       'href="%s" type="text/x-opml" />'."\n",
> -		       esc_attr($site_name), href(project=>undef, action=>"opml"));
> -	}
> +	print_feed_meta()
> +		if ($status eq '200 OK');
>  	if (defined $favicon) {
>  		print qq(<link rel="shortcut icon" href=").esc_url($favicon).qq(" type="image/png" />\n);
>  	}
