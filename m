From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 10/11] vcs-svn: Reject deltas that read past end of preimage
Date: Wed, 13 Oct 2010 04:53:18 -0500
Message-ID: <20101013095318.GK32608@burratino>
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
X-From: git-owner@vger.kernel.org Wed Oct 13 11:56:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5y4k-0001Wf-7M
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 11:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980Ab0JMJ4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 05:56:40 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49748 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab0JMJ4k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 05:56:40 -0400
Received: by ywi6 with SMTP id 6so1401809ywi.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 02:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=pVmK+Bn9KV4ZTLFesx+iwg0seaNok3PuMVPAN478so4=;
        b=nlba6CTV4Tiy3X5gH+CepbtvVXvyYELth+lfiBdGF7xh8Yt3OnCIT1V1ZEcJdxU8X6
         KrR57p0uEhmQJxaSGibJVbjVKw9bCWKgzyM7gPt7tfoMhYklMsleQWMYaljpzY+OHugX
         pe+Fo3IUfM9RbBq1xb74MB8k9Ec4sv4rTO2WY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=xd60MmXMuo0dbvpHN74zQhhgBlVOWIQtpxEiQhqawB7GZMojze+Z2Rexu4F5B4kENj
         w0er/bZNjzf1FIy7zNJrQktWK96xbPyhLSXg1vN40vhcHAmSS5A5e5Gu4M5+ivcsSzly
         NA6lWe2CJGwY/Ob0URG0bAjstjyTPfXXbuM9k=
Received: by 10.236.95.165 with SMTP id p25mr17819653yhf.24.1286963799381;
        Wed, 13 Oct 2010 02:56:39 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id 54sm7275864yhl.31.2010.10.13.02.56.38
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 13 Oct 2010 02:56:38 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101013091714.GA32608@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158923>

Some particularly strange deltas of unknown origin were found to
request copies beyond the end of the preimage.  But svn 1.6 never
produces anything like that.

Although Subversion accepts these perverse deltas as input, let's
error out if some future version of subversion starts to actually
produce them.

Without this change, the diff applier would have to separately
keep track of the number of bytes supposedly and actually written out.

Helped-by: Ramkumar Ramachandra <artagnon@gmail.com>
Helped-by: David Barr <david.barr@cordelta.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9011-svn-da.sh        |   11 ++++-------
 vcs-svn/sliding_window.c |   10 ++++++----
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/t/t9011-svn-da.sh b/t/t9011-svn-da.sh
index ccd31e9..c4bd1f3 100755
--- a/t/t9011-svn-da.sh
+++ b/t/t9011-svn-da.sh
@@ -105,16 +105,13 @@ test_expect_success 'preimage view: offsets compared by value' '
 	test_cmp empty actual
 '
 
-test_expect_success 'preimage view: accept truncated preimage' '
+test_expect_success 'preimage view: reject truncated preimage' '
 	printf "SVNQ%b" "\010QQQQ" | q_to_nul >clear.lateemptyread &&
 	printf "SVNQ%b" "\010\001QQQ" | q_to_nul >clear.latenonemptyread &&
 	printf "SVNQ%b" "\001\010QQQ" | q_to_nul >clear.longread &&
-	test-svn-fe -d preimage clear.lateemptyread 9 >actual.emptyread &&
-	test-svn-fe -d preimage clear.latenonemptyread 9 >actual.nonemptyread &&
-	test-svn-fe -d preimage clear.longread 9 >actual.longread &&
-	test_cmp empty actual.emptyread &&
-	test_cmp empty actual.nonemptyread &&
-	test_cmp empty actual.longread
+	test_must_fail test-svn-fe -d preimage clear.lateemptyread 9 &&
+	test_must_fail test-svn-fe -d preimage clear.latenonemptyread 9 &&
+	test_must_fail test-svn-fe -d preimage clear.longread 9
 '
 
 test_expect_success 'unconsumed inline data' '
diff --git a/vcs-svn/sliding_window.c b/vcs-svn/sliding_window.c
index 8273970..5c08828 100644
--- a/vcs-svn/sliding_window.c
+++ b/vcs-svn/sliding_window.c
@@ -49,17 +49,19 @@ int move_window(struct view *view, off_t off, size_t len)
 		const off_t gap = off - file_offset;
 		const off_t nread = buffer_skip_bytes(view->file, gap);
 		if (nread != gap) {
-			if (!buffer_ferror(view->file))	/* View ends early. */
-				goto done;
+			if (!buffer_ferror(view->file))
+				return error("Preimage ends early");
 			return error("Cannot seek forward in input: %s",
 				     strerror(errno));
 		}
 		file_offset += gap;
 	}
 	buffer_read_binary(&view->buf, len - view->buf.len, view->file);
-	if (buffer_ferror(view->file))
+	if (view->buf.len != len) {
+		if (!buffer_ferror(view->file))
+			return error("Preimage ends early");
 		return error("Cannot read preimage: %s", strerror(errno));
- done:
+	}
 	view->off = off;
 	return 0;
 }
-- 
1.7.2.3
