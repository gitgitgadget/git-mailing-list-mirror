From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/6] transport: learn to honor DNS SRV records
Date: Mon, 6 Jun 2011 04:46:20 -0500
Message-ID: <20110606094620.GK8015@elie>
References: <20110524202249.GA5889@elie>
 <20110524230900.GA9440@radis.liafa.jussieu.fr>
 <20110606093019.GD8015@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Julien Cristau <jcristau@debian.org>
X-From: git-owner@vger.kernel.org Mon Jun 06 11:46:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTWOF-0005oX-20
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 11:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755744Ab1FFJq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 05:46:26 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55324 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753545Ab1FFJqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 05:46:25 -0400
Received: by iwn34 with SMTP id 34so2974394iwn.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 02:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=sjZ9kw4it7QoDxBerT9WAJIoeBp2+AT1MzLebHoovFE=;
        b=qWdrDyc/iGEYflEhIzqVbpGaOu+aP8LKkIMhUCWV5r4kBOkl1bdeO9cnQcrQ+xNgZd
         nCWotrzg3fWN4Cbb6QYtHzv9omWYPO8ZH2qzqN624C6o824RPWOKnO63y7Ru8L0B/9k4
         Bt1qiu+5aLRNBGKo3prIAxZOHXEaYZqBdt6Tw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZpAayNI5msuIYKAfl9J9+Nc4XOYAHJ/TFouBUf120tmZXif6ZtgenUfBLB13rwr+bP
         ymrIiE+Rj+USoetrEr3Zj/K9KmvUlYufTIX2/h50bRLlPB+8m2MVzjRK1xkuNdZrFQOe
         lQ2BgKFg2Vz6MibdO4YwhJ114TaxQunOaTs7o=
Received: by 10.231.74.7 with SMTP id s7mr7706412ibj.172.1307353584464;
        Mon, 06 Jun 2011 02:46:24 -0700 (PDT)
Received: from elie (adsl-68-255-97-40.dsl.chcgil.ameritech.net [68.255.97.40])
        by mx.google.com with ESMTPS id 10sm1616719ibn.20.2011.06.06.02.46.22
        (version=SSLv3 cipher=OTHER);
        Mon, 06 Jun 2011 02:46:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110606093019.GD8015@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175112>

