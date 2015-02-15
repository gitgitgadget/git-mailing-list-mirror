From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH 1/2] daemon: look up client-supplied hostname lazily
Date: Sun, 15 Feb 2015 19:31:41 +0100
Message-ID: <54E0E60D.6000305@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 15 19:32:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YN3zU-0003lR-CT
	for gcvg-git-2@plane.gmane.org; Sun, 15 Feb 2015 19:32:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754933AbbBOScP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2015 13:32:15 -0500
Received: from mout.web.de ([212.227.15.3]:53626 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754390AbbBOScO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2015 13:32:14 -0500
Received: from [192.168.178.27] ([79.253.163.94]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0Ldmkd-1Xfiby39Ah-00iyFL; Sun, 15 Feb 2015 19:32:09
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
X-Provags-ID: V03:K0:wIInn2j6BUIXjqF/9CKDxc0FEOVBfA3wePfvK9DaqnbaI+ailAe
 80vrOlx+CNQUXfO1qGugSb90dEdgzYWPwnhJKYn7TvtenHgHeKy3TAx7SItqGkPpCTEGi8W
 MUBVD+IjhdeZz+06kHbQhoLDcMfE8/6zbybRqabTvk5C1CSGDOfmoIAuqHcxbHpjYO/FzQN
 Sr66gWzJSv4suL+OAA98w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263853>

Look up canonical hostname and IP address using getaddrinfo(3) or
gethostbyname(3) only if --interpolated-path or --access-hook were
specified.

Do that by introducing getter functions for canon_hostname and
ip_address and using them for all read accesses.  These wrappers call
the new helper lookup_hostname(), which sets the variables only at its
first call.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 daemon.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/daemon.c b/daemon.c
index 54a03bd..ef41943 100644
--- a/daemon.c
+++ b/daemon.c
@@ -61,6 +61,22 @@ static char *canon_hostname;
 static char *ip_address;
 static char *tcp_port;
 
+static int hostname_lookup_done;
+
+static void lookup_hostname(void);
+
+static const char *get_canon_hostname(void)
+{
+	lookup_hostname();
+	return canon_hostname;
+}
+
+static const char *get_ip_address(void)
+{
+	lookup_hostname();
+	return ip_address;
+}
+
 static void logreport(int priority, const char *err, va_list params)
 {
 	if (log_syslog) {
@@ -147,8 +163,8 @@ static const char *path_ok(const char *directory)
 		struct strbuf_expand_dict_entry dict[6];
 
 		dict[0].placeholder = "H"; dict[0].value = hostname;
-		dict[1].placeholder = "CH"; dict[1].value = canon_hostname;
-		dict[2].placeholder = "IP"; dict[2].value = ip_address;
+		dict[1].placeholder = "CH"; dict[1].value = get_canon_hostname();
+		dict[2].placeholder = "IP"; dict[2].value = get_ip_address();
 		dict[3].placeholder = "P"; dict[3].value = tcp_port;
 		dict[4].placeholder = "D"; dict[4].value = directory;
 		dict[5].placeholder = NULL; dict[5].value = NULL;
@@ -254,8 +270,8 @@ static int run_access_hook(struct daemon_service *service, const char *dir, cons
 	*arg++ = service->name;
 	*arg++ = path;
 	*arg++ = STRARG(hostname);
-	*arg++ = STRARG(canon_hostname);
-	*arg++ = STRARG(ip_address);
+	*arg++ = STRARG(get_canon_hostname());
+	*arg++ = STRARG(get_ip_address());
 	*arg++ = STRARG(tcp_port);
 	*arg = NULL;
 #undef STRARG
@@ -509,6 +525,7 @@ static void parse_host_arg(char *extra_args, int buflen)
 				}
 				free(hostname);
 				hostname = xstrdup_tolower(host);
+				hostname_lookup_done = 0;
 			}
 
 			/* On to the next one */
@@ -517,11 +534,14 @@ static void parse_host_arg(char *extra_args, int buflen)
 		if (extra_args < end && *extra_args)
 			die("Invalid request");
 	}
+}
 
-	/*
-	 * Locate canonical hostname and its IP address.
-	 */
-	if (hostname) {
+/*
+ * Locate canonical hostname and its IP address.
+ */
+static void lookup_hostname(void)
+{
+	if (!hostname_lookup_done && hostname) {
 #ifndef NO_IPV6
 		struct addrinfo hints;
 		struct addrinfo *ai;
@@ -569,6 +589,7 @@ static void parse_host_arg(char *extra_args, int buflen)
 			ip_address = xstrdup(addrbuf);
 		}
 #endif
+		hostname_lookup_done = 1;
 	}
 }
 
-- 
2.3.0
