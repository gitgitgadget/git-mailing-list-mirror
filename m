From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH RFC] completion: add support for completing email aliases
Date: Fri, 13 Nov 2015 10:17:40 -0800
Message-ID: <1447438660-6115-1-git-send-email-jacob.e.keller@intel.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Lee Marlow <lee.marlow@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 13 19:17:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxIux-0004X4-Oq
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 19:17:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933042AbbKMSRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 13:17:43 -0500
Received: from mga11.intel.com ([192.55.52.93]:45862 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933005AbbKMSRm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 13:17:42 -0500
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP; 13 Nov 2015 10:17:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,288,1444719600"; 
   d="scan'208";a="837248831"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([134.134.3.123])
  by fmsmga001.fm.intel.com with ESMTP; 13 Nov 2015 10:17:42 -0800
X-Mailer: git-send-email 2.6.1.264.gbab76a9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281259>

From: Jacob Keller <jacob.keller@gmail.com>

Extract email aliases from the sendemail.aliasesfile according to the
known types. Implementation only extracts the alias name and does not
attempt to complete email addresses.

Add a few tests for simple layouts of the currently supported alias
filetypes.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---

Labeled this RFC because I have only been able to test the mutt format
as this is what I use locally. I have a few (probably brittle) test
cases for the files, but they are not "real" configuration files as per
the upstream tools, so they are essentially made to work with the simple
extractors that I have now. I'd like some review on this to see if it's
valuable, but it definitely helps me type out aliases and see what is
available by just using TAB.

 contrib/completion/git-completion.bash | 69 ++++++++++++++++++++++++++
 t/t9902-completion.sh                  | 90 ++++++++++++++++++++++++++++++++++
 2 files changed, 159 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 482ca84b451b..9b786bb390ba 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -10,6 +10,7 @@
 #    *) local and remote tag names
 #    *) .git/remotes file names
 #    *) git 'subcommands'
+#    *) git email aliases for git-send-email
 #    *) tree paths within 'ref:path/to/file' expressions
 #    *) file paths within current working directory and index
 #    *) common --long-options
@@ -785,6 +786,56 @@ __git_aliased_command ()
 	done
 }
 
+# Print aliases for email addresses from sendemail.aliasesfile
+__git_email_aliases ()
+{
+	local file="$(git --git-dir="$(__gitdir)" config --path sendemail.aliasesfile)"
+	local filetype="$(git --git-dir="$(__gitdir)" config sendemail.aliasfiletype)"
+
+	# Only run awk if we find an actual file
+	if ! [ -f $file ]; then
+		return
+	fi
+
+	case "$filetype" in
+		# Each file type needs to be parsed differently.
+		mutt|mailrc)
+			# Mutt and mailrc are simple and just put the alias in
+			# the 2nd field of the file.
+			awk '{print $2}' $file
+			return
+			;;
+		sendmail)
+			# Skip new lines, lines without fields, and lines
+			# ending in '\' then print the name minus the final :
+			awk 'NF && $1!~/^#/ && !/\\$/ {sub(/:$/, "", $1); print $1 }' $file
+			return
+			;;
+		pine)
+			# According to spec, line continuations are any line
+			# which starts with whitespace, otherwise we can just
+			# use the normal separator and print the first field.
+			awk '/^\S/ {print $1}' "$file"
+			return
+			;;
+		elm)
+			# Elm doesn't appear to allow newlines, and
+			# git-send-email only accepts one alias per line, so
+			# just print the first field.
+			awk '{print $1}' "$file"
+			return
+			;;
+		gnus)
+			# The gnus format has the alias quoted, so we just use
+			# gsub to extract the alias from the quotes
+			awk '/define-mail-alias/ {gsub(/"/, "", $2); print $2}' $file
+			return
+			;;
+		*)
+			return;;
+	esac
+}
+
 # __git_find_on_cmdline requires 1 argument
 __git_find_on_cmdline ()
 {
@@ -1735,6 +1786,24 @@ _git_send_email ()
 			" "" "${cur##--thread=}"
 		return
 		;;
+	--to=*)
+		__gitcomp "
+		$(__git_email_aliases)
+		" "" "${cur##--to=}"
+		return
+		;;
+	--cc=*)
+		__gitcomp "
+		$(__git_email_aliases)
+		" "" "${cur##--cc=}"
+		return
+		;;
+	--bcc=*)
+		__gitcomp "
+		$(__git_email_aliases)
+		" "" "${cur##--bcc=}"
+		return
+		;;
 	--*)
 		__gitcomp "--annotate --bcc --cc --cc-cmd --chain-reply-to
 			--compose --confirm= --dry-run --envelope-sender
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 2ba62fbc178e..0549f75e6e7c 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -404,6 +404,96 @@ test_expect_success '__git_aliases' '
 	test_cmp expect actual
 '
 
+test_expect_success '__git_email_aliases (mutt)' '
+	cat >aliases <<-EOF &&
+	alias user1 Some User <user1@example.org>
+	alias user2 random-user-foo@foo.garbage
+	EOF
+	cat >expect <<-EOF &&
+	user1
+	user2
+	EOF
+	test_config sendemail.aliasesfile aliases &&
+	test_config sendemail.aliasfiletype mutt &&
+	__git_email_aliases >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '__git_email_aliases (mailrc)' '
+	cat >aliases <<-EOF &&
+	alias user1 Some User <user1@example.org>
+	alias user2 random-user-foo@foo.garbage
+	EOF
+	cat >expect <<-EOF &&
+	user1
+	user2
+	EOF
+	test_config sendemail.aliasesfile aliases &&
+	test_config sendemail.aliasfiletype mailrc &&
+	__git_email_aliases >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '__git_email_aliases (sendmail)' '
+	cat >aliases <<-EOF &&
+	user1: Some User <user1@example.org>
+	user2: random-user-foo@foo.garbage
+	EOF
+	cat >expect <<-EOF &&
+	user1
+	user2
+	EOF
+	test_config sendemail.aliasesfile aliases &&
+	test_config sendemail.aliasfiletype sendmail &&
+	__git_email_aliases >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '__git_email_aliases (pine)' '
+	cat >aliases <<-EOF &&
+	user1	Some User	user1@example.org>
+	user2	random-user-foo@foo.garbage
+	EOF
+	cat >expect <<-EOF &&
+	user1
+	user2
+	EOF
+	test_config sendemail.aliasesfile aliases &&
+	test_config sendemail.aliasfiletype pine &&
+	__git_email_aliases >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '__git_email_aliases (elm)' '
+	cat >aliases <<-EOF &&
+	user1 = User; Someone = user1@example.org
+	user2 = = user2@garbage.foo
+	EOF
+	cat >expect <<-EOF &&
+	user1
+	user2
+	EOF
+	test_config sendemail.aliasesfile aliases &&
+	test_config sendemail.aliasfiletype elm &&
+	__git_email_aliases >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '__git_email_aliases (gnus)' '
+	cat >aliases <<-EOF &&
+	define-mail-alias "user1" "user1@example.org"
+	define-mail-alias "user2" "user2@arbitrary.foo"
+	EOF
+	cat >expect <<-EOF &&
+	user1
+	user2
+	EOF
+	test_config sendemail.aliasesfile aliases &&
+	test_config sendemail.aliasfiletype gnus &&
+	__git_email_aliases >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'basic' '
 	run_completion "git " &&
 	# built-in
-- 
2.6.1.264.gbab76a9
