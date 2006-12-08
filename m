X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/5] rerere: avoid misrecording on a skipped or aborted rebase/am
Date: Fri, 08 Dec 2006 12:43:46 -0800
Message-ID: <7v7ix2i0e5.fsf@assigned-by-dhcp.cox.net>
References: <20061205092126.GE27236@soma>
	<11655749724034-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 20:44:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <11655749724034-git-send-email-normalperson@yhbt.net> (Eric
	Wong's message of "Fri, 8 Dec 2006 02:49:26 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33739>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsmZV-0002NB-2e for gcvg-git@gmane.org; Fri, 08 Dec
 2006 21:43:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1761191AbWLHUnu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 15:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761193AbWLHUnu
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 15:43:50 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:47588 "EHLO
 fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1761191AbWLHUnt (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 15:43:49 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061208204347.SDND9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>; Fri, 8
 Dec 2006 15:43:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id wLjA1V0021kojtg0000000; Fri, 08 Dec 2006
 15:43:10 -0500
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

Eric Wong <normalperson@yhbt.net> writes:

> +if (@ARGV && $ARGV[0] eq 'clear') {
> +	for my $path (keys %merge_rr) {
> +		my $name = $merge_rr{$path};
> +		if (-d "$rr_dir/$name") {
> +			rmtree(["$rr_dir/$name"]);
> +		}
> +	}
> +	unlink $merge_rr;
> +	exit 0;
> +}

Come to think of it, I am not sure about this one.  Don't you
need to make sure that there is no existing resolution before
removing it?  In other words, shouldn't the removal be like this?

	if (-d "$rr_dir/$name" && ! -f "$rr_dir/$name/postimage") {
		rmtree(["$rr_dir/$name"]);
	}

