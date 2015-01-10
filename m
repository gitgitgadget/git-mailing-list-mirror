From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: make it play nicely with submodules
Date: Sat, 10 Jan 2015 22:11:21 +0000
Message-ID: <20150110221121.GA30202@dcvr.yhbt.net>
References: <1420901711-81679-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 23:11:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YA4Fi-00006f-IS
	for gcvg-git-2@plane.gmane.org; Sat, 10 Jan 2015 23:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755156AbbAJWLW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2015 17:11:22 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:42367 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752879AbbAJWLV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2015 17:11:21 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 628D21FA58;
	Sat, 10 Jan 2015 22:11:21 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1420901711-81679-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262273>

Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> +++ b/git-svn.perl
> @@ -337,6 +337,10 @@ for (my $i = 0; $i < @ARGV; $i++) {
>  # make sure we're always running at the top-level working directory
>  if ($cmd && $cmd =~ /(?:clone|init|multi-init)$/) {
>  	$ENV{GIT_DIR} ||= ".git";
> +	# catch the submodule case
> +	if (open(my $fh, '<', $ENV{GIT_DIR})) {
> +		$ENV{GIT_DIR} = $1 if <$fh> =~ /^gitdir: (.+)$/;
> +	}

How portable is open on a directory?  Perhaps it'd be better to
check if it's a file, first:

	if (-f $ENV{GIT_DIR}) {
		open(my $fh, '<', $ENV{GIT_DIR}) or
			die "failed to open $ENV{GIT_DIR}: $!\n";
		$ENV{GIT_DIR} = $1 if <$fh> =~ /^gitdir: (.+)$/;
	}
