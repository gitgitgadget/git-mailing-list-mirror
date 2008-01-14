From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-remote - Unset core.origin when deleting the
	default remote
Date: Mon, 14 Jan 2008 06:05:12 -0500
Message-ID: <20080114110512.GA12723@coredump.intra.peff.net>
References: <478A3284.1000102@gmail.com> <1200241631-3300-1-git-send-email-mlevedahl@gmail.com> <1200241631-3300-2-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.org, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 14 12:05:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEN8Y-0005CJ-SX
	for gcvg-git-2@gmane.org; Mon, 14 Jan 2008 12:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754948AbYANLFR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2008 06:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754967AbYANLFQ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jan 2008 06:05:16 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1282 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754937AbYANLFP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2008 06:05:15 -0500
Received: (qmail 5859 invoked by uid 111); 14 Jan 2008 11:05:13 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 14 Jan 2008 06:05:13 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Jan 2008 06:05:12 -0500
Content-Disposition: inline
In-Reply-To: <1200241631-3300-2-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70452>

On Sun, Jan 13, 2008 at 11:27:08AM -0500, Mark Levedahl wrote:

> --- a/git-remote.perl
> +++ b/git-remote.perl
> @@ -328,6 +328,11 @@ sub rm_remote {
>  
>  	$git->command('config', '--remove-section', "remote.$name");
>  
> +	my $defremote = $git->config("core.origin");
> +	if (defined $defremote && $defremote eq $name) {
> +	       $git->command("config", "--unset", "core.origin");
> +	}
> +

I'm not sure I see the use case that this helps. Presumably you are
doing one of (assuming your core.origin is 'foo'):

  - delete 'foo', and then proceed with usual git commands. In this
    case, your core.origin has reverted to 'origin', but what is the
    chance that you actually have such a remote (since you presumably
    cloned with -o foo)?

  - delete 'foo', then re-add 'foo'. I would expect this to be
    equivalent to editing the config, but as a side effect, your
    core.origin has mysteriously changed.

  - delete 'foo', then re-add 'bar' with the intent of making it your
    new origin. This doesn't help at all, since there's nothing
    automatically setting core.origin to 'bar', so you might as well
    leave it as the bogus 'foo' rather than the bogus 'origin'. And to
    help this use case, something like a "-d" flag to git-remote to set
    the new origin as the default might make sense. I.e.,

      git remote rm foo
      git remote add -d bar git://bar/project.git

    Alternatively, when adding a remote, if it is the _only_ remote (or
    perhaps if the current core.origin doesn't exist), we could set
    core.origin which would automagically cover the latter two cases.
    Although it feels a little too DWIM.

-Peff
