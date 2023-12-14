X-Greylist: delayed 90 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Dec 2023 19:25:05 PST
Received: from impout006.msg.chrl.nc.charter.net (impout006aa.msg.chrl.nc.charter.net [47.43.20.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAEDB0
	for <git@vger.kernel.org>; Wed, 13 Dec 2023 19:25:05 -0800 (PST)
Received: from localhost.localdomain ([97.71.114.58])
	by cmsmtp with ESMTPA
	id DcJtr5lVm46f3DcJxrUCMq; Thu, 14 Dec 2023 03:23:34 +0000
Authentication-Results: charter.net; auth=pass (LOGIN)
 smtp.auth=ericsunshine@charter.net
X-Authority-Analysis: v=2.4 cv=RNOgoqu+ c=1 sm=1 tr=0 ts=657a7536
 a=4h87Vkt5vDwEBqoyvSX4iA==:117 a=4h87Vkt5vDwEBqoyvSX4iA==:17 a=BCjA09oAAAAA:8
 a=VwQbUJbxAAAA:8 a=l3aKIBErMCrECHyjdeQA:9 a=jYKBPJSq9nmHKCndOPe9:22
 a=AjGcO6oz07-iQ99wixmX:22
From: Eric Sunshine <ericsunshine@charter.net>
To: git@vger.kernel.org
Cc: Eric Sunshine <ericsunshine@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] tests: drop dependency on `git diff` in check-chainlint
Date: Wed, 13 Dec 2023 22:22:48 -0500
Message-ID: <20231214032248.1615-1-ericsunshine@charter.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfNi3LrTaYeryUjPY4BOXGgWvPLvMlTmrC7/vG/G4EPzJc2B3rOlgU2qI3ChNTY/NDiOWbP0zjk4NEPBi1cSQaRxHW3E0qLXwNm1uCMoinukcYEhsnBks
 W51ETZzlKs83su0qGWov8rrbQ2sBE16h2I6CCPzE68Q5la1WTYaK/iLaggtQV/6/Jqcj/7n6nYc6tbOrMZkfCzlpRXmTZ/DM2Ytq/0c1DCfiyqyYQMLfbQAx
 xm/pXQSa4oRHBFJFcQRaYxngY1SWy3exh9C/rkZlbHlcHo2m1O4NqrXMMfit2eW0txyz/zqEGPnMGVbwfhJbhQ==

From: Eric Sunshine <sunshine@sunshineco.com>

The "check-chainlint" target runs automatically when running tests and
performs self-checks to verify that the chainlinter itself produces the
expected output. Originally, the chainlinter was implemented via sed,
but the infrastructure has been rewritten in fb41727b7e (t: retire
unused chainlint.sed, 2022-09-01) to use a Perl script instead.

The rewrite caused some slight whitespace changes in the output that are
ultimately not of much importance. In order to be able to assert that
the actual chainlinter errors match our expectations we thus have to
ignore whitespace characters when diffing them. As the `-w` flag is not
in POSIX we try to use `git diff -w --no-index` before we fall back to
non-standard `diff -w -u`.

To accommodate for cases where the host system has no Git installation
we use the locally-compiled version of Git. This can result in problems
though when the Git project's repository is using extensions that the
locally-compiled version of Git doesn't understand, in which case `git`
may refuse to run and thus cause the checks to fail.

Work around this issue by normalizing whitespace via sed before invoking
diff, which allows any platform diff implementation to be used, thus
eliminating the dependency upon `git diff` and the non-POSIX `-w` flag.

Reported-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

This is an alternative solution to the issue Patrick's patch[1]
addresses. Hopefully, this approach should avoid the sort of push-back
Patrick's patch received[2].

I shamelessly stole most of Patrick's commit message.

The sed expressions for normalizing whitespace prior to `diff` may look
a bit hairy, but they are simple enough in concept:

* collapse runs of whitespace to a single SP
* drop blank lines (this step is not new)
* fold out possible SP at beginning and end of each line
* fold out SP surrounding common punctuation characters used in shell
  scripts, such as `>`, `|`, `;`, etc.

By the way, I'm somewhat surprised that this issue crops up at all
considering that --no-index is being used with git-diff. As such, I
would have thought that the local repository's format would not have
been interrogated at all. If that's a bug in `git diff --no-index`, then
fixing that could be considered yet another alternative solution to the
issue raised here.

[1]: https://lore.kernel.org/git/4112adbe467c14a8f22a87ea41aa4705f8760cf6.1702380646.git.ps@pks.im/
[2]: https://lore.kernel.org/git/xmqqr0jqnnmn.fsf@gitster.g/

 t/Makefile | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/t/Makefile b/t/Makefile
index 225aaf78ed..656ff10afa 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -103,20 +103,12 @@ check-chainlint:
 		echo "# chainlint: $(CHAINLINTTMP_SQ)/tests" && \
 		for i in $(CHAINLINTTESTS); do \
 			echo "# chainlint: $$i" && \
-			sed -e '/^[ 	]*$$/d' chainlint/$$i.expect; \
+			sed -e 's/[ 	][ 	]*/ /g;/^ *$$/d;s/^ //;s/ $$//;s/\([<>|();&]\) /\1/g;s/ \([<>|();&]\)/\1/g' chainlint/$$i.expect; \
 		done \
 	} >'$(CHAINLINTTMP_SQ)'/expect && \
 	$(CHAINLINT) --emit-all '$(CHAINLINTTMP_SQ)'/tests | \
-		sed -e 's/^[1-9][0-9]* //;/^[ 	]*$$/d' >'$(CHAINLINTTMP_SQ)'/actual && \
-	if test -f ../GIT-BUILD-OPTIONS; then \
-		. ../GIT-BUILD-OPTIONS; \
-	fi && \
-	if test -x ../git$$X; then \
-		DIFFW="../git$$X --no-pager diff -w --no-index"; \
-	else \
-		DIFFW="diff -w -u"; \
-	fi && \
-	$$DIFFW '$(CHAINLINTTMP_SQ)'/expect '$(CHAINLINTTMP_SQ)'/actual
+		sed -e 's/^[1-9][0-9]* //;s/[ 	][ 	]*/ /g;/^ *$$/d;s/^ //;s/ $$//;s/\([<>|();&]\) /\1/g;s/ \([<>|();&]\)/\1/g' >'$(CHAINLINTTMP_SQ)'/actual && \
+	diff -u '$(CHAINLINTTMP_SQ)'/expect '$(CHAINLINTTMP_SQ)'/actual
 
 test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax \
 	test-lint-filenames
-- 
2.43.0

