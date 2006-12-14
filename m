X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Brian Gernhardt <benji@silverinsanity.com>
Subject: [PATCH] Add --add option to git-repo-config
Date: Thu, 14 Dec 2006 08:46:23 -0500
Message-ID: <75CF19E7-7953-4C0A-B4CE-E9BB6822E062@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 14 Dec 2006 13:46:36 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: Apple Mail (2.752.3)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34335>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guqus-0006Nz-Pi for gcvg-git@gmane.org; Thu, 14 Dec
 2006 14:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932727AbWLNNq2 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 08:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932730AbWLNNq2
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 08:46:28 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:36724 "EHLO
 silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S932727AbWLNNq1 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 08:46:27 -0500
Received: from [IPv6???1] (localhost [127.0.0.1]) (using TLSv1 with cipher
 AES128-SHA (128/128 bits)) (No client certificate requested) by
 silverinsanity.com (Postfix) with ESMTP id 70F451FFD0EC for
 <git@vger.kernel.org>; Thu, 14 Dec 2006 13:46:26 +0000 (UTC)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

For multivars, the "git-repo-config name value ^$" is useful but
nonintuitive and troublesome to do repeatedly (since the value is not
at the end of the command line).  This commit simply adds an --add
option that adds a new value to a multivar.  Particularly useful for
tracking a new branch on a remote:

git-repo-config --add remote.origin.fetch next:origin/next

Includes documentation so new users can find it and and a test to
make sure it works.

Signed-off-by: Brian Gernhardt <benji@silverinsanity.com>
---

Found myself wanting this so decided to code it myself instead of
just complaining.

Documentation/git-repo-config.txt |   14 +++++++++++++-
builtin-repo-config.c             |    6 ++++--
t/t1300-repo-config.sh            |   10 ++++++++++
3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-repo-config.txt b/Documentation/git- 
repo-config.txt
index 5bede9a..b379ec5 100644
--- a/Documentation/git-repo-config.txt
+++ b/Documentation/git-repo-config.txt
@@ -10,6 +10,7 @@ SYNOPSIS
  --------
  [verse]
  'git-repo-config' [--global] [type] name [value [value_regex]]
+'git-repo-config' [--global] [type] --add name value
  'git-repo-config' [--global] [type] --replace-all name [value  
[value_regex]]
  'git-repo-config' [--global] [type] --get name [value_regex]
  'git-repo-config' [--global] [type] --get-all name [value_regex]
@@ -23,7 +24,8 @@ You can query/set/replace/unset options with this  
command. The name is
  actually the section and the key separated by a dot, and the value  
will be
  escaped.
-If you want to set/unset an option which can occur on multiple
+Multiple lines can be added to an option by using the '--add' option.
+If you want to update or unset an option which can occur on multiple
  lines, a POSIX regexp `value_regex` needs to be given.  Only the
  existing values that match the regexp are updated or unset.  If
  you want to handle the lines that do *not* match the regex, just
@@ -53,6 +55,10 @@ OPTIONS
  	Default behavior is to replace at most one line. This replaces
  	all lines matching the key (and optionally the value_regex).
+--add::
+	Adds a new line to the option without altering any existing
+	values.  This is the same as providing '^$' as the value_regex.
+
--get::
  	Get the value for a given key (optionally filtered by a regex
  	matching the value). Returns error code 1 if the key was not
@@ -194,6 +200,12 @@ To actually match only values with an  
exclamation mark, you have to
  % git repo-config section.key value '[!]'
  ------------
+To add a new proxy, without altering any of the existing ones, use
+
+------------
+% git repo-config core.gitproxy '"proxy" for example.com'
+------------
+
include::config.txt[]
diff --git a/builtin-repo-config.c b/builtin-repo-config.c
index 7b6e572..64fbdb7 100644
--- a/builtin-repo-config.c
+++ b/builtin-repo-config.c
@@ -3,7 +3,7 @@
  #include <regex.h>
  static const char git_config_set_usage[] =
-"git-repo-config [ --global ] [ --bool | --int ] [--get | --get-all  
| --get-regexp | --replace-all | --unset | --unset-all] name [value  
[value_regex]] | --list";
+"git-repo-config [ --global ] [ --bool | --int ] [--get | --get-all  
| --get-regexp | --replace-all | --add | --unset | --unset-all] name  
[value [value_regex]] | --list";
  static char *key;
  static regex_t *key_regexp;
@@ -190,7 +190,9 @@ int cmd_repo_config(int argc, const char **argv,  
const char *prefix)
  			use_key_regexp = 1;
  			do_all = 1;
  			return get_value(argv[2], argv[3]);
-		} else if (!strcmp(argv[1], "--replace-all"))
+		} else if (!strcmp(argv[1], "--add"))
+			return git_config_set_multivar(argv[2], argv[3], "^$", 0);
+		else if (!strcmp(argv[1], "--replace-all"))
  			return git_config_set_multivar(argv[2], argv[3], NULL, 1);
  		else
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 0de2497..16cd642 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -265,6 +265,16 @@ EOF
  test_expect_success '--get-regexp' \
  	'git-repo-config --get-regexp in > output && cmp output expect'
+git-repo-config --add nextsection.nonewline "wow4 for you"
+
+cat > expect << EOF
+wow2 for me
+wow4 for you
+EOF
+
+test_expect_success '--add' \
+	'git-repo-config --get-all nextsection.nonewline > output && cmp  
output expect'
+
  cat > .git/config << EOF
  [novalue]
  	variable
--
1.4.4.1.GIT
