From: Jim Hill <gjthill@gmail.com>
Subject: [PATCH v2] sha1_file: pass empty buffer to index empty file
Date: Thu, 14 May 2015 16:17:14 -0700
Message-ID: <1431645434-11790-1-git-send-email-gjthill@gmail.com>
References: <xmqqbnhnknio.fsf@gitster.dls.corp.google.com>
Cc: git@vger.kernel.org
To: Junkio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 15 01:17:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt2Nk-0006Gx-BH
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 01:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161221AbbENXRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 19:17:25 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:38780 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161210AbbENXRW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 19:17:22 -0400
Received: by igbhj9 with SMTP id hj9so87181171igb.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 16:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NqpRKe84//XeAJZsSC0PLhjRWx+3hCs/JyW7VSVrHIQ=;
        b=LBMC8YB/GEAtC/X3StQrbrFiayfZxWB1tGzUorNVDuhDfB8K9lHW09Etl9KBuf/j3R
         nsm0vR4ny8O5xncsaB4xymDOoiNepOjX3Xnl5nmEQID3fwjuERCfOAFSRAPr7RGdopMm
         PCzcayzdFXafs3ABZvt2bznwy9ept2NJ72bTj0U3/3NTjpbsIGUjtHHrm8yTeXYk+cNI
         4LMm1uk35yBMUFvxCPkPVSuKUih7EVxIjEvU9XjLB3eH1INJM/fYbONXocp8FEXvb0g0
         8D4bBLpRS5gYatfqMLNXbMH2YVVX0PKsDDmLpxFl5V+pQ8zlWumWH2Owxf81pLq6J2+l
         YjNg==
X-Received: by 10.107.162.147 with SMTP id l141mr8501882ioe.77.1431645440649;
        Thu, 14 May 2015 16:17:20 -0700 (PDT)
Received: from gadabout.domain.actdsltmp (pool-71-119-14-52.lsanca.dsl-w.verizon.net. [71.119.14.52])
        by mx.google.com with ESMTPSA id k16sm284536igf.19.2015.05.14.16.17.18
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 May 2015 16:17:19 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.4.gd9c648d
In-Reply-To: <xmqqbnhnknio.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269120>

`git add` of an empty file with a filter pops complaints from
`copy_fd` about a bad file descriptor.

This traces back to these lines in sha1_file.c:index_core:

	if (!size) {
		ret = index_mem(sha1, NULL, size, type, path, flags);

The problem here is that content to be added to the index can be
supplied from an fd, or from a memory buffer, or from a pathname. This
call is supplying a NULL buffer pointer and a zero size.

Downstream logic takes the complete absence of a buffer to mean the
data is to be found elsewhere -- for instance, these, from convert.c:

	if (params->src) {
		write_err = (write_in_full(child_process.in, params->src, params->size) < 0);
	} else {
		write_err = copy_fd(params->fd, child_process.in);
	}

~If there's a buffer, write from that, otherwise the data must be coming
from an open fd.~

Perfectly reasonable logic in a routine that's going to write from
either a buffer or an fd.

So change `index_core` to supply an empty buffer when indexing an empty
file.

There's a patch out there that instead changes the logic quoted above to
take a `-1` fd to mean "use the buffer", but it seems to me that the
distinction between a missing buffer and an empty one carries intrinsic
semantics, where the logic change is adapting the code to handle
incorrect arguments.

Signed-off-by: Jim Hill <gjthill@gmail.com>
---

Junio C Hamano wrote:
> Please lose that word.
Check.

> Good spotting.
Thanks :-)

> I am not enthused to see a new test script wasted just for one piece
> of test.  Don't we have other 
Yup. Didn't see a place I liked for it in the add and update-index
test suites, didn't think to look for a filter test suite...
Check.

> Please do not be cryptic and show a good example, e.g.
> Also lose the blank line from that test.
>~Say `>emptyfile &&`
Checkcheckcheck

> check that 'err' does not contain the copy-fd error

Implemented this out of necessity, because the add works and returns
success despite the complaints to stderr.


 sha1_file.c           |  2 +-
 t/t0021-conversion.sh | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index f860d67..61e2735 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -3186,7 +3186,7 @@ static int index_core(unsigned char *sha1, int fd, size_t size,
 	int ret;
 
 	if (!size) {
-		ret = index_mem(sha1, NULL, size, type, path, flags);
+		ret = index_mem(sha1, "", size, type, path, flags);
 	} else if (size <= SMALL_FILE_SIZE) {
 		char *buf = xmalloc(size);
 		if (size == read_in_full(fd, buf, size))
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index ca7d2a6..5986bb0 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -216,4 +216,15 @@ test_expect_success EXPENSIVE 'filter large file' '
 	! test -s err
 '
 
+test_expect_success "filtering empty file should not produce complaints" '
+	echo "emptyfile filter=cat" >>.gitattributes &&
+	git config filter.cat.clean cat &&
+	git config filter.cat.smudge cat &&
+	git add . &&
+	git commit -m "cat filter for emptyfile" &&
+	> emptyfile &&
+	git add emptyfile 2>err &&
+	! grep -Fiqs "bad file descriptor" err
+'
+
 test_done
-- 
2.4.1.4.gd9c648d
