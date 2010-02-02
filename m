From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCH 8/8 v6] gitweb: Add an option to force version match
Date: Mon, 01 Feb 2010 17:01:37 -0800
Message-ID: <4B677971.2080100@eaglescrag.net>
References: <1264890645-28310-1-git-send-email-jnareb@gmail.com> <1264890645-28310-9-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 02:02:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc7A2-00074A-GH
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 02:02:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736Ab0BBBC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 20:02:26 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:60690 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117Ab0BBBCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 20:02:25 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o1211bYw012666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Mon, 1 Feb 2010 17:01:37 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091209 Fedora/3.0-4.fc12 Lightning/1.0pre Thunderbird/3.0
In-Reply-To: <1264890645-28310-9-git-send-email-jnareb@gmail.com>
X-Enigmail-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Mon, 01 Feb 2010 17:01:38 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138669>

Starting to pop off the stack, and this came up first.  A quick reading
of this, I'd sign-off and agree to patches 1-7 completely.

I'm still going to take issue that this being off by default is the
wrong behavior and leaving this off by default more or less means that
it will never get run and it becomes useless code.  If this isn't on by
default, it shouldn't be committed, as I can't think of a legitimate use
case where an admin is going to turn this on.

I'd still argue this needs to be on by default to at least give admins
the explicit warning that if they want to deviate they are taking their
own risks, and that gitweb might not run as expected.  Once the warning
is disabled in a configuration file it's not like it's going to be
re-enabled.  People loading gitweb from their distro's package
management will likely be in sync properly and will never see this.
Those who are installing gitweb independent of their distro's package
management will at least be warned of the risk, at least until better
error reporting is done and in gitweb.

I've got a slightly modified version of this that re-enables it by
default, it passes t9501 for me.

- John 'Warthog9' Hawley

