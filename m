From: Jeff King <peff@peff.net>
Subject: [PATCH 0/13] ident cleanups and bugfixes
Date: Fri, 18 May 2012 19:05:28 -0400
Message-ID: <20120518230528.GA30510@sigill.intra.peff.net>
References: <20120511231303.GA24611@sigill.intra.peff.net>
 <20120514162824.GA24457@sigill.intra.peff.net>
 <20120514210225.GA9677@sigill.intra.peff.net>
 <20120514211324.GA11578@sigill.intra.peff.net>
 <20120515015437.GA13833@sigill.intra.peff.net>
 <7vtxzhfpv9.fsf@alter.siamese.dyndns.org>
 <20120515174724.GA329@sigill.intra.peff.net>
 <7vsjf1e2n7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Angus Hammond <angusgh@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 19 01:21:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVWTv-0000UB-3g
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 01:21:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966739Ab2ERXVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 19:21:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48736
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946569Ab2ERXFb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 19:05:31 -0400
Received: (qmail 7494 invoked by uid 107); 18 May 2012 23:05:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 May 2012 19:05:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2012 19:05:28 -0400
Content-Disposition: inline
In-Reply-To: <7vsjf1e2n7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197990>

On Tue, May 15, 2012 at 11:10:36AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So it seems to me like a much simpler set of rules would be:
> >
> >   1. When reading gecos, always fall back to the username if the gecos
> >      field is unavailable or blank.
> >
> >   2. Always die when the name field is blank. That means we will die
> >      when you pass in a bogus empty GIT_COMMITTER_NAME (or an empty
> >      config name), which makes a lot more sense to me than falling back;
> >      those are bogus requests, not system config problems.  And we won't
> >      ever have a blank gecos name, because we'll always fall back on the
> >      username.
> 
> That certainly sounds very simple to explain and understand, and I do not
> offhand think of anything *sane* that would break ;-)

Actually, it does end up breaking. The "error_on_no_name" check wants to
see the value _before_ the fallback, because it is not just about "do
not hand out an ident with an empty name", but rather about "do not hand
out this crappy fallback name when the gecos field is empty".  So we
cannot do an "always fallback" behavior without breaking that check.

I ended up avoiding the issue in a different way, as you'll see in patch
8 below. Here's the series:

  [01/13]: ident: split setup_ident into separate functions
  [02/13]: http-push: do not access git_default_email directly
  [03/13]: fmt-merge-msg: don't use static buffer in record_person
  [04/13]: move identity config parsing to ident.c
  [05/13]: move git_default_* variables to ident.c
  [06/13]: format-patch: use default email for generating message ids
  [07/13]: fmt_ident: drop IDENT_WARN_ON_NO_NAME code
  [08/13]: ident: don't write fallback username into git_default_name
  [09/13]: drop length limitations on gecos-derived names and emails
  [10/13]: ident: report passwd errors with a more friendly message
  [11/13]: ident: use full dns names to generate email addresses
  [12/13]: ident: use a dynamic strbuf in fmt_ident
  [13/13]: format-patch: refactor get_patch_filename

Patches 2, 8, and 11 fix actual bugs. The rest of it is refactoring and
cleanup; here's the diffstat:

 Documentation/git-commit-tree.txt |    9 --
 Documentation/git-var.txt         |    9 --
 builtin/fmt-merge-msg.c           |    8 +-
 builtin/log.c                     |   45 ++------
 cache.h                           |   12 +-
 config.c                          |   24 +----
 environment.c                     |    3 -
 git-compat-util.h                 |    3 +
 http-push.c                       |    2 +-
 ident.c                           |  213 ++++++++++++++++---------------------
 log-tree.c                        |   19 ++--
 log-tree.h                        |    4 +-
 wrapper.c                         |   12 ++
 13 files changed, 142 insertions(+), 221 deletions(-)

-Peff
