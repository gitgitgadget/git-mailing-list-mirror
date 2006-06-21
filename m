From: Dennis Stosberg <dennis@stosberg.net>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Wed, 21 Jun 2006 15:05:35 +0200
Message-ID: <20060621130535.G2b34d382@leonov.stosberg.net>
References: <e79921$u0e$1@sea.gmane.org> <46a038f90606201233p6283febbn9a46e36c3a666903@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 21 15:06:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ft2P0-00088R-Tg
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 15:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbWFUNFo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 09:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751552AbWFUNFo
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 09:05:44 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:15842 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1751550AbWFUNFo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jun 2006 09:05:44 -0400
Received: from leonov.stosberg.net (p213.54.85.218.tisdip.tiscali.de [213.54.85.218])
	by ncs.stosberg.net (Postfix) with ESMTP id 4EE7DAEBA065;
	Wed, 21 Jun 2006 15:05:31 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id 8770F10E04B; Wed, 21 Jun 2006 15:05:35 +0200 (CEST)
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90606201233p6283febbn9a46e36c3a666903@mail.gmail.com>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22266>

Martin Langhoff wrote:

> And, as you mention in your other post, mod_perl support. And a bit of
> speed. Gitweb rght now is really really slow.

A few days ago I have tried to run gitweb under mod_perl and these
are my results.  All of this hasn't got any real testing, so this is
more a request for comment.  I had to make two changes to gitweb to
get it running as a Registry script with mod_perl:

(1) With mod_perl you cannot access variables which were defined
    with "my" on file scope from subroutines.  Unless gitweb becomes
    split in separate packages the easiest solution is probably to
    use "our" to declare them.

(2) Setting %ENV has no effect on spawned processes under mod_perl,
    so the git commands would never find the project directories.
    My first thought was to set $GIT_DIR on the commands' command
    lines like in open($fh, '$GIT_DIR=blah git-rev-list ...') but it
    would lead to an extra shell being spawned on every invocation
    of a git command.

    So I added the possibility to set/override the path to the
    repository with a command line parameter.  For simplicity I
    handled that parameter in git.c.  The drawbacks are that it has
    to be given before the command name and that it won't work when
    commands are invoked as "git-command".

The gains vary hugely.  Inexpensive views like the title page, blob
and commit view are sped up by a factor of 5 to 8 for successive
requests.  The project summary in contrast issues quite a number of
calls to git, so the speedup is only a few percent for it.

Regards,
Dennis
