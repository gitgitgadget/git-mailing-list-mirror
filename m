From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 7/5] transport: optionally honor DNS SRV records
Date: Thu, 8 Mar 2012 07:21:55 -0600
Message-ID: <20120308132155.GG9426@burratino>
References: <20120308124857.GA7666@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Eric Wong <normalperson@yhbt.net>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 14:22:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5dIH-0004cM-86
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 14:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718Ab2CHNWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 08:22:04 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:65427 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751997Ab2CHNWB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 08:22:01 -0500
Received: by obbuo6 with SMTP id uo6so653638obb.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 05:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KL8+Fr72Anw9/VZmaLP3dTXU/tRR3BZG9FcN9wKgQx4=;
        b=QpnD6qfPh9+moiO0loYJFSJt91Dyd/DkNYgDJyoce67+gw5pKWTRCD/5JMGIba/YWC
         djqzgY0p/O1WFn/EEH87Zr7VE4Z2201vJIpOxxqvCvaCVDqarAyFYEjqFA96gkJDsRe/
         viqLUOu71js0Hn8HyUSJtZnL/1zpZ9+MIFgWWAuPkJodxSvO/cS/RSU4vRVPwe9dbVNn
         Aw2VUt5sHTezFmrkH69CKxGbAe9dJe3Wz9gXcq1D8GEO1qQcapbB5OldzGaVFi4mb6lz
         BC6qLvbig+vsvqsdSjny1fys5GZ7+RH7ZZ8vn/POuVbv/V9045n59IGRhzUffnBKm1FG
         g6fw==
Received: by 10.60.26.166 with SMTP id m6mr2382809oeg.45.1331212920472;
        Thu, 08 Mar 2012 05:22:00 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id s9sm936309oee.2.2012.03.08.05.21.59
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 05:22:00 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120308124857.GA7666@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192598>

Date: Mon, 6 Jun 2011 04:46:20 -0500

SRV records are an extra layer of indirection on top of A/AAAA records
mapping from domain names and service types to the hostnames of
machines that offer that service.  That has a couple of nice effects:

 - a single domain can use different hosts for different services
 - a single domain can use multiple hosts for one service

Teach git to perform a SRV lookup whenever resolving a git:// URL.
This means:

 - if your git server was previously the same machine as your wesnoth
   server, you can move it to a separate machine without forcing
   everyone to update their links to the old URLs

 - if you have a primary git server and a backup machine that should
   be used when the primary server goes down, the client can
   automatically take care of it

 - if you have multiple git servers and would like to spread load
   between them, the client can automatically take care of it

That is, SRV records let us ask the client to carry out various tasks
that would require a proxy on the server side with traditional DNS.
The client performs a SRV query to _git._tcp.<domain name> to receive
its instructions.  RFC 2782 has details.

Ideally reaping these benefits would just involve passing a special
flag to getaddrinfo().  Since we don't live in such a world, this
patch uses the BIND 8 API provided by libresolv to parse the response
for ourselves.

RFC 2782 requires some non-determinism in the order of hosts
contacted; this patch uses drand48() for that.  To avoid causing
trouble for platforms that lack the libbind ns_* functions or
drand48(), the SRV support is only provided when requested by setting
the USE_SRV_RR compile-time option.

git servers must ensure that they can also be reached by a plain
A/AAAA lookup to support git clients without SRV support, for example
by proxying connections to an appropriate server:

	# in inetd.conf
	git stream tcp nowait.400 nobody /usr/sbin/tcpd \
		/bin/nc -q0 gitserver.example.com git

Regression: this uglifies error messages for connection errors a
little.  It would probably be better to leave out the connection count
when we are not trying more than one server.

Based on a patch by Julien Cristau <jcristau@debian.org>.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
As I mentioned at the gittogether, I think this would be a valuable
feature in git.  You can test it out (though this is only the simple
case, no load balancing or failover) by doing

	git clone git://git.debian.org/~jrnieder-guest/git.git

and watching what happens with wireshark.

The patch needs documentation.  Maybe a howto and an addendum to the
protocol docs would do.  Anyway, I hope it's at least entertaining in
the current state.

 Makefile |   10 ++
 srv.c    |  321 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 srv.h    |   15 +++
 tcp.c    |  100 ++++++++++++++------
 4 files changed, 418 insertions(+), 28 deletions(-)
 create mode 100644 srv.c
 create mode 100644 srv.h

