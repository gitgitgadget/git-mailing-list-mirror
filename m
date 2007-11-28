From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-config --get-color: get configured color
Date: Tue, 27 Nov 2007 23:20:45 -0800
Message-ID: <7vir3mal9u.fsf_-_@gitster.siamese.dyndns.org>
References: <200711231904.53551.jnareb@gmail.com>
	<7vabp4u40y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Jeff King <peff@peff.net>, Dan Zwell <dzwell@zwell.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 14:14:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKvQ-0004Gs-5p
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 12:17:52 +0100
Received: from mail-mx6.uio.no ([129.240.10.47])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxHMq-0002Sf-17
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 08:29:56 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx6.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxHMh-0007eP-Bh
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 08:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbXK1HU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 02:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbXK1HU4
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 02:20:56 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:55729 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbXK1HUz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 02:20:55 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 3A9A72EF;
	Wed, 28 Nov 2007 02:21:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6B6F498BA1;
	Wed, 28 Nov 2007 02:21:09 -0500 (EST)
In-Reply-To: <7vabp4u40y.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 23 Nov 2007 11:59:25 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.5, required=5.0, autolearn=disabled, AWL=1.520,RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: F9DE3EC4FCB6168F672C1A14D43365E3C2351CDC
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -54 maxlevel 200 minaction 2 bait 0 mail/h: 43 total 724031 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66315>

This new option allows scripts to grab color setting from the user
configuration, translated to ANSI color escape sequence.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 Junio C Hamano <gitster@pobox.com> writes:

 > Jakub Narebski <jnareb@gmail.com> writes:
 >
 >> Integer variables can have optional 'k', 'm' or 'g' suffix.
 >> config_int() method will return simple decimal number, taking
 >> care of those suffixes.
 >
 > Good.  I forgot about --int option to "git config" already.
 >
 > Maybe in a similar way, we might want to add --color to "git
 > config" to return ANSI sequence, so that Git::config_color() can
 > work without even loading Term::ANSIColor?

 Documentation/git-config.txt |   16 ++++++++++++
 builtin-config.c             |   55 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 68 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index a592b61..ed3076f 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -20,6 +20,7 @@ SYNOPSIS
 'git-config' [<file-option>] --rename-section old_name new_name
 'git-config' [<file-option>] --remove-section name
 'git-config' [<file-option>] [-z|--null] -l | --list
+'git-config' [<file-option>] --get-color name [default]
 
 DESCRIPTION
 -----------
@@ -134,6 +135,12 @@ See also <<FILES>>.
 	output without getting confused e.g. by values that
 	contain line breaks.
 
+--get-color name default::
+
+	Find the color configured for `name` (e.g. `color.diff.new`) and
+	output it as the ANSI color escape sequence to the standard
+	output.  The optional `default` parameter is used if the
+	configuration for `name` is missing.
 
 [[FILES]]
 FILES
@@ -292,6 +299,15 @@ To add a new proxy, without altering any of the existing ones, use
 % git config core.gitproxy '"proxy-command" for example.com'
 ------------
 
+An example to use customized color from the configuration in your
+script:
+
+------------
+#!/bin/sh
+WS=$(git config --get-color color.diff.whitespace "blue reverse")
+RESET==$(git config --get-color "" "reset")
+echo "${WS}your whitespace color or blue reverse${RESET}"
+------------
 
 include::config.txt[]
 
diff --git a/builtin-config.c b/builtin-config.c
index f672c9c..4c9ded3 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -1,8 +1,9 @@
 #include "builtin.h"
 #include "cache.h"
+#include "color.h"
 
 static const char git_config_set_usage[] =
-"git-config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list";
+"git-config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default]";
 
 static char *key;
 static regex_t *key_regexp;
@@ -161,6 +162,53 @@ char *normalize_value(const char *key, const char *value)
 	return normalized;
 }
 
+static int get_color_found;
+static const char *get_color_slot;
+static char parsed_color[COLOR_MAXLEN];
+
+static int git_get_color_config(const char *var, const char *value)
+{
+	if (!strcmp(var, get_color_slot)) {
+		color_parse(value, var, parsed_color);
+		get_color_found = 1;
+	}
+	return 0;
+}
+
+static int get_color(int argc, const char **argv)
+{
+	/*
+	 * grab the color setting for the given slot from the configuration,
+	 * or parse the default value if missing, and return ANSI color
+	 * escape sequence.
+	 *
+	 * e.g.
+	 * git config --get-color color.diff.whitespace "blue reverse"
+	 */
+	const char *def_color = NULL;
+
+	switch (argc) {
+	default:
+		usage(git_config_set_usage);
+	case 2:
+		def_color = argv[1];
+		/* fallthru */
+	case 1:
+		get_color_slot = argv[0];
+		break;
+	}
+
+	get_color_found = 0;
+	parsed_color[0] = '\0';
+	git_config(git_get_color_config);
+
+	if (!get_color_found && def_color)
+		color_parse(def_color, "command line", parsed_color);
+
+	fputs(parsed_color, stdout);
+	return 0;
+}
+
 int cmd_config(int argc, const char **argv, const char *prefix)
 {
 	int nongit = 0;
@@ -234,8 +282,9 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 				return 1;
 			}
 			return 0;
-		}
-		else
+		} else if (!strcmp(argv[1], "--get-color")) {
+			return get_color(argc-2, argv+2);
+		} else
 			break;
 		argc--;
 		argv++;
-- 
1.5.3.6.2039.g0495
