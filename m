From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v2] add technical documentation about ref iteration
Date: Mon, 22 Aug 2011 22:36:45 +0200
Message-ID: <20110822203645.GD11745@sandbox-rc>
References: <20110803180319.GA13057@sandbox-rc>
 <7vei12b9aq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 22 22:36:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvbEq-0007uP-Tk
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 22:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238Ab1HVUgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 16:36:49 -0400
Received: from darksea.de ([83.133.111.250]:46023 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752042Ab1HVUgr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 16:36:47 -0400
Received: (qmail 31641 invoked from network); 22 Aug 2011 22:36:45 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 22 Aug 2011 22:36:45 +0200
Content-Disposition: inline
In-Reply-To: <7vei12b9aq.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179888>

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---

Hi,

this is an update of the previous doc patch.

On Wed, Aug 03, 2011 at 12:10:37PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> > +Submodules
> > +----------
> > +
> > +If you want to iterate the refs of a submodule you first need to call
> > +
> > +	add_submodule_odb(submodule)
> > +
> > +and test whether that succeeds.
> 
> Hmm, this should probably be explained a bit deeper or not at all. For
> example, what is "submodule" here? A path to the submodule directory? The
> name of submodule? What is the unwanted consequence of adding this extra
> object database into your process (e.g. you can no longer tell if an
> object exists in the superproject, as it may now come from the submodule's
> object database)? Can you get rid of it? How does this function signal
> failures? What is the symptom if you forget this call and used the
> iteration in the submodule (e.g. "we do not see any ref"; "we see only
> some ref but not all"; "the call crashes the process")?

I hope I answered all these questions in the patch below.

> 
> > +
> > +(Heiko Voigt)
> 
> Please drop this line for two reasons.

Dropped.

 Documentation/technical/api-ref-iteration.txt |   81 +++++++++++++++++++++++++
 1 files changed, 81 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/technical/api-ref-iteration.txt

diff --git a/Documentation/technical/api-ref-iteration.txt b/Documentation/technical/api-ref-iteration.txt
new file mode 100644
index 0000000..dbbea95
--- /dev/null
+++ b/Documentation/technical/api-ref-iteration.txt
@@ -0,0 +1,81 @@
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
+If you want to iterate the refs of a submodule you first need to add the
+submodules object database. You can do this by a code-snippet like
+this:
+
+	const char *path = "path/to/submodule"
+	if (!add_submodule_odb(path))
+		die("Error submodule '%s' not populated.", path);
+
+`add_submodule_odb()` will return an non-zero value on success. If you
+do not do this you will get an error for each ref that it does not point
+to a valid object.
+
+Note: As a side-effect of this you can not safely assume that all
+objects you lookup are available in superproject. All submodule objects
+will be available the same way as the superprojects objects.
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
-- 
1.7.6.351.g9ce65.dirty
