From: Junio C Hamano <junkio@cox.net>
Subject: Quote reference names while fetching with curl.
Date: Mon, 10 Oct 2005 21:29:20 -0700
Message-ID: <7vzmpgznfj.fsf_-_@assigned-by-dhcp.cox.net>
References: <46a038f90510062014l7f5740e0l77fc53b50f822e8f@mail.gmail.com>
	<46a038f90510082014i6b296f2bvbac56e25344cbdf2@mail.gmail.com>
	<4349ED5D.6020703@catalyst.net.nz>
	<7v4q7p927d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 11 06:31:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPBlc-0000D9-NI
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 06:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbVJKE3X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 00:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbVJKE3X
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 00:29:23 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:28551 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751036AbVJKE3W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2005 00:29:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051011042911.UIZ4169.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 11 Oct 2005 00:29:11 -0400
To: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
In-Reply-To: <7v4q7p927d.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 10 Oct 2005 02:00:06 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9952>



curl_escape ought to do this, but we should not let it quote slashes
(nobody said refs/tags can have subdirectories), so we roll our own
safer version.  With this, the last part of git-clone that used to fail
now works, which reads:

 $ git-http-fetch -v -a -w 'tags/MOODLE_15_MERGED **INVALID**' \
   'tags/MOODLE_15_MERGED **INVALID**' \
   http://locke.catalyst.net.nz/git/moodle.git/

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

  Junio C Hamano <junkio@cox.net> writes:

  > I do not speak curl, but I wonder if we should be quoting
  > these funky characters like SP and asterisk in the URL when we
  > make that request, or it is what the library does for us.
  >
  > Hmph.  Interesting.  I just tried.
  >
  > $ curl 'http://locke.catalyst.net.nz/git/moodle.git/refs/tags/MOODLE_15_MERGED **INVALID**'
  >
  > gives an error page "404 Not Found", while
  >
  > $ wget -O - -o /dev/null 'http://locke.catalyst.net.nz/git/moodle.git/refs/tags/MOODLE_15_MERGED **INVALID**'
  >
  > works fine and gives 2ddfec0dfd0cffd4892af9aaf48ee29c40c7ada3
  > back.  So we do need to fix things up somewhat in our scripts as
  > well.
  >
  > Anyway, I think I know the problems 'git-clone' would have had
  > if you tried to clone it with it (not cg-clone which I do not
  > know much about), and luckily it is only towards the end (after
  > fetching most of the heads, but hitting the first funky tag).
  > We should be able to fix this relatively easily.

  With this patch on top of the parallel transfer http-fetch in
  proposed updates branch, git-clone successfully cloned your
  repository.

  But in general, we should avoid spaces in reference names.
  Scripts have problem with them.  For example, "git-fetch
  --tags" currently cannot handle it.  If people cared deeply
  enough maybe they can rewrite parts of it in Perl and send me
  a patch ;-).

  Anyway, I _do_ care about the really core part (i.e. things
  written in C, roughly speaking), so this patch will likely
  make into "master" branch.

 http-fetch.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 49 insertions(+), 8 deletions(-)

applies-to: 4ac37eb1d8cf308455b69828c5df8f64634b5789
1d32c9c017af915a390693021938ae8c56f33007
diff --git a/http-fetch.c b/http-fetch.c
index e537591..acae805 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -969,9 +969,56 @@ int fetch(unsigned char *sha1)
 		     alt->base);
 }
 
+static inline int needs_quote(int ch)
+{
+	switch (ch) {
+	case '/': case '-':
+	case 'A'...'Z':
+	case 'a'...'z':
+	case '0'...'9':
+		return 0;
+	default:
+		return 1;
+	}
+}
+
+static inline int hex(int v)
+{
+	if (v < 10) return '0' + v;
+	else return 'A' + v - 10;
+}
+
+static char *quote_ref_url(const char *base, const char *ref)
+{
+	const char *cp;
+	char *dp, *qref;
+	int len, baselen, ch;
+
+	baselen = strlen(base);
+	len = baselen + 6; /* "refs/" + NUL */
+	for (cp = ref; (ch = *cp) != 0; cp++, len++)
+		if (needs_quote(ch))
+			len += 2; /* extra two hex plus replacement % */
+	qref = xmalloc(len);
+	memcpy(qref, base, baselen);
+	memcpy(qref + baselen, "refs/", 5);
+	for (cp = ref, dp = qref + baselen + 5; (ch = *cp) != 0; cp++) {
+		if (needs_quote(ch)) {
+			*dp++ = '%';
+			*dp++ = hex((ch >> 4) & 0xF);
+			*dp++ = hex(ch & 0xF);
+		}
+		else
+			*dp++ = ch;
+	}
+	*dp = 0;
+
+	return qref;
+}
+
 int fetch_ref(char *ref, unsigned char *sha1)
 {
-        char *url, *posn;
+        char *url;
         char hex[42];
         struct buffer buffer;
 	char *base = alt->base;
@@ -981,13 +1028,7 @@ int fetch_ref(char *ref, unsigned char *
         buffer.buffer = hex;
         hex[41] = '\0';
         
-        url = xmalloc(strlen(base) + 6 + strlen(ref));
-        strcpy(url, base);
-        posn = url + strlen(base);
-        strcpy(posn, "refs/");
-        posn += 5;
-        strcpy(posn, ref);
-
+	url = quote_ref_url(base, ref);
 	slot = get_active_slot();
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &buffer);
 	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, fwrite_buffer);
---
0.99.8.GIT
