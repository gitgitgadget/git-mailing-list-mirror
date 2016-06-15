From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v8 12/12] Documentation: add documentation for 'git
 interpret-trailers'
Date: Wed, 26 Mar 2014 23:15:30 +0100
Message-ID: <20140326221531.11352.87454.chriscool@tuxfamily.org>
References: <20140326215858.11352.89243.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 26 23:16:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSw7u-0002AT-3H
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 23:16:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756503AbaCZWQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 18:16:44 -0400
Received: from [194.158.98.14] ([194.158.98.14]:44140 "EHLO mail-1y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756251AbaCZWQn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 18:16:43 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 9847467;
	Wed, 26 Mar 2014 23:16:07 +0100 (CET)
X-git-sha1: fbc3606edc3e7fd040e2620dce9d0f5168fc6f6f 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20140326215858.11352.89243.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245241>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-interpret-trailers.txt | 123 +++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 Documentation/git-interpret-trailers.txt

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
new file mode 100644
index 0000000..75ae386
--- /dev/null
+++ b/Documentation/git-interpret-trailers.txt
@@ -0,0 +1,123 @@
+git-interpret-trailers(1)
+=========================
+
+NAME
+----
+git-interpret-trailers - help add stuctured information into commit messages
+
+SYNOPSIS
+--------
+[verse]
+'git interpret-trailers' [--trim-empty] [(<token>[(=|:)<value>])...]
+
+DESCRIPTION
+-----------
+Help add RFC 822-like headers, called 'trailers', at the end of the
+otherwise free-form part of a commit message.
+
+This command is a filter. It reads the standard input for a commit
+message and applies the `token` arguments, if any, to this
+message. The resulting message is emited on the standard output.
+
+Some configuration variables control the way the `token` arguments are
+applied to the message and the way any existing trailer in the message
+is changed. They also make it possible to automatically add some
+trailers.
+
+By default, a 'token=value' or 'token:value' argument will be added
+only if no trailer with the same (token, value) pair is already in the
+message. The 'token' and 'value' parts will be trimmed to remove
+starting and trailing whitespace, and the resulting trimmed 'token'
+and 'value' will appear in the message like this:
+
+------------------------------------------------
+token: value
+------------------------------------------------
+
+By default, if there are already trailers with the same 'token', the
+new trailer will appear just after the last trailer with the same
+'token'. Otherwise it will appear at the end of the message.
+
+Note that 'trailers' do not follow and are not intended to follow many
+rules that are in RFC 822. For example they do not follow the line
+breaking rules, the encoding rules and probably many other rules.
+
+OPTIONS
+-------
+--trim-empty::
+	If the 'value' part of any trailer contains only whitespace,
+	the whole trailer will be removed from the resulting message.
+
+CONFIGURATION VARIABLES
+-----------------------
+
+trailer.<token>.key::
+	This 'key' will be used instead of 'token' in the
+	trailer. After some alphanumeric characters, it can contain
+	some non alphanumeric characters like ':', '=' or '#' that will
+	be used instead of ':' to separate the token from the value in
+	the trailer, though the default ':' is more standard.
+
+trailer.<token>.where::
+	This can be either `after`, which is the default, or
+	`before`. If it is `before`, then a trailer with the specified
+	token, will appear before, instead of after, other trailers
+	with the same token, or otherwise at the beginning, instead of
+	at the end, of all the trailers.
+
+trailer.<token>.ifexist::
+	This option makes it possible to choose what action will be
+	performed when there is already at least one trailer with the
+	same token in the message.
++
+The valid values for this option are: `addIfDifferent` (this is the
+default), `addIfDifferentNeighbor`, `add`, `overwrite` or `doNothing`.
++
+With `addIfDifferent`, a new trailer will be added only if no trailer
+with the same (token, value) pair is already in the message.
++
+With `addIfDifferentNeighbor`, a new trailer will be added only if no
+trailer with the same (token, value) pair is above or below the line
+where the new trailer will be added.
++
+With `add`, a new trailer will be added, even if some trailers with
+the same (token, value) pair are already in the message.
++
+With `overwrite`, the new trailer will overwrite an existing trailer
+with the same token.
++
+With `doNothing`, nothing will be done, that is no new trailer will be
+added if there is already one with the same token in the message.
+
+trailer.<token>.ifmissing::
+	This option makes it possible to choose what action will be
+	performed when there is not yet any trailer with the same
+	token in the message.
++
+The valid values for this option are: `add` (this is the default) and
+`doNothing`.
++
+With `add`, a new trailer will be added.
++
+With `doNothing`, nothing will be done.
+
+trailer.<token>.command::
+	This option can be used to specify a shell command that will
+	be used to automatically add or modify a trailer with the
+	specified 'token'.
++
+When this option is specified, it is like if a special 'token=value'
+argument is added at the end of the command line, where 'value' will
+be given by the standard output of the specified command.
++
+If the command contains the `$ARG` string, this string will be
+replaced with the 'value' part of an existing trailer with the same
+token, if any, before the command is launched.
+
+SEE ALSO
+--------
+linkgit:git-commit[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
-- 
1.9.0.164.g3aa33cd.dirty
