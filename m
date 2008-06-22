From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH v2 1/2] api-parse-options.txt: Introduce documentation for parse options API
Date: Sun, 22 Jun 2008 17:04:25 +0200
Message-ID: <1214147066-10979-1-git-send-email-s-beyer@gmx.net>
References: <200806221639.04811.barra_cuda@katamail.com>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Sun Jun 22 17:05:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAR8b-0006VF-AA
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 17:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157AbYFVPEc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 11:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753308AbYFVPEc
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 11:04:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:59081 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752944AbYFVPEa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 11:04:30 -0400
Received: (qmail invoked by alias); 22 Jun 2008 15:04:27 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp045) with SMTP; 22 Jun 2008 17:04:27 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX18os/R5VmooZ2PeBe+fM6mrxe+R4nU2PVnDxYlm7k
	znocerQC+STeRj
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KAR7C-0002rS-71; Sun, 22 Jun 2008 17:04:26 +0200
X-Mailer: git-send-email 1.5.6.310.g344d
In-Reply-To: <200806221639.04811.barra_cuda@katamail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85781>

Add some documentation of basics, macros and callback
implementation of the parse-options API.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---
Ha, great ;)

So here are my patches, now based on your one.

Regards,
  Stephan

 Documentation/technical/api-parse-options.txt |  204 ++++++++++++++++++++++++-
 1 files changed, 202 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index b7cda94..60a433b 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -1,6 +1,206 @@
 parse-options API
 =================
 
-Talk about <parse-options.h>
+The parse-options API is used to parse and massage options in git
+and to provide a usage help with consistent look.
 
