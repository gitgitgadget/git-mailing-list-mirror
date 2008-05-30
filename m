From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Introduce core.showUntrackedFiles to make it
 possible to disable showing of untracked files.
Date: Fri, 30 May 2008 13:27:57 -0700
Message-ID: <7viqwvk04y.fsf@gitster.siamese.dyndns.org>
References: <043361f81946d5657217e6be0f22f4df350fd13f.1212152269.git.marius@trolltech.com> <3088e5a9507aa55ee55f512fb3bd554f1658d2e3.1212152269.git.marius@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Fri May 30 22:29:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2BDe-0002MQ-87
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 22:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246AbYE3U2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 16:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753113AbYE3U2G
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 16:28:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:52633 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753246AbYE3U2F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 16:28:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2CEFE239B;
	Fri, 30 May 2008 16:28:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5D4F92399; Fri, 30 May 2008 16:28:00 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E7E04A0E-2E86-11DD-A3D3-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83327>

Simon Hausmann <simon@lst.de> writes:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 5331b45..e42ead0 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -214,6 +214,11 @@ core.ignoreStat::
>  	See linkgit:git-update-index[1].
>  	False by default.
>  
> +core.showUntrackedFiles::
> +	A boolean to enable/disable displaying untracked files in the output
> +	of linkgit:git-status[1] and linkgit:git-commit[1].
> +	Defaults to true.
> +

This does not belong to the 'core.*', which is about the low-level
plumbing.  It perhaps could live in 'status.*' section, but I think you
can do better than introducing this as a boolean.

> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index c3c9f5b..a3174e4 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -150,12 +150,17 @@ but can be used to amend a merge commit.
>  	the last commit without committing changes that have
>  	already been staged.
>  
> +-U|--untracked::
> +	Show untracked files, in the "Untracked files:" section of commit
> +	message template.
> +	This option overrides the core.showUntrackedFiles
> +	configuration option, and is normally not needed.
> +
>  -u|--untracked-files::
>  	Show all untracked files, also those in uninteresting
> -	directories, in the "Untracked files:" section of commit
> -	message template.  Without this option only its name and
> +	directories.  Without this option only its name and
>  	a trailing slash are displayed for each untracked
> -	directory.
> +	directory. This option implies --untracked.

I wonder if we really need a new option that is half independent to an
existing one.

Step back a bit and think.  You have three choice:

 (1) Do not show untracked files at all; or

 (2) Show untracked but summarize untracked directories; or

 (3) Show all untracked files.

We have had (2) and (3) so far, and you are adding (1) as a new feature.
How about allowing -u on the command line to take an optional parameter to
say what kind the user wants?  I.e.

        -u=none		shows nothing (i.e. (1))
        -u=normal	shows summarized report (i.e. (2))
	-u=all		shows all untracked files (i.e. (3))

And (3) can also be spelled as "-u without parameter"; absense of -u
anywhere defaults to (2).  That would be the first patch.

Then, in the second patch, you can add support to 'status.showuntracked';
you pretend that it is set to 'normal' if it is not defined in the
configuration file.

Hmm?
