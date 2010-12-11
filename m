From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH db/vcs-svn-incremental] vcs-svn: avoid git-isms in
 fast-import stream
Date: Sat, 11 Dec 2010 17:00:33 -0600
Message-ID: <20101211230033.GB18822@burratino>
References: <20101210102007.GA26298@burratino>
 <C59168D0-B409-4A83-B96C-8CCD42D0B62F@cordelta.com>
 <20101211184654.GA17464@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Sam Vilain <sam@vilain.net>, Stephen Bash <bash@genarts.com>,
	Tomas Carnecky <tom@dbservice.com>
To: David Michael Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Sun Dec 12 00:07:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRYXE-0004Tz-Hg
	for gcvg-git-2@lo.gmane.org; Sun, 12 Dec 2010 00:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022Ab0LKXAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Dec 2010 18:00:41 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51931 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909Ab0LKXAk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Dec 2010 18:00:40 -0500
Received: by gyb11 with SMTP id 11so2427090gyb.19
        for <git@vger.kernel.org>; Sat, 11 Dec 2010 15:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=pu5ENjNRVEsYP9UdcmWdmU3BlMFSzlTjLWBx1+EnqSI=;
        b=iqKETN4R9R8TvWIz44vpAn7XCcTbTnXLUTF1Fl30ZfnS3pKpOmCbx+Ts6W9TuTeG5x
         nK/CfhbV3GgMOZIqHZM18LN1L7N6UsDE2qhQB9zxDQUolJEOryXPAwJt95WWo5h/VP9s
         ep6qec254Xgp28UW4+OTKOC6U3RQ7pzhQc1js=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KWQvcvjFdmsTSxCbgTzZa8QjNqWNPSpkojJpgPJRj6OFoSiW7m//mB5xA0l1QzcnCK
         KPLviCo0bvlj8/9ZM3GtIzwhXC8pyqoaDz2CZS2tGGrW06w4Js752GmQ+R66DkpWifjX
         b4x8/w7wzY4ERR2YoVVwV7mjEkjRNvhLg143w=
Received: by 10.236.95.173 with SMTP id p33mr5307942yhf.44.1292108439642;
        Sat, 11 Dec 2010 15:00:39 -0800 (PST)
Received: from burratino (adsl-69-209-48-248.dsl.chcgil.sbcglobal.net [69.209.48.248])
        by mx.google.com with ESMTPS id k52sm2904973yhg.39.2010.12.11.15.00.37
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 11 Dec 2010 15:00:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101211184654.GA17464@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163462>

Jonathan Nieder wrote:

> I am not totally happy with the result, since it adds another
> git-specific detail to svn-fe (the first was hardcoding the
> empty blob sha1 instead of using
> 
> 	blob
> 	mark :0
> 	data 0
> 
> ).

Maybe this would help?

-- 8< --
Subject: vcs-svn: avoid git-isms in fast-import stream

Current svn-fe is not likely to work without change with other
fast-import backends, but don't let that stop us from trying:

 - instead of suppressing copies of empty trees, let the backend
   decide what to do with them;

 - use a mark instead of hard-coding git's name for the empty blob.

However, we do not include commands in the stream for new empty
directories, since no syntax is documented for that yet.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/fast_export.c |    8 +-------
 vcs-svn/svndump.c     |    2 +-
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/vcs-svn/fast_export.c b/vcs-svn/fast_export.c
index 75d674e..85166a6 100644
--- a/vcs-svn/fast_export.c
+++ b/vcs-svn/fast_export.c
@@ -40,12 +40,6 @@ void fast_export_delete(uint32_t depth, const uint32_t *path)
 void fast_export_modify(uint32_t depth, const uint32_t *path, uint32_t mode,
 			const char *dataref)
 {
-	/* Git does not track empty directories. */
-	if (S_ISDIR(mode) && !strcmp(dataref, EMPTY_TREE_SHA1_HEX)) {
-		fast_export_delete(depth, path);
-		return;
-	}
-
 	/* Mode must be 100644, 100755, 120000, or 160000. */
 	printf("M %06"PRIo32" %s ", mode, dataref);
 	pool_print_seq(depth, path, '/', stdout);
@@ -255,7 +249,7 @@ void fast_export_data(uint32_t mode, uint32_t len, struct line_buffer *input)
 
 void fast_export_empty_blob(void)
 {
-	printf("blob\ndata 0\n\n");
+	printf("blob\nmark :0\ndata 0\n\n");
 }
 
 void fast_export_delta(const uint32_t *path, uint32_t mode, uint32_t old_mode,
diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index 68a8435..e28e762 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -244,7 +244,7 @@ static void handle_node(void)
 		if (type == REPO_MODE_DIR)
 			old_data = NULL;
 		else if (have_text)
-			old_data = EMPTY_BLOB_SHA1_HEX;
+			old_data = ":0";
 		else
 			die("invalid dump: adds node without text");
 	} else {
-- 
1.7.2.4
