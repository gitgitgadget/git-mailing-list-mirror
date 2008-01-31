From: Jeff King <peff@peff.net>
Subject: Re: git-push: forced update of tag shows unabbreviated SHA1
Date: Thu, 31 Jan 2008 05:39:48 -0500
Message-ID: <20080131103947.GD25546@coredump.intra.peff.net>
References: <47A1948F.6080308@viscovery.net> <20080131100625.GB25546@coredump.intra.peff.net> <7vodb2cn2a.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 11:41:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKWqm-0007HE-3E
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 11:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933131AbYAaKjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 05:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933390AbYAaKjv
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 05:39:51 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1144 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933384AbYAaKju (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 05:39:50 -0500
Received: (qmail 28228 invoked by uid 111); 31 Jan 2008 10:39:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 31 Jan 2008 05:39:49 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Jan 2008 05:39:48 -0500
Content-Disposition: inline
In-Reply-To: <7vodb2cn2a.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72123>

On Thu, Jan 31, 2008 at 02:21:49AM -0800, Junio C Hamano wrote:

> I think that needs to be done carefully.  I recall some callers
> do expect it to return NULL for nonexistant objects, so the bug
> you noted above as "rare case" may need to be fixed, which I
> think is more important than coming up with a potentially too
> short abbreviation.

The patch I just posted just figures out ahead of time whether the
object exists. We can easily have it default to returning NULL but allow
a special flag for the new behavior. Something like:

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 8afb1d0..454ad8f 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -263,9 +263,8 @@ static void print_ref_status(char flag, const char *summary, struct ref *to, str
 
 static const char *status_abbrev(unsigned char sha1[20])
 {
-	const char *abbrev;
-	abbrev = find_unique_abbrev(sha1, DEFAULT_ABBREV);
-	return abbrev ? abbrev : sha1_to_hex(sha1);
+	return find_unique_abbrev_flags(sha1, DEFAULT_ABBREV,
+			FIND_UNIQUE_ABBREV_MISSING);
 }
 
 static void print_ok_ref_status(struct ref *ref)
diff --git a/cache.h b/cache.h
index 7a38511..0bcbf54 100644
--- a/cache.h
+++ b/cache.h
@@ -383,7 +383,14 @@ extern char *git_path(const char *fmt, ...) __attribute__((format (printf, 1, 2)
 extern char *sha1_file_name(const unsigned char *sha1);
 extern char *sha1_pack_name(const unsigned char *sha1);
 extern char *sha1_pack_index_name(const unsigned char *sha1);
-extern const char *find_unique_abbrev(const unsigned char *sha1, int);
+
+#define FIND_UNIQUE_ABBREV_MISSING 1
+extern const char *find_unique_abbrev_flags(const unsigned char *sha1, int len, int flags);
+static inline const char *find_unique_abbrev(const unsigned char *sha1, int len)
+{
+	return find_unique_abbrev_flags(sha1, len, 0);
+}
+
 extern const unsigned char null_sha1[20];
 static inline int is_null_sha1(const unsigned char *sha1)
 {
diff --git a/sha1_name.c b/sha1_name.c
index a99aff3..666d36c 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -190,12 +190,15 @@ static int get_short_sha1(const char *name, int len, unsigned char *sha1,
 	return status;
 }
 
-const char *find_unique_abbrev(const unsigned char *sha1, int len)
+const char *find_unique_abbrev_flags(const unsigned char *sha1, int len,
+		int flags)
 {
 	int status, missing;
 	static char hex[41];
 
 	missing = !has_sha1_file(sha1);
+	if (missing && !(flags & FIND_UNIQUE_ABBREV_MISSING))
+		return NULL;
 	memcpy(hex, sha1_to_hex(sha1), 40);
 	if (len == 40 || !len)
 		return hex;
