From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] config includes, take 2
Date: Mon, 6 Feb 2012 01:27:13 -0500
Message-ID: <20120206062713.GA9699@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 06 07:27:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuI2q-0008Ll-5a
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 07:27:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956Ab2BFG1Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 01:27:16 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58596
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750721Ab2BFG1P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 01:27:15 -0500
Received: (qmail 23993 invoked by uid 107); 6 Feb 2012 06:34:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Feb 2012 01:34:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2012 01:27:13 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190027>

I decided to drop the "read config from a ref" bits of the series. There
was some debate about what the proper workflow should be around projects
sharing config. And since I am not part of a project that does so, I
can't contribute anything empirical to the discussion. So I'll let that
part live on in the list archive, and somebody whose project really
wants to experiment with it can feel free to do so.

That leaves the file-inclusion bits:

  [1/2]: imap-send: remove dead code
  [2/2]: config: add include directive

The first patch is new in this round, and is a necessary cleanup for the
second patch (though it might be worth applying regardless).

The second patch corresponds to patch 1/4 from the previous round. Among
the functional changes are:

  1. do not use includes for "git config" in single-file mode

  2. do not respect include.foo.path

  3. perform cycle and duplicate detection on included files

Doing (3) actually ended up changing the implementation a fair bit. The
original implementation worked purely as a drop-in callback wrapper. But
to suppress duplicates, you need to know not just which files you've
included, but which files you started from. So either
git_config_from_file has to learn about the include mechanism, or each
caller has to manually mark the file it is about to read.

I ended up just teaching the config machinery about the include
mechanism. It meant more changes (because we now pass an extra "include"
argument between the config functions) but I think turns out much more
readable.

That being said, I'm having doubts about the idea of duplicate
suppression at all. Suppose I have a setup like this:

  git config -f foo test.value foo
  git config test.value repo
  git config include.path $PWD/foo
  git config --global test.value global
  git config --global include.path $PWD/foo

That is, two config files, each of which sets test.value but also
includes "foo". One might assume from this that the output of "git
config test.value" would be "foo". But because of duplicate suppression,
it's not.

We first read the global config, which sets the value to "global", then
includes foo, which overwrites it to "foo". Then we read the repo
config, which sets the value to "repo", and then does _not_ actually
read foo. Because git config is read linearly and later values tend to
overwrite earlier ones, we would want to suppress the _first_ instance
of a file, not the second (or really, the final if it is included many
times). But that is impossible to do without generating a complete graph
of includes and then pruning the early ones.

Sure, this is a trivial toy example, and by looking at all of the
inputs, you can see what is happening and fix it. But the point of
duplicate suppression was that individual config files wouldn't have to
know or care what was being included elsewhere. A slightly more
real-world example is this:

  1. A config file "/etc/git-defaults-foo.cfg" sets a bunch of
     reasonable defaults for some group of developers.

  2. One of the developers really likes these foo defaults, but wants to
     override one particular option. So he does this:

       git config --global include.path /etc/git-defaults-foo.cfg
       git config --global some.option override

  3. On one particular repo, though, this dev wants the stock foo
     defaults. So he does:

       git config --global include.path /etc/git-defaults-foo.cfg

But we ignore the final include request; it's suppressed as a duplicate,
even though it would cancel his override.

So I'm actually thinking I should drop the duplicate suppression and
just do some sort of sanity check on include-depth to break cycles
(i.e., just die because it's a crazy thing to do, and we are really just
trying to tell the user their config is broken rather than go into an
infinite loop). As a bonus, it makes the code much simpler, too.

I'll post the patch with duplicate suppression for reference, but read
it with a grain of salt (or don't bother to read it at all if after
reading the above you think it should be thrown out).

-Peff
