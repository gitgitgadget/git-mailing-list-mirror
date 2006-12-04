X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Set permissions of each new file before "cvs add"ing it.
Date: Sun, 03 Dec 2006 18:41:16 -0800
Message-ID: <7vbqmktmb7.fsf@assigned-by-dhcp.cox.net>
References: <87ac24zrk0.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 02:41:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <87ac24zrk0.fsf@rho.meyering.net> (Jim Meyering's message of
	"Sun, 03 Dec 2006 20:51:27 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33161>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gr3lg-00076a-Al for gcvg-git@gmane.org; Mon, 04 Dec
 2006 03:41:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758986AbWLDClS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 21:41:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759011AbWLDClR
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 21:41:17 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:8364 "EHLO
 fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP id S1758982AbWLDClR
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 21:41:17 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao12.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061204024116.LVTE4226.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>; Sun, 3
 Dec 2006 21:41:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id uShS1V0081kojtg0000000; Sun, 03 Dec 2006
 21:41:26 -0500
To: Jim Meyering <jim@meyering.net>
Sender: git-owner@vger.kernel.org

Jim Meyering <jim@meyering.net> writes:

> Without the following patch, git-cvsexportcommit would fail to propagate
> permissions of files added in git to the CVS repository.  I.e., when I
> added an executable script in coreutils' git repo, then tried to propagate
> that addition to the mirroring CVS repository, the script ended up added
> not executable there.

Thanks.  But...

> +# For any file we want to add to cvs, we must first set its permissions
> +# properly, *before* the "cvs add ..." command.  Otherwise, it is impossible
> +# to change the permission of the file in the CVS repository using only cvs
> +# commands.  This should be fixed in cvs-1.12.14.
> +sub set_new_file_permissions {
> +    my ($file) = @_;
> +    # Given input like this:
> +    # ba45154d8e9f5f49f46c8c2c2d8a554db7c3465f ...
> +    # :000000 100755 0000000... b595dc6... A  tests/du/one-file-system
> +    # extract the three octal permission digits:
> +    my $cmd = 'git-whatchanged --max-count=1 --pretty=oneline -- $f'
> +      . q! | sed -n '2s/^:00* [0-7][0-7][0-7]\([0-7][0-7][0-7]\) .*/\1/p'!;
> +    my $perm = `$cmd`;
> +
> +    chmod oct($perm), $file
> +      or die "failed to set permissions of \"$file\": $!\n";
> +}

Why sed in a Perl script ;-)?
