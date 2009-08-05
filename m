From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Making git push output quieter
Date: Wed, 5 Aug 2009 12:26:58 -0700
Message-ID: <20090805192658.GI1033@spearce.org>
References: <200908042327.10912.aacid@kde.org> <3af572ac0908041520l327482f1u45121b6b991a3673@mail.gmail.com> <200908052113.06373.aacid@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pau Garcia i Quiles <pgquiles@elpauer.org>, git@vger.kernel.org
To: Albert Astals Cid <aacid@kde.org>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Aug 05 21:27:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYm8g-0000gP-GS
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 21:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbZHET06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 15:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbZHET06
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 15:26:58 -0400
Received: from george.spearce.org ([209.20.77.23]:38622 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750749AbZHET05 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 15:26:57 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 595F0381FD; Wed,  5 Aug 2009 19:26:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200908052113.06373.aacid@kde.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124954>

Albert Astals Cid <aacid@kde.org> wrote:
> A Dimecres, 5 d'agost de 2009, Pau Garcia i Quiles va escriure:
> > On Tue, Aug 4, 2009 at 11:27 PM, Albert Astals Cid<aacid@kde.org> wrote:
> > > Hi, at KDE we are starting to try to use git and one of the things that's
> > > bothering me is that git push is too verbose for our scripts.
...
> > Have you tried redirecting only stdout to /dev/null, and keeping
> > stderr to yourself ?
> 
> Everything goes to stderr.

Sadly our use of isatty to determine if progress/verbosity should
be used is inconsistent.  pack-objects.c, which is what you are
talking about above, is using stderr to determine if progress should
be enabled, but other code like transport.c, which is used on the
client side, is using stdout.  Hence the suggestion above to redirect
stdout to /dev/null to try and shutoff the spew.

  $ git grep isatty
  builtin-commit.c:		if (isatty(0))
  builtin-config.c:			stdout_is_tty = isatty(1);
  builtin-pack-objects.c:	progress = isatty(2);
  builtin-revert.c:	if (isatty(0))
  builtin-shortlog.c:	if (!nongit && !rev.pending.nr && isatty(0))
  builtin-unpack-objects.c:	quiet = !isatty(2);
  color.c:		stdout_is_tty = isatty(1);
  compat/winansi.c:	if (!isatty(fileno(stream)))
  compat/winansi.c:	if (!isatty(fileno(stream)))
  pack-redundant.c:	if (!isatty(0)) {
  pager.c:	if (!isatty(1))
  pager.c:	if (isatty(2))
  transport.c:	args.no_progress = args.quiet || (!transport->progress && !isatty(1));
  wt-status.c:	 * will have checked isatty on stdout).

I'm thinking this might be a reasonable patch to apply, Junio/Nico?

--8<--
pack-objects: Display progress only if stdout is tty

Client transports underneath git fetch display progress output only
if stdout is a tty, allowing redirection of stdout to /dev/null (or
a pipe) to silence progress but still report actual errors on stderr.

Doing the same in pack-objects means push, bundle creation and
repack can use the same trick to silence noisy progress progress,
but still obtain real errors.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-pack-objects.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 961b639..0b9234a 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -2110,7 +2110,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (!pack_compression_seen && core_compression_seen)
 		pack_compression_level = core_compression_level;
 
-	progress = isatty(2);
+	progress = isatty(1);
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
-- 
1.6.4.70.g9c084


-- 
Shawn.
