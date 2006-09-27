From: Jon Loeliger <jdl@jdl.com>
Subject: [PATCH] Removed memory leaks from interpolation table uses.
Date: Wed, 27 Sep 2006 11:16:10 -0500
Message-ID: <E1GSc4w-0005cu-I3@jdl.com>
X-From: git-owner@vger.kernel.org Wed Sep 27 18:19:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSc56-0004jz-ID
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 18:16:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWI0QQQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 12:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWI0QQQ
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 12:16:16 -0400
Received: from jdl.com ([66.118.10.122]:7066 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1751162AbWI0QQP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 12:16:15 -0400
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1GSc4w-0005cu-I3
	for git@vger.kernel.org; Wed, 27 Sep 2006 11:16:12 -0500
To: git@vger.kernel.org
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27911>

Clarified that parse_extra_args()s results in
interpolation table entries.
Removed a few trailing whitespace occurrences.

Signed-off-by: Jon Loeliger <jdl@jdl.com>

---

Junio,

This is on top of my previous cleanup [PATCH Rev 3].

BTW, In that previous patch of mine, this line:

        -	and %D for the absolute path of the named repository.	

has trailing blanks in my patch that must be removed in order
to apply it correctly to the HEAD of git.  The _previous_ patch
clearly was (correctly) applied with --whitepace=strip!

*sigh*

Thanks,
jdl



 daemon.c      |   56 ++++++++++++++++++++++++++++++++++----------------------
 interpolate.c |   26 ++++++++++++++++++++++++++
 interpolate.h |    3 +++
 3 files changed, 63 insertions(+), 22 deletions(-)

diff --git a/daemon.c b/daemon.c
index 260f0cf..46c7fa2 100644
--- a/daemon.c
+++ b/daemon.c
@@ -71,7 +71,7 @@ static struct interp interp_table[] = {
 	{ "%IP", 0},
 	{ "%P", 0},
 	{ "%D", 0},
-	{ "%%", "%"},
+	{ "%%", 0},
 };
 
 
@@ -398,7 +398,11 @@ static void make_service_overridable(con
 	die("No such service %s", name);
 }
 
-static void parse_extra_args(char *extra_args, int buflen)
+/*
+ * Separate the "extra args" information as supplied by the client connection.
+ * Any resulting data is squirrelled away in the given interpolation table.
+ */
+static void parse_extra_args(struct interp *table, char *extra_args, int buflen)
 {
 	char *val;
 	int vallen;
@@ -410,18 +414,17 @@ static void parse_extra_args(char *extra
 			val = extra_args + 5;
 			vallen = strlen(val) + 1;
 			if (*val) {
-				char *port;
-				char *save = xmalloc(vallen);	/* FIXME: Leak */
-
-				interp_table[INTERP_SLOT_HOST].value = save;
-				strlcpy(save, val, vallen);
-				port = strrchr(save, ':');
+				/* Split <host>:<port> at colon. */
+				char *host = val;
+				char *port = strrchr(host, ':');
 				if (port) {
 					*port = 0;
 					port++;
-					interp_table[INTERP_SLOT_PORT].value = port;
+					interp_set_entry(table, INTERP_SLOT_PORT, port);
 				}
+				interp_set_entry(table, INTERP_SLOT_HOST, host);
 			}
+
 			/* On to the next one */
 			extra_args = val + vallen;
 		}
@@ -431,8 +434,6 @@ static void parse_extra_args(char *extra
 void fill_in_extra_table_entries(struct interp *itable)
 {
 	char *hp;
-	char *canon_host = NULL;
-	char *ipaddr = NULL;
 
 	/*
 	 * Replace literal host with lowercase-ized hostname.
@@ -459,10 +460,12 @@ #ifndef NO_IPV6
 			for (ai = ai0; ai; ai = ai->ai_next) {
 				struct sockaddr_in *sin_addr = (void *)ai->ai_addr;
 
-				canon_host = xstrdup(ai->ai_canonname);
 				inet_ntop(AF_INET, &sin_addr->sin_addr,
 					  addrbuf, sizeof(addrbuf));
-				ipaddr = addrbuf;
+				interp_set_entry(interp_table,
+						 INTERP_SLOT_CANON_HOST, ai->ai_canonname);
+				interp_set_entry(interp_table,
+						 INTERP_SLOT_IP, addrbuf);
 				break;
 			}
 			freeaddrinfo(ai0);
@@ -476,22 +479,20 @@ #else
 		static char addrbuf[HOST_NAME_MAX + 1];
 
 		hent = gethostbyname(interp_table[INTERP_SLOT_HOST].value);
-		canon_host = xstrdup(hent->h_name);
 
 		ap = hent->h_addr_list;
 		memset(&sa, 0, sizeof sa);
 		sa.sin_family = hent->h_addrtype;
 		sa.sin_port = htons(0);
 		memcpy(&sa.sin_addr, *ap, hent->h_length);
-			
+
 		inet_ntop(hent->h_addrtype, &sa.sin_addr,
 			  addrbuf, sizeof(addrbuf));
-		ipaddr = addrbuf;
+
+		interp_set_entry(interp_table, INTERP_SLOT_CANON_HOST, hent->h_name);
+		interp_set_entry(interp_table, INTERP_SLOT_IP, addrbuf);
 	}
 #endif
-
-	interp_table[INTERP_SLOT_CANON_HOST].value = canon_host;	/* FIXME: Leak */
-	interp_table[INTERP_SLOT_IP].value = xstrdup(ipaddr);		/* FIXME: Leak */
 }
 
 
@@ -535,8 +536,14 @@ #endif
 	if (len && line[len-1] == '\n')
 		line[--len] = 0;
 
+	/*
+	 * Initialize the path interpolation table for this connection.
+	 */
+	interp_clear_table(interp_table, ARRAY_SIZE(interp_table));
+	interp_set_entry(interp_table, INTERP_SLOT_PERCENT, "%");
+
 	if (len != pktlen) {
-	    parse_extra_args(line + len + 1, pktlen - len - 1);
+	    parse_extra_args(interp_table, line + len + 1, pktlen - len - 1);
 	    fill_in_extra_table_entries(interp_table);
 	}
 
@@ -546,7 +553,12 @@ #endif
 		if (!strncmp("git-", line, 4) &&
 		    !strncmp(s->name, line + 4, namelen) &&
 		    line[namelen + 4] == ' ') {
-			interp_table[INTERP_SLOT_DIR].value = line+namelen+5;
+			/*
+			 * Note: The directory here is probably context sensitive,
+			 * and might depend on the actual service being performed.
+			 */
+			interp_set_entry(interp_table,
+					 INTERP_SLOT_DIR, line + namelen + 5);
 			return run_service(interp_table, s);
 		}
 	}
@@ -982,7 +994,7 @@ int main(int argc, char **argv)
 		    char *ph = listen_addr = xmalloc(strlen(arg + 9) + 1);
 		    while (*p)
 			*ph++ = tolower(*p++);
-		    *ph = 0;		    
+		    *ph = 0;
 		    continue;
 		}
 		if (!strncmp(arg, "--port=", 7)) {
diff --git a/interpolate.c b/interpolate.c
index d82f1b5..8357742 100644
--- a/interpolate.c
+++ b/interpolate.c
@@ -4,9 +4,35 @@
 
 #include <string.h>
 
+#include "git-compat-util.h"
 #include "interpolate.h"
 
 
+void interp_set_entry(struct interp *table, int slot, char *value)
+{
+	char *oldval = table[slot].value;
+	char *newval = value;
+
+	if (oldval)
+		free(oldval);
+
+	if (value)
+		newval = xstrdup(value);
+
+	table[slot].value = newval;
+}
+
+
+void interp_clear_table(struct interp *table, int ninterps)
+{
+	int i;
+
+	for (i = 0; i < ninterps; i++) {
+		interp_set_entry(table, i, NULL);
+	}
+}
+
+
 /*
  * Convert a NUL-terminated string in buffer orig
  * into the supplied buffer, result, whose length is reslen,
diff --git a/interpolate.h b/interpolate.h
index 00c63a5..7f386bd 100644
--- a/interpolate.h
+++ b/interpolate.h
@@ -11,6 +11,9 @@ struct interp {
 	char *value;
 };
 
+extern void interp_set_entry(struct interp *table, int slot, char *value);
+extern void interp_clear_table(struct interp *table, int ninterps);
+
 extern int interpolate(char *result, int reslen,
 		       char *orig,
 		       struct interp *interps, int ninterps);
-- 
1.4.2.1.g85d8-dirty
