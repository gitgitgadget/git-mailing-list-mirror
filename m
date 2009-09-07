From: Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH 0/2] Add url.<base>.pushInsteadOf: URL rewriting for push
 only
Date: Sun, 6 Sep 2009 23:59:28 -0700
Message-ID: <cover.1252306396.git.josh@joshtriplett.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Sep 07 09:07:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkYJm-0000fX-WD
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 09:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbZIGHHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 03:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbZIGHHD
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 03:07:03 -0400
Received: from slow3-v.mail.gandi.net ([217.70.178.89]:46151 "EHLO
	slow3-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbZIGHHC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 03:07:02 -0400
Received: from relay2-v.mail.gandi.net (relay2-v.mail.gandi.net [217.70.178.76])
	by slow3-v.mail.gandi.net (Postfix) with ESMTP id 5FF9E3AEE7
	for <git@vger.kernel.org>; Mon,  7 Sep 2009 09:00:02 +0200 (CEST)
Received: from feather (pool-173-50-250-234.ptldor.fios.verizon.net [173.50.250.234])
	by relay2-v.mail.gandi.net (Postfix) with ESMTP id 71D97135D0;
	Mon,  7 Sep 2009 08:59:40 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127889>

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


Josh Triplett (2):
  Wrap rewrite globals in a struct in preparation for adding another set
  Add url.<base>.pushInsteadOf: URL rewriting for push only

 Documentation/config.txt               |   12 +++++
 Documentation/urls.txt                 |   18 +++++++
 contrib/completion/git-completion.bash |    2 +-
 remote.c                               |   80 +++++++++++++++++++------------
 t/t5516-fetch-push.sh                  |   31 ++++++++++++
 5 files changed, 111 insertions(+), 32 deletions(-)
