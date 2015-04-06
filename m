From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/6] address packed-refs speed regressions
Date: Mon, 6 Apr 2015 00:49:07 -0400
Message-ID: <20150406044907.GA1932@peff.net>
References: <20150405010611.GA15901@peff.net>
 <55213B93.9050207@web.de>
 <20150405185259.GB13096@peff.net>
 <5521B993.1080202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Apr 06 06:49:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeyyK-0001ls-Aa
	for gcvg-git-2@plane.gmane.org; Mon, 06 Apr 2015 06:49:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbbDFEtL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2015 00:49:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:42785 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750837AbbDFEtK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 00:49:10 -0400
Received: (qmail 29687 invoked by uid 102); 6 Apr 2015 04:49:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 05 Apr 2015 23:49:10 -0500
Received: (qmail 9472 invoked by uid 107); 6 Apr 2015 04:49:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Apr 2015 00:49:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Apr 2015 00:49:07 -0400
Content-Disposition: inline
In-Reply-To: <5521B993.1080202@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266835>

On Mon, Apr 06, 2015 at 12:39:15AM +0200, Ren=C3=A9 Scharfe wrote:

> >...this. I think that effort might be better spent on a ref storage
> >format that's more efficient, simpler (with respect to subtle races =
and
> >such), and could provide other features (e.g., transactional atomici=
ty).
>=20
> Such as a DBMS? :-)  Leaving storage details to SQLite or whatever so=
unds
> attractive to me because I'm lazy.

Exactly. Though I think some folks were worried about the extra
dependency (e.g., I think SQLite is hard for JGit, because there's no
pure-java implementation, which makes Eclipse unhappy).

With pluggable backends we can make something like a SQLite backend
optional. I.e., use it if you want the benefits and can accept the
portability downsides. But that also risks fracturing the community, an=
d
people on the "old" format being left behind.

> Forgot to say: I like your changes.  But if strbuf_getline can only b=
e made
> fast enough beyond that by duplicating stdio buffering then I feel it=
's
> better to take a different way.  E.g. dropping the requirement to han=
dle NUL
> chars and basing it on fgets as Junio suggested in his reply to patch=
 3
> sounds good.

Yeah, though we probably need to either audit the callers, or provide a
flag for each caller to turn on the speed-over-NULs behavior. I'll look
into that, but it may not be this week, as I'll be traveling starting
tomorrow.

> In any case, the packed refs file seems special enough to receive spe=
cial
> treatment.  Using mmap would make the most sense if we could also avo=
id
> copying lines to a strbuf for parsing, though.

I had a similar thought. Below is hacky patch, on top of your mmap
patch, that does this. It does shave off another 300ms (around 5%).

I think we may be getting into a useless area of micro-optimizing here,
though.  The results are noticeable on this ridiculous repository, but
probably not so much on real ones. The low-hanging fruit (e.g., droppin=
g
time in half by using getc_unlocked) seems to provide the most bang for
the buck.

---
diff --git a/refs.c b/refs.c
index 144255f..708b49b 100644
--- a/refs.c
+++ b/refs.c
@@ -334,27 +334,40 @@ static int refname_is_safe(const char *refname)
 	return 1;
 }
