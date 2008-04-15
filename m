From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Clarify documentation of git-cvsserver, particularly in
 relation to git-shell
Date: Tue, 15 Apr 2008 11:27:54 -0700
Message-ID: <7vve2jx9at.fsf@gitster.siamese.dyndns.org>
References: <1208273402-2152-1-git-send-email-scc@ScottCollins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Scott Collins <scc@ScottCollins.net>
X-From: git-owner@vger.kernel.org Tue Apr 15 20:37:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlptj-0004RJ-QZ
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 20:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765AbYDOS2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 14:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbYDOS2G
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 14:28:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62928 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726AbYDOS2D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 14:28:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5236F2DE7;
	Tue, 15 Apr 2008 14:28:02 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 47C072DE5; Tue, 15 Apr 2008 14:27:58 -0400 (EDT)
In-Reply-To: <1208273402-2152-1-git-send-email-scc@ScottCollins.net> (Scott
 Collins's message of "Tue, 15 Apr 2008 11:30:02 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79616>

Scott Collins <scc@ScottCollins.net> writes:

> Currently, git-cvsserver requires CVS_SERVER to be set to 'cvs' if you are
> restricted to git-shell, so we need to mention that here.  Previous wording
> mentioning GIT_AUTHOR, GIT_COMMITTER variables may not have made clear we
> really meant GIT_AUTHOR_(NAME|COMMITTER), etc.  Add a bit of text to
> differentiate cvs -d (setting CVSROOT) from cvs co -d (setting the name of
> the newly checked out directory).
>
> Signed-off-by: Scott Collins <scc@ScottCollins.net>
> ---
>  Documentation/git-cvsserver.txt |   19 +++++++++++++------
>  1 files changed, 13 insertions(+), 6 deletions(-)

Thanks; please make it a habit to give a final round of proofreading
before you send your messages out.  For example, I do not think we meant
"GIT_AUTHOR_(NAME|COMMITTER)" ;-)

> diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
> index 9cec802..5e67a89 100644
> --- a/Documentation/git-cvsserver.txt
> +++ b/Documentation/git-cvsserver.txt
> @@ -106,7 +106,10 @@ Note: Newer CVS versions (>= 1.12.11) also support specifying
>  CVS_SERVER directly in CVSROOT like
>  
>  ------
> -cvs -d ":ext;CVS_SERVER=git-cvsserver:user@server/path/repo.git" co <HEAD_name>
> +cvs -d ":ext;CVS_SERVER=git-cvsserver:user@server/path/repo.git" co <HEAD_name> -d <dir_name>
> +
> +# or for git-shell users:
> +cvs -d ":ext;CVS_SERVER=cvs:user@server/path/repo.git" co <HEAD_name> -d <dir_name>
>  ------
>  This has the advantage that it will be saved in your 'CVS/Root' files and
>  you don't need to worry about always setting the correct environment
> @@ -146,7 +149,8 @@ allowing access over SSH.
>     appropriate git repo. For example:
>  +
>  --
> -For SSH access, CVS_SERVER should be set to git-cvsserver
> +For normal SSH access, CVS_SERVER should be set to git-cvsserver.  For those
> +whose access is restricted to git-shell, CVS_SERVER should be set to cvs.
>  
>  Example:

Hmm.  Can't this be further improved?

My undestanding of the reasoning behind 0c696fe (Support cvs via
git-shell, 2007-10-09) is by doing this people do not have to say
CVS_SERVER and do this instead:

	cvs -d :ext:[user@]cvs.example.com:/path/to/repo checkout foo

which would truly hide the fact that the server end is running something
funky, because the command line exactly matches how you would access the
real CVS repository over ssh.

Dscho, care to comment?  This commit happened while I was away so I do not
really _recall_ the discussion that led to it, but I have always thought
that was the intention.

> @@ -155,14 +159,17 @@ Example:
>       export CVS_SERVER=git-cvsserver
>  ------
>  --
> -4. For SSH clients that will make commits, make sure their .bashrc file
> -   sets the GIT_AUTHOR and GIT_COMMITTER variables.
> +4. For SSH clients that will make commits, make sure their (server-side) .bashrc
> +   files export GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, GIT_COMMITTER_NAME, and
> +   GIT_COMMITTER_EMAIL.
>  
>  5. Clients should now be able to check out the project. Use the CVS 'module'
> -   name to indicate what GIT 'head' you want to check out. Example:
> +   name to indicate what GIT 'head' you want to check out.  This also sets the
> +   name of your newly checked-out directory, unless you tell it otherwise with
> +   `-d <dir_name>` Example:
>  +
>  ------
> -     cvs co -d project-master master
> +     cvs co master -d project-master
>  ------

Are you sure you wanted to do this?  In any case this is different from
what I read you changed in your commit log message, where you clarified
distinction between d1 and d2 in "cvs -d d1 co -d d2 module".  Instead
what you did here is to change "cvs co -d d module" (which looks more
natural) to "cvs co module -d d" (which might work if the options are
reordered across parameters, but is unusual).