As rfc2782 explains, SRV records allow administrators "to use serveral
servers for a single domain, to move services from host to host with
little fuss, and to designate some hosts as primary servers for a
service and others as backups".  Someone noticed in a recent server
move that that second part would have been very handy (since the git
protocol doesn't include a concept of redirects).

Sadly, getaddrinfo itself does not include a facility to resolve SRV
records automatically.  So this patch uses the libbind functions from
libresolv to parse the response for ourselves.  Hopefully after
reading enough specimens of code like this, someone will be disgusted
enough to extend libc to take care of this in general.

RFC 2782 requires some non-determinism in the order of hosts
contacted; this patch uses drand48() for that.  To avoid causing
trouble for platforms without the libbind ns_* functions or drand48(),
the new SRV support is only built when requested with the USE_SRV_RR
compile-time option.

Based on a patch by Julien Cristau <jcristau@debian.org>.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for reading.

 Makefile |   10 ++
 srv.c    |  290 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 srv.h    |   15 +++
 tcp.c    |   90 +++++++++++++-------
 4 files changed, 375 insertions(+), 30 deletions(-)
 create mode 100644 srv.c
 create mode 100644 srv.h

diff --git a/Makefile b/Makefile
index 7d3cb41..316b29e 100644
--- a/Makefile
+++ b/Makefile
@@ -124,6 +124,10 @@ all::
 # Notably on Solaris hstrerror resides in libresolv and on Solaris 7
 # inet_ntop and inet_pton additionally reside there.
 #
+# Define USE_SRV_RR if you want git to pay attention to SRV resource records
+# when looking up servers to contact over git protocol.  This implies
+# NEEDS_RESOLV.
+#
 # Define NO_MMAP if you want to avoid mmap.
 #
 # Define NO_PTHREADS if you do not have or do not want to use Pthreads.
@@ -1357,6 +1361,11 @@ endif
 ifdef NEEDS_NSL
 	EXTLIBS += -lnsl
 endif
+ifdef USE_SRV_RR
+	BASIC_CFLAGS += -DUSE_SRV_RR
+	LIB_OBJS += srv.o
+	NEEDS_RESOLV = YesPlease
+endif
 ifdef NEEDS_RESOLV
 	EXTLIBS += -lresolv
 endif
@@ -1965,6 +1974,7 @@ builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
 builtin/tar-tree.o archive-tar.o: tar.h
 connect.o transport.o http-backend.o: url.h
 connect.o daemon.o tcp.o: tcp.h
+tcp.o srv.o: srv.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.h
 http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h url.h
 
diff --git a/srv.c b/srv.c
new file mode 100644
index 0000000..222c244
--- /dev/null
+++ b/srv.c
@@ -0,0 +1,290 @@
+#include "cache.h"
+#include "strbuf.h"
+#include "srv.h"
+
+#include <arpa/nameser.h>
+#include <resolv.h>
+
+struct parsed_srv_rr {
+	int priority;
+	int weight;
+	int port;
+	char *target;
+};
+
+static void srv_swap(struct parsed_srv_rr *p1, struct parsed_srv_rr *p2)
+{
+	char *a, *b;
+	int size = sizeof(struct parsed_srv_rr);
+
+	for (a = (char *) p1, b = (char *) p2; size; size--) {
+		char t = *a;
+		*a++ = *b;
+		*b++ = t;
+	}
+}
+
+static int priority_compare(const void *p1, const void *p2)
+{
+	const struct parsed_srv_rr *a = p1, *b = p2;
+
+	/* can't overflow because priorities are 16 bits wide */
+	return b->priority - a->priority;
+}
+
+static int get_qname_for_srv(struct strbuf *sb, const char *host)
+{
+	const char prefix[] = "_git._tcp.";
+	size_t hostlen;
+
+	hostlen = strlen(host);
+	if (unsigned_add_overflows(strlen(prefix) + 1, hostlen))
+		return -1;
+
+	strbuf_reset(sb);
+	strbuf_grow(sb, strlen(prefix) + hostlen);
+	strbuf_add(sb, prefix, strlen(prefix));
+	strbuf_add(sb, host, hostlen);
+	return 0;
+}
+
+static int srv_parse_rr(const ns_msg *msg,
+			const ns_rr *rr, struct parsed_srv_rr *res)
+{
+	const unsigned char *p;
+	char buf[1024];
+
+	if (ns_rr_rdlen(*rr) < 2+2+2 /* priority, weight, port */)
+		return -1;
+
+	p = ns_rr_rdata(*rr);
+	res->priority = *p++ << CHAR_BIT;
+	res->priority += *p++;
+
+	res->weight = *p++ << CHAR_BIT;
+	res->weight += *p++;
+
+	res->port = *p++ << CHAR_BIT;
+	res->port += *p++;
+
+	/*
+	 * RFC2782 doesn't allow compressed target domain names but we
+	 * might as well accept them anyway.
+	 */
+	if (dn_expand(ns_msg_base(*msg), ns_msg_end(*msg), p,
+			buf, sizeof(buf)) < 0)
+		return -1;
+
+	res->target = xstrdup(buf);
+	return 0;
+}
+
+static struct parsed_srv_rr *srv_parse(ns_msg *msg, int n)
+{
+	struct parsed_srv_rr *rrs;
+	int nr_parsed = 0;
+	int i;
+
+	rrs = xmalloc(sizeof(*rrs) * n);
+	for (i = 0; i < n; i++) {
+		ns_rr rr;
+
+		if (ns_parserr(msg, ns_s_an, i, &rr) ||
+		    srv_parse_rr(msg, &rr, rrs + i))
+			goto fail;
+		nr_parsed++;
+	}
+
+	return rrs;
+fail:
+	for (i = 0; i < nr_parsed; i++)
+		free(rrs[i].target);
+	free(rrs);
+	return NULL;
+}
+
+static int weighted_item(struct parsed_srv_rr *rrs, int n, unsigned int pos)
+{
+	int i;
+
+	for (i = 0; i < n; i++) {
+		unsigned int wt = rrs[i].weight;
+
+		if (wt >= pos)
+			break;
+		pos -= wt;
+	}
+	return i;
+}
+
+static void shuffle_one(struct parsed_srv_rr *rrs, int n,
+				int i, int *j, unsigned int *wt_remaining)
+{
+	unsigned int pos;
+	int k;
+
+	pos = (unsigned) (drand48() * (*wt_remaining + 1));
+
+	if (!pos) {
+		*wt_remaining -= rrs[i].weight;
+		return;
+	}
+
+	/* Which item will take the place of rrs[i]? */
+	if (*j < i)
+		*j = i;
+	k = *j + weighted_item(rrs + *j, n - *j, pos);
+
+	assert(k < n);
+	*wt_remaining -= rrs[k].weight;
+
+	if (k == i)
+		return;
+
+	srv_swap(rrs + i, rrs + k);
+
+	/*
+	 * If rrs[i] had weight zero, move it to stay in the clump
+	 * of weight-zero records.  rrs[k] cannot have had weight
+	 * zero because pos > 0.
+	 */
+	assert(*j <= k);
+	if (i < *j) {
+		srv_swap(rrs + k, rrs + *j + 1);
+		(*j)++;
+	}
+}
+
+static void weighted_shuffle(struct parsed_srv_rr *rrs, int n)
+{
+	int i, j;
+	unsigned int total = 0;
+	static int seeded;
+
+	/*
+	 * Calculate total weight and move weight-zero
+	 * records to the left.
+	 */
+	assert(n < (1 << 16));
+	for (i = j = 0; i < n; i++) {
+		unsigned int wt = rrs[i].weight;
+		assert(wt < (1 << 16));
+
+		if (!wt) {
+			srv_swap(rrs + i, rrs + j);
+			j++;
+		}
+
+		/*
+		 * In the worst case, n is 2^16 - 1 and
+		 * each weight is 2^16 - 1, making the total
+		 * a little less than 2^32.
+		 */
+		assert(!unsigned_add_overflows(total, wt + 1));
+		total += wt;
+	}
+	/* Usual case: all weights are zero. */
+	if (!total)
+		return;
+
+	if (!seeded) {
+		seeded = 1;
+		srand48(time(NULL));
+	}
+
+	for (i = 0; i < n; i++)
+		/*
+		 * Now the records starting at rrs[i] could be in any order,
+		 * except those of weight 0 are at the start of the list
+		 * (ending with rrs[j-1]).
+		 *
+		 * Pick an item at random, taking weights into account, and
+		 * make it rrs[i], preserving that invariant.
+		 */
+		shuffle_one(rrs, n, i, &j, &total);
+}
+
+static void sort_rrs(struct parsed_srv_rr *rrs, int n)
+{
+	int i, j, prio;
+
+	qsort(rrs, n, sizeof(*rrs), priority_compare);
+
+	/*
+	 * Within each priority level, order servers randomly,
+	 * respecting weight.
+	 */
+	j = 0;
+	prio = rrs[j].priority;
+	for (i = 0; i < n; i++) {
+		if (rrs[i].priority == prio)
+			continue;
+
+		weighted_shuffle(rrs + j, i - j);
+		j = i;
+		prio = rrs[j].priority;
+	}
+	weighted_shuffle(rrs + j, n - j);
+}
+
+/* Reference: RFC2782. */
+int get_srv(const char *host, struct host **hosts)
+{
+	struct strbuf sb = STRBUF_INIT;
+	unsigned char buf[1024];
+	ns_msg msg;
+	int len, n, i, ret;
+	struct parsed_srv_rr *rrs = NULL;
+	struct host *reply = NULL;
+
+	/* if no SRV record is found, fall back to plain address lookup */
+	ret = 0;
+
+	/* _git._tcp.<host> */
+	if (get_qname_for_srv(&sb, host))
+		goto out;
+	len = res_query(sb.buf, ns_c_in, ns_t_srv, buf, sizeof(buf));
+	if (len < 0)
+		goto out;
+
+	if (ns_initparse(buf, len, &msg))
+		goto out;
+	n = ns_msg_count(msg, ns_s_an);
+	if (!n)
+		goto out;
+	assert(n < (1 << 16));
+
+	/* Parse reply.  If a SRV RR cannot be parsed, give up. */
+	ret = -1;
+	rrs = srv_parse(&msg, n);
+	if (!rrs)
+		goto out;
+
+	/* A single RR with target "." means "go away". */
+	if (n == 1 &&
+	    (!*rrs[0].target || !strcmp(rrs[0].target, ".")))
+		goto out2;
+
+	sort_rrs(rrs, n);
+
+	/* Success! */
+	ret = n;
+	reply = xmalloc(n * sizeof(**hosts));
+	for (i = 0; i < n; i++) {
+		char buf[32];
+		snprintf(buf, sizeof(buf), "%d", rrs[i].port);
+
+		reply[i].hostname = rrs[i].target;
+		reply[i].port = xstrdup(buf);
+	}
+	*hosts = reply;
+	goto out;
+
+out2:
+	for (i = 0; i < n; i++)
+		free(rrs[i].target);
+out:
+	free(rrs);
+	strbuf_release(&sb);
+	return 0;
+}
diff --git a/srv.h b/srv.h
new file mode 100644
index 0000000..7cea4f4
--- /dev/null
+++ b/srv.h
@@ -0,0 +1,15 @@
+#ifndef SRV_H
+#define SRV_H
+
+struct host {
+	char *hostname;
+	char *port;
+};
+
+#ifndef USE_SRV_RR
+#define get_srv(host, hosts) 0
+#else
+extern int get_srv(const char *host, struct host **hosts);
+#endif
+
+#endif
diff --git a/tcp.c b/tcp.c
index aacc2d1..53ad2e0 100644
--- a/tcp.c
+++ b/tcp.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "run-command.h"
+#include "srv.h"
 
 #ifndef NO_IPV6
 #include "dns-ipv6.h"
@@ -120,49 +121,73 @@ void git_locate_host(const char *hostname, char **ip_address,
 static int git_tcp_connect_sock(char *host, int flags)
 {
 	int sockfd = -1, saved_errno = 0;
-	const char *port = STR(DEFAULT_GIT_PORT);
+	const char *port = NULL;
+	struct host *hosts = NULL;
 	resolver_result ai;
 	resolved_address i;
 	int cnt = -1;
+	int j, n = 0;
 
 	get_host_and_port(&host, &port);
+	if (!port) {
+		port = STR(DEFAULT_GIT_PORT);
+		n = get_srv(host, &hosts);
+	}
+	if (n < 0)
+		die("Unable to look up %s", host);
 	if (!*port)
 		port = "<none>";
+	if (!n) {
+		hosts = xmalloc(sizeof(*hosts));
+		hosts[0].hostname = xstrdup(host);
+		hosts[0].port = xstrdup(port);
+		n = 1;
+	}
 
-	if (flags & CONNECT_VERBOSE)
-		fprintf(stderr, "Looking up %s ... ", host);
-
-	if (dns_resolve(host, port, 0, &ai))
-		die("BUG: dns_resolve returned error?");
-
-	if (flags & CONNECT_VERBOSE)
-		fprintf(stderr, "done.\nConnecting to %s (port %s) ... ", host, port);
+	for (j = 0; j < n; j++) {
+		if (flags & CONNECT_VERBOSE)
+			fprintf(stderr, "Looking up %s ... ", hosts[j].hostname);
 
-	for_each_address(i, ai) {
-		cnt++;
-		sockfd = socket(dns_family(i, ai),
-				dns_socktype(i, ai), dns_protocol(i, ai));
-		if (sockfd < 0) {
-			saved_errno = errno;
-			continue;
-		}
-		if (connect(sockfd, dns_addr(i, ai), dns_addrlen(i, ai)) < 0) {
-			saved_errno = errno;
-			fprintf(stderr, "%s[%d: %s]: errno=%s\n",
-				host,
-				cnt,
-				dns_name(&i),
-				strerror(saved_errno));
-			close(sockfd);
-			sockfd = -1;
+		if (dns_resolve(hosts[j].hostname,
+				hosts[j].port, RESOLVE_IGNORE_ERROR, &ai)) {
+			if (flags & CONNECT_VERBOSE)
+				fprintf(stderr, "failed.\n");
 			continue;
 		}
+
 		if (flags & CONNECT_VERBOSE)
-			fprintf(stderr, "%s ", dns_name(&i));
-		break;
-	}
+			fprintf(stderr, "done.\nConnecting to %s (port %s) ... ",
+					hosts[j].hostname, hosts[j].port);
+
+		for_each_address(i, ai) {
+			cnt++;
+			sockfd = socket(dns_family(i, ai),
+					dns_socktype(i, ai), dns_protocol(i, ai));
+			if (sockfd < 0) {
+				saved_errno = errno;
+				continue;
+			}
+			if (connect(sockfd, dns_addr(i, ai), dns_addrlen(i, ai)) < 0) {
+				saved_errno = errno;
+				fprintf(stderr, "%s[%d: %s]: errno=%s\n",
+					hosts[j].hostname,
+					cnt,
+					dns_name(&i),
+					strerror(saved_errno));
+				close(sockfd);
+				sockfd = -1;
+				continue;
+			}
+			if (flags & CONNECT_VERBOSE)
+				fprintf(stderr, "%s ", dns_name(&i));
+			break;
+		}
+
+		dns_free(ai);
 
-	dns_free(ai);
+		if (sockfd >= 0)
+			break;
+	}
 
 	if (sockfd < 0)
 		die("unable to connect a socket (%s)", strerror(saved_errno));
@@ -170,6 +195,11 @@ static int git_tcp_connect_sock(char *host, int flags)
 	if (flags & CONNECT_VERBOSE)
 		fprintf(stderr, "done.\n");
 
+	for (j = 0; j < n; j++) {
+		free(hosts[j].hostname);
+		free(hosts[j].port);
+	}
+	free(hosts);
 	return sockfd;
 }
 
-- 
1.7.5.3