=20
-static struct ref_entry *create_ref_entry(const char *refname,
-					  const unsigned char *sha1, int flag,
-					  int check_name)
+static struct ref_entry *create_ref_entry_len(const char *refname, siz=
e_t len,
+					      const unsigned char *sha1, int flag,
+					      int check_name)
 {
-	int len;
 	struct ref_entry *ref;
=20
+	/*
+	 * allocate before checking, since the check functions require
+	 * a NUL-terminated refname. And since we die() anyway if
+	 * the check fails, the overhead of the extra malloc is negligible
+	 */
+	ref =3D xmalloc(sizeof(struct ref_entry) + len + 1);
+	hashcpy(ref->u.value.sha1, sha1);
+	hashclr(ref->u.value.peeled);
+	memcpy(ref->name, refname, len);
+	ref->name[len] =3D '\0';
+	ref->flag =3D flag;
+
 	if (check_name &&
 	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
 		die("Reference has invalid format: '%s'", refname);
 	if (!check_name && !refname_is_safe(refname))
 		die("Reference has invalid name: '%s'", refname);
-	len =3D strlen(refname) + 1;
-	ref =3D xmalloc(sizeof(struct ref_entry) + len);
-	hashcpy(ref->u.value.sha1, sha1);
-	hashclr(ref->u.value.peeled);
-	memcpy(ref->name, refname, len);
-	ref->flag =3D flag;
 	return ref;
 }
=20
+static struct ref_entry *create_ref_entry(const char *refname,
+					 const unsigned char *sha1, int flag,
+					 int check_name)
+{
+	return create_ref_entry_len(refname, strlen(refname), sha1, flag,
+				    check_name);
+}
+
 static void clear_ref_dir(struct ref_dir *dir);
=20
 static void free_ref_entry(struct ref_entry *entry)
@@ -1095,7 +1108,9 @@ static const char PACKED_REFS_HEADER[] =3D
  * Return a pointer to the refname within the line (null-terminated),
  * or NULL if there was a problem.
  */
-static const char *parse_ref_line(struct strbuf *line, unsigned char *=
sha1)
+static const char *parse_ref_line(const char *line, int len,
+				  unsigned char *sha1,
+				  size_t *refname_len)
 {
 	const char *ref;
=20
@@ -1107,22 +1122,22 @@ static const char *parse_ref_line(struct strbuf=
 *line, unsigned char *sha1)
 	 *  +1 (space in between hex and name)
 	 *  +1 (newline at the end of the line)
 	 */
-	if (line->len <=3D 42)
+	if (len <=3D 42)
 		return NULL;
=20
-	if (get_sha1_hex(line->buf, sha1) < 0)
+	if (get_sha1_hex(line, sha1) < 0)
 		return NULL;
-	if (!isspace(line->buf[40]))
+	if (!isspace(line[40]))
 		return NULL;
=20
-	ref =3D line->buf + 41;
+	ref =3D line + 41;
 	if (isspace(*ref))
 		return NULL;
=20
-	if (line->buf[line->len - 1] !=3D '\n')
+	if (line[len - 1] !=3D '\n')
 		return NULL;
-	line->buf[--line->len] =3D 0;
=20
+	*refname_len =3D len - (ref - line) - 1;
 	return ref;
 }
=20
@@ -1156,7 +1171,6 @@ static const char *parse_ref_line(struct strbuf *=
line, unsigned char *sha1)
 static void read_packed_refs(int fd, struct ref_dir *dir)
 {
 	struct ref_entry *last =3D NULL;
-	struct strbuf line =3D STRBUF_INIT;
 	enum { PEELED_NONE, PEELED_TAGS, PEELED_FULLY } peeled =3D PEELED_NON=
E;
 	struct stat st;
 	void *map;
@@ -1172,18 +1186,20 @@ static void read_packed_refs(int fd, struct ref=
_dir *dir)
 	for (p =3D map, len =3D mapsz; len; ) {
 		unsigned char sha1[20];
 		const char *refname;
+		size_t refname_len;
 		const char *traits;
 		const char *nl;
+		const char *line;
 		size_t linelen;
=20
 		nl =3D memchr(p, '\n', len);
+		line =3D p;
 		linelen =3D nl ? nl - p + 1 : len;
-		strbuf_reset(&line);
-		strbuf_add(&line, p, linelen);
 		p +=3D linelen;
 		len -=3D linelen;
=20
-		if (skip_prefix(line.buf, "# pack-refs with:", &traits)) {
+		/* XXX these should take care not to look past linelen */
+		if (skip_prefix(line, "# pack-refs with:", &traits)) {
 			if (strstr(traits, " fully-peeled "))
 				peeled =3D PEELED_FULLY;
 			else if (strstr(traits, " peeled "))
@@ -1192,7 +1208,7 @@ static void read_packed_refs(int fd, struct ref_d=
ir *dir)
 			continue;
 		}
=20
-		refname =3D parse_ref_line(&line, sha1);
+		refname =3D parse_ref_line(line, linelen, sha1, &refname_len);
 		if (refname) {
 			int flag =3D REF_ISPACKED;
=20
@@ -1200,7 +1216,7 @@ static void read_packed_refs(int fd, struct ref_d=
ir *dir)
 				hashclr(sha1);
 				flag |=3D REF_BAD_NAME | REF_ISBROKEN;
 			}
-			last =3D create_ref_entry(refname, sha1, flag, 0);
+			last =3D create_ref_entry_len(refname, len, sha1, flag, 0);
 			if (peeled =3D=3D PEELED_FULLY ||
 			    (peeled =3D=3D PEELED_TAGS && starts_with(refname, "refs/tags/"=
)))
 				last->flag |=3D REF_KNOWS_PEELED;
@@ -1208,10 +1224,10 @@ static void read_packed_refs(int fd, struct ref=
_dir *dir)
 			continue;
 		}
 		if (last &&
-		    line.buf[0] =3D=3D '^' &&
-		    line.len =3D=3D PEELED_LINE_LENGTH &&
-		    line.buf[PEELED_LINE_LENGTH - 1] =3D=3D '\n' &&
-		    !get_sha1_hex(line.buf + 1, sha1)) {
+		    line[0] =3D=3D '^' &&
+		    linelen =3D=3D PEELED_LINE_LENGTH &&
+		    line[PEELED_LINE_LENGTH - 1] =3D=3D '\n' &&
+		    !get_sha1_hex(line + 1, sha1)) {
 			hashcpy(last->u.value.peeled, sha1);
 			/*
 			 * Regardless of what the file header said,
@@ -1222,7 +1238,6 @@ static void read_packed_refs(int fd, struct ref_d=
ir *dir)
 		}
 	}
=20
-	strbuf_release(&line);
 	munmap(map, mapsz);
 }
=20
