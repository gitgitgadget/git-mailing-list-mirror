From: Jeff King <peff@peff.net>
Subject: [PATCHv2 3/3] completion: match ctags symbol names in grep patterns
Date: Fri, 21 Oct 2011 13:30:21 -0400
Message-ID: <20111021173021.GC24417@sigill.intra.peff.net>
References: <20111021172239.GA22289@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 19:30:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHIvM-0006jx-SY
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 19:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754411Ab1JURaY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Oct 2011 13:30:24 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38976
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754098Ab1JURaY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2011 13:30:24 -0400
Received: (qmail 21860 invoked by uid 107); 21 Oct 2011 17:30:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 21 Oct 2011 13:30:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 21 Oct 2011 13:30:21 -0400
Content-Disposition: inline
In-Reply-To: <20111021172239.GA22289@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184072>

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
This incorporates the suggestions from G=C3=A1bor's review, with one
exception: it still looks only in the current directory for the "tags"
files. I think that might have some performance implications, so I'd
rather add it separately, if at all.

 contrib/completion/git-completion.bash |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completio=
n/git-completion.bash
index 888e8e1..af283cb 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1429,6 +1429,10 @@ _git_gitk ()
 	_gitk
 }
=20
+__git_match_ctag() {
+	awk "/^${1////\\/}/ { print \$1 }" "$2"
+}
+
 _git_grep ()
 {
 	__git_has_doubledash && return
@@ -1451,6 +1455,15 @@ _git_grep ()
 		;;
 	esac
=20
+	case "$cword,$prev" in
+	2,*|*,-*)
+		if test -r tags; then
+			__gitcomp "$(__git_match_ctag "$cur" tags)"
+			return
+		fi
+		;;
+	esac
+
 	__gitcomp "$(__git_refs)"
 }
=20
--=20
1.7.7.rc1.28.g5dd2ee
