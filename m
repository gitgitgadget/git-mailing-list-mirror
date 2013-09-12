From: Jeff King <peff@peff.net>
Subject: Re: Specifying a private key when connecting to a remote SSH repo
Date: Thu, 12 Sep 2013 01:19:13 -0400
Message-ID: <20130912051913.GA1977@sigill.intra.peff.net>
References: <CAOgHByvTtNDho50B+pECMeXkq=3FF8EheFbP4iQbKYTiAPTwYw@mail.gmail.com>
 <xmqqeh8ur6uc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Breck Yunits <breck7@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 07:19:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJzJJ-00058H-EX
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 07:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738Ab3ILFTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 01:19:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:51760 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752491Ab3ILFTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 01:19:16 -0400
Received: (qmail 30081 invoked by uid 102); 12 Sep 2013 05:19:16 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Sep 2013 00:19:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Sep 2013 01:19:13 -0400
Content-Disposition: inline
In-Reply-To: <xmqqeh8ur6uc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234624>

On Wed, Sep 11, 2013 at 09:39:55PM -0700, Junio C Hamano wrote:

> If the only thing you are interested in supporting is a one-shot
> invocation, i.e. giving which identity file to use from the command
> line when you run either "git push" or "git fetch", I suspect that
> you could play with GIT_SSH environment variable, e.g.
> 
>     GIT_SSH_IDENTITY_FILE=$HOME/.ssh/id_for_example_com git push
> 
> and do something ugly like the attached, I suppose.

We already have GIT_SSH, so I would expect:

  GIT_SSH='ssh -i $HOME/.ssh/id_for_example_com' git push

to work. But sadly, GIT_SSH does not use the shell, unlike most other
configure git commands. :(

We could consider it a consistency bug and fix it, though I suspect we
may be annoying people on Windows who have spaces in their paths.

If we do go the route of adding a new variable, it would make sense to
add something for specifying arbitrary arguments, not just the identity
file. Something like GIT_SSH_ARGS would be enough, though once you start
handling splitting, dequoting, and interpreting variables, you're better
off using the shell. So maybe GIT_SSH_SHELL or similar as a preferred
version of GIT_SSH that uses the shell.

> It also crossed my mind that you could (ab)use the credential helper
> framework and ask it to return not the password but the identity
> filename, and pass it down the callchain to git_connect(), but again
> you will have to teach the credential helper as many settings as you
> would need to make in ~/.ssh/config anyway, so I find it dubious how
> it would be a win.

You could write a credential helper shell script that knows about
classes of remotes (e.g., selecting an identity file based on the
hostname), and write only a few lines to cover a large number of hosts.
For example:

  #!/bin/sh
  test "$1" = "get" || exit 0
  while IFS== read key val; do
    test "$key" = "host" || continue
    case "$val" in
      *.example.com) echo sshident=com_key ;;
      *.example.net) echo sshident=net_key ;;
    esac
  done

But it feels a bit hacky to be using the credential helpers at all for
ssh connections.

-Peff
