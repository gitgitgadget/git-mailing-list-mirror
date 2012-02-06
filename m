From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] docs: add a basic description of the config API
Date: Mon, 6 Feb 2012 04:53:46 -0500
Message-ID: <20120206095346.GA4300@sigill.intra.peff.net>
References: <20120206095306.GA2404@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 06 10:53:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuLGk-0002HO-4u
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 10:53:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496Ab2BFJxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 04:53:50 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58730
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754432Ab2BFJxt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 04:53:49 -0500
Received: (qmail 26260 invoked by uid 107); 6 Feb 2012 10:00:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Feb 2012 05:00:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Feb 2012 04:53:46 -0500
Content-Disposition: inline
In-Reply-To: <20120206095306.GA2404@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190057>

This wasn't documented at all; this is pretty bare-bones,
but it should at least give new git hackers a basic idea of
how the reading side works.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/technical/api-config.txt |  101 ++++++++++++++++++++++++++++++++
 1 files changed, 101 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/technical/api-config.txt

diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
new file mode 100644
index 0000000..f428c5c
--- /dev/null
+++ b/Documentation/technical/api-config.txt
@@ -0,0 +1,101 @@
+config API
+==========
+
+The config API gives callers a way to access git configuration files
+(and files which have the same syntax). See linkgit:git-config[1] for a
+discussion of the config file syntax.
+
+General Usage
+-------------
+
+Config files are parsed linearly, and each variable found is passed to a
+caller-provided callback function. The callback function is responsible
+for any actions to be taken on the config option, and is free to ignore
+some options (it is not uncommon for the configuration to be parsed
+several times during the run of a git program, with different callbacks
+picking out different variables useful to themselves).
+
+A config callback function takes three parameters:
+
+- the name of the parsed variable. This is in canonical "flat" form: the
+  section, subsection, and variable segments will be separated by dots,
+  and the section and variable segments will be all lowercase. E.g.,
+  `core.ignorecase`, `diff.SomeType.textconv`.
+
+- the value of the found variable, as a string. If the variable had no
+  value specified, the value will be NULL (typically this means it
+  should be interpreted as boolean true).
+
+- a void pointer passed in by the caller of the config API; this can
+  contain callback-specific data
+
+A config callback should return 0 for success, or -1 if the variable
+could not be parsed properly.
+
+Basic Config Querying
+---------------------
+
+Most programs will simply want to look up variables in all config files
+that git knows about, using the normal precedence rules. To do this,
+call `git_config` with a callback function and void data pointer.
+
+`git_config` will read all config sources in order of increasing
+priority. Thus a callback should typically overwrite previously-seen
+entries with new ones (e.g., if both the user-wide `~/.gitconfig` and
+repo-specific `.git/config` contain `color.ui`, the config machinery
+will first feed the user-wide one to the callback, and then the
+repo-specific one; by overwriting, the higher-priority repo-specific
+value is left at the end).
+
+There is a special version of `git_config` called `git_config_early`
+that takes an additional parameter to specify the repository config.
+This should be used early in a git program when the repository location
+has not yet been determined (and calling the usual lazy-evaluation
+lookup rules would yield an incorrect location).
+
+Reading Specific Files
+----------------------
+
+To read a specific file in git-config format, use
+`git_config_from_file`. This takes the same callback and data parameters
+as `git_config`.
+
+Value Parsing Helpers
+---------------------
+
+To aid in parsing string values, the config API provides callbacks with
+a number of helper functions, including:
+
+`git_config_int`::
+Parse the string to an integer, including unit factors. Dies on error;
+otherwise, returns the parsed result.
+
+`git_config_ulong`::
+Identical to `git_config_int`, but for unsigned longs.
+
+`git_config_bool`::
+Parse a string into a boolean value, respecting keywords like "true" and
+"false". Integer values are converted into true/false values (when they
+are non-zero or zero, respectively). Other values cause a die(). If
+parsing is successful, the return value is the result.
+
+`git_config_bool_or_int`::
+Same as `git_config_bool`, except that integers are returned as-is, and
+an `is_bool` flag is unset.
+
+`git_config_maybe_bool`::
+Same as `git_config_bool`, except that it returns -1 on error rather
+than dying.
+
+`git_config_string`::
+Allocates and copies the value string into the `dest` parameter; if no
+string is given, prints an error message and returns -1.
+
+`git_config_pathname`::
+Similar to `git_config_string`, but expands `~` or `~user` into the
+user's home directory when found at the beginning of the path.
+
+Writing Config Files
+--------------------
+
+TODO
-- 
1.7.9.rc1.29.g43677
