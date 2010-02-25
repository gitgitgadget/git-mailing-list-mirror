From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH maint] Windows: redirect f[re]open("/dev/null") to f[re]open("nul")
Date: Thu, 25 Feb 2010 21:03:44 +0100
Message-ID: <4B86D7A0.2010007@viscovery.net>
References: <4B86399E.3090508@viscovery.net> <20100225162032.GA3527@cthulhu> <7vtyt59rjg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Larry D'Anna <larry@elder-gods.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 21:03:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkjwA-0005Ji-SO
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 21:03:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933574Ab0BYUDt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 15:03:49 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:51350 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933525Ab0BYUDs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 15:03:48 -0500
Received: from [192.168.0.202] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7294710029;
	Thu, 25 Feb 2010 21:03:43 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7vtyt59rjg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141064>

From: Johannes Sixt <j6t@kdbg.org>

On Windows, the equivalent of "/dev/null" is "nul". This implements
compatibility wrappers around fopen() and freopen() that check for this
particular file name.

The new tests exercise code paths where this is relevant.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Junio C Hamano schrieb:
> Larry D'Anna <larry@elder-gods.org> writes:
>> Doesn't store_updated_refs do this too?
> 
> I think there is no problem, as the patch covers that case, too.

Nevertheless, we should do this, but this is now not specific to
ld/maint-diff-quiet-w anymore.

-- Hannes

  compat/mingw.c        |   16 ++++++++++++++++
  compat/mingw.h        |    6 ++++++
  t/t5510-fetch.sh      |    7 +++++++
  t/t6023-merge-file.sh |    4 ++++
  4 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 5edf152..02c6c07 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -140,6 +140,22 @@ int mingw_open (const char *filename, int oflags, ...)
  	return fd;
  }

+#undef fopen
+FILE *mingw_fopen (const char *filename, const char *otype)
+{
+	if (!strcmp(filename, "/dev/null"))
+		filename = "nul";
+	return fopen(filename, otype);
+}
+
+#undef freopen
+FILE *mingw_freopen (const char *filename, const char *otype, FILE *stream)
+{
+	if (filename && !strcmp(filename, "/dev/null"))
+		filename = "nul";
+	return freopen(filename, otype, stream);
+}
+
  /*
   * The unit of FILETIME is 100-nanoseconds since January 1, 1601, UTC.
   * Returns the 100-nanoseconds ("hekto nanoseconds") since the epoch.
diff --git a/compat/mingw.h b/compat/mingw.h
index f53bcca..3347362 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -170,6 +170,12 @@ int link(const char *oldpath, const char *newpath);
  int mingw_open (const char *filename, int oflags, ...);
  #define open mingw_open

+FILE *mingw_fopen (const char *filename, const char *otype);
+#define fopen mingw_fopen
+
+FILE *mingw_freopen (const char *filename, const char *otype, FILE *stream);
+#define freopen mingw_freopen
+
  char *mingw_getcwd(char *pointer, int len);
  #define getcwd mingw_getcwd

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 6659972..462fc64 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -342,6 +342,13 @@ test_expect_success 'fetch into the current branch with --update-head-ok' '

  '

+test_expect_success 'fetch --dry-run' '
+
+	rm -f .git/FETCH_HEAD &&
+	git fetch --dry-run . &&
+	! test -f .git/FETCH_HEAD
+'
+
  test_expect_success "should be able to fetch with duplicate refspecs" '
          mkdir dups &&
          cd dups &&
diff --git a/t/t6023-merge-file.sh b/t/t6023-merge-file.sh
index 6291307..d605024 100755
--- a/t/t6023-merge-file.sh
+++ b/t/t6023-merge-file.sh
@@ -64,6 +64,10 @@ cp new1.txt test.txt
  test_expect_success "merge without conflict" \
  	"git merge-file test.txt orig.txt new2.txt"

+cp new1.txt test.txt
+test_expect_success "merge without conflict (--quiet)" \
+	"git merge-file --quiet test.txt orig.txt new2.txt"
+
  cp new1.txt test2.txt
  test_expect_success "merge without conflict (missing LF at EOF)" \
  	"git merge-file test2.txt orig.txt new2.txt"
-- 
1.7.0.1287.g50986
