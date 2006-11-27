X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] revision traversal: Add --refs=<pattern> option
Date: Mon, 27 Nov 2006 15:59:33 -0800
Message-ID: <7vhcwke90a.fsf@assigned-by-dhcp.cox.net>
References: <7vzmadl5b0.fsf@assigned-by-dhcp.cox.net>
	<11646401513369-git-send-email-vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 00:00:25 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32465>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoqOP-0006IC-42 for gcvg-git@gmane.org; Tue, 28 Nov
 2006 01:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758629AbWK0X7f (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 27 Nov 2006
 18:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758630AbWK0X7f
 (ORCPT <rfc822;git-outgoing>); Mon, 27 Nov 2006 18:59:35 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:53163 "EHLO
 fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP id S1758629AbWK0X7e
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 27 Nov 2006 18:59:34 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061127235934.KREA18207.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>; Mon, 27
 Nov 2006 18:59:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id rzz11V00q1kojtg0000000; Mon, 27 Nov 2006
 18:59:02 -0500
To: Sergey Vlasov <vsu@altlinux.ru>
Sender: git-owner@vger.kernel.org

Sergey Vlasov <vsu@altlinux.ru> writes:

> Add the --refs=<pattern> option, which can be used to select a
> subset of refs matching the specified glob pattern.
>
> Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
> ---
>
>  If --all-branches is too specific for the mentioned use case,
>  what about adding a more general glob pattern match?

Traditionally any new option to rev-list must be accompanied
with a matching change to rev-parse.  I do not know offhand how
strictly we should adhere to this rule these days; it depends on
how people's script use rev-list.

Before revision.c "revision walking library" was done, many
Porcelain-ish commands were implemented as a pipeline that plugs
rev-list output to diff-tree.  These shell scripts took
parameters from the command line, and rev-parse was used to
separate parameters (both "flags" that begin with a dash and
"non-flags" that don't) that should be given to rev-list and the
other parameters (meant to be used by the shell script itself
but often are given straight to the downstream diff-tree).  The
rev-parse command has even the --sq option to facilitate this
usage:

	rev_opts=`git rev-parse --sq --default=HEAD --revs "$@"`
	diff_opts=`git rev-parse --sq --no-revs "$@"`
        eval "git-rev-list $rev_opts" |
        eval "git-diff-tree --stdin $diff_opts"

so that it can even pass -S'I want to find this string' to diff-tree
without worrying about spaces.

I personally feel that part of rev-parse outlived its usefulness
(--flags, --no-flags, --revs-only, and --no-revs).  It was a
useful hack, and served us well, but it was a hack.

In that sense it probably is Ok to leave it unmaintained, but it
might be a good idea to plan deprecating it, given that we have
been talking about UI warts.  If there are pipelines that can be
easily formed (with the help of rev-parse "parameter sifter"),
but whose functionality cannot be easily emulated with the
current crop of Porcelain-ish, we should work on polishing the
Porcelain-ish to make the pipelines unnecessary.

The remaining parts of rev-parse (the most important of which is
the --verify option) should probably stay.  The original
question of "list all the branches" can be done with:

	git rev-parse --symbolic --branches

