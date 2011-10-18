From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] completion: match ctags symbol names in grep patterns
Date: Tue, 18 Oct 2011 01:01:05 -0400
Message-ID: <20111018050105.GC9008@sigill.intra.peff.net>
References: <20111018044955.GA8976@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 18 07:01:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG1oM-0004TU-41
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 07:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608Ab1JRFBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Oct 2011 01:01:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34196
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752565Ab1JRFBI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Oct 2011 01:01:08 -0400
Received: (qmail 16251 invoked by uid 107); 18 Oct 2011 05:01:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Oct 2011 01:01:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Oct 2011 01:01:05 -0400
Content-Disposition: inline
In-Reply-To: <20111018044955.GA8976@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183853>

A common thing to grep for is the name of a symbol. This
patch teaches the completion for "git grep" to look in
a 'tags' file, if present, to complete a pattern. For
example, in git.git:

  $ make tags
  $ git grep get_sha1<Tab><Tab>
  get_sha1                 get_sha1_oneline
  get_sha1_1               get_sha1_with_context
  get_sha1_basic           get_sha1_with_context_1
  get_sha1_hex             get_sha1_with_mode
  get_sha1_hex_segment     get_sha1_with_mode_1
  get_sha1_mb

Signed-off-by: Jeff King <peff@peff.net>
---
It's debatable whether this belongs in the generic completion code, as
it really only works if your project uses ctags. But I find it to be a
huge timesaver for finding callsites of functions, especially when
coupled with "git jump grep" from the previous patch.

Undoubtedly you can do something similar with cscope, or with an editor
plugin, but using grep feels very natural and simple to me.

For using with "git jump grep", I do this:

  # much easier to type
  git config --global alias.vgrep 'jump grep'

  # and set up completion for it, too
  cat >>~/.bashrc
  _git_vgrep() {
          _git_grep
  }

 contrib/completion/git-completion.bash |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8648a36..f4ab13d 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1432,6 +1432,10 @@ _git_gitk ()
 	_gitk
 }
 
+_git_grep_ctag_match() {
+	awk -v ORS=' ' "/^${1////\\/}/ { print \$1 }" "$2"
+}
+
 _git_grep ()
 {
 	__git_has_doubledash && return
@@ -1454,6 +1458,13 @@ _git_grep ()
 		;;
 	esac
 
+	case "$COMP_CWORD,$prev" in
+	2,*|*,-*)
+		test -r tags || return
+		COMPREPLY=( $(compgen -W "`_git_grep_ctag_match "$cur" tags`") )
+		return
+	esac
+
 	__gitcomp "$(__git_refs)"
 }
 
-- 
1.7.7.rc3.37.gc4dc8
