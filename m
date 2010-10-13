From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 03/11] vcs-svn: Read the preimage while applying deltas
Date: Wed, 13 Oct 2010 04:30:37 -0500
Message-ID: <20101013093037.GD32608@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
 <20100810125317.GB3921@kytes>
 <20101011023435.GA706@burratino>
 <20101011040140.GC5649@burratino>
 <20101013091714.GA32608@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 13 11:34:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5xj4-0002AF-6M
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 11:34:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042Ab0JMJeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 05:34:13 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59852 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab0JMJeM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 05:34:12 -0400
Received: by gyg13 with SMTP id 13so20276gyg.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 02:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=JU+LlL4GUvy3Orgj6Zl39Q6NMSBX/1RoTyPphFuGFkM=;
        b=ohIhLn+Cxb38zjOkHj2lUE3Urmbn5wCYgc2llwp9Z7Gw6qLdOnxV4tx+b+lAeasLME
         PHRvDzSyZ5frROSytZ7WP7/QTb3loS4VBDHX5v8Uwq+6ilJFFkbARL4QCm/0ekhAuoRG
         dFv2kKfv7BOQs52+/CUv0NNtSL44dm1GIlB1U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tQTtdRd9xrdE2wPSFM46wj9PN2ZWF8vMchtXWg5EKPM9ItkXO21bAKhy46jQ0l5s/R
         pPXer6abHwm4mssCtp8i0pdEQrHZNHkReef52hcIkd/w4dNM+3OI6i0kAt3hNDivB7yE
         nILQFZHPLSjdCfKjXxGqTnyL/q5N27sKh3Krg=
Received: by 10.101.75.13 with SMTP id c13mr4530459anl.118.1286962439856;
        Wed, 13 Oct 2010 02:33:59 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id b8sm6472349ana.2.2010.10.13.02.33.57
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 02:33:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101013091714.GA32608@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158916>

The source view offset heading each svndiff0 window represents a
number of bytes past the beginning of the preimage.  Together with the
source view length, it instructs the delta applier about what portion
of the preimage instructions will refer to.  Read in that data right
away using the sliding window code.

Maybe some day we will mmap() to prepare to read data more lazily.

For compatibility with Subversion's implementation, tolerate source
view offsets pointing past the end of the preimage file (a later
patch will remove this flexibility).  For simplicity, also permit
source views that start within the preimage and end outside of it,
even though Subversion does not.

This does not teach the delta applier to read instructions or copy
data from the source view yet.  Deltas that would produce nonempty
output are still rejected.

Helped-by: Ramkumar Ramachandra <artagnon@gmail.com>
Helped-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
It occurs to me that Sam Vilain may well have something valuable to
say about this series, having implemented something similar[1].

Sam, this series adds an svndiff0 parser for git to use in parsing
v3 dumps (which are way easier to produce with remote access to an
svn repository than v2 dumps).  The beginning of the series is at [2],
though that cover letter is out of date: now, modulo any new bugs
I've introduced with this reroll, it is known to successfully apply
all the deltas involved in a complete dump of the ASF repo.

I am interested in improvements and complaints of all kinds.

[1] http://search.cpan.org/~samv/Parse-SVNDiff-0.03/lib/Parse/SVNDiff.pm
[2] http://thread.gmane.org/gmane.comp.version-control.git/151086/focus=158731

 t/t9011-svn-da.sh |   38 ++++++++++++++++++++++++++++++++++++++
 vcs-svn/svndiff.c |   22 +++++++++++++++-------
 2 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/t/t9011-svn-da.sh b/t/t9011-svn-da.sh
index 8dccd16..b9aad70 100755
--- a/t/t9011-svn-da.sh
+++ b/t/t9011-svn-da.sh
@@ -79,4 +79,42 @@ test_expect_success 'nonempty (but unused) preimage view' '
 	test_cmp empty actual
 '
 
