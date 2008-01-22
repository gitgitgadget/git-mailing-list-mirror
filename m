From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Let "git svn" run "git gc --auto" occasionally
Date: Mon, 21 Jan 2008 16:30:26 -0800
Message-ID: <7vr6gawvkt.fsf@gitster.siamese.dyndns.org>
References: <20080119123557.GA30778@diana.vm.bytemark.co.uk>
	<20080119223249.8227.31460.stgit@yoghurt>
	<1200783050.5724.196.camel@brick> <20080120033737.GA7767@soma>
	<20080120093436.GA10924@diana.vm.bytemark.co.uk>
	<7vlk6k8fyp.fsf@gitster.siamese.dyndns.org>
	<20080121224818.GA8872@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>,
	Harvey Harrison <harvey.harrison@gmail.com>,
	git@vger.kernel.org, Kevin Ballard <kevin@sb.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Jan 22 01:31:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH72l-0001yf-Eo
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 01:31:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117AbYAVAam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 19:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756020AbYAVAam
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 19:30:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40285 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756000AbYAVAal (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 19:30:41 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DEC5052F3;
	Mon, 21 Jan 2008 19:30:39 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AF8952EF;
	Mon, 21 Jan 2008 19:30:33 -0500 (EST)
In-Reply-To: <20080121224818.GA8872@untitled> (Eric Wong's message of "Mon, 21
	Jan 2008 14:48:28 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71377>

Eric Wong <normalperson@yhbt.net> writes:

> Here's a conservative change for 1.5.4 (not at all tested):
>
> From dbccd8081c6422569a9ca1211e27f56a24fdf3f3 Mon Sep 17 00:00:00 2001
> From: Eric Wong <normalperson@yhbt.net>
> Date: Mon, 21 Jan 2008 14:37:41 -0800
> Subject: [PATCH] git-svn: default to repacking every 1000 commits
>
> This should reduce disk space usage when doing large imports.
> We'll be switching to "gc --auto" post-1.5.4 to handle
> repacking for us.
>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>  git-svn.perl |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/git-svn.perl b/git-svn.perl
> index 9f2b587..12745d5 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1408,11 +1408,9 @@ sub read_all_remotes {
>  }
>  
>  sub init_vars {
> -	if (defined $_repack) {
> -		$_repack = 1000 if ($_repack <= 0);
> -		$_repack_nr = $_repack;
> -		$_repack_flags ||= '-d';
> -	}
> +	$_repack = 1000 unless (defined $_repack && $_repack > 0);
> +	$_repack_nr = $_repack;
> +	$_repack_flags ||= '-d';
>  }
>  
>  sub verify_remotes_sanity {

Thanks, but I think you need to do something about this part:

2154:	if (defined $_repack && (--$_repack_nr == 0)) {

I'd say 

	if ($_repack && (--$_repack_nr == 0)) {
