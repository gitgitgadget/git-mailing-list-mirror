From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] grep: allow -E and -n to be turned on by default via
 configuration
Date: Mon, 28 Mar 2011 15:12:06 -0700
Message-ID: <7vbp0ux5c9.fsf_-_@alter.siamese.dyndns.org>
References: <1301088071-918-1-git-send-email-jratt0@gmail.com>
 <7vlj024wal.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Joe Ratterman <jratt0@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 00:12:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4Kfq-0001ix-5U
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 00:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838Ab1C1WMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 18:12:19 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41815 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923Ab1C1WMS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 18:12:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 629B05378;
	Mon, 28 Mar 2011 18:14:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KGicLv7RWYaR3LzLafJugW1UT4A=; b=EQ79Eg
	HKIMeZi/LYdqWiyYIvbN3VLu0s2Mqx8FBSWi9yKFfi40yCjQVPGM9Ug4dy43VdQl
	3ENC8HvXJzJ5aG+Zp7pQamXqGdRLG8cOIj89HqLvnbDJNC6R/o5z1KYFnIUPHYsJ
	QZC9N+hWv0x1mQxdKdpdohJKR6NIc3bd7cEEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZtnUAByU8LqIiIqM3WUmQgw8C4hudJPJ
	fNoi+qSXBcRW14mjucR6ioufhUwzR5go/dTEjkS+i/Roejh0XTiGbPlo+n7aTB2S
	mOngnWJ0b2UE/cbyD4CztpKjqeWZaMHnZaHL72WLTQDuplDYeza7avAEsFi/KeMq
	02obUCAAyAc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 01D865377;
	Mon, 28 Mar 2011 18:13:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E0AF25376; Mon, 28 Mar 2011
 18:13:54 -0400 (EDT)
In-Reply-To: <7vlj024wal.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 25 Mar 2011 16:25:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AD4FF74C-5988-11E0-AAB7-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170194>

From: Joe Ratterman <jratt0@gmail.com>

Add two configration variables grep.extendedRegexp and grep.lineNumbers to
allow the user to skip typing -E and -n on the command line, respectively.

Scripts that are meant to be used by random users and/or in random
repositories now have use -G and/or --no-line-number options as
appropriately to override the settings in the repository or user's
~/.gitconfig settings. Just because the script didn't say "git grep -n" no
longer guarantees that the output from the command will not have line
numbers.

Signed-off-by: Joe Ratterman <jratt0@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Having discussed the b/c issue to death, here is an updated version of
   your patch to be applied on top of your --[no-]line-number patch.

   I addressed both the title for shortlog and names of the variables, but
   two more important fixes are not to overwrite the whole regflags and
   not to assume that the value of REG_EXTENDED is 01.

   I did not add tests, but we do need one perhaps at the end of t7810 to
   move things forward.

 Documentation/config.txt   |    6 ++++++
 Documentation/git-grep.txt |   10 ++++++++++
 builtin/grep.c             |   10 ++++++++++
 3 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 8ea55d4..1ae5d80 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1098,6 +1098,12 @@ All gitcvs variables except for 'gitcvs.usecrlfattr' and
 is one of "ext" and "pserver") to make them apply only for the given
 access method.
 
+grep.lineNumbers::
+	If set to true, enable '-n' option by default.
+
+grep.extendedRegexp::
+	If set to true, enable '--extended-regexp' option by default.
+
 gui.commitmsgwidth::
 	Defines how wide the commit message window is in the
 	linkgit:git-gui[1]. "75" is the default.
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 132505e..d7c2427 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -31,6 +31,16 @@ Look for specified patterns in the tracked files in the work tree, blobs
 registered in the index file, or blobs in given tree objects.
 
 
+CONFIGURATION
+-------------
+
+grep.lineNumbers::
+	If set to true, enable '-n' option by default.
+
+grep.extendedRegexp::
+	If set to true, enable '--extended-regexp' option by default.
+
+
 OPTIONS
 -------
 --cached::
diff --git a/builtin/grep.c b/builtin/grep.c
index 85e9583..62d8b11 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -302,6 +302,16 @@ static int grep_config(const char *var, const char *value, void *cb)
 	default: return 0;
 	}
 
+	if (!strcmp(var, "grep.extendedregexp")) {
+		opt->regflags |= git_config_bool(var, value) ? REG_EXTENDED : 0;
+		return 0;
+	}
+
+	if (!strcmp(var, "grep.linenumbers")) {
+		opt->linenum = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "color.grep"))
 		opt->color = git_config_colorbool(var, value, -1);
 	else if (!strcmp(var, "color.grep.context"))
-- 
1.7.4.2.412.g61e8a