On 01/30/2010 02:30 PM, Jakub Narebski wrote:
> From: John 'Warthog9' Hawley <warthog9@kernel.org>
> 
> This adds $git_versions_must_match variable, which if set to true,
> checks that we are running on the same version of git that we
> shipped with, and if not throw '500 Internal Server Error' error.
> What is checked is the version of gitweb (embedded in building
> gitweb.cgi), against version of runtime git binary used.
> 
> Gitweb can usually run with a mismatched git install.  This is more
> here to give an obvious warning as to what's going on vs. silently
> failing.
> 
> By default this feature is turned off.
> 
> Add tests to t9501-gitweb-standalone-http-status.sh that this feature
> works correctly (as expected) if turned on, both in match and no match
> case.
> 
> Signed-off-by: John 'Warthog9' Hawley <warthog9@kernel.org>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> Changes from version from 'Gitweb caching v5' and
>   git://git.kernel.org/pub/scm/git/warthog9/gitweb.git gitweb-ml-v5
> 
> * Again turned off by default
> * More detailed error description, as requested by Petr 'Pasky' Baudis
>   in http://permalink.gmane.org/gmane.comp.version-control.git/137922
> * Which in turn required to set $GITWEB_CONFIG_SYSTEM to be able to
>   use its value in error description; otherwise we would get 'Variable 
>   "$GITWEB_CONFIG_SYSTEM" is not imported' error.
> * Turn off forcing version matching in t/gitweb-lib.sh
> * Add some tests for this feature in t9501-gitweb-standalone-http-status.sh
> 
>  gitweb/README                            |    5 +++++
>  gitweb/gitweb.perl                       |   29 ++++++++++++++++++++++++++++-
>  t/gitweb-lib.sh                          |    1 +
>  t/t9501-gitweb-standalone-http-status.sh |   27 +++++++++++++++++++++++++++
>  4 files changed, 61 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/README b/gitweb/README
> index 6c2c8e1..83a25a9 100644
> --- a/gitweb/README
> +++ b/gitweb/README
> @@ -233,6 +233,11 @@ not include variables usually directly set during build):
>     If server load exceed this value then return "503 Service Unavaliable" error.
>     Server load is taken to be 0 if gitweb cannot determine its value.  Set it to
>     undefined value to turn it off.  The default is 300.
> + * $git_versions_must_match
> +   If set to true value, gitweb fails with "500 Internal Server Error" error
> +   if the version of the gitweb doesn't match version of the git binary.
> +   Gitweb can usually run with a mismatched git install.   The default is 0
> +   (false).
>  
>  
>  Projects list file format
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index d0c3ff2..e69efeb 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -221,6 +221,9 @@ our %avatar_size = (
>  	'double'  => 32
>  );
>  
> +# If it is true, exit if gitweb version and git binary version don't match
> +our $git_versions_must_match = 0;
> +
>  # Used to set the maximum load that we will still respond to gitweb queries.
>  # If server load exceed this value then return "503 server busy" error.
>  # If gitweb cannot determined server load, it is taken to be 0.
> @@ -550,10 +553,10 @@ sub filter_snapshot_fmts {
>  }
>  
>  our $GITWEB_CONFIG = $ENV{'GITWEB_CONFIG'} || "++GITWEB_CONFIG++";
> +our $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITWEB_CONFIG_SYSTEM++";
>  if (-e $GITWEB_CONFIG) {
>  	do $GITWEB_CONFIG;
>  } else {
> -	our $GITWEB_CONFIG_SYSTEM = $ENV{'GITWEB_CONFIG_SYSTEM'} || "++GITWEB_CONFIG_SYSTEM++";
>  	do $GITWEB_CONFIG_SYSTEM if -e $GITWEB_CONFIG_SYSTEM;
>  }
>  
> @@ -583,6 +586,30 @@ sub get_loadavg {
>  our $git_version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
>  $number_of_git_cmds++;
>  
> +# Throw an error if git versions does not match, if $git_versions_must_match is true.
> +if ($git_versions_must_match &&
> +    $git_version ne $version) {
> +	my $admin_contact =
> +		defined $ENV{'SERVER_ADMIN'} ? ", $ENV{'SERVER_ADMIN'}," : '';
> +	my $err_msg = <<EOT;
> +<h1 align="center">*** Warning ***</h1>
> +<p>
> +This version of gitweb was compiled for <b>@{[esc_html($version)]}</b>,
> +however git version <b>@{[esc_html($git_version)]}</b> was found on server,
> +and administrator requested strict version checking by setting
> +\$git_versions_must_match to @{[esc_html($git_versions_must_match)]}
> +(true value) in gitweb configuration file,
> +'@{[esc_path(-e $GITWEB_CONFIG ? $GITWEB_CONFIG : $GITWEB_CONFIG_SYSTEM)]}'.
> +</p>
> +<p>
> +Please contact the server administrator${admin_contact} to either configure
> +gitweb to allow mismatched versions, or update git or gitweb installation
> +so that their versions do match.
> +</p>
> +EOT
> +	die_error(500, 'Internal server error', $err_msg);
> +}
> +
>  $projects_list ||= $projectroot;
>  
>  if (defined $maxload && get_loadavg() > $maxload) {
> diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
> index 5a734b1..66a3e2d 100755
> --- a/t/gitweb-lib.sh
> +++ b/t/gitweb-lib.sh
> @@ -26,6 +26,7 @@ our \$projects_list = '';
>  our \$export_ok = '';
>  our \$strict_export = '';
>  our \$maxload = undef;
> +our \$git_versions_must_match = 0;
>  
>  EOF
>  
> diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitweb-standalone-http-status.sh
> index 7590f10..e195f97 100755
> --- a/t/t9501-gitweb-standalone-http-status.sh
> +++ b/t/t9501-gitweb-standalone-http-status.sh
> @@ -133,5 +133,32 @@ cat >>gitweb_config.perl <<\EOF
>  our $maxload = undef;
>  EOF
>  
> +# ======================================================================
> +# check $git_versions_must_match feature
> +# should be last section, just in case
> +cp -f gitweb_config.perl gitweb_config.perl.bak
> +echo 'our $git_versions_must_match = 1;' >>gitweb_config.perl
> +
> +cat <<\EOF >>gitweb_config.perl
> +our $version = "current";
> +EOF
> +test_expect_success 'force version match: no match' '
> +	gitweb_run "p=.git" &&
> +	grep "Status: 500 Internal Server Error" gitweb.headers &&
> +	grep "500 - Internal server error" gitweb.body
> +'
> +test_debug 'cat gitweb.headers'
> +
> +cat <<\EOF >>gitweb_config.perl
> +# must be kept in sync with code in gitweb/gitweb.perl
> +our $version = qx("$GIT" --version) =~ m/git version (.*)$/ ? $1 : "unknown";
> +EOF
> +test_expect_success 'force version match: match' '
> +	gitweb_run "p=.git" &&
> +	grep "Status: 200 OK" gitweb.headers
> +'
> +test_debug 'cat gitweb.headers'
> +
> +mv -f gitweb_config.perl.bak gitweb_config.perl
>  
>  test_done
