From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make builtin-tag.c use parse_options.
Date: Sat, 10 Nov 2007 01:26:58 -0800
Message-ID: <7vhcjuo3h9.fsf@gitster.siamese.dyndns.org>
References: <473463E0.7000406@gmail.com>
	<7vabpmpr9y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Carlos Rica <jasampler@gmail.com>
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 10:27:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqmce-0008SJ-JF
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 10:27:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203AbXKJJ1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 04:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750908AbXKJJ1I
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 04:27:08 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:60517 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857AbXKJJ1F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 04:27:05 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 1EEFF2F2;
	Sat, 10 Nov 2007 04:27:26 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 8BD9A92417;
	Sat, 10 Nov 2007 04:27:22 -0500 (EST)
In-Reply-To: <7vabpmpr9y.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 09 Nov 2007 22:07:37 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64319>

Junio C Hamano <gitster@pobox.com> writes:

> While I freely admit that I do not particularly find the "One -m
> introduces one new line, concatenated to form the final
> paragraph" handling of multiple -m options done by git-commit
> nice nor useful, I suspect that it would make more sense to make
> git-tag and git-commit handle multiple -m option consistently,
> if you are going to change the existing semantics.  Since some
> people really seem to like multiple -m handling of git-commit,
> the avenue of the least resistance for better consistency would
> be to accept and concatenate (with LF in between) multiple -m
> options.
>
> With multiple -F, I think erroring out would be the sensible
> thing to do, but some people might prefer concatenation.  I do
> not care either way as long as commit and tag behave
> consistently.

Alas, this exposes a regression in kh/commit series.

 t/t7501-commit.sh |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 1b444d4..bf5dd86 100644
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -178,4 +178,27 @@ test_expect_success 'amend commit to fix author' '
 	diff expected current
 
 '
+
+test_expect_success 'sign off' '
+
+	>positive &&
+	git add positive &&
+	git commit -s -m "thank you" &&
+	actual=$(git cat-file commit HEAD | sed -ne "s/Signed-off-by: //p") &&
+	expected=$(git var GIT_COMMITTER_IDENT | sed -e "s/>.*/>/") &&
+	test "z$actual" = "z$expected"
+
+'
+
+test_expect_success 'multiple -m' '
+
+	>negative &&
+	git add negative &&
+	git commit -m "one" -m "two" -m "three" &&
+	actual=$(git cat-file commit HEAD | sed -e "1,/^\$/d") &&
+	expected=$(echo one; echo; echo two; echo; echo three) &&
+	test "z$actual" = "z$expected"
+
+'
+
 test_done
