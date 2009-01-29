From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvsserver: run post-update hook *after* update.
Date: Thu, 29 Jan 2009 14:48:05 -0800
Message-ID: <7v3af1enkq.fsf@gitster.siamese.dyndns.org>
References: <7viqo61mfq.fsf@gitster.siamese.dyndns.org>
 <1233266282-8010-1-git-send-email-stefan.karpinski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>,
	Michael Witten <mfwitten@mit.edu>, git@vger.kernel.org
To: Stefan Karpinski <stefan.karpinski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 23:49:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSfhd-0003cP-Iy
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 23:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071AbZA2WsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 17:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbZA2WsP
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 17:48:15 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58860 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbZA2WsP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 17:48:15 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 53725943C7;
	Thu, 29 Jan 2009 17:48:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9B322943C3; Thu,
 29 Jan 2009 17:48:07 -0500 (EST)
In-Reply-To: <1233266282-8010-1-git-send-email-stefan.karpinski@gmail.com>
 (Stefan Karpinski's message of "Thu, 29 Jan 2009 13:58:02 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E8EAED74-EE56-11DD-BF43-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107746>

Stefan Karpinski <stefan.karpinski@gmail.com> writes:

> CVS server was running the hook before the update action was
> actually done. This performs the update before the hook is called.
>
> The original commit that introduced the current incorrect behavior
> was 394d66d "git-cvsserver runs hooks/post-update". The error in
> ordering of the hook call appears to have gone unnoticed, but since
> git-cvsserver is supposed to emulate receive-pack, it stands to
> reason that the hook should be run *after* the update. Since this
> behavior is inconsistent with recieve-pack, users are either:
>
>   1) not using post-update hooks with git-cvsserver;
>   2) using post-update hooks that don't care whether they are
>      called before or after the actual update occurs;
>   3) using post-update hooks *only* with git-cvsserver, and
>      relying on the hook being called just before the update.
>
> This patch would affect only users in case 3. These users are
> depending on fairly obviously wrong behavior, and moreover they can
> simply change their current post-update into post-recieve hooks,
> and their systems will work correctly again.
>
> Signed-off-by: Stefan Karpinski <stefan.karpinski@gmail.com>
> ---
> I'm CCing Andy Parkins, Michael Witten, and Junio Hamano, who
> authored the other three commits implementing or affecting hooks in
> git-cvsserver (394d66d, cdf6328, b2741f6). If you could please take
> a look at this patch and comment on if it's harmful or not, it
> would be much appreciated.

I think I've seen this one before and I thought it was a sensible thing to
do (and perhaps I even said so here).

Is this a resend?  If so, let's queue it in at least 'next' and see if
anybody screams ;-).  For a program near the fringe like cvsserver, not
many people run it but the small number of people who run it gets hurt
rather quickly if the updated behaviour breaks their existing practice,
and sometimes breaking things for them would be the only way to extract
any response.  Yes, it is very unfortunate.

>  git-cvsserver.perl |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index c1e09ea..d2e6003 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -1413,14 +1413,14 @@ sub req_ci
>  		close $pipe || die "bad pipe: $! $?";
>  	}
>  
> +    $updater->update();
> +
>  	### Then hooks/post-update
>  	$hook = $ENV{GIT_DIR}.'hooks/post-update';
>  	if (-x $hook) {
>  		system($hook, "refs/heads/$state->{module}");
>  	}
>  
> -    $updater->update();
> -
>      # foreach file specified on the command line ...
>      foreach my $filename ( @committedfiles )
>      {
> -- 
> 1.6.0.3.3.g08dd8
