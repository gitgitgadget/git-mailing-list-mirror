From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCHv2 0/2] Add url.<base>.pushInsteadOf: URL rewriting for push
 only
Date: Mon, 7 Sep 2009 01:55:40 -0700
Message-ID: <cover.1252313313.git.josh@joshtriplett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Sep 07 10:56:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mka13-0003Xt-LC
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 10:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbZIGIzw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 04:55:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752353AbZIGIzw
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 04:55:52 -0400
Received: from relay1-v.mail.gandi.net ([217.70.178.75]:38563 "EHLO
	relay1-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbZIGIzv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 04:55:51 -0400
Received: from feather (pool-173-50-250-234.ptldor.fios.verizon.net [173.50.250.234])
	by relay1-v.mail.gandi.net (Postfix) with ESMTP id 89F3D362AF;
	Mon,  7 Sep 2009 10:55:52 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127910>

Many sites host repositories via both git:// for fetch-only anonymous
access and ssh:// for push-capable access.  The "insteadOf" mechanism
makes it straightforward to substitute the push-capable URLs for the
pull-only URLs, which proves convenient when the site hosts many
repositories using the same URL scheme.  However, if you use such a
substitution and you cannot use the ssh:// URLs (either because you
don't have SSH access or you don't have permission to a particular
repository), you cannot clone or fetch either, even though you could do
so via the git:// URLs.  A situation like this arises when sharing git
configuration files between systems, of which only a few have SSH access
to repositories.

"pushurl" provides a way to specify URLs used only for push, but this
requires configuring a pushurl for each such repository.  As in the
rationale for insteadOf, it makes sense to configure this for all
repositories hosted on a given system at once.

This patch series adds a new "pushInsteadOf" option to go with
"insteadOf".  pushInsteadOf allows systematically rewriting fetch-only
URLs to push-capable URLs when used with push.  For instance:

[url "ssh://example.org/"]
    pushInsteadOf = "git://example.org/"

This will allow clones of "git://example.org/path/to/repo" to
subsequently push to "ssh://example.org/path/to/repo", without manually
configuring pushurl for that remote.

Includes documentation for the new option, bash completion updates, and
test cases (both that pushInsteadOf applies to push and that it does
*not* apply to fetch).


Changes in v2:
 - Don't add implicit pushurls from pushInsteadOf to remotes with explicit
   pushurls (suggested by Junio).
 - Fix pushInsteadOf rewrites to occur before insteadOf rewrites, to avoid
   basing the pushInsteadOf rewrites on the rewritten URLs.


Josh Triplett (2):
  Wrap rewrite globals in a struct in preparation for adding another set
  Add url.<base>.pushInsteadOf: URL rewriting for push only

 Documentation/config.txt               |   13 +++++
 Documentation/urls.txt                 |   18 +++++++
 contrib/completion/git-completion.bash |    2 +-
 remote.c                               |   83 ++++++++++++++++++++------------
 t/t5516-fetch-push.sh                  |   31 ++++++++++++
 5 files changed, 115 insertions(+), 32 deletions(-)
