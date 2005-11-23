From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-mv is not able to handle big directories
Date: Tue, 22 Nov 2005 22:14:48 -0800
Message-ID: <7voe4b7uw7.fsf@assigned-by-dhcp.cox.net>
References: <200511231141.57683.lan@ac-sw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 07:34:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EenuA-0007QZ-Ee
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 07:14:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbVKWGOv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 01:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030327AbVKWGOu
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 01:14:50 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:32676 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030325AbVKWGOu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 01:14:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051123061451.OINL25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 23 Nov 2005 01:14:51 -0500
To: Alexander Litvinov <lan@ac-sw.com>
In-Reply-To: <200511231141.57683.lan@ac-sw.com> (Alexander Litvinov's message
	of "Wed, 23 Nov 2005 11:41:57 +0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12605>

Alexander Litvinov <lan@ac-sw.com> writes:

> When moving directory with large number of files git-mv says:
>> git-mv jsp* .
> Can't exec "git-update-index": Argument list too long at /usr/local/bin/git-mv 
> line 193.
> git-update-index failed to add new names with code -1
>
> This patch fixes this by building list of files with limited len (currently 
> 5000) and executing git-update-index few times until all files will be 
> processed. I don't know how to determinate limit of command line but 5000 
> seems safe enougth to me.

Two comments.

(1) the argument limit is enforced by the operating system in
    bytes (including environment size unfortunately) so we might
    want to count bytes not number of paths.  I heard GNU xargs
    uses 131072 as the default limit.

(2) I wonder if we can detect this particular failure case and
    then fall back on splitting the arguments dynamically, maybe
    something like this:

	sub xargs_system {
        	my ($cmd, @args) = @_;
                my $rc = system(@$cmd, @args);
                if ($rc == 'argument list too long error') {
                	my (@args0) = splice(@args, 0, @args/2);
			$rc = xargs_system($cmd, @args0);
                        return $c if ($rc);
                        return xargs_system($cmd, @args);
		}
		return $rc;
	}

    and:

	$rc = xargs_system([qw(git-update-index --)], @changedfiles);
	$rc = xargs_system([qw(git-update-index --add --)], @addedfiles);
	...
