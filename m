From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 5/7] gitk: Make cherry-pick call git-citool on conflicts.
Date: Thu, 9 Oct 2008 18:42:33 +1100
Message-ID: <18669.46569.45285.170033@cargo.ozlabs.ibm.com>
References: <1223449540-20457-1-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-2-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-3-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-4-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-5-git-send-email-angavrilov@gmail.com>
	<1223449540-20457-6-git-send-email-angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 09:44:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnqBe-0008H2-CZ
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 09:43:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891AbYJIHml (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 03:42:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754557AbYJIHml
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 03:42:41 -0400
Received: from ozlabs.org ([203.10.76.45]:50085 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795AbYJIHmk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 03:42:40 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 51079DDF37; Thu,  9 Oct 2008 18:42:39 +1100 (EST)
In-Reply-To: <1223449540-20457-6-git-send-email-angavrilov@gmail.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97832>

Alexander Gavrilov writes:

> Now that git-gui has facilities to help users resolve
> conflicts, it makes sense to launch it from other gui
> tools when they happen.

Nice idea...

> +proc exec_citool {args {baseid {}}} {

I'm a little nervous about you having a parameter called "args", since
that specific name has a special meaning in Tcl; it's how Tcl handles
variable-length argument lists.

> +    global commitinfo env
> +
> +    if {[info exists env(GIT_AUTHOR_NAME)]} {
> +	set old_name $env(GIT_AUTHOR_NAME)
> +    }
> +    if {[info exists env(GIT_AUTHOR_EMAIL)]} {
> +	set old_email $env(GIT_AUTHOR_EMAIL)
> +    }
> +    if {[info exists env(GIT_AUTHOR_DATE)]} {
> +	set old_date $env(GIT_AUTHOR_DATE)
> +    }
> +
> +    if {$baseid ne {}} {
> +	if {![info exists commitinfo($baseid)]} {
> +	    getcommit $baseid
> +	}
> +	set author [lindex $commitinfo($baseid) 1]
> +	set date [lindex $commitinfo($baseid) 2]
> +	if {[regexp {^\s*(\S.*\S|\S)\s*<(.*)>\s*$} \
> +	            $author author name email]
> +	    && $date ne {}} {
> +	    set env(GIT_AUTHOR_NAME) $name
> +	    set env(GIT_AUTHOR_EMAIL) $email
> +	    set env(GIT_AUTHOR_DATE) $date
> +	}
> +    }
> +
> +    eval exec git citool $args &

If we can assume the existence of a shell (which we do elsewhere), we
can perhaps do this more simply by putting the environment variable
settings in the command before the command name.  It's a pity that git
citool won't take the author name/email/date as command-line arguments
or from a file, since it ends up being pretty verbose doing it the way
you have.

> @@ -7861,7 +7908,17 @@ proc cherrypick {} {
>      # no error occurs, and exec takes that as an indication of error...
>      if {[catch {exec sh -c "git cherry-pick -r $rowmenuid 2>&1"} err]} {
>  	notbusy cherrypick
> -	error_popup $err
> +	if {[regexp -line \
> +	    {Entry '(.*)' would be overwritten by merge} $err msg fname]} {
> +	    error_popup [mc "Cherry-pick failed: file '%s' had local modifications.
> +Your working directory is in an inconsistent state." $fname]

That message seems a bit too scary.  It's not inconsistent, it's just
got local modifications.  If I remember correctly, in this situation
git cherry-pick will back out all the changes it did and leave the
working directory as it was before.

> +	} elseif {[regexp -line {^CONFLICT \(.*\):} $err msg]} {
> +	    # Force citool to read MERGE_MSG
> +	    file delete [file join [gitdir] "GITGUI_MSG"]
> +	    exec_citool [list] $rowmenuid

[list] as an idiom for the empty list is a little unusual (here and
elsewhere in your patches); {} would be more usual.

Paul.
