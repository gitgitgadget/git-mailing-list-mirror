From: Jeff King <peff@peff.net>
Subject: [PATCH 4/3] completion: quote completions we find
Date: Wed, 26 Sep 2012 17:57:00 -0400
Message-ID: <20120926215700.GB18628@sigill.intra.peff.net>
References: <20120926214653.GA18628@sigill.intra.peff.net>
 <20120926215119.GC18653@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed Sep 26 23:57:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGzbV-0002Nu-1p
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 23:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751830Ab2IZV5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 17:57:03 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59371 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016Ab2IZV5C (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 17:57:02 -0400
Received: (qmail 28185 invoked by uid 107); 26 Sep 2012 21:57:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 26 Sep 2012 17:57:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Sep 2012 17:57:00 -0400
Content-Disposition: inline
In-Reply-To: <20120926215119.GC18653@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206453>

On Wed, Sep 26, 2012 at 05:51:19PM -0400, Jeff King wrote:

> This is not a complete fix, as the completion result does
> will still contain metacharacters, so it would need extra
> quoting to actually be used on a command line. But it's
> still a step in the right direction, because:
> [...]
>   2. We don't know yet what the final fix will look like,
>      but this is probably the first step towards it. It
>      handles quoting on the input side of compgen; the next
>      step will likely be handling the quoting on the output
>      side of compgen to yield a usable string for the
>      command line.

Here is on attempt at that. It seems to work for me, but I know it is
not what bash does internally with:

  $ ls
  name with spaces
  $ cat name<TAB>

Because in bash's internal case, it knows that "name with spaces" is the
real entry (because if you have many entries and double-tab, it shows it
without the quotes), and only later adds the quoting.

So while this works, I'm not sure if it is optimal or if it has any
weird side effects.

-- >8 --
Subject: [PATCH] completion: quote completions we find

If you try to complete a filename with spaces, you might end
up with this:

  $ git show HEAD:name<TAB>
  $ git show HEAD:name with spaces

which is technically correct, but does not help you, since
the shell will split the words as soon as you hit enter.
Instead, let's quote completions coming out of __gitcomp_nl
to yield:

  $ git show HEAD:'name with spaces'

Signed-off-by: Jeff King <peff@peff.net>
---
 contrib/completion/git-completion.bash | 23 +++++++++++++++++++++++
 t/t9902-completion.sh                  |  6 +++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b0416ea..1fc43f7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -274,6 +274,29 @@ __gitcomp_nl ()
 {
 	local IFS=$'\n'
 	COMPREPLY=($(compgen -P "${2-}" -S "${4- }" -W "$(__git_quote "$1")" -- "${3-$cur}"))
+
+	local i
+	for (( i=0; i < ${#COMPREPLY[@]}; i++ )); do
+		# Hack to handle the extra space we add for some
+		# entries, since we use "-o nospace".
+		local stripped
+		case "${COMPREPLY[$i]}" in
+		*\ )
+			stripped=' '
+			COMPREPLY[$i]=${COMPREPLY[$i]% }
+			;;
+		esac
+
+		# Now we can check if we need actual quoting.
+		case "${COMPREPLY[$i]}" in
+		*[\ \$\'\"\(\)]*)
+			COMPREPLY[$i]="'${COMPREPLY[$i]//\'/\'\\\'\'}'"
+			;;
+		esac
+
+		# And then restore any stripped space.
+		COMPREPLY[$i]="${COMPREPLY[$i]}$stripped"
+	done
 }
 
 __git_heads ()
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index da67705..d2c5104 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -274,7 +274,7 @@ test_expect_success 'complete tree filename with spaces' '
 	git add . &&
 	git commit -m spaces &&
 	test_completion_long "git show HEAD:nam" <<-\EOF
-	name with spaces_
+	'\''name with spaces'\''_
 	EOF
 '
 
@@ -283,8 +283,8 @@ test_expect_success 'complete tree filename with metacharacters' '
 	git add . &&
 	git commit -m meta &&
 	test_completion_long "git show HEAD:nam" <<-\EOF
-	name with ${meta}_
-	name with spaces_
+	'\''name with ${meta}'\''_
+	'\''name with spaces'\''_
 	EOF
 '
 
-- 
1.7.12.10.g31da6dd
