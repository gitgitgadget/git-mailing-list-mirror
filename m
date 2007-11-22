From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Replace setenv(GIT_DIR_ENVIRONMENT, ...) with
 set_git_dir()
Date: Thu, 22 Nov 2007 22:09:10 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711222149390.27959@racer.site>
References: <11956768414090-git-send-email-prohaska@zib.de>
 <11956768412804-git-send-email-prohaska@zib.de> <11956768413887-git-send-email-prohaska@zib.de>
 <11956768412755-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0711220121560.27959@racer.site>
 <7v63zv9fel.fsf@gitster.siamese.dyndns.org> <C50619A0-4A67-4968-8431-D7A685F723B7@zib.de>
 <7vsl2y90pm.fsf@gitster.siamese.dyndns.org> <52415F60-C080-4260-86CD-32A379482341@zib.de>
 <474552D6.5060305@viscovery.net> <3B6B19E6-255F-4D8F-B6A3-255A9E8E0AB0@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Nov 22 23:09:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvKEp-0006Q9-EK
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 23:09:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736AbXKVWJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 17:09:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752855AbXKVWJQ
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 17:09:16 -0500
Received: from mail.gmx.net ([213.165.64.20]:47346 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752979AbXKVWJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 17:09:16 -0500
Received: (qmail invoked by alias); 22 Nov 2007 22:09:13 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp041) with SMTP; 22 Nov 2007 23:09:13 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX190UKgCPGB0/D6LRJrPoS2q0SHgRJYfoFWtZ2ePX7
	CfWcxnE84S1sr2
X-X-Sender: gene099@racer.site
In-Reply-To: <3B6B19E6-255F-4D8F-B6A3-255A9E8E0AB0@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65852>

Hi,

On Thu, 22 Nov 2007, Steffen Prohaska wrote:

> Yes, and apparently even nobody knows how to trigger the problem on 
> Windows.

A quick and easy way would be to instrument getenv(), unsetenv() and 
setenv(), which would trigger an error.  Something like this (but you 
will have to put in a few "extern called_getenv; called_getenv = 0;", 
since already a simple git-init fails because of setup_path()):

-- snipsnap --
[PATCH] Instrument getenv(), setenv(), unsetenv() and putenv()

... for finding places where a pointer obtained by getenv() could
be invalidated later.

---

 environment.c     |    1 +
 git-compat-util.h |   31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/environment.c b/environment.c
index ce75e98..027340e 100644
--- a/environment.c
+++ b/environment.c
@@ -9,6 +9,7 @@
  */
 #include "cache.h"
 
+int called_setenv, called_getenv;
 char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
 int trust_executable_bit = 1;
diff --git a/git-compat-util.h b/git-compat-util.h
index 79eb10e..a41469b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -427,4 +427,35 @@ static inline int strtol_i(char const *s, int base, int *result)
 	return 0;
 }
 
+extern int called_setenv, called_getenv;
+static inline char *test_getenv(const char *name)
+{
+	if (!called_setenv)
+		warning ("called test_getenv %s", name);
+	called_getenv = 1;
+	return getenv(name);
+}
+static inline int test_setenv(const char *name, const char *value, int overwrite)
+{
+	if (!called_setenv && called_getenv)
+		die ("getenv was called before setenv(%s, %s, %d)",
+				name, value, overwrite);
+	return setenv(name, value, overwrite);
+}
+static inline int test_unsetenv(const char *name)
+{
+	if (!called_setenv && called_getenv)
+		die ("getenv was called before unsetenv(%s)", name);
+	return unsetenv(name);
+}
+static inline int test_putenv(char *string)
+{
+	if (!called_setenv && called_getenv)
+		die ("getenv was called before putenv(%s)", string);
+	return putenv(string);
+}
+#define getenv test_getenv
+#define setenv test_setenv
+#define unsetenv test_unsetenv
+
 #endif
