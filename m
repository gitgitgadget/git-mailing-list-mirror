From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/4] vcs-svn: replace buffer_read_string memory pool with a
 strbuf
Date: Fri, 24 Dec 2010 02:17:00 -0600
Message-ID: <20101224081700.GC29681@burratino>
References: <20101224080505.GA29681@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 24 09:17:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PW2q3-00035T-Rq
	for gcvg-git-2@lo.gmane.org; Fri, 24 Dec 2010 09:17:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567Ab0LXIRM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Dec 2010 03:17:12 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:65253 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab0LXIRL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Dec 2010 03:17:11 -0500
Received: by ywl5 with SMTP id 5so2927079ywl.19
        for <git@vger.kernel.org>; Fri, 24 Dec 2010 00:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=z/Cuma3b7k178elGOnL1/sqQ/pZGW7atN4jlpf4jjno=;
        b=kZa9wWToDftmUbRztzH0OggzXSDGte8VFHABFN0/G+UfGlc5VD4Hs7WhAdA8HB7/Us
         QuBFtaDa12mHdjOKcfneRpbTGmSOMiJQnXqbGx5l/ee0puqcsVnPnSQHCgQ+RScc58aV
         ky7ie0Q39AzttQx/re8fvJl4h+3EyMBiaRSgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bgoEkjaoRCDqDnf+jU14diHzIfFa1Licy2RO3SEdL001BsZUTlVLtBYeqfBeoM9Kgk
         aNjw7xKn9kUG56EJLxL2TcpNhVb91ruhxzqhTsASUZM4e5TuyJEpJB9W+871Cbzlhj1l
         EAAsczo07mVvX/N+k9yYz+qHTmFThJr6IhrIM=
Received: by 10.150.198.7 with SMTP id v7mr13620628ybf.328.1293178630557;
        Fri, 24 Dec 2010 00:17:10 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id l4sm10301013ybj.21.2010.12.24.00.17.08
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Dec 2010 00:17:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101224080505.GA29681@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164148>

Date: Sat, 6 Nov 2010 12:01:28 -0500

obj_pool is inherently global and does not use the standard growing
factor alloc_nr, which makes it feel out of place in the git codebase.
Plus it is overkill for this application: all that is needed is a
buffer that can grow between requests to accomodate larger strings.
Use a strbuf instead.

As a side effect, this improves the error handling: allocation
failures will result in a clean exit instead of segfaults.  It would
be nice to add a test case (using ulimit or failmalloc) but that can
wait for another day.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Requires jn/thinner-wrapper (from master) if contrib/svn-fe/svn-fe is
to build without linking to libz et al.

The initial size of the per-line buffer shrinks from 4096 to 0 (well,
maybe 16 or so).  strbuf_fread is not inline.  I haven't looked into
the effect on performance from these changes.

I find obj_pool tricky to use correctly (see 3c93983, vcs-svn: fix
intermittent repo_tree corruption, 2010-12-05 for example) so I look
forward to eliminating obj_pool from the vcs-svn/ dir altogether.
Excitingly enough, David has already done that, it seems[1].

[1] git://github.com/barrbrain/git.git vcs-svn-incremental

 vcs-svn/line_buffer.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/vcs-svn/line_buffer.c b/vcs-svn/line_buffer.c
index f22c94f..6f32f28 100644
--- a/vcs-svn/line_buffer.c
+++ b/vcs-svn/line_buffer.c
@@ -5,15 +5,13 @@
 
 #include "git-compat-util.h"
 #include "line_buffer.h"
-#include "obj_pool.h"
+#include "strbuf.h"
 
 #define LINE_BUFFER_LEN 10000
 #define COPY_BUFFER_LEN 4096
 
-/* Create memory pool for char sequence of known length */
-obj_pool_gen(blob, char, 4096)
-
 static char line_buffer[LINE_BUFFER_LEN];
+static struct strbuf blob_buffer = STRBUF_INIT;
 static FILE *infile;
 
 int buffer_init(const char *filename)
@@ -58,11 +56,9 @@ char *buffer_read_line(void)
 
 char *buffer_read_string(uint32_t len)
 {
-	char *s;
-	blob_free(blob_pool.size);
-	s = blob_pointer(blob_alloc(len + 1));
-	s[fread(s, 1, len, infile)] = '\0';
-	return ferror(infile) ? NULL : s;
+	strbuf_reset(&blob_buffer);
+	strbuf_fread(&blob_buffer, len, infile);
+	return ferror(infile) ? NULL : blob_buffer.buf;
 }
 
 void buffer_copy_bytes(uint32_t len)
@@ -94,5 +90,5 @@ void buffer_skip_bytes(uint32_t len)
 
 void buffer_reset(void)
 {
-	blob_reset();
+	strbuf_release(&blob_buffer);
 }
-- 
1.7.2.3.554.gc9b5c.dirty
