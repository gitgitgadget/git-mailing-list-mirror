From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH 0/6] address packed-refs speed regressions
Date: Sun, 05 Apr 2015 15:41:39 +0200
Message-ID: <55213B93.9050207@web.de>
References: <20150405010611.GA15901@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 05 15:42:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YekoV-0003L0-Qx
	for gcvg-git-2@plane.gmane.org; Sun, 05 Apr 2015 15:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbbDENmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2015 09:42:07 -0400
Received: from mout.web.de ([212.227.17.12]:54474 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751555AbbDENmF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2015 09:42:05 -0400
Received: from [192.168.178.27] ([79.250.182.13]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LjJL9-1ZHejN21N9-00dUw9; Sun, 05 Apr 2015 15:42:02
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <20150405010611.GA15901@peff.net>
X-Provags-ID: V03:K0:lKK/bQOZIjv/xfl7GMjKGp9aVX2oJuqrsmg5lBvs9Fp7y3Fs05v
 6hohJUpSQ2y2T0kA0j2Fcfg4P0Gsyb5+KDPGYq89xfXdshgMqu1bEe/PVwuZiLA7xDCGINI
 CV2CGLbESALN8U0SSvnfbCScjq+ohM90P+5orlFbnTna5E4AD/VXkjHKlPrVkhZa+NUAFBK
 RB3sDnMZs/3iJh7lEdt1w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266805>

Am 05.04.2015 um 03:06 schrieb Jeff King:
> As I've mentioned before, I have some repositories with rather large
> numbers of refs. The worst one has ~13 million refs, for a 1.6GB
> packed-refs file. So I was saddened by this:
> 
>    $ time git.v2.0.0 rev-parse refs/heads/foo >/dev/null 2>&1
>    real    0m6.840s
>    user    0m6.404s
>    sys     0m0.440s
> 
>    $ time git.v2.4.0-rc1 rev-parse refs/heads/foo >/dev/null 2>&1
>    real    0m19.432s
>    user    0m18.996s
>    sys     0m0.456s
> 
> The command isn't important; what I'm really measuring is loading the
> packed-refs file. And yes, of course this repository is absolutely
> ridiculous. But the slowdowns here are linear with the number of refs.
> So _every_ git command got a little bit slower, even in less crazy
> repositories. We just didn't notice it as much.
> 
> Here are the numbers after this series:
> 
>    real    0m8.539s
>    user    0m8.052s
>    sys     0m0.496s
> 
> Much better, but I'm frustrated that they are still 20% slower than the
> original.
> 
> The main culprits seem to be d0f810f (which introduced some extra
> expensive code for each ref) and my 10c497a, which switched from fgets()
> to strbuf_getwholeline. It turns out that strbuf_getwholeline is really
> slow.

10c497a changed read_packed_refs(), which reads *all* packed refs.
Each is checked for validity.  That sounds expensive if the goal is
just to look up a single (non-existing) ref.

Would it help to defer any checks until a ref is actually accessed?
Can a binary search be used instead of reading the whole file?

I wonder if pluggable reference backends could help here.  Storing refs
in a database table indexed by refname should simplify things.

Short-term, can we avoid the getc()/strbuf_grow() dance e.g. by mapping
the packed refs file?  What numbers do you get with the following patch?

---
 refs.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/refs.c b/refs.c
index 47e4e53..144255f 100644
--- a/refs.c
+++ b/refs.c
@@ -1153,16 +1153,35 @@ static const char *parse_ref_line(struct strbuf *line, unsigned char *sha1)
  *      compatibility with older clients, but we do not require it
  *      (i.e., "peeled" is a no-op if "fully-peeled" is set).
  */
-static void read_packed_refs(FILE *f, struct ref_dir *dir)
+static void read_packed_refs(int fd, struct ref_dir *dir)
 {
 	struct ref_entry *last = NULL;
 	struct strbuf line = STRBUF_INIT;
 	enum { PEELED_NONE, PEELED_TAGS, PEELED_FULLY } peeled = PEELED_NONE;
+	struct stat st;
+	void *map;
+	size_t mapsz, len;
+	const char *p;
+
+	fstat(fd, &st);
+	mapsz = xsize_t(st.st_size);
+	if (!mapsz)
+		return;
+	map = xmmap(NULL, mapsz, PROT_READ, MAP_PRIVATE, fd, 0);
 
-	while (strbuf_getwholeline(&line, f, '\n') != EOF) {
+	for (p = map, len = mapsz; len; ) {
 		unsigned char sha1[20];
 		const char *refname;
 		const char *traits;
+		const char *nl;
+		size_t linelen;
+
+		nl = memchr(p, '\n', len);
+		linelen = nl ? nl - p + 1 : len;
+		strbuf_reset(&line);
+		strbuf_add(&line, p, linelen);
+		p += linelen;
+		len -= linelen;
 
 		if (skip_prefix(line.buf, "# pack-refs with:", &traits)) {
 			if (strstr(traits, " fully-peeled "))
@@ -1204,6 +1223,7 @@ static void read_packed_refs(FILE *f, struct ref_dir *dir)
 	}
 
 	strbuf_release(&line);
+	munmap(map, mapsz);
 }
 
 /*
@@ -1224,16 +1244,16 @@ static struct packed_ref_cache *get_packed_ref_cache(struct ref_cache *refs)
 		clear_packed_ref_cache(refs);
 
 	if (!refs->packed) {
-		FILE *f;
+		int fd;
 
 		refs->packed = xcalloc(1, sizeof(*refs->packed));
 		acquire_packed_ref_cache(refs->packed);
 		refs->packed->root = create_dir_entry(refs, "", 0, 0);
-		f = fopen(packed_refs_file, "r");
-		if (f) {
-			stat_validity_update(&refs->packed->validity, fileno(f));
-			read_packed_refs(f, get_ref_dir(refs->packed->root));
-			fclose(f);
+		fd = open(packed_refs_file, O_RDONLY);
+		if (fd >= 0) {
+			stat_validity_update(&refs->packed->validity, fd);
+			read_packed_refs(fd, get_ref_dir(refs->packed->root));
+			close(fd);
 		}
 	}
 	return refs->packed;
-- 
2.3.5
