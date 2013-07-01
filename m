From: Andrew Pimlott <andrew@pimlott.net>
Subject: Re: [PATCH] lib-rebase: use write_script
Date: Mon, 01 Jul 2013 09:23:38 -0700
Message-ID: <1372695617-sup-5251@pimlott.net>
References: <1372357825-21824-1-git-send-email-andrew@pimlott.net> <7va9mbs8lw.fsf@alter.siamese.dyndns.org> <1372359086-sup-9704@pimlott.net> <7vvc4zqnve.fsf@alter.siamese.dyndns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 01 18:23:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtgtE-0004gR-PV
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 18:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535Ab3GAQXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 12:23:41 -0400
Received: from pimlott.net ([72.249.23.100]:52923 "EHLO fugue.pimlott.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752098Ab3GAQXk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 12:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=pimlott.net; s=default;
	h=Content-Transfer-Encoding:Message-Id:Date:References:In-reply-to:To:From:Subject:Cc:Content-Type; bh=F6vLzKbXlkC+hpxQ4J6ThfryOca9W4GjKzo1FDJdfo8=;
	b=Uj21O68aQGIr2VLY6jl/pG/pSCbaXP3P3romGJwCSYwQbYvP838AjEsFej7BZrAxLjAm5rmhgrH+ujc91fEsiGhz8gTZWxh4uyMS6WclSEF+AX7pid29xWLQKAhvOkGvqilzB5grbhC685PXNuRwt9KBvDJWvZ/ohSTM5kd1Bv8=;
Received: from andrew by fugue.pimlott.net with local (Exim 4.72)
	(envelope-from <andrew@pimlott.net>)
	id 1Utgt8-0004Hf-GH; Mon, 01 Jul 2013 09:23:38 -0700
In-reply-to: <7vvc4zqnve.fsf@alter.siamese.dyndns.org>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229307>

Excerpts from Junio C Hamano's message of Thu Jun 27 13:50:45 -0700 2013:
> Andrew Pimlott <andrew@pimlott.net> writes:
> 
> > I should update the function I introduced first.  I will re-submit
> > the rebase -i --autosquash patch and wait for acceptance before
> > trying to fix other things.
> 
> Thanks.

Applies on top of rebase -i patch already accepted.  Mostly whitespace
changes.

Thanks for your other help.

Andrew

---8<---
Subject: [PATCH] lib-rebase: style: use write_script, <<-\EOF


Signed-off-by: Andrew Pimlott <andrew@pimlott.net>
---
 t/lib-rebase.sh |   74 +++++++++++++++++++++++++++----------------------------
 1 file changed, 36 insertions(+), 38 deletions(-)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 7f119e2..8ff87fb 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -24,48 +24,46 @@
 #   ">" -- Add a blank line.
 
 set_fake_editor () {
-	echo "#!$SHELL_PATH" >fake-editor.sh
-	cat >> fake-editor.sh <<\EOF
-case "$1" in
-*/COMMIT_EDITMSG)
-	test -z "$EXPECT_HEADER_COUNT" ||
-		test "$EXPECT_HEADER_COUNT" = "$(sed -n '1s/^# This is a combination of \(.*\) commits\./\1/p' < "$1")" ||
+	write_script fake-editor.sh <<-\EOF
+	case "$1" in
+	*/COMMIT_EDITMSG)
+		test -z "$EXPECT_HEADER_COUNT" ||
+			test "$EXPECT_HEADER_COUNT" = "$(sed -n '1s/^# This is a combination of \(.*\) commits\./\1/p' < "$1")" ||
+			exit
+		test -z "$FAKE_COMMIT_MESSAGE" || echo "$FAKE_COMMIT_MESSAGE" > "$1"
+		test -z "$FAKE_COMMIT_AMEND" || echo "$FAKE_COMMIT_AMEND" >> "$1"
 		exit
-	test -z "$FAKE_COMMIT_MESSAGE" || echo "$FAKE_COMMIT_MESSAGE" > "$1"
-	test -z "$FAKE_COMMIT_AMEND" || echo "$FAKE_COMMIT_AMEND" >> "$1"
-	exit
-	;;
-esac
-test -z "$EXPECT_COUNT" ||
-	test "$EXPECT_COUNT" = $(sed -e '/^#/d' -e '/^$/d' < "$1" | wc -l) ||
-	exit
-test -z "$FAKE_LINES" && exit
-grep -v '^#' < "$1" > "$1".tmp
-rm -f "$1"
-echo 'rebase -i script before editing:'
-cat "$1".tmp
-action=pick
-for line in $FAKE_LINES; do
-	case $line in
-	squash|fixup|edit|reword)
-		action="$line";;
-	exec*)
-		echo "$line" | sed 's/_/ /g' >> "$1";;
-	"#")
-		echo '# comment' >> "$1";;
-	">")
-		echo >> "$1";;
-	*)
-		sed -n "${line}s/^pick/$action/p" < "$1".tmp >> "$1"
-		action=pick;;
+		;;
 	esac
-done
-echo 'rebase -i script after editing:'
-cat "$1"
-EOF
+	test -z "$EXPECT_COUNT" ||
+		test "$EXPECT_COUNT" = $(sed -e '/^#/d' -e '/^$/d' < "$1" | wc -l) ||
+		exit
+	test -z "$FAKE_LINES" && exit
+	grep -v '^#' < "$1" > "$1".tmp
+	rm -f "$1"
+	echo 'rebase -i script before editing:'
+	cat "$1".tmp
+	action=pick
+	for line in $FAKE_LINES; do
+		case $line in
+		squash|fixup|edit|reword)
+			action="$line";;
+		exec*)
+			echo "$line" | sed 's/_/ /g' >> "$1";;
+		"#")
+			echo '# comment' >> "$1";;
+		">")
+			echo >> "$1";;
+		*)
+			sed -n "${line}s/^pick/$action/p" < "$1".tmp >> "$1"
+			action=pick;;
+		esac
+	done
+	echo 'rebase -i script after editing:'
+	cat "$1"
+	EOF
 
 	test_set_editor "$(pwd)/fake-editor.sh"
-	chmod a+x fake-editor.sh
 }
 
 # After set_cat_todo_editor, rebase -i will write the todo list (ignoring
-- 
1.7.10.4
