From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/16] t4200: use cut instead of sed
Date: Thu, 13 Mar 2008 11:00:23 -0700
Message-ID: <7vtzjay05k.fsf@gitster.siamese.dyndns.org>
References: <cover.1205356737.git.peff@peff.net>
 <20080312213756.GI26286@coredump.intra.peff.net>
 <7vejaf1b0d.fsf@gitster.siamese.dyndns.org>
 <20080313125920.GF19485@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Whit Armstrong <armstrong.whit@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 13 19:01:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZrjt-0003pA-H4
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 19:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796AbYCMSAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 14:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753686AbYCMSAd
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 14:00:33 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45556 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022AbYCMSAc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 14:00:32 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F33EE5E21;
	Thu, 13 Mar 2008 14:00:30 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 3ECD35E1D; Thu, 13 Mar 2008 14:00:26 -0400 (EDT)
In-Reply-To: <20080313125920.GF19485@coredump.intra.peff.net> (Jeff King's
 message of "Thu, 13 Mar 2008 08:59:20 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77118>

Jeff King <peff@peff.net> writes:

> But the actual problem is that MERGE_RR lacks a trailing newline. I
> don't see any code to add newlines, even though it seems possible that
> we will write out several paths. So I think we need a newline here:
>
> diff --git a/builtin-rerere.c b/builtin-rerere.c
> index c607aad..e4a1dc1 100644
> --- a/builtin-rerere.c
> +++ b/builtin-rerere.c
> @@ -58,7 +58,8 @@ static int write_rr(struct path_list *rr, int out_fd)
>  		int length = strlen(path) + 1;
>  		if (write_in_full(out_fd, rr->items[i].util, 40) != 40 ||
>  		    write_in_full(out_fd, "\t", 1) != 1 ||
> -		    write_in_full(out_fd, path, length) != length)
> +		    write_in_full(out_fd, path, length) != length ||
> +		    write_in_full(out_fd, "\n", 1) != 1)
>  			die("unable to write rerere record");
>  	}
>  	if (commit_lock_file(&write_lock) != 0)

No, check 3f43d72392b6c0477debd7edbd49bae9b7f41e60^:git-rerere.perl; the
records in this file are supposed to be NUL terminated (the paths are
allowed to have LF in them).

> And unless I am missing something, rerere on multiple paths is very
> broken (but that seems weird, since this code is so old).

I do not recall offhand an example of multi-path rerere working or not
working correctly, but I am not surprised if the C re-implementation is
broken.  Will need to check.
