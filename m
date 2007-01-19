From: Junio C Hamano <junkio@cox.net>
Subject: Re: git ls-files -o under .git/ prints all repository files
Date: Fri, 19 Jan 2007 11:03:17 -0800
Message-ID: <7vtzymhma2.fsf@assigned-by-dhcp.cox.net>
References: <87r6trsu7n.wl@mail2.atmark-techno.com>
	<7vwt3jjywc.fsf@assigned-by-dhcp.cox.net>
	<45B07875.9030506@fs.ei.tum.de>
	<81b0412b0701182357l3a6d44fel58da50c7895fb6b4@mail.gmail.com>
	<45B0C7E6.4020509@op5.se>
	<1169214414.18684.25.camel@localhost.localdomain>
	<Pine.LNX.4.63.0701191600020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Kestenholz <lists@spinlock.ch>,
	Andreas Ericsson <ae@op5.se>, Alex Riesen <raa.lkml@gmail.com>,
	Simon 'corecode' Schubert <corecode@fs.ei.tum.de>,
	Yasushi SHOJI <yashi@atmark-techno.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 20:03:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7z1G-0000Nx-RT
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 20:03:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932844AbXASTDU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 14:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932845AbXASTDU
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 14:03:20 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:41256 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932844AbXASTDT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 14:03:19 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070119190318.QORQ26900.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jan 2007 14:03:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id D73b1W0111kojtg0000000; Fri, 19 Jan 2007 14:03:36 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701191600020.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 19 Jan 2007 16:00:48 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37191>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 19 Jan 2007, Matthias Kestenholz wrote:
> ...
>> Why not check for /.git/ somewhere inside the current working directory 
>> (pwd) ? That's the way mercurial does it currently, and I think that is 
>> a sane thing to do _if_ you want to protect the user from his own 
>> stupidity.
>
> There are valid reasons why you might want to have a (possibly 
> temporary) repository _inside_ the GIT_DIR. You'd break these cases.

You are right that strstr(here, "/.git/") is not a good check.

If we really care about this problem (and I am not yet starting
to think we might, but who knows, I reserve the right to change
my mind every once in a while), we could make the commands that
deal with working trees (that is, among the things under
discussion in this thread, 'git-clean' always is, and
'git-ls-files' only when it is given options like '-o', '-k',
'-m', '-i') when the cwd is GIT_DIR or a subdirectory of it.

If you did something like:

	mkdir /var/tmp/a
        cd /var/tmp/a
        git init-db
        cd .git
        GIT_DIR=.git git init-db
        git add .
	git ls-files
	echo junk >garbage
        git clean

the repository at /var/tmp/a/.git/.git ought to track HEAD,
config and friends in /var/tmp/a/.git directory.

Not that I am saying I think the above is a sensible use case.
