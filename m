From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gnulib-tool --version
Date: Fri, 14 Mar 2008 23:08:11 -0700
Message-ID: <7vabl0o6yc.fsf@gitster.siamese.dyndns.org>
References: <910CF843580B3C40A25CD0D04B3908E286A29C@exchange4.comune.prato.local>
 <200803150052.44573.bruno@clisp.org> <47DB12F3.8020504@byu.net>
 <200803150512.53166.bruno@clisp.org> <47DB5295.9080005@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bruno Haible <bruno@clisp.org>, git@vger.kernel.org
To: Eric Blake <ebb9@byu.net>
X-From: git-owner@vger.kernel.org Sat Mar 15 07:09:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaPaE-0003C3-OW
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 07:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbYCOGIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 02:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbYCOGIZ
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 02:08:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48312 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbYCOGIY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 02:08:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 38167252A;
	Sat, 15 Mar 2008 02:08:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 82DD42529; Sat, 15 Mar 2008 02:08:15 -0400 (EDT)
In-Reply-To: <47DB5295.9080005@byu.net> (Eric Blake's message of "Fri, 14 Mar
 2008 22:37:41 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77312>

Eric Blake <ebb9@byu.net> writes:

> What is really needed is a method in git where once a SHA1 prefix becomes
> ambiguous, you can still easily choose to resolve the ambiguity in favor
> of the oldest commit that matches the prefix.

"Oldest commit" does not make much sense in a distributed environment.  In
git.git, I tend to have many objects in my primary repository that nobody
else has, and other people would probably have many objects that I do not
have.  "Oldest among the ones reachable from these heads" and specifying
only the ones that are publicly available may have some value, though.

I agree that we would want a reverse operation of find_unique_abbrev();
here is a quick and dirty one.

    $ git rev-parse --disamb=aba1 |
      git name-rev --stdin
    aba14750f47700b8923b411a9348fb251b788967 tree
    aba15f7f592c302196401d17a42c772d744555b4 (tags/gitgui-0.9.3~5) commit
    aba16b190c54a107521801ad77ab66586553ba69 blob
    aba170cdb4874b72dd619e6f7bbc13c33295f831 (tags/v1.5.2^0) commit

It is very tempting to say that we should favor commits over other types,
but at the "extended sha1 expression" level, we traditionally haven't
favored one type over others, so it has to wait until 1.6.0 at least.

---
 builtin-rev-parse.c |   13 +++++++++++++
 cache.h             |    3 +++
 sha1_name.c         |   37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index 0351d54..c64b43e 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -365,6 +365,15 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 	return 0;
 }
 
+static void disamb_show(const unsigned char *sha1, void *cb_data)
+{
+	char *orig = cb_data;
+	enum object_type type;
+
+	type = sha1_object_info(sha1, NULL);
+	printf("%s %s %s\n", sha1_to_hex(sha1), typename(type), orig);
+}
+
 int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 {
 	int i, as_is = 0, verify = 0;
@@ -548,6 +557,10 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				show_datestring("--min-age=", arg+8);
 				continue;
 			}
+			if (!prefixcmp(arg, "--disamb=")) {
+				for_each_sha1(arg + 9, disamb_show, NULL);
+				continue;
+			}
 			if (show_flag(arg) && verify)
 				die("Needed a single revision");
 			continue;
diff --git a/cache.h b/cache.h
index 2a1e7ec..fa15140 100644
--- a/cache.h
+++ b/cache.h
@@ -454,6 +454,9 @@ extern char *sha1_file_name(const unsigned char *sha1);
 extern char *sha1_pack_name(const unsigned char *sha1);
 extern char *sha1_pack_index_name(const unsigned char *sha1);
 extern const char *find_unique_abbrev(const unsigned char *sha1, int);
+typedef void for_each_sha1_fn(const unsigned char *sha1, void *);
+int for_each_sha1(const char *prefix, for_each_sha1_fn fn, void *cb_data);
+
 extern const unsigned char null_sha1[20];
 static inline int is_null_sha1(const unsigned char *sha1)
 {
diff --git a/sha1_name.c b/sha1_name.c
index 8b6c76f..2703831 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -213,6 +213,43 @@ const char *find_unique_abbrev(const unsigned char *sha1, int len)
 	return hex;
 }
 
+static int for_each_sha1_rec(char *prefix, int len, for_each_sha1_fn fn, void *cb_data)
+{
+	unsigned char sha1[20];
+	int status, i, found;
+
+	if (40 <= len)
+		return 0;
+	status = get_short_sha1(prefix, len, sha1, 1);
+	if (status == SHORT_NAME_NOT_FOUND)
+		return 0;
+	if (!status) {
+		fn(sha1, cb_data);
+		return 1;
+	}
+	/* Ambiguous */
+	found = 0;
+	for (i = 0; i < 16; i++) {
+		prefix[len] = "0123456789abcdef"[i];
+		prefix[len+1] = '\0';
+		found += for_each_sha1_rec(prefix, len + 1, fn, cb_data);
+	}
+	return found;
+}
+
+int for_each_sha1(const char *prefix, for_each_sha1_fn fn, void *cb_data)
+{
+	int len;
+	char hex[41];
+
+	len = strlen(prefix);
+	if (40 <= len)
+		return 0;
+	memcpy(hex, prefix, len+1);
+
+	return for_each_sha1_rec(hex, len, fn, cb_data);
+}
+
 static int ambiguous_path(const char *path, int len)
 {
 	int slash = 1;