-(Pierre)
+Basics
+------
+
+The argument vector `argv[]` may usually contain mandatory or optional
+'non-option arguments', e.g. a filename or a branch, and 'options'.
+Options are optional arguments that start with a dash and
+that allow to change the behavior of a command.
+
+* There are basically three types of options:
+  'boolean' options,
+  options with (mandatory) 'arguments' and
+  options with 'optional arguments'
+  (i.e. a boolean option that can be adjusted).
+
+* There are basically two forms of options: 
+  'Short options' consist of one dash (`-`) and one alphanumeric
+  character.
+  'Long options' begin with two dashes (`\--`) and some 
+  alphanumeric characters.
+
+* Options are case-sensitive.
+  Please define 'lower-case long options' only.
+
+The parse-options API allows:
+
+* 'sticked' and 'separate form' of options with arguments.
+  `-oArg` is sticked, `-o Arg` is separate form.
+  `\--option=Arg` is sticked, `\--option Arg` is separate form.
+
+* Long options may be 'abbreviated', as long as the abbreviation
+  is unambiguous.
+
+* Short options may be bundled, e.g. `-a -b` can be specified as `-ab`.
+
+* Boolean long options can be 'negated' (or 'unset') by prepending
+  `no-`, e.g. `\--no-abbrev` instead of `\--abbrev`.
+
+* Options and non-option arguments can clearly be separated using the `\--`
+  option, e.g. `-a -b \--option \-- \--this-is-a-file` indicates that
+  `\--this-is-a-file` must not be processed as an option.
+
+Steps to parse options
+----------------------
+
+. `#include "parse-options.h"`
+
+. define a NULL-terminated
+  `static const char * const builtin_foo_usage[]` array
+  containing alternative usage strings
+
+. define `builtin_foo_options` array as described below
+  in section 'Data Structure'.
+
+. in `cmd_foo(int argc, const char **argv, const char *prefix)`
+  call
+
+	argc = parse_options(argc, argv, builtin_foo_options, builtin_foo_usage, flags);
++
+`parse_options()` will filter out the processed options of `argv[]` and leave the
+non-option arguments in `argv[]`.
+`argc` is updated appropriately because of the assignment.
++
+Flags are the bitwise-or of:
+
+`PARSE_OPT_KEEP_DASHDASH`::
+	Keep the `\--` that usually separates options from
+	non-option arguments.
+
+`PARSE_OPT_STOP_AT_NON_OPTION`::
+	Usually the whole argument vector is massaged and reordered.
+	Using this flag, processing is stopped at the first non-option
+	argument.
+
+Data Structure
+--------------
+
+The main data structure is an array of the `option` struct,
+say `static struct option builtin_add_options[]`.
+There are some macros to easily define options:
+
+`OPT__ABBREV(&int_var)`::
+	Add `\--abbrev[=<n>]`.
+
+`OPT__DRY_RUN(&int_var)`::
+	Add `-n, \--dry-run`.
+
+`OPT__QUIET(&int_var)`::
+	Add `-q, \--quiet`.
+
+`OPT__VERBOSE(&int_var)`::
+	Add `-v, \--verbose`.
+
+`OPT_GROUP(description)`::
+	Start an option group. `description` is a short string that
+	describes the group or an empty string.
+	Start the description with an upper-case letter.
+
+`OPT_BOOLEAN(short, long, &int_var, description)`::
+	Introduce a boolean option.
+	`int_var` is incremented on each use.
+
+`OPT_BIT(short, long, &int_var, description, mask)`::
+	Introduce a boolean option.
+	If used, `int_var` is bitwise-ored with `mask`.
+
+`OPT_SET_INT(short, long, &int_var, description, integer)`::
+	Introduce a boolean option.
+	If used, set `int_var` to `integer`.
+
+`OPT_SET_PTR(short, long, &ptr_var, description, ptr)`::
+	Introduce a boolean option.
+	If used, set `ptr_var` to `ptr`.
+
+`OPT_STRING(short, long, &str_var, arg_str, description)`::
+	Introduce an option with string argument.
+	The string argument is put into `str_var`.
+
+`OPT_INTEGER(short, long, &int_var, description)`::
+	Introduce an option with integer argument.
+	The integer is put into `int_var`.
+
+`OPT_DATE(short, long, &int_var, description)`::
+	Introduce an option with date argument, see `approxidate()`.
+	The timestamp is put into `int_var`.
+
+`OPT_CALLBACK(short, long, &var, arg_str, description, func_ptr)`::
+	Introduce an option with argument.
+	The argument will be fed into the function given by `func_ptr`
+	and the result will be put into `var`.
+	See 'Option Callbacks' below for a more elaborate description.
+
+`OPT_ARGUMENT(long, description)`::
+	Introduce a long-option argument that will be kept in `argv[]`.
+
+
+The last element of the array must be `OPT_END()`.
+
+If not stated otherwise, interpret the arguments as follows:
+
+* `short` is a character for the short option
+  (e.g. `\'e\'` for `-e`, use `0` to omit),
+
+* `long` is a string for the long option
+  (e.g. `"example"` for `\--example`, use `NULL` to omit),
+
+* `int_var` is an integer variable,
+
+* `str_var` is a string variable (`char *`),
+
+* `arg_str` is the string that is shown as argument
+  (e.g. `"branch"` will result in `<branch>`).
+  If set to `NULL`, three dots (`...`) will be displayed.
+
+* `description` is a short string to describe the effect of the option.
+  It shall begin with a lower-case letter and a full stop (`.`) shall be
+  omitted at the end.
+
+Option Callbacks
+----------------
+
+The function must be defined in this form:
+
+	int func(const struct option *opt, const char *arg, int unset)
+
+The callback mechanism is as follows:
+
+* Inside `funct`, the only interesting member of the structure
+  given by `opt` is the void pointer `opt->value`.
+  `\*opt->value` will be the value that is saved into `var`, if you
+  use `OPT_CALLBACK()`.
+  For example, do `*(unsigned long *)opt->value = 42;` to get 42
+  into an `unsigned long` variable.
+
+* Return value `0` indicates success and non-zero return
+  value will invoke `usage_with_options()` and, thus, die.
+
+* If the user negates the option, `arg` is `NULL` and `unset` is 1.
+
+Sophisticated option parsing
+----------------------------
+
+If you need, for example, option callbacks with optional arguments
+or without arguments at all, or if you need other special cases,
+that are not handled by the macros above, you need to specify the
+members of the `option` structure manually.
+
+This is not covered in this document, but well documented
+in `parse-options.h` itself.
+
+Examples
+--------
+
+See `test-parse-options.c` and
+`builtin-add.c`,
+`builtin-clone.c`,
+`builtin-commit.c`,
+`builtin-fetch.c`,
+`builtin-fsck.c`,
+`builtin-rm.c`
+for real-world examples.
-- 
1.5.6.310.g344d
