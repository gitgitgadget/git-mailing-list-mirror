From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: t5541-http-push hanging
Date: Wed, 11 Nov 2009 20:26:45 -0800
Message-ID: <20091112042645.GO11919@spearce.org>
References: <B17AB159-E217-4E1F-BEA3-97E5892C13F4@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 05:26:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8RGm-0000I8-01
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 05:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759970AbZKLE0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 23:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759942AbZKLE0k
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 23:26:40 -0500
Received: from george.spearce.org ([209.20.77.23]:52176 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756514AbZKLE0j (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 23:26:39 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 891C7E0005; Thu, 12 Nov 2009 04:26:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <B17AB159-E217-4E1F-BEA3-97E5892C13F4@gernhardtsoftware.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132734>

Brian Gernhardt <brian@gernhardtsoftware.com> wrote:
> My build script for git has been hanging at t5541.2 and I haven't had the tuits to discover why.  Here's what I've gotten so far, in case anyone can figure it out faster:
...
> Initialized empty Git repository in /Users/brian/dev/git/t/trash directory.t5541-http-push/test_repo_clone/.git/
> error: RPC failed; result=22, HTTP code = 500
> ^CFATAL: Unexpected exit with code 130
...
> 
> [Wed Nov 11 06:19:39 2009] [error] [client 127.0.0.1] git-http-backend(59490) malloc: *** error for object 0x100200340: incorrect checksum for freed object - object was probably modified after being freed.
> [Wed Nov 11 06:19:39 2009] [error] [client 127.0.0.1] *** set a breakpoint in malloc_error_break to debug
> [Wed Nov 11 06:19:40 2009] [error] [client 127.0.0.1] Premature end of script headers: git-http-backend

Probably caused by a missing cast:


diff --git a/http-backend.c b/http-backend.c
index f8ea9d7..957e4ef 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -136,7 +136,7 @@ static void hdr_str(const char *name, const char *value)
 
 static void hdr_int(const char *name, size_t value)
 {
-	format_write(1, "%s: %" PRIuMAX "\r\n", name, value);
+	format_write(1, "%s: %" PRIuMAX "\r\n", name, (uintmax_t)value);
 }
 
 static void hdr_date(const char *name, unsigned long when)

-- 
Shawn.
