From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] add technical documentation about ref iteration
Date: Wed, 3 Aug 2011 20:03:37 +0200
Message-ID: <20110803180319.GA13057@sandbox-rc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 20:03:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QofnE-0007Us-QU
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 20:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755021Ab1HCSDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 14:03:40 -0400
Received: from darksea.de ([83.133.111.250]:48852 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754719Ab1HCSDj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 14:03:39 -0400
Received: (qmail 29960 invoked from network); 3 Aug 2011 20:03:36 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 3 Aug 2011 20:03:36 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178602>

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 Documentation/technical/api-ref-iteration.txt |   73 +++++++++++++++++++++++++
 1 files changed, 73 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/technical/api-ref-iteration.txt

diff --git a/Documentation/technical/api-ref-iteration.txt b/Documentation/technical/api-ref-iteration.txt
new file mode 100644
index 0000000..0a67e39
--- /dev/null
+++ b/Documentation/technical/api-ref-iteration.txt
@@ -0,0 +1,73 @@
+ref iteration API
+=================
+
+
+Iteration of refs is done by using an iterate function which will call a
+callback function for every ref. The callback function has this
+signature:
+
+	int handle_one_ref(const char *refname, const unsigned char *sha1,
+			   int flags, void *cb_data);
+
+There are different kinds of iterate functions which all take a
+callback of this type. The callback is then called for each found ref
+until the callback returns nonzero. The returned value is then also
+returned by the iterate function.
+
+Iteration functions
+-------------------
+
+* `head_ref()` just iterates the head ref.
+
+* `for_each_ref()` iterates all refs.
+
+* `for_each_ref_in()` iterates all refs which have a defined prefix and
+  strips that prefix from the passed variable refname.
+
+* `for_each_tag_ref()`, `for_each_branch_ref()`, `for_each_remote_ref()`,
+  `for_each_replace_ref()` iterate refs from the respective area.
+
+* `for_each_glob_ref()` iterates all refs that match the specified glob
+  pattern.
+
+* `for_each_glob_ref_in()` the previous and `for_each_ref_in()` combined.
+
+* `head_ref_submodule()`, `for_each_ref_submodule()`,
+  `for_each_ref_in_submodule()`, `for_each_tag_ref_submodule()`,
+  `for_each_branch_ref_submodule()`, `for_each_remote_ref_submodule()`
+  do the same as the functions descibed above but for a specified
+  submodule.
+
+* `for_each_rawref()` can be used to learn about broken ref and symref.
+
+* `for_each_reflog()` iterates each reflog file.
+
+Submodules
+----------
+
+If you want to iterate the refs of a submodule you first need to call
+
+	add_submodule_odb(submodule)
+
+and test whether that succeeds.
+
+Example:
+--------
+
+----
+static int handle_remote_ref(const char *refname,
+		const unsigned char *sha1, int flags, void *cb_data)
+{
+	struct strbuf *output = cb_data;
+	strbuf_addf(output, "%s\n", refname);
+	return 0;
+}
+
+...
+
+	struct strbuf output = STRBUF_INIT;
+	for_each_remote_ref(handle_remote_ref, &output);
+	printf("%s", output.buf);
+----
+
+(Heiko Voigt)
-- 
1.7.6.353.g02057.dirty
