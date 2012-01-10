From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv3 10/13] credentials: add "cache" helper
Date: Mon, 9 Jan 2012 19:50:38 -0600
Message-ID: <20120110015038.GA17754@burratino>
References: <20111210102827.GA16460@sigill.intra.peff.net>
 <20111210103407.GJ16529@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 10 02:45:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkQmX-00088T-2F
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 02:45:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933452Ab2AJBpk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 20:45:40 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57628 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933305Ab2AJBpj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 20:45:39 -0500
Received: by yenm10 with SMTP id m10so527374yen.19
        for <git@vger.kernel.org>; Mon, 09 Jan 2012 17:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=79mfht1ZhGRmcKD4S3yb+Wt/CZnevd9iTDxt+/oTIW8=;
        b=fLbk4ThnxtrmSVVm4DjgeHvlfQCV0UDVmHYZCbxLDgKnrzPsR5JLsE5Jlz9KA1Luy2
         RPCwf7aAkzalHWw1q8BDxqfqFBKT0wi6mv7sj8VUMCWK6U/tJWBT4gCiBBf8OwUKB8EK
         VnXOB4Q7g2D0eZRY1jehuBKct4KN3prURVF8o=
Received: by 10.236.153.42 with SMTP id e30mr24277976yhk.10.1326159939154;
        Mon, 09 Jan 2012 17:45:39 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id m14sm119949164anh.11.2012.01.09.17.45.37
        (version=SSLv3 cipher=OTHER);
        Mon, 09 Jan 2012 17:45:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20111210103407.GJ16529@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188206>

Hi,

Jeff King wrote:

> This patch introduces a credential helper that will cache
> passwords in memory for a short period of time.
>
> Signed-off-by: Jeff King <peff@peff.net>
[...]
> t/t0301-credential-cache.sh                    |   18 ++

This test is failing for me:

	expecting success: 
			check fill $HELPER <<-\EOF
			protocol=https
			host=example.com
			--
			username=askpass-username
			password=askpass-password
			--
			askpass: Username for 'https://example.com':
			askpass: Password for 'https://askpass-username@example.com':
			EOF

	--- expect-stderr       2012-01-10 00:07:02.398365248 +0000
	+++ stderr      2012-01-10 00:07:02.418364996 +0000
	@@ -1,2 +1,3 @@
	+fatal: socket path is too long to fit in sockaddr
	 askpass: Username for 'https://example.com':
	 askpass: Password for 'https://askpass-username@example.com':
	not ok - 1 helper (cache) has no existing data

I didn't notice until recently because typically the cwd is short.
The sun_path[] array on this machine is 108 bytes; POSIX informs me
that some platforms make it as small as 96 bytes and there's no
guaranteed lower limit.  The machines[*] triggering it were running
tests in a chroot, hence the long path.

So you should be able to reproduce this with

	longpath=foo/bar; # > 6 chars
	longpath=$longpath/$longpath/$longpath/$longpath; # > 24
	longpath=$longpath/$longpath/$longpath/$longpath; # > 96
	longpath=/tmp/$longpath/$longpath
	mkdir -p $longpath
	sh t0301-credential-cache.sh --root=$longpath

Ideas?
---
[*] https://buildd.debian.org/status/logs.php?pkg=git&ver=1%3A1.7.9~rc0-1

 credential-cache.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/credential-cache.c b/credential-cache.c
index dc98372e..fd9304e6 100644
--- a/credential-cache.c
+++ b/credential-cache.c
@@ -82,7 +82,7 @@ static void do_cache(const char *socket, const char *action, int timeout,
 
 int main(int argc, const char **argv)
 {
-	char *socket_path = NULL;
+	const char *socket_path = NULL;
 	int timeout = 900;
 	const char *op;
 	const char * const usage[] = {
@@ -102,10 +102,18 @@ int main(int argc, const char **argv)
 		usage_with_options(usage, options);
 	op = argv[0];
 
-	if (!socket_path)
-		socket_path = expand_user_path("~/.git-credential-cache/socket");
-	if (!socket_path)
-		die("unable to find a suitable socket path; use --socket");
+	if (!socket_path) {
+		char *home = expand_user_path("~");
+		if (!home)
+			die("unable to find a suitable socket path; use --socket");
+
+		if (!chdir(home))
+			socket_path = ".git-credential-cache/socket";
+		else if (errno == ENOENT && !strcmp(op, "exit"))
+			return 0;
+		else
+			die("cannot enter home directory");
+	}
 
 	if (!strcmp(op, "exit"))
 		do_cache(socket_path, op, timeout, 0);
-- 
1.7.8.2
