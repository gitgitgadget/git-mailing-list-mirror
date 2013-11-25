From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH] Document khash
Date: Mon, 25 Nov 2013 16:04:48 +0100
Message-ID: <ccce08818b6856f67a5316eba148d5a860d1d8f7.1385391631.git.tr@thomasrast.ch>
References: <87fvqlfpmw.fsf@linux-k42r.v.cablecom.net>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Vicent=20Mart=C3=AD?= <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 25 16:05:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vkxiq-0003wP-AW
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 16:05:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754045Ab3KYPFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 10:05:07 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:55648 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753938Ab3KYPFF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 10:05:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id DFCBD4D658F;
	Mon, 25 Nov 2013 16:05:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id UwkzCtT-ZYcf; Mon, 25 Nov 2013 16:04:49 +0100 (CET)
Received: from linux-k42r.v.cablecom.net (unknown [74.125.61.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 597514D64DE;
	Mon, 25 Nov 2013 16:04:49 +0100 (CET)
X-Mailer: git-send-email 1.8.5.rc3.397.g2a3acd5
In-Reply-To: <87fvqlfpmw.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238314>

For squashing into a commit that adds khash.h.

Signed-off-by: Thomas Rast <tr@thomasrast.ch>
---

> I think I'll also lend you a hand writing Documentation/technical/api-khash.txt
> (expect it tomorrow) so that we also have documentation in the git
> style, where gitters can be expected to find it on their own.

Here goes.

> Furthermore, would it be a problem to name the second hash sha1_int
> instead?  I have another use for such a hash, and I can't imagine I'm
> the only one.  (That's not critical however, I can do the required
> editing in that other series.)

Actually, let's not do that.  Since everything is 'static inline'
anyway, there's no cost to simply instantiating more hashes as needed.


 Documentation/technical/api-khash.txt | 109 ++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)
 create mode 100644 Documentation/technical/api-khash.txt

diff --git a/Documentation/technical/api-khash.txt b/Documentation/technical/api-khash.txt
new file mode 100644
index 0000000..e7ca883
--- /dev/null
+++ b/Documentation/technical/api-khash.txt
@@ -0,0 +1,109 @@
+khash
+=====
+
+The khash API is a collection of macros that instantiate hash table
+routines for arbitrary key/value types.
+
+It lives in 'khash.h', which we imported from
+  https://github.com/attractivechaos/klib/blob/master/khash.h
+and then gitified somewhat.
+
+Usage
+-----
+
+------------
+#import "khash.h"
+KHASH_INIT(NAME, key_t, value_t, is_map, key_hash_fn, key_equal_fn)
+------------
+
+The arguments are as follows:
+
+`NAME`::
+	Used to give your hash and its API a unique name.  Spelled
+	`NAME` here to set it apart from the rest of the names, but
+	generally should be a lowercase C identifier.
+
+`key_t`::
+	Type of the keys for your hashes.  Generally should be
+	`const`.
+
+`value_t`::
+	Type of the values of your hashes.
+
+`is_map`::
+	Whether the hash holds values.  Set to 0 to create a hash for
+	use as a set.
+
+`khint_t key_hash_fn(key_t)`::
+	Hash function.
+
+`int key_equal_fn(key_t a, key_t b)`::
+	Comparison function.  Return 1 if the two keys are the same, 0
+	otherwise.
+
+These two functions may also be macros.
+
+
+API
+---
+
+The above instantiation defines a single type:
+
+`kh_NAME_t`::
+	A struct that holds your hash.  You should only ever use
+	pointers to it.
+
+After the above instantiation, the following functions and
+function-like macros are defined:
+
+`kh_NAME_t *kh_init_NAME(void)`::
+	Allocate and initialize a new hash table.
+
+`void kh_destroy_NAME(kh_NAME_t *)`::
+	Free the hash table.
+
+`void kh_clear_NAME(kh_NAME_t *)`::
+	Clear (but do not free) the hash table.
+
+`khint_t kh_get_NAME(const kh_NAME_t *hash, key_t key)`::
+	Find the given key in the hash table.  The returned khint_t
+	should be treated as an opaque iterator token that indexes
+	into the hash.  Use `kh_value` to get the value from the
+	token.  If the key does not exist, returns kh_end(hash).
+
+`khint_t kh_put_NAME(const kh_NAME_t *hash, key_t key, int *ret)`::
+	Put the given key in the hash table.  The returned khint_t
+	should be treated as an opaque iterator token that indexes
+	into the hash.  Use `kh_value(hash, token) = value` to assign
+	a value after putting the key.
++
+'ret' tells you whether the key already existed: it is -1 if the
+operation failed; 0 if the key was already present; 1 if the bucket is
+empty; 2 if the bucket has been deleted.
+
+`kh_key(kh_NAME_t *, khint_t)`::
+	The key slot for the given iterator token.  This can be used
+	as an lvalue, but you must not change the key!
+
+`kh_value(kh_NAME_t *, khint_t)`::
+`kh_val(kh_NAME_t *, khint_t)`::
+	The value slot for the given iterator token.  This can be used
+	as an lvalue.
+
+`int kh_exist(const kh_NAME_t *, key_t)`::
+	Tests if the given bucket contains data.
+
+`khint_t kh_begin(const kh_NAME_t *)`::
+	The smallest iterator token.
+
+`khint_t kh_end(const kh_NAME_t *)`::
+	The beyond-the-hash iterator token; it is one larger than the
+	largest token that points to a hash member.
+
+`khint_t kh_size(const kh_NAME_t *)`::
+	The number of elements in the hash.
+
+`kh_foreach(const kh_NAME_t *, keyvar, valuevar, { ... loop body ... })`::
+	Iterate over every key-value pair in the hash.  This is a
+	macro, and keyvar and valuevar must be pre-declared of type
+	key_t and value_t, respectively.
-- 
1.8.5.rc3.397.g2a3acd5
