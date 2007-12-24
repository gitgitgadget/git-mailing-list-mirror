From: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [PATCH] git-send-email: Add --suppress-cc all
Date: Mon, 24 Dec 2007 13:59:10 -0800
Message-ID: <20071224215910.GK7242@mail.oracle.com>
References: <1198216860-487-1-git-send-email-git@davidb.org> <1198522902-12117-1-git-send-email-git@davidb.org> <20071224210325.GA7242@mail.oracle.com> <20071224212648.GA21070@old.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 24 23:01:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6vLz-0001Ft-7s
	for gcvg-git-2@gmane.org; Mon, 24 Dec 2007 23:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbXLXWAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2007 17:00:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751746AbXLXWAa
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Dec 2007 17:00:30 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:13281 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751580AbXLXWAa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2007 17:00:30 -0500
Received: from agmgw2.us.oracle.com (agmgw2.us.oracle.com [152.68.180.213])
	by agminet01.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id lBOM0RlI000884
	for <git@vger.kernel.org>; Mon, 24 Dec 2007 16:00:27 -0600
Received: from acsmt354.oracle.com (acsmt354.oracle.com [141.146.40.154])
	by agmgw2.us.oracle.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id lBO8PEIO023312
	for <git@vger.kernel.org>; Mon, 24 Dec 2007 15:00:27 -0700
Received: from ca-server1.us.oracle.com by acsmt354.oracle.com
	with ESMTP id 6523990901198533552; Mon, 24 Dec 2007 13:59:12 -0800
Received: from jlbec by ca-server1.us.oracle.com with local (Exim 4.67)
	(envelope-from <joel.becker@oracle.com>)
	id 1J6vKJ-00044J-Ne
	for git@vger.kernel.org; Mon, 24 Dec 2007 13:59:11 -0800
Content-Disposition: inline
In-Reply-To: <20071224212648.GA21070@old.davidb.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever
	come to perfection.
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69224>

On Mon, Dec 24, 2007 at 01:26:48PM -0800, David Brown wrote:
> Add the 'all' option to --suppress-cc, allowing easier suppression of
> everything.

	Thank you!
>
> Signed-off-by: David Brown <git@davidb.org>
> ---
> On Mon, Dec 24, 2007 at 01:03:25PM -0800, Joel Becker wrote:
>
>> +   all    - all of the above, thus only honoring '--to', '--cc', and
>>             '--bcc'
>
> I can squash this with the other patch if that would be cleaner.
>
> Dave
>
>  Documentation/git-send-email.txt |    2 +-
>  git-send-email.perl              |   11 ++++++++++-
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
> index 432f336..fdfb56e 100644
> --- a/Documentation/git-send-email.txt
> +++ b/Documentation/git-send-email.txt
> @@ -125,7 +125,7 @@ The --cc option must be repeated for each user you want on the cc list.
>  	avoid including the patch author, 'cc' will avoid including anyone
>  	mentioned in Cc lines in the patch, 'sob' will avoid including
>  	anyone mentioned in Signed-off-by lines, and 'cccmd' will avoid
> -	running the --cc-cmd.
> +	running the --cc-cmd.  'all' will suppress all auto cc values.
>  	Default is the value of 'sendemail.suppresscc' configuration value;
>  	if that is unspecified, default to 'self' if --suppress-from is
>  	specified, as well as 'sob' if --no-signed-off-cc is specified.
> diff --git a/git-send-email.perl b/git-send-email.perl
> index cb9adf2..ef16824 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -275,7 +275,7 @@ my(%suppress_cc);
>  if (@suppress_cc) {
>  	foreach my $entry (@suppress_cc) {
>  		die "Unknown --suppress-cc field: '$entry'\n"
> -			unless $entry =~ /^(cccmd|cc|author|self|sob)$/;
> +			unless $entry =~ /^(all|cccmd|cc|author|self|sob)$/;
>  		$suppress_cc{$entry} = 1;
>  	}
>  } else {
> @@ -284,6 +284,15 @@ if (@suppress_cc) {
>  	$suppress_cc{'sob'} = 1 unless $signed_off_cc;
>  }
>  +if ($suppress_cc{'all'}) {
> +	foreach my $entry (qw (ccmd cc author self sob)) {
> +		$suppress_cc{$entry} = 1;
> +	}
> +	delete $suppress_cc{'all'};
> +}
> +
> +printf "Suppressions: %s\n", join(',', keys(%suppress_cc));
> +
>  my ($repoauthor) = $repo->ident_person('author');
>  my ($repocommitter) = $repo->ident_person('committer');
>  
> -- 
> 1.5.3.7
>

-- 

"Can any of you seriously say the Bill of Rights could get through
 Congress today?  It wouldn't even get out of committee."
	- F. Lee Bailey

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
