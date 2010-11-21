From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Status of the svn remote helper project (Nov 2010, #2)
Date: Sun, 21 Nov 2010 17:06:13 -0600
Message-ID: <20101121230613.GA24397@burratino>
References: <20101107112129.GA30042@burratino>
 <20101121063149.GA15449@burratino>
 <BB713021-7826-4E9E-8576-7D1704BF517C@cordelta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: David Michael Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Mon Nov 22 00:06:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKIzX-0002rq-Lm
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 00:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754852Ab0KUXGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Nov 2010 18:06:33 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44040 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754561Ab0KUXGd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Nov 2010 18:06:33 -0500
Received: by gxk23 with SMTP id 23so3725729gxk.19
        for <git@vger.kernel.org>; Sun, 21 Nov 2010 15:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rmtHxq72tNx/GPILou4wpu+5JK9cCf7HMpeAPgvOL5I=;
        b=jP/SE/s7Zt9kQkmQ4x3cyFOl+xRnHCp05J+zy3NpyxNK4KdYbzqVGmu2yfQMheBRD6
         /qmvtiD0ZLazfdiq7NLBRNc7cclh1j8eu81pVilueTXbUtlGZ3I7qvfrOPZetFVfSKfp
         YziwlLkuw54nGvIiP2WCe8vyyWZx1BHkxgn7w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ArjnuWuANO1HX/3bsHcQPyL0/RfAnBmz8GfkEe3JUkN7T6Re8Hp+2aYbTFl+JS0zjo
         jkr3NxGrkJXa0wh8gsJHnlARG6ArSTO/CpIlEI09e7SJKv+0PRkIW8FUdvjYBG/XzEim
         fa/a6k6n/qlZ7z0AXw8grtoj9PhxB1NAt5e/I=
Received: by 10.100.205.10 with SMTP id c10mr2839227ang.172.1290380791850;
        Sun, 21 Nov 2010 15:06:31 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id d10sm4964438and.39.2010.11.21.15.06.27
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 21 Nov 2010 15:06:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <BB713021-7826-4E9E-8576-7D1704BF517C@cordelta.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161874>

David Michael Barr wrote:
> Jonathan Nieder wrote:

>> A delta in r36 of <http://svn.apache.org/repos/asf> does not apply
>> with this brand of svn-fe.
>
> That's odd, I was able to import up to r354 before receiving:
> fatal: missing newline after cat-blob response

Apparently sometimes deltas use the whole preimage and sometimes they
don't.

Here's a fix (still needs a simple reproduction script).

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/test-svn-fe.c b/test-svn-fe.c
index 64f63cf..71de02b 100644
--- a/test-svn-fe.c
+++ b/test-svn-fe.c
@@ -11,7 +11,7 @@
 int main(int argc, char *argv[])
 {
 	static const char test_svnfe_usage[] =
-		"test-svn-fe (<dumpfile> | [-d] <preimage> <delta> <len>)";
+		"test-svn-fe (<dumpfile> | [-d] <preimage> [<preimage len>] <delta> <len>)";
 	if (argc < 2)
 		usage(test_svnfe_usage);
 	if (argc == 2) {
@@ -22,16 +22,26 @@ int main(int argc, char *argv[])
 		svndump_reset();
 		return 0;
 	}
-	if (argc == 5 && !strcmp(argv[1], "-d")) {
+	if ((argc == 5 || argc == 6) && !strcmp(argv[1], "-d")) {
+		char **arg = argv + 2;
 		struct line_buffer delta = LINE_BUFFER_INIT;
-		int preimage_fd = open(argv[2], O_RDONLY);
+		int preimage_fd = open(*arg++, O_RDONLY);
 		struct view preimage_view = {preimage_fd, 0, STRBUF_INIT};
+		off_t preimage_len;
 		if (preimage_fd < 0)
 			die_errno("cannot open preimage");
-		if (buffer_init(&delta, argv[3]))
+		if (argc == 6) {
+			preimage_len = (off_t) strtoull(*arg++, NULL, 0);
+		} else {
+			struct stat st;
+			if (fstat(preimage_fd, &st))
+				die_errno("cannot stat preimage");
+			preimage_len = st.st_size;
+		}
+		if (buffer_init(&delta, *arg++))
 			die_errno("cannot open delta");
-		if (svndiff0_apply(&delta, (off_t) strtoull(argv[4], NULL, 0),
-				   &preimage_view, stdout))
+		if (svndiff0_apply(&delta, (off_t) strtoull(*arg++, NULL, 0),
+				   &preimage_view, preimage_len, stdout))
 			return 1;
 		if (close(preimage_fd))
 			die_errno("cannot close preimage");
diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index ceb1fc5..02456cf 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -119,6 +119,7 @@ static long apply_delta(uint32_t mark, off_t len, struct line_buffer *input,
 			uint32_t old_mark, uint32_t old_mode)
 {
 	long ret;
+	off_t preimage_len = 0;
 	struct view preimage = {REPORT_FILENO, 0, STRBUF_INIT};
 	FILE *out;
 
@@ -130,13 +131,12 @@ static long apply_delta(uint32_t mark, off_t len, struct line_buffer *input,
 		printf("cat-blob :%"PRIu32"\n", old_mark);
 		fflush(stdout);
 		response = get_response_line();
-		/* Not necessary, just for robustness */
-		if (parse_cat_response_line(response, &dummy))
+		if (parse_cat_response_line(response, &preimage_len))
 			die("invalid cat-blob response: %s", response);
 	}
 	if (old_mode == REPO_MODE_LNK)
 		strbuf_addstr(&preimage.buf, "link ");
-	if (svndiff0_apply(input, len, &preimage, out))
+	if (svndiff0_apply(input, len, &preimage, preimage_len, out))
 		die("cannot apply delta");
 	if (old_mark) {
 		/* Discard trailing newline from cat-blob-fd. */
diff --git a/vcs-svn/svndiff.c b/vcs-svn/svndiff.c
index 308c734..8210561 100644
--- a/vcs-svn/svndiff.c
+++ b/vcs-svn/svndiff.c
@@ -283,7 +283,8 @@ static int apply_one_window(struct line_buffer *delta, off_t *delta_len,
 }
 
 int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
-			struct view *preimage_view, FILE *postimage)
+			struct view *preimage_view, off_t preimage_len,
+			FILE *postimage)
 {
 	assert(delta && preimage_view && postimage);
 
@@ -302,5 +303,7 @@ int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
 			return error("Delta ends early! (%"PRIu64" bytes remaining)",
 			      (uint64_t) delta_len);
 	}
+	if (move_window(preimage_view, preimage_len, 0))
+		return -1;
 	return 0;
 }
diff --git a/vcs-svn/svndiff.h b/vcs-svn/svndiff.h
index bb5afd0..640e04f 100644
--- a/vcs-svn/svndiff.h
+++ b/vcs-svn/svndiff.h
@@ -5,6 +5,7 @@
 #include "sliding_window.h"
 
 extern int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
-				struct view *preimage_view, FILE *postimage);
+				struct view *preimage_view, off_t preimage_len,
+				FILE *postimage);
 
 #endif