diff --git a/Makefile b/Makefile
index 8b603895..56198f11 100644
--- a/Makefile
+++ b/Makefile
@@ -148,6 +148,10 @@ all::
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
@@ -1490,6 +1494,11 @@ endif
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
@@ -2155,6 +2164,7 @@ builtin/commit.o builtin/revert.o wt-status.o: wt-status.h
 builtin/tar-tree.o archive-tar.o: tar.h
 connect.o transport.o url.o http-backend.o: url.h
 connect.o daemon.o tcp.o: tcp.h
+tcp.o srv.o: srv.h
 http-fetch.o http-walker.o remote-curl.o transport.o walker.o: walker.h
 http.o http-walker.o http-push.o http-fetch.o remote-curl.o: http.h url.h
 
diff --git a/srv.c b/srv.c
new file mode 100644
index 00000000..2716206e
--- /dev/null
+++ b/srv.c
@@ -0,0 +1,321 @@
+#include "git-compat-util.h"
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
+		return error("absurdly long hostname");
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
+		return error("SRV RR is too short");
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
+		return error("cannot expand target domain name in SRV RR");
+
+	res->target = xstrdup(buf);
+	return 0;
+}
+
+static int srv_parse(ns_msg *msg, struct parsed_srv_rr **res)
+{
+	struct parsed_srv_rr *rrs = NULL;
+	int nr_parsed = 0;
+	int cnames = 0;
+	int i, n;
+
+	n = ns_msg_count(*msg, ns_s_an);
+
+	/* skip CNAME records */
+	for (i = 0; i < n; i++) {
+		ns_rr rr;
+		if (ns_parserr(msg, ns_s_an, i, &rr)) {
+			error("cannot parse DNS RR: %s", strerror(errno));
+			goto fail;
+		}
+		if (ns_rr_type(rr) != ns_t_cname)
+			break;
+	}
+	cnames = i;
+	n -= cnames;
+
+	rrs = xmalloc(n * sizeof(*rrs));
+	for (i = 0; i < n; i++) {
+		ns_rr rr;
+
+		if (ns_parserr(msg, ns_s_an, cnames + i, &rr)) {
+			error("cannot parse DNS RR: %s", strerror(errno));
+			goto fail;
+		}
+		if (ns_rr_type(rr) != ns_t_srv) {
+			error("expected SRV RR, found RR type %d",
+						(int) ns_rr_type(rr));
+			goto fail;
+		}
+		if (srv_parse_rr(msg, &rr, rrs + i))
+			/* srv_parse_rr writes a message */
+			goto fail;
+		nr_parsed++;
+	}
+
+	*res = rrs;
+	return n;
+fail:
+	for (i = 0; i < nr_parsed; i++)
+		free(rrs[i].target);
+	free(rrs);
+	return -1;
+}
+
+static int weighted_item(struct parsed_srv_rr *rrs, int n, unsigned int pos)
+{
+	int i;
+
+	for (i = 0; i < n; i++) {
+		unsigned int wt = rrs[i].weight;
+
+		if (pos <= wt)
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
+	pos = (unsigned int) ((*wt_remaining + 1) * drand48());
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
+		srv_swap(rrs + k, rrs + *j);
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
+	 * records to the beginning of the array.
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
+		 * Pick an item from rrs[i]..rrs[n] at random, taking weights
+		 * into account, and reorder to make it rrs[i], preserving
+		 * that invariant.
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
+	/* If a SRV RR cannot be parsed, give up. */
+	ret = -1;
+
+	if (ns_initparse(buf, len, &msg)) {
+		error("cannot initialize DNS parser: %s", strerror(errno));
+		goto out;
+	}
+	n = srv_parse(&msg, &rrs);
+	if (n < 0)
+		/* srv_parse writes a message */
+		goto out;
+	if (!n) {
+		ret = 0;
+		goto out;
+	}
+	assert(n < (1 << 16));
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
+	reply = xmalloc(n * sizeof(*reply));
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
+	return ret;
+}
diff --git a/srv.h b/srv.h
new file mode 100644
index 00000000..7cea4f4c
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
index 83f0313a..c27a0d7f 100644
--- a/tcp.c
+++ b/tcp.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "run-command.h"
+#include "srv.h"
 
 #ifndef NO_IPV6
 #include "dns-ipv6.h"
@@ -72,46 +73,85 @@ void git_locate_host(const char *hostname, char **ip_address,
 static int git_tcp_connect_sock(char *host, int flags)
 {
 	struct strbuf error_message = STRBUF_INIT;
-	int sockfd = -1;
-	const char *port = STR(DEFAULT_GIT_PORT);
-	resolver_result ai;
-	resolved_address i;
-	int cnt = -1;
+	int sockfd = -1, gai = 0;
+	const char *port = NULL;
+	struct host *hosts = NULL;
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
+	for (j = 0; j < n; j++) {
+		resolver_result ai;
+		resolved_address i;
+		int cnt;
 
-	if (dns_resolve(host, port, 0, &ai))
-		die("BUG: dns_resolve returned error?");
+		if (flags & CONNECT_VERBOSE)
+			fprintf(stderr, "Looking up %s ... ", hosts[j].hostname);
 
-	if (flags & CONNECT_VERBOSE)
-		fprintf(stderr, "done.\nConnecting to %s (port %s) ... ", host, port);
+		gai = dns_resolve(hosts[j].hostname,
+				hosts[j].port, RESOLVE_FAIL_QUIETLY, &ai);
+		if (gai) {
+			if (flags & CONNECT_VERBOSE)
+				fprintf(stderr, "failed.\n");
 
-	for_each_address(i, ai) {
-		cnt++;
-		sockfd = socket(dns_family(i, ai),
-				dns_socktype(i, ai), dns_protocol(i, ai));
-		if (sockfd < 0 ||
-		    connect(sockfd, dns_addr(i, ai), dns_addrlen(i, ai)) < 0) {
-			strbuf_addf(&error_message, "%s[%d: %s]: errno=%s\n",
-				    host, cnt, dns_name(&i), strerror(errno));
-			if (0 <= sockfd)
-				close(sockfd);
-			sockfd = -1;
+			if (n == 1 && !strcmp(host, hosts[j].hostname))
+				strbuf_addf(&error_message, "%s: %s\n",
+					host, dns_strerror(gai));
+			else
+				strbuf_addf(&error_message,
+					"%s[%d: %s:%s]: %s\n", host, j,
+					hosts[j].hostname, hosts[j].port,
+					dns_strerror(gai));
 			continue;
 		}
+
 		if (flags & CONNECT_VERBOSE)
-			fprintf(stderr, "%s ", dns_name(&i));
-		break;
+			fprintf(stderr, "done.\nConnecting to %s (port %s) ... ",
+					hosts[j].hostname, hosts[j].port);
+
+		cnt = -1;
+		for_each_address(i, ai) {
+			cnt++;
+			sockfd = socket(dns_family(i, ai),
+					dns_socktype(i, ai), dns_protocol(i, ai));
+			if (sockfd < 0 ||
+			    connect(sockfd, dns_addr(i, ai), dns_addrlen(i, ai)) < 0) {
+				strbuf_addf(&error_message, "%s[%d: %s]: errno=%s\n",
+						hosts[j].hostname,
+						cnt,
+						dns_name(&i),
+						strerror(errno));
+				if (0 <= sockfd)
+					close(sockfd);
+				sockfd = -1;
+				continue;
+			}
+			if (flags & CONNECT_VERBOSE)
+				fprintf(stderr, "%s ", dns_name(&i));
+			break;
+		}
+
+		dns_free(ai);
+
+		if (sockfd >= 0)
+			break;
 	}
 
-	dns_free(ai);
-
-	if (sockfd < 0)
+	if (gai || sockfd < 0)
 		die("unable to connect to %s:\n%s", host, error_message.buf);
 
 	enable_keepalive(sockfd);
@@ -119,8 +159,12 @@ static int git_tcp_connect_sock(char *host, int flags)
 	if (flags & CONNECT_VERBOSE)
 		fprintf(stderr, "done.\n");
 
+	for (j = 0; j < n; j++) {
+		free(hosts[j].hostname);
+		free(hosts[j].port);
+	}
+	free(hosts);
 	strbuf_release(&error_message);
-
 	return sockfd;
 }
 
-- 
1.7.9.2
