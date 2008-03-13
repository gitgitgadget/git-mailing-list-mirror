From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-cvsimport: fix initial checkout
Date: Thu, 13 Mar 2008 14:05:53 -0700
Message-ID: <7vve3qwczy.fsf@gitster.siamese.dyndns.org>
References: <1205435378-10411-1-git-send-email-marcandre.lureau@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin Langhoff <martin@catalyst.net.nz>
To: Marc-Andre Lureau <marcandre.lureau@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 22:06:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZudS-0004K2-US
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 22:06:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754613AbYCMVGI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 17:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753993AbYCMVGH
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 17:06:07 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38985 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbYCMVGG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 17:06:06 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EB68C1F65;
	Thu, 13 Mar 2008 17:06:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 35CAF1F62; Thu, 13 Mar 2008 17:06:01 -0400 (EDT)
In-Reply-To: <1205435378-10411-1-git-send-email-marcandre.lureau@gmail.com>
 (Marc-Andre Lureau's message of "Thu, 13 Mar 2008 21:09:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77138>

Marc-Andre Lureau <marcandre.lureau@gmail.com> writes:

> git-symbolic-ref HEAD returns master reference, even if the file does
> not exists. That prevents the initial checkout and fails in
> git-rev-parse.

I had an impression that this check was deliberately done, but I do not
recall the details.  Martin?

> diff --git a/git-cvsimport.perl b/git-cvsimport.perl
> index 95c5eec..1512fe4 100755
> --- a/git-cvsimport.perl
> +++ b/git-cvsimport.perl
> @@ -570,12 +570,16 @@ unless (-d $git_dir) {
>  	open(F, "git-symbolic-ref HEAD |") or
>  		die "Cannot run git-symbolic-ref: $!\n";
>  	chomp ($last_branch = <F>);
> -	$last_branch = basename($last_branch);
> -	close(F);
> -	unless ($last_branch) {
> +	if (-f "$git_dir/$last_branch") {
> +	    $last_branch = basename($last_branch);
> +	    unless ($last_branch) {
>  		warn "Cannot read the last branch name: $! -- assuming 'master'\n";
>  		$last_branch = "master";
> +	    }

In any case, what if last_branch is a branch with hierarchical name, I
have to wonder.  If you are on a branch whose name has a slash
in it, like "frotz/nitfol" when you start cvsimport, doesn't this (before
or after the patch) code break your repository?
