From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: [PATCH] git-svn: Configure a prompt callback for gnome_keyring.
Date: Thu, 29 Aug 2013 11:42:05 +0200
Message-ID: <20130829094205.GO10217@login.drsnuggles.stderr.nl>
References: <20130618163609.GD10217@login.drsnuggles.stderr.nl>
 <1371573490-21973-1-git-send-email-matthijs@stdin.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Gustav Munkby <grddev@gmail.com>,
	Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 29 11:42:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEyk5-0005PF-2f
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 11:42:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755946Ab3H2JmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 05:42:12 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:40500 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755960Ab3H2JmK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 05:42:10 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1VEyju-0000ap-5G; Thu, 29 Aug 2013 11:42:07 +0200
Received: (nullmailer pid 2280 invoked by uid 1000);
	Thu, 29 Aug 2013 09:42:06 -0000
Mail-Followup-To: Matthijs Kooijman <matthijs@stdin.nl>,
	git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>,
	Gustav Munkby <grddev@gmail.com>, Edward Rudd <urkle@outoforder.cc>,
	Carsten Bormann <cabo@tzi.org>
Content-Disposition: inline
In-Reply-To: <1371573490-21973-1-git-send-email-matthijs@stdin.nl>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.0 AWL                    AWL: From: address is in the auto white-list
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233244>

Hi folks,

any chance this patch can be merged?

Gr.

Matthijs

On Tue, Jun 18, 2013 at 06:38:10PM +0200, Matthijs Kooijman wrote:
> This allows git-svn to prompt for a keyring unlock password, when a
> the needed gnome keyring is locked.
> 
> This requires changes in the subversion perl bindings which have been
> committed to svn trunk (r1241554 and some followup commits) and are
> first available in the 1.8.0 release.
> ---
>  perl/Git/SVN/Prompt.pm |  5 +++++
>  perl/Git/SVN/Ra.pm     | 13 +++++++++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/perl/Git/SVN/Prompt.pm b/perl/Git/SVN/Prompt.pm
> index e940b08..faeda01 100644
> --- a/perl/Git/SVN/Prompt.pm
> +++ b/perl/Git/SVN/Prompt.pm
> @@ -23,6 +23,11 @@ sub simple {
>  	$SVN::_Core::SVN_NO_ERROR;
>  }
>  
> +sub gnome_keyring_unlock {
> +	my ($keyring, $pool) = @_;
> +	_read_password("Password for '$keyring' GNOME keyring: ", undef);
> +}
> +
>  sub ssl_server_trust {
>  	my ($cred, $realm, $failures, $cert_info, $may_save, $pool) = @_;
>  	$may_save = undef if $_no_auth_cache;
> diff --git a/perl/Git/SVN/Ra.pm b/perl/Git/SVN/Ra.pm
> index 75ecc42..38ed0cb 100644
> --- a/perl/Git/SVN/Ra.pm
> +++ b/perl/Git/SVN/Ra.pm
> @@ -104,6 +104,19 @@ sub new {
>  		}
>  	} # no warnings 'once'
>  
> +	# Allow git-svn to show a prompt for opening up a gnome-keyring, if needed.
> +	if (defined(&SVN::Core::auth_set_gnome_keyring_unlock_prompt_func)) {
> +		my $keyring_callback = SVN::Core::auth_set_gnome_keyring_unlock_prompt_func(
> +			$baton,
> +			\&Git::SVN::Prompt::gnome_keyring_unlock
> +		);
> +		# Keep a reference to this callback, to prevent the function
> +		# (reference) from being garbage collected.  We just add it to
> +		# the callbacks value, which are also used only to prevent the
> +		# garbage collector from eating stuff.
> +		$callbacks = [$callbacks, $keyring_callback]
> +	}
> +
>  	my $self = SVN::Ra->new(url => $url, auth => $baton,
>  	                      config => $config,
>  			      pool => SVN::Pool->new,
> -- 
> 1.8.3.rc1
> 
