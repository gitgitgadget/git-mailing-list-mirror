From: Junio C Hamano <gitster@pobox.com>
Subject: Re*: AW: Getting the full path of a conflicting file within a custom merge driver?
Date: Thu, 04 Jun 2015 15:11:16 -0700
Message-ID: <xmqqvbf3t98b.fsf@gitster.dls.corp.google.com>
References: <D8780C527EB1E642B3150E6D705B46D468837861@DWPWHMS531.dwpbank.local>
	<xmqqr3pv74ww.fsf@gitster.dls.corp.google.com>
	<D8780C527EB1E642B3150E6D705B46D468837AA7@DWPWHMS531.dwpbank.local>
	<xmqq4mmq3sug.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: "Gondek\, Andreas" <Andreas.Gondek@dwpbank.de>
X-From: git-owner@vger.kernel.org Fri Jun 05 00:11:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0dMC-0007y0-If
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 00:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726AbbFDWLT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2015 18:11:19 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:38377 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181AbbFDWLS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2015 18:11:18 -0400
Received: by igblz2 with SMTP id lz2so1910042igb.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2015 15:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-type;
        bh=3q0pJOMWNkWU+/4hv2Bfsy+hwSDOtDMqpmRz/HHEy/8=;
        b=aQh287z9MI5NWYIcilX/ZombkMzlQnTYCJcBmsOFS21XsftYB5AeiuPaphV6GlC24p
         b79F8j48h2pj+zuCXsmEqY97fo45eDfFjHbeMQHePbeRZlX8j5OY24lTJq6hVC1ZGTT+
         Q8fDBDz4eE1s9PtMh1Zi7c3ql4tBIgD1WjXTUPRt4nb429A132XNQj5SiZd6uWwiO2lc
         pxg/K65vsnxyL5li+onZv7P/tgg3tu5+zXMojh61zOqKAbSdKNSMxzfjdAS6aD6dns8w
         VzCjoROX4FTCtA0rNXzALVL8dgzpL27XPLOMFUFSMuW5Hht0kUY8uGersFop9AcF5W4H
         mRig==
X-Received: by 10.43.39.208 with SMTP id tn16mr6753290icb.27.1433455877844;
        Thu, 04 Jun 2015 15:11:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:8c50:e66f:fc40:1825])
        by mx.google.com with ESMTPSA id r4sm214041igh.9.2015.06.04.15.11.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Jun 2015 15:11:17 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270802>

Junio C Hamano <gitster@pobox.com> writes:

> "Gondek, Andreas" <Andreas.Gondek@dwpbank.de> writes:
>
>> thank you for responding this fast. I would suggest providing this
>> information as an additional parameter (like %A %O %B and %L) maybe
>> %P.
>
> Yes, per-cent plus a letter is more in line with the way information
> is passed to the scripts already.  Thanks for making a more sensible
> counter-suggestion.  And your %P(ath) sounds like a sensible choice.
>
> It won't be a two-liner, though, as the path is an arbitrary string,
> unlike the names of the three temporary files, and needs to be
> quoted for the shell.
>
> Let me see if I can find time today to cook up something.

I had this in my outbox but then forgot to send it out.

-- >8 --
Subject: ll-merge: pass the original path to external drivers

The interface to custom low-level merge driver was modeled to be
capable of driving programs like "merge" (from the RCS suite) that
can produce result solely by looking at three files that hold
contents of common ancestor, ours and theirs.  The information we
feed to the external drivers via the command line placeholders %O,
%A, and %B were designed to be purely about contents by giving
names of the temporary files that hold these variants without
exposing the original pathname.  No matter where the result goes,
merging the same three variants should produce the same result,
contents is the king, that is the Git way.

The external driver interface, however, is meant to help people to
step outside the Git worldview, and sometimes people want to know
the final path that the resulting merged contents would be stored
in.  Expose this to the external drivers via a new placeholder %P.

Requested-by: Andreas Gondek
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * t6026 is ancient and its style may need to be modernised to use
   test_cmp intead of cmp, etc.

 Documentation/gitattributes.txt |  5 ++++-
 ll-merge.c                      | 10 ++++++++--
 t/t6026-merge-attr.sh           | 14 +++++++++-----
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 70899b3..81fe586 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -774,7 +774,7 @@ To define a custom merge driver `filfre`, add a section to your
 ----------------------------------------------------------------
 [merge "filfre"]
 	name = feel-free merge driver
-	driver = filfre %O %A %B
+	driver = filfre %O %A %B %L %P
 	recursive = binary
 ----------------------------------------------------------------
 
@@ -800,6 +800,9 @@ merge between common ancestors, when there are more than one.
 When left unspecified, the driver itself is used for both
 internal merge and the final merge.
 
+The merge driver can learn the pathname in which the merged result
+will be stored via placeholder `%P`.
+
 
 `conflict-marker-size`
 ^^^^^^^^^^^^^^^^^^^^^^
