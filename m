From: Jeff King <peff@peff.net>
Subject: Re: Solaris test failure -- FAIL 61: invalid bool (set)
Date: Tue, 19 Feb 2008 18:44:22 -0500
Message-ID: <20080219234422.GA9987@coredump.intra.peff.net>
References: <8ec76080802191322t2417ea48y1537011f1031dff8@mail.gmail.com> <alpine.LSU.1.00.0802192220440.7826@racer.site> <8ec76080802191517k5f070d45l497063d93e080272@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Whit Armstrong <armstrong.whit@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 00:45:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRc8z-0002zm-Tw
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 00:45:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754969AbYBSXo0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 18:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753708AbYBSXo0
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 18:44:26 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1774 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751774AbYBSXoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 18:44:25 -0500
Received: (qmail 26330 invoked by uid 111); 19 Feb 2008 23:44:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 19 Feb 2008 18:44:23 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Feb 2008 18:44:22 -0500
Content-Disposition: inline
In-Reply-To: <8ec76080802191517k5f070d45l497063d93e080272@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74477>

On Tue, Feb 19, 2008 at 06:17:42PM -0500, Whit Armstrong wrote:

>         git config --bool bool.nobool foobar
> t1300-repo-config.sh: line -176: 18181 Segmentation Fault      (core
> dumped) git config --bool bool.nobool foobar

Ah. The problem is that we use git_config_int() to parse the command
line option which, upon failure, attempts to print a message with
config_file_name, which is NULL (since we're not parsing a config file
currently). On most systems, printf simply prints "(null)", but on
Solaris, it segfaults. But we shouldn't be passing NULL anyway on any
system, since it makes the message ugly.

This patch fixes it.

-- >8 --
git_config_*: don't assume we are parsing a config file

These functions get called by other code, including parsing config
options from the command line. In that case, config_file_name is NULL,
leading to an ugly message or even a segfault on some implementations of
printf.

---
diff --git a/config.c b/config.c
index 8064cae..c105c13 100644
--- a/config.c
+++ b/config.c
@@ -280,11 +280,18 @@ int git_parse_ulong(const char *value, unsigned long *ret)
 	return 0;
 }
 
+static void die_bad_config(const char *name)
+{
+	if (config_file_name)
+		die("bad config value '%s' in %s", name, config_file_name);
+	die("bad config value for '%s'", name);
+}
+
 int git_config_int(const char *name, const char *value)
 {
 	long ret;
 	if (!git_parse_long(value, &ret))
-		die("bad config value for '%s' in %s", name, config_file_name);
+		die_bad_config(name);
 	return ret;
 }
 
@@ -292,7 +299,7 @@ unsigned long git_config_ulong(const char *name, const char *value)
 {
 	unsigned long ret;
 	if (!git_parse_ulong(value, &ret))
-		die("bad config value for '%s' in %s", name, config_file_name);
+		die_bad_config(name);
 	return ret;
 }
 
