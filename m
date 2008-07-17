From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cvsserver: Add support for packed refs
Date: Thu, 17 Jul 2008 13:50:37 +0200 (CEST)
Message-ID: <alpine.LSU.1.00.0807171346560.3486@wbgn129.biozentrum.uni-wuerzburg.de>
References: <1216288877-12140-1-git-send-email-lars@public.noschinski.de> <1216288877-12140-2-git-send-email-lars@public.noschinski.de> <1216288877-12140-3-git-send-email-lars@public.noschinski.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, fabian.emmes@rwth-aachen.de
To: Lars Noschinski <lars@public.noschinski.de>
X-From: git-owner@vger.kernel.org Thu Jul 17 13:51:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJS1L-0007vy-KF
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 13:51:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655AbYGQLuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 07:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753543AbYGQLuk
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 07:50:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:46548 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751114AbYGQLuj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 07:50:39 -0400
Received: (qmail invoked by alias); 17 Jul 2008 11:50:37 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp047) with SMTP; 17 Jul 2008 13:50:37 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18NdmknEBcNQuaFsYyBZFR95VPQkpyswcflOANXCk
	Sh18RReILyu8An
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <1216288877-12140-3-git-send-email-lars@public.noschinski.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88833>

Hi,

On Thu, 17 Jul 2008, Lars Noschinski wrote:

> req_update still parses /refs/heads manually. Replace this by
> a call to show-ref.
> 
> Signed-off-by: Lars Noschinski <lars@public.noschinski.de>
> ---
>  git-cvsserver.perl |   25 +++++++++----------------
>  1 files changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index b00d1c2..0e4f5f9 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -947,24 +947,17 @@ sub req_update
>      # projects (heads in this case) to checkout.
>      #
>      if ($state->{module} eq '') {
> -	my $heads_dir = $state->{CVSROOT} . '/refs/heads';
> -	if (!opendir HEADS, $heads_dir) {
> -	    print "E [server aborted]: Failed to open directory, "
> -	      . "$heads_dir: $!\nerror\n";
> -	    return 0;
> -	}
> -        print "E cvs update: Updating .\n";
> -	while (my $head = readdir(HEADS)) {
> -	    if (-f $state->{CVSROOT} . '/refs/heads/' . $head) {
> -	        print "E cvs update: New directory `$head'\n";
> -	    }
> -	}
> -	closedir HEADS;
> -	print "ok\n";
> -	return 1;
> +        my $showref = `git show-ref --heads`;
> +        for my $line (split '\n', $showref) {
> +            if ( $line =~ m% refs/heads/(.*)$% ) {
> +                print "M $1\t$1\n";

In the removed part, I see that this changes behaviour from "E cvs update: 
..." to "M ...".

I do not know the CVS protocol well enough to know if that is still 
correct.

BTW from the removed part, it seems that the indentation was done with 
tabs formerly, and with spaces now; please use tabs instead.

Thanks,
Dscho
