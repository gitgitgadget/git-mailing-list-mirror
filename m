From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/4] vcs-svn: avoid hangs from corrupt deltas
Date: Fri, 27 May 2011 06:14:24 -0500
Message-ID: <20110527111424.GE7972@elie>
References: <BANLkTi=O9AeOZTHVLbq+rKv5k-CqNGb+LQ@mail.gmail.com>
 <BANLkTinpta+a4MAr0e2YtMa1Kr1QcJmYWg@mail.gmail.com>
 <20110525235520.GA6971@elie>
 <BANLkTinBGnCKsUOXY_RD-7yNyM7XqNTsRw@mail.gmail.com>
 <20110527110828.GA7972@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Fri May 27 13:14:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPuzy-0004t5-OR
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 13:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787Ab1E0LOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 07:14:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34250 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152Ab1E0LO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 07:14:29 -0400
Received: by iwn34 with SMTP id 34so1248631iwn.19
        for <git@vger.kernel.org>; Fri, 27 May 2011 04:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=lel/HM0tsCWQoltwPeWSWqOn64PY6YA+nWUiG5tBdVQ=;
        b=RCTVwa0L30H0ZeJ/ZsJlcnTlOlLDuRhS0UGC9aWuo9Hc15yPeAOfDHNCprgE7Flxh+
         FI0pLwiiVYJVlxcZ06BSXDtjUqjvG9X7ErJzvZJI4TBWm2UO4je5GvPCZ8bAuaCcxM2K
         BvLblw2p+EaWpQzI1l9QX0vRl/jyOWyGtgysI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kSA17VlEtbXNE0LaIOZCCCyrccPZqPv0C1xQXiLb9bY+z7tZ7IFdBwPTmDhFrJGx6D
         3CKAHlHuLzDWA/y0l0omKuQrOXm0ZRg8La4GUupekju7WGt/S0RmpZoFwzJsEqe1xtO5
         HsVR1CXk+wDoDPI9Z2yVXp03bdfF5NKiBwJDs=
Received: by 10.42.243.3 with SMTP id lk3mr1262042icb.161.1306494868373;
        Fri, 27 May 2011 04:14:28 -0700 (PDT)
Received: from elie (adsl-69-209-65-98.dsl.chcgil.ameritech.net [69.209.65.98])
        by mx.google.com with ESMTPS id fx10sm124693ibb.18.2011.05.27.04.14.26
        (version=SSLv3 cipher=OTHER);
        Fri, 27 May 2011 04:14:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110527110828.GA7972@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174609>

A corrupt Subversion-format delta can request reads past the end of
the preimage.  Set sliding_view::max_off so such corruption is caught
when it appears rather than blocking in an impossible-to-fulfill
read() when input is coming from a socket or pipe.

Inspired-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
The title feature.  Thanks for reading.

 t/t9010-svn-fe.sh     |   40 +++++++++++++++++++++++++++++++++++++---
 vcs-svn/fast_export.c |   15 +++++++++------
 2 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/t/t9010-svn-fe.sh b/t/t9010-svn-fe.sh
index f24f004..b7eed24 100755
--- a/t/t9010-svn-fe.sh
+++ b/t/t9010-svn-fe.sh
@@ -18,12 +18,13 @@ reinit_git () {
 
 try_dump () {
 	input=$1 &&
-	maybe_fail=${2:+test_$2} &&
+	maybe_fail_svnfe=${2:+test_$2} &&
+	maybe_fail_fi=${3:+test_$3} &&
 
 	{
-		$maybe_fail test-svn-fe "$input" >stream 3<backflow &
+		$maybe_fail_svnfe test-svn-fe "$input" >stream 3<backflow &
 	} &&
-	git fast-import --cat-blob-fd=3 <stream 3>backflow &&
+	$maybe_fail_fi git fast-import --cat-blob-fd=3 <stream 3>backflow &&
 	wait $!
 }
 
@@ -1047,6 +1048,39 @@ test_expect_success PIPE 'deltas need not consume the whole preimage' '
 	test_cmp expect.3 actual.3
 '
 
+test_expect_success PIPE 'no hang for delta trying to read past end of preimage' '
+	reinit_git &&
+	{
+		# COPY 1
+		printf "SVNQ%b%b" "Q\001\001\002Q" "\001Q" |
+		q_to_nul
+	} >greedy.delta &&
+	{
+		cat <<-\EOF &&
+		SVN-fs-dump-format-version: 3
+
+		Revision-number: 1
+		Prop-content-length: 10
+		Content-length: 10
+
+		PROPS-END
+
+		Node-path: bootstrap
+		Node-kind: file
+		Node-action: add
+		Text-delta: true
+		Prop-content-length: 10
+		EOF
+		echo Text-content-length: $(wc -c <greedy.delta) &&
+		echo Content-length: $((10 + $(wc -c <greedy.delta))) &&
+		echo &&
+		echo PROPS-END &&
+		cat greedy.delta &&
+		echo
+	} >greedydelta.dump &&
+	try_dump greedydelta.dump must_fail might_fail
+'
+
 test_expect_success 'set up svn repo' '
 	svnconf=$PWD/svnconf &&
 	mkdir -p "$svnconf" &&
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 96a75d5..97f5fdf 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -198,8 +198,7 @@ static long apply_delta(off_t len, struct line_buffer *input,
 			const char *old_data, uint32_t old_mode)
 {
 	long ret;
-	off_t preimage_len = 0;
-	struct sliding_view preimage = SLIDING_VIEW_INIT(&report_buffer, -1);
+	struct sliding_view preimage = SLIDING_VIEW_INIT(&report_buffer, 0);
 	FILE *out;
 
 	if (init_postimage() || !(out = buffer_tmpfile_rewind(&postimage)))
@@ -211,19 +210,23 @@ static long apply_delta(off_t len, struct line_buffer *input,
 		printf("cat-blob %s\n", old_data);
 		fflush(stdout);
 		response = get_response_line();
-		if (parse_cat_response_line(response, &preimage_len))
+		if (parse_cat_response_line(response, &preimage.max_off))
 			die("invalid cat-blob response: %s", response);
+		check_preimage_overflow(preimage.max_off, 1);
 	}
 	if (old_mode == REPO_MODE_LNK) {
 		strbuf_addstr(&preimage.buf, "link ");
-		check_preimage_overflow(preimage_len, strlen("link "));
-		preimage_len += strlen("link ");
+		check_preimage_overflow(preimage.max_off, strlen("link "));
+		preimage.max_off += strlen("link ");
+		check_preimage_overflow(preimage.max_off, 1);
 	}
 	if (svndiff0_apply(input, len, &preimage, out))
 		die("cannot apply delta");
 	if (old_data) {
 		/* Read the remainder of preimage and trailing newline. */
-		if (move_window(&preimage, preimage_len, 1))
+		assert(!signed_add_overflows(preimage.max_off, 1));
+		preimage.max_off++;	/* room for newline */
+		if (move_window(&preimage, preimage.max_off - 1, 1))
 			die("cannot seek to end of input");
 		if (preimage.buf.buf[0] != '\n')
 			die("missing newline after cat-blob response");
-- 
1.7.5.1
