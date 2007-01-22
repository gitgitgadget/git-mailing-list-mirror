From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] New files in git weren't being downloaded during CVS update
Date: Sun, 21 Jan 2007 18:35:47 -0800
Message-ID: <7vmz4bwzy4.fsf@assigned-by-dhcp.cox.net>
References: <200701211425.12971.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 22 03:35:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8p2G-00055B-Lx
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 03:35:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbXAVCft (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 21:35:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751880AbXAVCft
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 21:35:49 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:55811 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbXAVCfs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 21:35:48 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070122023547.COWB9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Sun, 21 Jan 2007 21:35:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id E2c51W00X1kojtg0000000; Sun, 21 Jan 2007 21:36:06 -0500
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <200701211425.12971.andyparkins@gmail.com> (Andy Parkins's
	message of "Sun, 21 Jan 2007 14:25:12 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37388>

Andy Parkins <andyparkins@gmail.com> writes:

> If a repository was checked out via git-cvsserver and then later a new
> file is added to the git repository via some other method; a CVS update
> wasn't fetching the new file.
>
> It would be reported as a new file as
>  A some/dir/newfile.c
> but would never appear in the directory.
>
> The problem (I think) is that when git-cvsserver detected a new file, it
> was issuing the new file message then skipping the actual file send part
> and moving to the next file its list.  In fact only an updated file
> would be transmitted.
>
> The fix is to make the added file section identical to the udpated file
> section.  This additionally makes git-cvsserver behave like a
> traditional CVS server and will now output
>  U some/dir/newfile.c
> for an added file.
>
> Signed-off-by: Andy Parkins <andyparkins@gmail.com>
> ---
> This is in response to Simon Schubert's suggestion that T_ADDED is an
> inappropriate category for a remotely added file.  Instead this treats
> remotely added files the same as remotely changed files.

Martin, I think this looks like a sane change.  

I do not have anything other than the real CVS running on a
Linux box to try this change (most notably I do not do Eclipse
nor Tortoise) myself and I am reluctant to touch things I cannot
personally test at this stage near the release.  I am sure Andy
tested this for his own use in his environment, but I would
really appreciate a third party Ack from an environment
different from the originator of the patch.

>  git-cvsserver.perl |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index a33a876..501c182 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -879,11 +879,11 @@ sub req_update
>  	    elsif ( !defined($wrev) || $wrev == 0 )
>  	    {
>  	        $log->info("Tell the client the file will be added");
> -		print "MT text A \n";
> -                print "MT fname $filename\n";
> -                print "MT newline\n";
> -		next;
> -
> +			print "MT +updated\n";
> +			print "MT text U \n";
> +			print "MT fname $filename\n";
> +			print "MT newline\n";
> +			print "MT -updated\n";
>  	    }
>  	    else {
>                  $log->info("Updating '$filename' $wrev");
> -- 
> 1.5.0.rc1.gf4b6c