+test_expect_success 'preimage view: right endpoint cannot backtrack' '
+	printf "SVNQ%b%b" "Q\003QQQ" "Q\002QQQ" |
+		q_to_nul >clear.backtrack &&
+	test_must_fail test-svn-fe -d preimage clear.backtrack 14
+'
+
+test_expect_success 'preimage view: left endpoint can advance' '
+	printf "SVNQ%b%b" "Q\003QQQ" "\001\002QQQ" |
+		q_to_nul >clear.preshrink &&
+	printf "SVNQ%b%b" "Q\003QQQ" "\001\001QQQ" |
+		q_to_nul >clear.shrinkbacktrack &&
+	test-svn-fe -d preimage clear.preshrink 14 >actual &&
+	test_must_fail test-svn-fe -d preimage clear.shrinkbacktrack 14 &&
+	test_cmp empty actual
+'
+
+test_expect_success 'preimage view: offsets compared by value' '
+	printf "SVNQ%b%b" "\001\001QQQ" "\0200Q\003QQQ" |
+		q_to_nul >clear.noisybacktrack &&
+	printf "SVNQ%b%b" "\001\001QQQ" "\0200\001\002QQQ" |
+		q_to_nul >clear.noisyadvance &&
+	test_must_fail test-svn-fe -d preimage clear.noisybacktrack 15
+	test-svn-fe -d preimage clear.noisyadvance 15 &&
+	test_cmp empty actual
+'
+
+test_expect_success 'preimage view: accept truncated preimage' '
+	printf "SVNQ%b" "\010QQQQ" | q_to_nul >clear.lateemptyread &&
+	printf "SVNQ%b" "\010\001QQQ" | q_to_nul >clear.latenonemptyread &&
+	printf "SVNQ%b" "\001\010QQQ" | q_to_nul >clear.longread &&
+	test-svn-fe -d preimage clear.lateemptyread 9 >actual.emptyread &&
+	test-svn-fe -d preimage clear.latenonemptyread 9 >actual.nonemptyread &&
+	test-svn-fe -d preimage clear.longread 9 >actual.longread &&
+	test_cmp empty actual.emptyread &&
+	test_cmp empty actual.nonemptyread &&
+	test_cmp empty actual.longread
+'
+
 test_done
diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index e572a93..f2876b3 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -4,6 +4,7 @@
  */
 
 #include "git-compat-util.h"
+#include "sliding_window.h"
 #include "line_buffer.h"
 
 /*
@@ -122,21 +123,28 @@ static int apply_one_window(struct line_buffer *delta, off_t *delta_len)
 int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
 		   struct line_buffer *preimage, FILE *postimage)
 {
+	struct view preimage_view = {preimage, 0, STRBUF_INIT};
 	assert(delta && preimage && postimage);
 
 	if (read_magic(delta, &delta_len))
-		return -1;
+		goto fail;
 	while (delta_len > 0) {	/* For each window: */
-		off_t pre_off;
+		off_t pre_off = pre_off;
 		size_t pre_len;
 		if (read_offset(delta, &pre_off, &delta_len) ||
 		    read_length(delta, &pre_len, &delta_len) ||
+		    move_window(&preimage_view, pre_off, pre_len) ||
 		    apply_one_window(delta, &delta_len))
-			return -1;
-		if (delta_len && buffer_at_eof(delta))
-			return error("Delta ends early! "
-				     "(%"PRIu64" bytes remaining)",
-				     (uint64_t) delta_len);
+			goto fail;
+		if (delta_len && buffer_at_eof(delta)) {
+			error("Delta ends early! (%"PRIu64" bytes remaining)",
+			      (uint64_t) delta_len);
+			goto fail;
+		}
 	}
+	strbuf_release(&preimage_view.buf);
 	return 0;
+ fail:
+	strbuf_release(&preimage_view.buf);
+	return -1;
 }
-- 
1.7.2.3
