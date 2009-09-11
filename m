From: Jeff King <peff@peff.net>
Subject: Re: bash_completion outside repo
Date: Fri, 11 Sep 2009 10:17:30 -0400
Message-ID: <20090911141730.GA384@coredump.intra.peff.net>
References: <a3b675320909100813i3e70ab3at66408aebb9952c7d@mail.gmail.com>
 <20090911133313.GF2582@inocybe.localdomain>
 <a3b675320909110700k7eb7286qc8cb5691aae214c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
To: james bardin <jbardin@bu.edu>
X-From: git-owner@vger.kernel.org Fri Sep 11 16:17:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mm6wg-0001zL-BE
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 16:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752940AbZIKORd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2009 10:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752743AbZIKORd
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Sep 2009 10:17:33 -0400
Received: from peff.net ([208.65.91.99]:51769 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752563AbZIKORd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2009 10:17:33 -0400
Received: (qmail 7424 invoked by uid 107); 11 Sep 2009 14:17:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 11 Sep 2009 10:17:51 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Sep 2009 10:17:30 -0400
Content-Disposition: inline
In-Reply-To: <a3b675320909110700k7eb7286qc8cb5691aae214c7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128195>

On Fri, Sep 11, 2009 at 10:00:33AM -0400, james bardin wrote:

> I did a make install, and dropped the completion file in
> /etc/bash_completion.d/. No other settings changed. I did a quick
> check, and it happens with the current 1.6.5 snapshot too, and on a
> fedora 10 box I found.
> 
> It seems I only get this error if I don't have a global config.
> Touching ~/.gitconfig stops the error.

Ah, I see. It looks like we use "git config --list" to view several bits
of configuration. However, it is not happy if there is no config file to
list.

However, I'm not sure that "config --list" isn't broken. Inside a repo,
doing "git config --list" shows the repo config and my global config,
and exits with no error.  Outside a repo, it shows my global config, and
exits with no error. But if I _don't_ have global config, it produces an
error. Shouldn't it treat that as simply "no config is available"?

I also question why it is using "git config --list" at all in snippets
like this:

        for i in $(git --git-dir="$d" config --list); do
                case "$i" in
                remote.*.url=*)
                        i="${i#remote.}"
                        echo "${i/.url=*/}"
                        ;;
                esac
        done

instead of just using "git config --get-regexp 'remote\..*\.url'", which
would be slightly more efficient, and also doesn't have this bug. ;)

-Peff
