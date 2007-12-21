From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [PATCH] git-send-email: Add --suppress-all-from option.
Date: Fri, 21 Dec 2007 03:05:32 -0800
Message-ID: <20071221110532.GG18627@ca-server1.us.oracle.com>
References: <1198216860-487-1-git-send-email-git@davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Fri Dec 21 12:06:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5fhn-00064T-TK
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 12:06:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbXLULFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 06:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752921AbXLULFv
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 06:05:51 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:36529 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbXLULFu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 06:05:50 -0500
Received: from rgmgw2.us.oracle.com (rgmgw2.us.oracle.com [138.1.186.111])
	by agminet01.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id lBLB5ZZk004046;
	Fri, 21 Dec 2007 05:05:36 -0600
Received: from acsmt357.oracle.com (acsmt357.oracle.com [141.146.40.157])
	by rgmgw2.us.oracle.com (Switch-3.2.4/Switch-3.2.4) with ESMTP id lBLB5Yh5001301;
	Fri, 21 Dec 2007 04:05:34 -0700
Received: from ca-server1.us.oracle.com by acsmt354.oracle.com
	with ESMTP id 6491601881198235133; Fri, 21 Dec 2007 03:05:33 -0800
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.67)
	(envelope-from <joel.becker@oracle.com>)
	id 1J5fh6-0007AQ-RJ; Fri, 21 Dec 2007 03:05:32 -0800
Content-Disposition: inline
In-Reply-To: <1198216860-487-1-git-send-email-git@davidb.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
	come to perfection.
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69057>

On Thu, Dec 20, 2007 at 10:01:00PM -0800, David Brown wrote:
> Sometimes, it is useful to be able to send a patch to a third party
s/Sometimes/Most of the time/g

> without the author of the patch being copied on the message.  An
> common example would be an internal discussion at a company to ask if
> a particular patch should be applied.  Some environments may even have
> policy against such mail being sent outside of the company.
> 
> Add the --suppress-all-from/--no-suppress-all-from options to avoid
> sending patches to the patch author, even if different from the
> sender.  Add the sendemail.suppressallfrom config option to allow this
> to have a different default.
> 
> Signed-off-by: David Brown <git@davidb.org>
Please-dog-yes: Joel Becker <jlbec@evilplan.org>

> ---
>  Documentation/git-send-email.txt |    7 +++++++
>  git-send-email.perl              |    9 ++++++++-
>  2 files changed, 15 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index f0bd285..5d06264 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -117,6 +117,13 @@ The --cc option must be repeated for each user you want on the cc list.
>          Default is the value of 'sendemail.suppressfrom' configuration value;
>          if that is unspecified, default to --no-suppress-from.
>  
> +--suppress-all-from, --no-suppress-all-from::
> +        If this is set, do not add the From: address to the cc: list,
> +        even if it is different than the person sending the email.
> +        Default is the value of the 'sendemail.suppressallfrom'
> +        configuration value; if that is unspecified, default to
> +        -no-suppress-all-from.
> +
>  --thread, --no-thread::
>  	If this is set, the In-Reply-To header will be set on each email sent.
>  	If disabled with "--no-thread", no emails will have the In-Reply-To
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 248d035..80265b5 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -90,6 +90,9 @@ Options:
>  
>     --suppress-from Suppress sending emails to yourself. Defaults to off.
>  
> +   --suppress-all-from Never automatically send to a patch author.
> +                  Defaults to off.
> +
>     --thread       Specify that the "In-Reply-To:" header should be set on all
>                    emails. Defaults to on.
>  
> @@ -174,7 +177,8 @@ if ($@) {
>  my ($quiet, $dry_run) = (0, 0);
>  
>  # Variables with corresponding config settings
> -my ($thread, $chain_reply_to, $suppress_from, $signed_off_cc, $cc_cmd);
> +my ($thread, $chain_reply_to, $suppress_from, $suppress_all_from);
> +my ($signed_off_cc, $cc_cmd);
>  my ($smtp_server, $smtp_server_port, $smtp_authuser, $smtp_authpass, $smtp_ssl);
>  my ($identity, $aliasfiletype, @alias_files, @smtp_host_parts);
>  
> @@ -182,6 +186,7 @@ my %config_bool_settings = (
>      "thread" => [\$thread, 1],
>      "chainreplyto" => [\$chain_reply_to, 1],
>      "suppressfrom" => [\$suppress_from, 0],
> +    "suppressallfrom" => [\$suppress_all_from, 0],
>      "signedoffcc" => [\$signed_off_cc, 1],
>      "smtpssl" => [\$smtp_ssl, 0],
>  );
> @@ -218,6 +223,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
>  		    "quiet" => \$quiet,
>  		    "cc-cmd=s" => \$cc_cmd,
>  		    "suppress-from!" => \$suppress_from,
> +		    "suppress-all-from!" => \$suppress_all_from,
>  		    "signed-off-cc|signed-off-by-cc!" => \$signed_off_cc,
>  		    "dry-run" => \$dry_run,
>  		    "envelope-sender=s" => \$envelope_sender,
> @@ -700,6 +706,7 @@ foreach my $t (@files) {
>  					$subject = $1;
>  
>  				} elsif (/^(Cc|From):\s+(.*)$/) {
> +					next if ($suppress_all_from);
>  					if (unquote_rfc2047($2) eq $sender) {
>  						next if ($suppress_from);
>  					}
> -- 
> 1.5.3.7
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 

Life's Little Instruction Book #456

	"Send your loved one flowers.  Think of a reason later."

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
