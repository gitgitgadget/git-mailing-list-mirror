From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] fix "git apply --index ..." not to deref NULL
Date: Wed, 12 Oct 2011 16:33:54 +0200
Message-ID: <87sjmy5lf1.fsf@rho.meyering.net>
References: <87lisq8vye.fsf@rho.meyering.net>
	<20111012142750.GB25085@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 12 16:34:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDztD-0000EO-5z
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 16:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392Ab1JLOeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 10:34:06 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:51915 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751130Ab1JLOeF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 10:34:05 -0400
Received: from mx.meyering.net (unknown [88.168.87.75])
	by smtp5-g21.free.fr (Postfix) with ESMTP id AE52CD48312
	for <git@vger.kernel.org>; Wed, 12 Oct 2011 16:33:57 +0200 (CEST)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id 08CDF6006A;
	Wed, 12 Oct 2011 16:33:54 +0200 (CEST)
In-Reply-To: <20111012142750.GB25085@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 12 Oct 2011 10:27:50 -0400")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183371>

Jeff King wrote:
> On Wed, Oct 12, 2011 at 10:18:01AM +0200, Jim Meyering wrote:
>
>> I noticed this when "git am CORRUPTED" unexpectedly failed with an
>> odd diagnostic, and even removed one of the files it was supposed
>> to have patched.
>>
>> Reproduce with any valid old/new patch from which you have removed
>> the "+++ b/FILE" line.  You'll see a diagnostic like this
>>
>>     fatal: unable to write file '(null)' mode 100644: Bad address
>>
>> and you'll find that FILE has been removed.
>
> Yikes. Your fix looks right to me.
>
>>  builtin/apply.c       |    3 +++
>>  t/t4254-am-corrupt.sh |   43 +++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 46 insertions(+), 0 deletions(-)
>>  create mode 100644 t/t4254-am-corrupt.sh
>
> Missing executable bit on the new test.

Thanks.
Fixed with this:

-- >8 --
Subject: [PATCH] fix "git apply --index ..." not to deref NULL

I noticed this when "git am CORRUPTED" unexpectedly failed with an
odd diagnostic, and even removed one of the files it was supposed
to have patched.

Reproduce with any valid old/new patch from which you have removed
the "+++ b/FILE" line.  You'll see a diagnostic like this

    fatal: unable to write file '(null)' mode 100644: Bad address

and you'll find that FILE has been removed.

The above is on glibc-based systems.  On other systems, rather than
getting "null", you may provoke a segfault as git tries to
dereference the NULL file name.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 builtin/apply.c       |    3 +++
 t/t4254-am-corrupt.sh |   43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 0 deletions(-)
 create mode 100755 t/t4254-am-corrupt.sh

diff --git a/builtin/apply.c b/builtin/apply.c
index f2edc52..aaa39fe 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1407,6 +1407,9 @@ static int find_header(char *line, unsigned long size, int *hdrsize, struct patc
 					    "%d leading pathname components (line %d)" , p_value, linenr);
 				patch->old_name = patch->new_name = patch->def_name;
 			}
+			if (!patch->is_delete && !patch->new_name)
+				die("git diff header lacks filename information "
+				    "(line %d)", linenr);
 			patch->is_toplevel_relative = 1;
 			*hdrsize = git_hdr_len;
 			return offset;
diff --git a/t/t4254-am-corrupt.sh b/t/t4254-am-corrupt.sh
new file mode 100755
index 0000000..b7da95f
--- /dev/null
+++ b/t/t4254-am-corrupt.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+
+test_description='git am with corrupt input'
+. ./test-lib.sh
+
+# Note the missing "+++" line:
+cat > bad-patch.diff <<'EOF'
+From: A U Thor <au.thor@example.com>
+diff --git a/f b/f
+index 7898192..6178079 100644
+--- a/f
+@@ -1 +1 @@
+-a
++b
+EOF
+
+test_expect_success setup '
+	test $? = 0 &&
+	echo a > f &&
+	git add f &&
+	test_tick &&
+	git commit -m initial
+'
+
+# This used to fail before, too, but with a different diagnostic.
+#   fatal: unable to write file '(null)' mode 100644: Bad address
+# Also, it had the unwanted side-effect of deleting f.
+test_expect_success 'try to apply corrupted patch' '
+	git am bad-patch.diff 2> actual
+	test $? = 1
+'
+
+cat > expected <<EOF
+fatal: git diff header lacks filename information (line 4)
+EOF
+
+test_expect_success 'compare diagnostic; ensure file is still here' '
+	test $? = 0 &&
+	test -f f &&
+	test_cmp expected actual
+'
+
+test_done
--
1.7.7
