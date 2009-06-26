From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] git svn: Support multiple branch and tag paths in the
 svn repository.
Date: Fri, 26 Jun 2009 15:20:42 -0400
Message-ID: <4A451F8A.9060501@xiplink.com>
References: <4A3A4945.6050307@drmicha.warpmail.net> <1245335463-4488-1-git-send-email-git@drmicha.warpmail.net> <4A3F9A44.8070805@xiplink.com> <4A410A90.1090101@xiplink.com> <20090625093602.GA3997@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Jun 26 21:22:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKGzh-00044S-Ep
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 21:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761444AbZFZTUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 15:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761438AbZFZTUy
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 15:20:54 -0400
Received: from smtp192.iad.emailsrvr.com ([207.97.245.192]:47319 "EHLO
	smtp192.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761254AbZFZTUx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 15:20:53 -0400
Received: from relay9.relay.iad.mlsrvr.com (localhost [127.0.0.1])
	by relay9.relay.iad.mlsrvr.com (SMTP Server) with ESMTP id 7F9811E5123
	for <git@vger.kernel.org>; Fri, 26 Jun 2009 15:20:56 -0400 (EDT)
Received: by relay9.relay.iad.mlsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id B41E81E2EDD;
	Fri, 26 Jun 2009 15:20:49 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
In-Reply-To: <20090625093602.GA3997@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122316>

Thanks a bunch, Eric!

Can I assume that since you've taken the commit into your repo that the feature will find itself into Junio's git at some point?

I'll send out a documentation patch shortly.

Is the svn_cmd wrapper simply a drop-in replacement for svn?  I can make that change, too.

		M.


Eric Wong wrote:
> Marc Branchaud <marcnarc@xiplink.com> wrote:
>> This enables git-svn.perl to read multiple 'branches' and 'tags' entries in
>> svn-remote config sections.  The init and clone subcommands also support
>> multiple --branches and --tags arguments.
>>
>> The branch (and tag) subcommand gets a new argument: --destination (or -d).
>> This argument is required if there are multiple branches (or tags) entries
>> configured for the remote Subversion repository.  The argument's value
>> specifies which branch (or tag) path to use to create the branch (or tag).
>> The specified value must match the left side (without wildcards) of one of
>> the branches (or tags) refspecs in the svn-remote's config.
>>
>> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
>> ---
>>
>> I got carried away making unit tests and went and implemented most of this...
>>
>> I'm fairly happy with this, except for the way the branch subcommand matches
>> refspecs.  The patch does a simple string comparison, but it'd be better to do
>> an actual glob.  I just couldn't track down the right function for that, so I
>> left it as a strcmp and hope that a gitizen can tell me how to glob here.
>>
>> (ps. I'm trying a new way to send patches -- apologies if it's mangled!)
> 
> Thanks Marc!  Everything looks fine here; I don't think I'll have time
> to test it myself any time soon but your test case looks good and
> doesn't break any of the other tests :)  Sorry for the delay, I haven't
> had access to my computer or email much in the past few weeks.
> 
> Acked and and pushed out to git://git.bogomips.org/git-svn along with a
> followup patch to convert the glob to a regexp for branching:
> 
> From f7050599310c18bd67b35b8d59486116b30ff1f6 Mon Sep 17 00:00:00 2001
> From: Eric Wong <normalperson@yhbt.net>
> Date: Thu, 25 Jun 2009 02:28:15 -0700
> Subject: [PATCH] git-svn: convert globs to regexps for branch destinations
> 
> Marc Branchaud wrote:
>> I'm fairly happy with this, except for the way the branch
>> subcommand matches refspecs.  The patch does a simple string
>> comparison, but it'd be better to do an actual glob.  I just
>> couldn't track down the right function for that, so I left it as
>> a strcmp and hope that a gitizen can tell me how to glob here.
> 
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
> 
>  I haven't actually tested it, and yes, it should probably be
>  moved to Git.pm even though it's not necessarily git-only...
> 
>  git-svn.perl |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 48e8aad..6c42e2a 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -646,7 +646,9 @@ sub cmd_branch {
>  		            " with the --destination argument.\n";
>  		}
>  		foreach my $g (@{$allglobs}) {
> -			if ($_branch_dest eq $g->{path}->{left}) {
> +			# SVN::Git::Editor could probably be moved to Git.pm..
> +			my $re = SVN::Git::Editor::glob2pat($g->{path}->{left});
> +			if ($_branch_dest =~ /$re/) {
>  				$glob = $g;
>  				last;
>  			}
