From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] trace: add GIT_TRACE_STDIN
Date: Wed, 17 Jun 2015 15:10:23 -0400
Message-ID: <20150617191023.GA25304@peff.net>
References: <20150616193102.GA15856@peff.net>
 <20150616193716.GC15931@peff.net>
 <20150616194907.GA15988@peff.net>
 <20150616212039.GA11353@peff.net>
 <CACsJy8DaJOOu7PA8jL+Mu3HQua-TRmzN378Mek1HuWVmRzT+ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Augie Fackler <augie@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 21:10:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5IjJ-0007SN-Ak
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 21:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756899AbbFQTK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 15:10:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:47571 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756613AbbFQTK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 15:10:26 -0400
Received: (qmail 29818 invoked by uid 102); 17 Jun 2015 19:10:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Jun 2015 14:10:26 -0500
Received: (qmail 28198 invoked by uid 107); 17 Jun 2015 19:10:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Jun 2015 15:10:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Jun 2015 15:10:23 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8DaJOOu7PA8jL+Mu3HQua-TRmzN378Mek1HuWVmRzT+ww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271881>

On Wed, Jun 17, 2015 at 05:04:04PM +0700, Duy Nguyen wrote:

> I wonder if we could do it a bit differently. Instead of
> GIT_TRACE_STDIN, I would add GIT_TRACE_HOOK that points to a script.
> Whenever a command is run via run-command interface, the actual
> command line to be executed would be "<hook script> <command>
> <arguments>".

Hmm, yeah, I like that. It's even more flexible, and it is much more
obvious why it works only for run-command. If we feed the resulting
"hooked" command to the shell, I think you could do:

  GIT_TRACE_HOOK='
    f() {
      case "$1 $2" in
      git pack-objects)
        tee /tmp/foo.out | "$@"
	;;
      esac
    }; f
  '

That is not 100% correct (you would miss "git --some-arg pack-objects"),
but it is probably fine in practice for debugging sessions. It is a bit
more complicated to use, but I really like the flexibility (I can
imagine that "GIT_TRACE_HOOK=gdbserver localhost:1234" would come in
handy).

> Because this script is given full command line, it can decide to trace
> something if the command name is matched (or arguments are matched) or
> just execute the original command. It's more flexible that trace.*
> config keys. We also have an opportunity to replace builtin commands,
> like pack-objects, in command pipeline in fetch or push with something
> else, to inject errors or whatever. It can be done manually, but it's
> not easy or convenient.

My other motive for trace.* was that we could have something like
"trace.prune", and have git-prune provide verbose debugging information.
We have custom patches like that on GitHub servers, which we've used to
debug occasional weirdness (e.g., you find that an object is missing
from a repo, but you have no clue why it went away; was it never there,
did somebody prune it, did it get dropped from a pack?).

I can send those upstream, but it would be nice not to introduce a
totally separate tracing facility when trace_* is so close. But it
needs:

  1. To be enabled by config, not environment.

  2. To support some basic output filename flexibility so the output can
     be organized (we write the equivalent of GIT_TRACE_FOO to
     $GIT_DIR/ghlog_foo/YYYY-MM-DD/YYYY-MM-DDTHH:MM:SS.PID).

For (1), we could just load trace.* in git_default_config; you couldn't
use it with any "early" tracing that happens before then, but I think in
practice it would be fine for most traces.

For (2), I think we could accomplish that with %-placeholders (like my
earlier patch), and the ability to write relative paths into $GIT_DIR
(again, you couldn't do this for "early" traces, but you could for other
stuff).

Or we could just do nothing. I'm not sure if anybody else is actually
interested in verbose-logging patches like these.

-Peff