diff --git a/ll-merge.c b/ll-merge.c
index 8ea03e5..fc3c049 100644
--- a/ll-merge.c
+++ b/ll-merge.c
@@ -9,6 +9,7 @@
 #include "xdiff-interface.h"
 #include "run-command.h"
 #include "ll-merge.h"
+#include "quote.h"
 
 struct ll_merge_driver;
 
@@ -166,17 +167,20 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 {
 	char temp[4][50];
 	struct strbuf cmd = STRBUF_INIT;
-	struct strbuf_expand_dict_entry dict[5];
+	struct strbuf_expand_dict_entry dict[6];
+	struct strbuf path_sq = STRBUF_INIT;
 	const char *args[] = { NULL, NULL };
 	int status, fd, i;
 	struct stat st;
 	assert(opts);
 
+	sq_quote_buf(&path_sq, path);
 	dict[0].placeholder = "O"; dict[0].value = temp[0];
 	dict[1].placeholder = "A"; dict[1].value = temp[1];
 	dict[2].placeholder = "B"; dict[2].value = temp[2];
 	dict[3].placeholder = "L"; dict[3].value = temp[3];
-	dict[4].placeholder = NULL; dict[4].value = NULL;
+	dict[4].placeholder = "P"; dict[4].value = path_sq.buf;
+	dict[5].placeholder = NULL; dict[5].value = NULL;
 
 	if (fn->cmdline == NULL)
 		die("custom merge driver %s lacks command line.", fn->name);
@@ -210,6 +214,7 @@ static int ll_ext_merge(const struct ll_merge_driver *fn,
 	for (i = 0; i < 3; i++)
 		unlink_or_warn(temp[i]);
 	strbuf_release(&cmd);
+	strbuf_release(&path_sq);
 	return status;
 }
 
@@ -269,6 +274,7 @@ static int read_merge_config(const char *var, const char *value, void *cb)
 		 *    %A - temporary file name for our version.
 		 *    %B - temporary file name for the other branches' version.
 		 *    %L - conflict marker length
+		 *    %P - the original path (safely quoted for the shell)
 		 *
 		 * The external merge driver should write the results in the
 		 * file named by %A, and signal that it has done with zero exit
diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
index 3c21938..04c0509 100755
--- a/t/t6026-merge-attr.sh
+++ b/t/t6026-merge-attr.sh
@@ -85,11 +85,12 @@ test_expect_success 'retry the merge with longer context' '
 cat >./custom-merge <<\EOF
 #!/bin/sh
 
-orig="$1" ours="$2" theirs="$3" exit="$4"
+orig="$1" ours="$2" theirs="$3" exit="$4" path=$5
 (
 	echo "orig is $orig"
 	echo "ours is $ours"
 	echo "theirs is $theirs"
+	echo "path is $path"
 	echo "=== orig ==="
 	cat "$orig"
 	echo "=== ours ==="
@@ -110,7 +111,7 @@ test_expect_success 'custom merge backend' '
 
 	git reset --hard anchor &&
 	git config --replace-all \
-	merge.custom.driver "./custom-merge %O %A %B 0" &&
+	merge.custom.driver "./custom-merge %O %A %B 0 %P" &&
 	git config --replace-all \
 	merge.custom.name "custom merge driver for testing" &&
 
@@ -121,7 +122,7 @@ test_expect_success 'custom merge backend' '
 	o=$(git unpack-file master^:text) &&
 	a=$(git unpack-file side^:text) &&
 	b=$(git unpack-file master:text) &&
-	sh -c "./custom-merge $o $a $b 0" &&
+	sh -c "./custom-merge $o $a $b 0 'text'" &&
 	sed -e 1,3d $a >check-2 &&
 	cmp check-1 check-2 &&
 	rm -f $o $a $b
@@ -131,7 +132,7 @@ test_expect_success 'custom merge backend' '
 
 	git reset --hard anchor &&
 	git config --replace-all \
-	merge.custom.driver "./custom-merge %O %A %B 1" &&
+	merge.custom.driver "./custom-merge %O %A %B 1 %P" &&
 	git config --replace-all \
 	merge.custom.name "custom merge driver for testing" &&
 
@@ -148,9 +149,12 @@ test_expect_success 'custom merge backend' '
 	o=$(git unpack-file master^:text) &&
 	a=$(git unpack-file anchor:text) &&
 	b=$(git unpack-file master:text) &&
-	sh -c "./custom-merge $o $a $b 0" &&
+	sh -c "./custom-merge $o $a $b 0 'text'" &&
 	sed -e 1,3d $a >check-2 &&
 	cmp check-1 check-2 &&
+	sed -e 1,3d -e 4q $a >check-3 &&
+	echo "path is text" >expect &&
+	cmp expect check-3 &&
 	rm -f $o $a $b
 '
 
