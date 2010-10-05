From: Mathias Lafeldt <misfire@debugon.org>
Subject: Re: [BUG] git-svn parses --pretty=medium log output, fails when log.decorate
 is true
Date: Tue, 05 Oct 2010 19:53:36 +0200
Message-ID: <4CAB6620.4000909@debugon.org>
References: <1286273926.2364.6.camel@wpalmer.simply-domain> <20101005165830.GA13413@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Will Palmer <wmpalmer@gmail.com>,
	Eric Wong <normalperson@yhbt.net>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 05 19:53:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3Bi4-0001WA-Od
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 19:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753663Ab0JERxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 13:53:47 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:51216 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724Ab0JERxq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 13:53:46 -0400
Received: from [192.168.2.2] (p54B945BF.dip.t-dialin.net [84.185.69.191])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MZhpC-1PJ4Qv1uIQ-00Kxej; Tue, 05 Oct 2010 19:53:40 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100915 Thunderbird/3.0.8
In-Reply-To: <20101005165830.GA13413@sigill.intra.peff.net>
X-Provags-ID: V02:K0:7KC475YfEKcxGQddXa/p3vLeTND6GjEqtfGZLb6DtFF
 mcTzVmxdjvmjAsBvCGMXLwTmWN3TJ2m8DKrpjg8qLzo3H0FAVE
 pfiSmTKfnan14jP1ETNSAsYRs9+ytf6GQ64UuMSVWzegBuy7UF
 J6ecvibtg3/dbde5rJJlf4e4Z5Wms5/FBLAb0hKfFLw9VEDb8D
 qUllQt9xq+MhpTlI4jXxmjqnCLgwfMG/470lwG+VhM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158219>

On 10/05/2010 06:58 PM, Jeff King wrote:
> On Tue, Oct 05, 2010 at 11:18:46AM +0100, Will Palmer wrote:
> 
>> I started receiving this error during "git svn dcommit" today:
>>
>> Use of uninitialized value $hash in string eq
>> at /home/wpalmer/libexec/git-core/git-svn line 1534.
>>
>> Examining that section reveals that git-svn is running 
>> "git log --no-color --first-parent --pretty=medium"
>>
>> and parsing the output in order to find commit hashes and git-svn-id:
>> lines. This breaks when log.decorate is true.
>>
>> This could be patched-up by adding "--no-decorate" to the options
>> git-svn passes, but that seems to me like it would just be adding to the
>> pile, as "--pretty=medium" is a moving target. I assume the correct
>> solution is to specify the format exactly as it is expected.
> 
> The problem isn't necessarily --pretty=medium, but that we are using
> "git log" instead of "git rev-list" (though because "git log" does have
> some features that rev-list does not have, we do turn off most
> configurable features for "git log --pretty=raw").
> 
> So I think the simplest thing is just the patch below (which has only
> been lightly tested by me):
> 
> -- >8 --
> Subject: [PATCH] git-svn: use rev-list instead of log
> 
> We are parsing the output, so we don't want user
> configuration like color or decorations to appear in the
> output. The simplest way to accomplish this is to use the
> rev-list plumbing instead of the log porcelain.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  git-svn.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index d292224..03d93d8 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1514,7 +1514,7 @@ sub cmt_sha2rev_batch {
>  
>  sub working_head_info {
>  	my ($head, $refs) = @_;
> -	my @args = ('log', '--no-color', '--first-parent', '--pretty=medium');
> +	my @args = ('rev-list', '--first-parent', '--pretty=medium');
>  	my ($fh, $ctx) = command_output_pipe(@args, $head);
>  	my $hash;
>  	my %max;

You're right. Using rev-list looks like a much cleaner solution.

In addition, I think we can replace the call to git-log in git_svn_log_cmd() too.

-Mathias
