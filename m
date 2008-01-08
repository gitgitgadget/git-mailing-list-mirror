From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: [PATCH] Added recurse command to git submodule
Date: Tue, 8 Jan 2008 09:14:19 +0600
Message-ID: <7bfdc29a0801071914s207be500veae8e507d7d9d29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_31513_21338067.1199762059763"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 04:15:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JC4va-0008Lr-63
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 04:14:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755079AbYAHDOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 22:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753963AbYAHDOY
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 22:14:24 -0500
Received: from fk-out-0910.google.com ([209.85.128.187]:30046 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753928AbYAHDOW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 22:14:22 -0500
Received: by fk-out-0910.google.com with SMTP id z23so8877251fkz.5
        for <git@vger.kernel.org>; Mon, 07 Jan 2008 19:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type;
        bh=I0bYDZNvDKN51duwKgdildrYp60nXvBvvp10amvwqv0=;
        b=pNXhung8sNgR/LaKXBlFj+ruiPatCli6jnm7nT6i89zcNMtQS6zqr6/fVjsEsLw9qEJjtMhg/V7RGnPBjt4D8NDGAm0KGVZESZfc3jL/0hTo39MpKlzGs+iNnrVwsXzTGPY7TZ7QOB3c79Cf1UlsMSIqejfsq+Dom7ak+egjsNs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type;
        b=el1jXkQ/xEaazu8xiLsAUYRsjv0T21xx8UzV/NKszoewCk4CKrChYCwIVdGUs7qg9dokgNKp3mg95yKHpwCQZWhk2QKlBmfp4aLiu9GA4dkAUtNhuXvvgqigg/a9Fvjq01/gT9MNWQZZ0tK7GnM8YG2j5D5x3ia3QzqlSvkHUGw=
Received: by 10.78.201.2 with SMTP id y2mr24120509huf.56.1199762059942;
        Mon, 07 Jan 2008 19:14:19 -0800 (PST)
Received: by 10.78.50.5 with HTTP; Mon, 7 Jan 2008 19:14:19 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69834>

------=_Part_31513_21338067.1199762059763
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Added a recurse command to git-submodule. Using this recurse command
any git command (for example, git-status, git-diff, git-checkout) can
be performed from the top level to all its submodules at any depth; if
the module has not been initialized and updated (that is git sumodule
init and git submodule update) the script will take care of that too.

I needed this feature especially for diff, status and pull; as I am
working on a multi module maven project with each module having
separate repository due to architecture and future extensibility.

Following is the diff with git-submdoule version 1.5.3.7. I also
attached the diff and the modified file in the attachment.

diff --git a/git-submodule b/git-submodule
index b91d626..e819152 100755
--- a/git-submodule
+++ b/git-submodule
@@ -1,10 +1,11 @@
 #!/bin/sh
 #
 # git-submodules.sh: add, init, update or list git submodules
+# or recurse any git command over the submodules recursively.
 #
 # Copyright (c) 2007 Lars Hjemli

-USAGE='[--quiet] [--cached] [add <repo> [-b
branch]|status|init|update] [--] [<path>...]'
+USAGE='[[--quiet] [--cached] [add <repo> [-b
branch]|status|init|update] [--] [<path>...]|[recurse [-v] command
arguments ...]]'
 . git-sh-setup
 require_work_tree

@@ -251,6 +252,78 @@ modules_list()
 	done
 }

+# Simply checks whether the submodule is initialized
+# or not. If not initialized it does so.
+initializeSubModule() {
+	if [ ! -d "$1"/.git ]; then
+		if [ $recurse_verbose -eq 1 ]; then
+			echo Initializing and updating "$1"
+		fi
+		git-submodule init "$1"; git-submodule update "$1"
+	fi
+}
+
+# This actually traverses the module; checks
+# whether the module is initialized or not.
+# if not initialized, then done so and then the
+# intended command is evaluated. Then it
+# recursively goes into it modules.
+traverseModule() {
+	current_dir=`pwd`
+	dir_path="$current_dir:$dir_path"
+	initializeSubModule "$1"
+        cd "$1"
+	if [ $recurse_verbose -eq 1 ]; then
+		echo Working in mod $1 @ `pwd` with $2
+	fi
+        eval "$2"
+	if [ -f .gitmodules ]; then
+                for mod_path in `grep "path =" .gitmodules | awk
'{print $3}'`; do
+                        traverseModule "$mod_path" "$2"
+                done
+        fi
+	old_dir=$(echo $dir_path | cut -d':' -f1-1)
+	length_old_dir=`expr "$old_dir" : '.*'`
+	cd $old_dir
+	index=$(echo "$length_old_dir+2" | bc)
+	dir_path=`echo $dir_path $index | awk '{print substr($1, $2)}'`
+}
+
+# Propagates or recurses over all the submodules at any
+# depth with any git command, e.g. git-clone, git-status,
+# git-commit etc., with the arguments supplied exactly as
+# it would have been supplied to the command otherwise.
+# This actually starts the recursive propagation
+propagate() {
+	project_home=`pwd`
+	echo Project Home: $project_home
+	if [ -d $project_home/.git/ ]; then
+		git_command=$1
+		shift
+		command_arguments=""
+		for arg in "$@"; do
+			if [ `expr index "$arg" ' '` -gt 0 ]; then
+				arg="\"$arg\""
+			fi
+			command_arguments="$command_arguments $arg"
+		done
+		if [ $recurse_verbose -eq 1 ]; then
+			echo GIT Command git-$git_command with arguments\($#\) "$command_arguments"
+		fi
+		main_command="git-$git_command $command_arguments"
+		eval $main_command
+		if [ -f .gitmodules ]; then
+			for mod_path in `grep "path =" .gitmodules | awk '{print $3}'`; do
+				traverseModule $mod_path "$main_command"
+			done
+		fi
+	else
+		echo $project_home not a git repo thus exiting
+		exit
+	fi
+}
+
+recurse_verbose=0
 while test $# != 0
 do
 	case "$1" in
@@ -286,6 +359,17 @@ do
 	-*)
 		usage
 		;;
+	recurse)
+		recurse=1
+		case "$2" in
+			-v)
+				recurse_verbose=1
+				shift
+				;;
+		esac
+		shift
+		break
+		;;
 	*)
 		break
 		;;
@@ -303,17 +387,21 @@ case "$add,$branch" in
 	;;
 esac

-case "$add,$init,$update,$status,$cached" in
-1,,,,)
+
+case "$add,$init,$update,$recurse,$status,$cached" in
+1,,,,,)
 	module_add "$@"
 	;;
-,1,,,)
+,1,,,,)
 	modules_init "$@"
 	;;
-,,1,,)
+,,1,,,)
 	modules_update "$@"
 	;;
-,,,*,*)
+,,,1,,)
+	propagate "$@"
+	;;
+,,,,*,*)
 	modules_list "$@"
 	;;
 *)

-- 
Imran M Yousuf

------=_Part_31513_21338067.1199762059763
Content-Type: text/plain; name=git-submodule-diff-1.5.3.7.txt
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fb5ur82m2
Content-Disposition: attachment; filename=git-submodule-diff-1.5.3.7.txt

ZGlmZiAtLWdpdCBhL2dpdC1zdWJtb2R1bGUgYi9naXQtc3VibW9kdWxlCmluZGV4IGI5MWQ2MjYu
LmU4MTkxNTIgMTAwNzU1Ci0tLSBhL2dpdC1zdWJtb2R1bGUKKysrIGIvZ2l0LXN1Ym1vZHVsZQpA
QCAtMSwxMCArMSwxMSBAQAogIyEvYmluL3NoCiAjCiAjIGdpdC1zdWJtb2R1bGVzLnNoOiBhZGQs
IGluaXQsIHVwZGF0ZSBvciBsaXN0IGdpdCBzdWJtb2R1bGVzCisjIG9yIHJlY3Vyc2UgYW55IGdp
dCBjb21tYW5kIG92ZXIgdGhlIHN1Ym1vZHVsZXMgcmVjdXJzaXZlbHkuCiAjCiAjIENvcHlyaWdo
dCAoYykgMjAwNyBMYXJzIEhqZW1saQogCi1VU0FHRT0nWy0tcXVpZXRdIFstLWNhY2hlZF0gW2Fk
ZCA8cmVwbz4gWy1iIGJyYW5jaF18c3RhdHVzfGluaXR8dXBkYXRlXSBbLS1dIFs8cGF0aD4uLi5d
JworVVNBR0U9J1tbLS1xdWlldF0gWy0tY2FjaGVkXSBbYWRkIDxyZXBvPiBbLWIgYnJhbmNoXXxz
dGF0dXN8aW5pdHx1cGRhdGVdIFstLV0gWzxwYXRoPi4uLl18W3JlY3Vyc2UgWy12XSBjb21tYW5k
IGFyZ3VtZW50cyAuLi5dXScKIC4gZ2l0LXNoLXNldHVwCiByZXF1aXJlX3dvcmtfdHJlZQogCkBA
IC0yNTEsNiArMjUyLDc4IEBAIG1vZHVsZXNfbGlzdCgpCiAJZG9uZQogfQogCisjIFNpbXBseSBj
aGVja3Mgd2hldGhlciB0aGUgc3VibW9kdWxlIGlzIGluaXRpYWxpemVkCisjIG9yIG5vdC4gSWYg
bm90IGluaXRpYWxpemVkIGl0IGRvZXMgc28uCitpbml0aWFsaXplU3ViTW9kdWxlKCkgeworCWlm
IFsgISAtZCAiJDEiLy5naXQgXTsgdGhlbgorCQlpZiBbICRyZWN1cnNlX3ZlcmJvc2UgLWVxIDEg
XTsgdGhlbgorCQkJZWNobyBJbml0aWFsaXppbmcgYW5kIHVwZGF0aW5nICIkMSIKKwkJZmkKKwkJ
Z2l0LXN1Ym1vZHVsZSBpbml0ICIkMSI7IGdpdC1zdWJtb2R1bGUgdXBkYXRlICIkMSIKKwlmaQor
fQorCisjIFRoaXMgYWN0dWFsbHkgdHJhdmVyc2VzIHRoZSBtb2R1bGU7IGNoZWNrcworIyB3aGV0
aGVyIHRoZSBtb2R1bGUgaXMgaW5pdGlhbGl6ZWQgb3Igbm90LgorIyBpZiBub3QgaW5pdGlhbGl6
ZWQsIHRoZW4gZG9uZSBzbyBhbmQgdGhlbiB0aGUKKyMgaW50ZW5kZWQgY29tbWFuZCBpcyBldmFs
dWF0ZWQuIFRoZW4gaXQKKyMgcmVjdXJzaXZlbHkgZ29lcyBpbnRvIGl0IG1vZHVsZXMuCit0cmF2
ZXJzZU1vZHVsZSgpIHsKKwljdXJyZW50X2Rpcj1gcHdkYAorCWRpcl9wYXRoPSIkY3VycmVudF9k
aXI6JGRpcl9wYXRoIgorCWluaXRpYWxpemVTdWJNb2R1bGUgIiQxIgorICAgICAgICBjZCAiJDEi
CisJaWYgWyAkcmVjdXJzZV92ZXJib3NlIC1lcSAxIF07IHRoZW4KKwkJZWNobyBXb3JraW5nIGlu
IG1vZCAkMSBAIGBwd2RgIHdpdGggJDIKKwlmaQorICAgICAgICBldmFsICIkMiIKKwlpZiBbIC1m
IC5naXRtb2R1bGVzIF07IHRoZW4KKyAgICAgICAgICAgICAgICBmb3IgbW9kX3BhdGggaW4gYGdy
ZXAgInBhdGggPSIgLmdpdG1vZHVsZXMgfCBhd2sgJ3twcmludCAkM30nYDsgZG8KKyAgICAgICAg
ICAgICAgICAgICAgICAgIHRyYXZlcnNlTW9kdWxlICIkbW9kX3BhdGgiICIkMiIKKyAgICAgICAg
ICAgICAgICBkb25lCisgICAgICAgIGZpCisJb2xkX2Rpcj0kKGVjaG8gJGRpcl9wYXRoIHwgY3V0
IC1kJzonIC1mMS0xKQorCWxlbmd0aF9vbGRfZGlyPWBleHByICIkb2xkX2RpciIgOiAnLionYAor
CWNkICRvbGRfZGlyCisJaW5kZXg9JChlY2hvICIkbGVuZ3RoX29sZF9kaXIrMiIgfCBiYykKKwlk
aXJfcGF0aD1gZWNobyAkZGlyX3BhdGggJGluZGV4IHwgYXdrICd7cHJpbnQgc3Vic3RyKCQxLCAk
Mil9J2AKK30KKworIyBQcm9wYWdhdGVzIG9yIHJlY3Vyc2VzIG92ZXIgYWxsIHRoZSBzdWJtb2R1
bGVzIGF0IGFueSAKKyMgZGVwdGggd2l0aCBhbnkgZ2l0IGNvbW1hbmQsIGUuZy4gZ2l0LWNsb25l
LCBnaXQtc3RhdHVzLAorIyBnaXQtY29tbWl0IGV0Yy4sIHdpdGggdGhlIGFyZ3VtZW50cyBzdXBw
bGllZCBleGFjdGx5IGFzCisjIGl0IHdvdWxkIGhhdmUgYmVlbiBzdXBwbGllZCB0byB0aGUgY29t
bWFuZCBvdGhlcndpc2UuCisjIFRoaXMgYWN0dWFsbHkgc3RhcnRzIHRoZSByZWN1cnNpdmUgcHJv
cGFnYXRpb24KK3Byb3BhZ2F0ZSgpIHsKKwlwcm9qZWN0X2hvbWU9YHB3ZGAKKwllY2hvIFByb2pl
Y3QgSG9tZTogJHByb2plY3RfaG9tZQorCWlmIFsgLWQgJHByb2plY3RfaG9tZS8uZ2l0LyBdOyB0
aGVuCisJCWdpdF9jb21tYW5kPSQxCisJCXNoaWZ0CisJCWNvbW1hbmRfYXJndW1lbnRzPSIiCisJ
CWZvciBhcmcgaW4gIiRAIjsgZG8KKwkJCWlmIFsgYGV4cHIgaW5kZXggIiRhcmciICcgJ2AgLWd0
IDAgXTsgdGhlbgorCQkJCWFyZz0iXCIkYXJnXCIiCisJCQlmaSAKKwkJCWNvbW1hbmRfYXJndW1l
bnRzPSIkY29tbWFuZF9hcmd1bWVudHMgJGFyZyIKKwkJZG9uZQorCQlpZiBbICRyZWN1cnNlX3Zl
cmJvc2UgLWVxIDEgXTsgdGhlbgorCQkJZWNobyBHSVQgQ29tbWFuZCBnaXQtJGdpdF9jb21tYW5k
IHdpdGggYXJndW1lbnRzXCgkI1wpICIkY29tbWFuZF9hcmd1bWVudHMiCisJCWZpCisJCW1haW5f
Y29tbWFuZD0iZ2l0LSRnaXRfY29tbWFuZCAkY29tbWFuZF9hcmd1bWVudHMiCisJCWV2YWwgJG1h
aW5fY29tbWFuZAorCQlpZiBbIC1mIC5naXRtb2R1bGVzIF07IHRoZW4KKwkJCWZvciBtb2RfcGF0
aCBpbiBgZ3JlcCAicGF0aCA9IiAuZ2l0bW9kdWxlcyB8IGF3ayAne3ByaW50ICQzfSdgOyBkbwor
CQkJCXRyYXZlcnNlTW9kdWxlICRtb2RfcGF0aCAiJG1haW5fY29tbWFuZCIKKwkJCWRvbmUKKwkJ
ZmkKKwllbHNlCisJCWVjaG8gJHByb2plY3RfaG9tZSBub3QgYSBnaXQgcmVwbyB0aHVzIGV4aXRp
bmcKKwkJZXhpdAorCWZpCit9CisKK3JlY3Vyc2VfdmVyYm9zZT0wCiB3aGlsZSB0ZXN0ICQjICE9
IDAKIGRvCiAJY2FzZSAiJDEiIGluCkBAIC0yODYsNiArMzU5LDE3IEBAIGRvCiAJLSopCiAJCXVz
YWdlCiAJCTs7CisJcmVjdXJzZSkKKwkJcmVjdXJzZT0xCisJCWNhc2UgIiQyIiBpbgorCQkJLXYp
CisJCQkJcmVjdXJzZV92ZXJib3NlPTEKKwkJCQlzaGlmdAorCQkJCTs7CisJCWVzYWMKKwkJc2hp
ZnQKKwkJYnJlYWsKKwkJOzsKIAkqKQogCQlicmVhawogCQk7OwpAQCAtMzAzLDE3ICszODcsMjEg
QEAgY2FzZSAiJGFkZCwkYnJhbmNoIiBpbgogCTs7CiBlc2FjCiAKLWNhc2UgIiRhZGQsJGluaXQs
JHVwZGF0ZSwkc3RhdHVzLCRjYWNoZWQiIGluCi0xLCwsLCkKKworY2FzZSAiJGFkZCwkaW5pdCwk
dXBkYXRlLCRyZWN1cnNlLCRzdGF0dXMsJGNhY2hlZCIgaW4KKzEsLCwsLCkKIAltb2R1bGVfYWRk
ICIkQCIKIAk7OwotLDEsLCwpCissMSwsLCwpCiAJbW9kdWxlc19pbml0ICIkQCIKIAk7OwotLCwx
LCwpCissLDEsLCwpCiAJbW9kdWxlc191cGRhdGUgIiRAIgogCTs7Ci0sLCwqLCopCissLCwxLCwp
CisJcHJvcGFnYXRlICIkQCIKKwk7OworLCwsLCosKikKIAltb2R1bGVzX2xpc3QgIiRAIgogCTs7
CiAqKQo=
------=_Part_31513_21338067.1199762059763
Content-Type: application/octet-stream; name=git-submodule
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fb5urpdk1
Content-Disposition: attachment; filename=git-submodule

IyEvYmluL3NoCiMKIyBnaXQtc3VibW9kdWxlcy5zaDogYWRkLCBpbml0LCB1cGRhdGUgb3IgbGlz
dCBnaXQgc3VibW9kdWxlcwojIG9yIHJlY3Vyc2UgYW55IGdpdCBjb21tYW5kIG92ZXIgdGhlIHN1
Ym1vZHVsZXMgcmVjdXJzaXZlbHkuCiMKIyBDb3B5cmlnaHQgKGMpIDIwMDcgTGFycyBIamVtbGkK
ClVTQUdFPSdbWy0tcXVpZXRdIFstLWNhY2hlZF0gW2FkZCA8cmVwbz4gWy1iIGJyYW5jaF18c3Rh
dHVzfGluaXR8dXBkYXRlXSBbLS1dIFs8cGF0aD4uLi5dfFtyZWN1cnNlIFstdl0gY29tbWFuZCBh
cmd1bWVudHMgLi4uXV0nCi4gZ2l0LXNoLXNldHVwCnJlcXVpcmVfd29ya190cmVlCgphZGQ9CmJy
YW5jaD0KaW5pdD0KdXBkYXRlPQpzdGF0dXM9CnF1aWV0PQpjYWNoZWQ9CgojCiMgcHJpbnQgc3R1
ZmYgb24gc3Rkb3V0IHVubGVzcyAtcSB3YXMgc3BlY2lmaWVkCiMKc2F5KCkKewoJaWYgdGVzdCAt
eiAiJHF1aWV0IgoJdGhlbgoJCWVjaG8gIiRAIgoJZmkKfQoKIyBORUVEU1dPUks6IGlkZW50aWNh
bCBmdW5jdGlvbiBleGlzdHMgaW4gZ2V0X3JlcG9fYmFzZSBpbiBjbG9uZS5zaApnZXRfcmVwb19i
YXNlKCkgewoJKAoJCWNkICJgL2Jpbi9wd2RgIiAmJgoJCWNkICIkMSIgfHwgY2QgIiQxLmdpdCIg
JiYKCQl7CgkJCWNkIC5naXQKCQkJcHdkCgkJfQoJKSAyPi9kZXYvbnVsbAp9CgojCiMgTWFwIHN1
Ym1vZHVsZSBwYXRoIHRvIHN1Ym1vZHVsZSBuYW1lCiMKIyAkMSA9IHBhdGgKIwptb2R1bGVfbmFt
ZSgpCnsKCSMgRG8gd2UgaGF2ZSAic3VibW9kdWxlLjxzb21ldGhpbmc+LnBhdGggPSAkMSIgZGVm
aW5lZCBpbiAuZ2l0bW9kdWxlcyBmaWxlPwoJcmU9JChwcmludGYgJyVzJyAiJDEiIHwgc2VkIC1l
ICdzL1tdLlteJFxcKl0vXFwmL2cnKQoJbmFtZT0kKCBHSVRfQ09ORklHPS5naXRtb2R1bGVzIFwK
CQlnaXQgY29uZmlnIC0tZ2V0LXJlZ2V4cCAnXnN1Ym1vZHVsZVwuLipcLnBhdGgkJyB8CgkJc2Vk
IC1uIC1lICdzfF5zdWJtb2R1bGVcLlwoLipcKVwucGF0aCAnIiRyZSInJHxcMXxwJyApCiAgICAg
ICB0ZXN0IC16ICIkbmFtZSIgJiYKICAgICAgIGRpZSAiTm8gc3VibW9kdWxlIG1hcHBpbmcgZm91
bmQgaW4gLmdpdG1vZHVsZXMgZm9yIHBhdGggJyRwYXRoJyIKICAgICAgIGVjaG8gIiRuYW1lIgp9
CgojCiMgQ2xvbmUgYSBzdWJtb2R1bGUKIwojIFByaW9yIHRvIGNhbGxpbmcsIG1vZHVsZXNfdXBk
YXRlIGNoZWNrcyB0aGF0IGEgcG9zc2libHkgZXhpc3RpbmcKIyBwYXRoIGlzIG5vdCBhIGdpdCBy
ZXBvc2l0b3J5LgojIExpa2V3aXNlLCBtb2R1bGVfYWRkIGNoZWNrcyB0aGF0IHBhdGggZG9lcyBu
b3QgZXhpc3QgYXQgYWxsLAojIHNpbmNlIGl0IGlzIHRoZSBsb2NhdGlvbiBvZiBhIG5ldyBzdWJt
b2R1bGUuCiMKbW9kdWxlX2Nsb25lKCkKewoJcGF0aD0kMQoJdXJsPSQyCgoJIyBJZiB0aGVyZSBh
bHJlYWR5IGlzIGEgZGlyZWN0b3J5IGF0IHRoZSBzdWJtb2R1bGUgcGF0aCwKCSMgZXhwZWN0IGl0
IHRvIGJlIGVtcHR5IChzaW5jZSB0aGF0IGlzIHRoZSBkZWZhdWx0IGNoZWNrb3V0CgkjIGFjdGlv
bikgYW5kIHRyeSB0byByZW1vdmUgaXQuCgkjIE5vdGU6IGlmICRwYXRoIGlzIGEgc3ltbGluayB0
byBhIGRpcmVjdG9yeSB0aGUgdGVzdCB3aWxsCgkjIHN1Y2NlZWQgYnV0IHRoZSBybWRpciB3aWxs
IGZhaWwuIFdlIG1pZ2h0IHdhbnQgdG8gZml4IHRoaXMuCglpZiB0ZXN0IC1kICIkcGF0aCIKCXRo
ZW4KCQlybWRpciAiJHBhdGgiIDI+L2Rldi9udWxsIHx8CgkJZGllICJEaXJlY3RvcnkgJyRwYXRo
JyBleGlzdCwgYnV0IGlzIG5laXRoZXIgZW1wdHkgbm9yIGEgZ2l0IHJlcG9zaXRvcnkiCglmaQoK
CXRlc3QgLWUgIiRwYXRoIiAmJgoJZGllICJBIGZpbGUgYWxyZWFkeSBleGlzdCBhdCBwYXRoICck
cGF0aCciCgoJZ2l0LWNsb25lIC1uICIkdXJsIiAiJHBhdGgiIHx8CglkaWUgIkNsb25lIG9mICck
dXJsJyBpbnRvIHN1Ym1vZHVsZSBwYXRoICckcGF0aCcgZmFpbGVkIgp9CgojCiMgQWRkIGEgbmV3
IHN1Ym1vZHVsZSB0byB0aGUgd29ya2luZyB0cmVlLCAuZ2l0bW9kdWxlcyBhbmQgdGhlIGluZGV4
CiMKIyAkQCA9IHJlcG8gW3BhdGhdCiMKIyBvcHRpb25hbCBicmFuY2ggaXMgc3RvcmVkIGluIGds
b2JhbCBicmFuY2ggdmFyaWFibGUKIwptb2R1bGVfYWRkKCkKewoJcmVwbz0kMQoJcGF0aD0kMgoK
CWlmIHRlc3QgLXogIiRyZXBvIjsgdGhlbgoJCXVzYWdlCglmaQoKCSMgVHVybiB0aGUgc291cmNl
IGludG8gYW4gYWJzb2x1dGUgcGF0aCBpZgoJIyBpdCBpcyBsb2NhbAoJaWYgYmFzZT0kKGdldF9y
ZXBvX2Jhc2UgIiRyZXBvIik7IHRoZW4KCQlyZXBvPSIkYmFzZSIKCWZpCgoJIyBHdWVzcyBwYXRo
IGZyb20gcmVwbyBpZiBub3Qgc3BlY2lmaWVkIG9yIHN0cmlwIHRyYWlsaW5nIHNsYXNoZXMKCWlm
IHRlc3QgLXogIiRwYXRoIjsgdGhlbgoJCXBhdGg9JChlY2hvICIkcmVwbyIgfCBzZWQgLWUgJ3N8
LyokfHwnIC1lICdzfDoqLypcLmdpdCR8fCcgLWUgJ3N8LipbLzpdfHxnJykKCWVsc2UKCQlwYXRo
PSQoZWNobyAiJHBhdGgiIHwgc2VkIC1lICdzfC8qJHx8JykKCWZpCgoJdGVzdCAtZSAiJHBhdGgi
ICYmCglkaWUgIickcGF0aCcgYWxyZWFkeSBleGlzdHMiCgoJZ2l0IGxzLWZpbGVzIC0tZXJyb3It
dW5tYXRjaCAiJHBhdGgiID4gL2Rldi9udWxsIDI+JjEgJiYKCWRpZSAiJyRwYXRoJyBhbHJlYWR5
IGV4aXN0cyBpbiB0aGUgaW5kZXgiCgoJbW9kdWxlX2Nsb25lICIkcGF0aCIgIiRyZXBvIiB8fCBl
eGl0CgkodW5zZXQgR0lUX0RJUiAmJiBjZCAiJHBhdGgiICYmIGdpdCBjaGVja291dCAtcSAke2Jy
YW5jaDorLWIgIiRicmFuY2giICJvcmlnaW4vJGJyYW5jaCJ9KSB8fAoJZGllICJVbmFibGUgdG8g
Y2hlY2tvdXQgc3VibW9kdWxlICckcGF0aCciCglnaXQgYWRkICIkcGF0aCIgfHwKCWRpZSAiRmFp
bGVkIHRvIGFkZCBzdWJtb2R1bGUgJyRwYXRoJyIKCglHSVRfQ09ORklHPS5naXRtb2R1bGVzIGdp
dCBjb25maWcgc3VibW9kdWxlLiIkcGF0aCIucGF0aCAiJHBhdGgiICYmCglHSVRfQ09ORklHPS5n
aXRtb2R1bGVzIGdpdCBjb25maWcgc3VibW9kdWxlLiIkcGF0aCIudXJsICIkcmVwbyIgJiYKCWdp
dCBhZGQgLmdpdG1vZHVsZXMgfHwKCWRpZSAiRmFpbGVkIHRvIHJlZ2lzdGVyIHN1Ym1vZHVsZSAn
JHBhdGgnIgp9CgojCiMgUmVnaXN0ZXIgc3VibW9kdWxlcyBpbiAuZ2l0L2NvbmZpZwojCiMgJEAg
PSByZXF1ZXN0ZWQgcGF0aHMgKGRlZmF1bHQgdG8gYWxsKQojCm1vZHVsZXNfaW5pdCgpCnsKCWdp
dCBscy1maWxlcyAtLXN0YWdlIC0tICIkQCIgfCBncmVwIC1lICdeMTYwMDAwICcgfAoJd2hpbGUg
cmVhZCBtb2RlIHNoYTEgc3RhZ2UgcGF0aAoJZG8KCQkjIFNraXAgYWxyZWFkeSByZWdpc3RlcmVk
IHBhdGhzCgkJbmFtZT0kKG1vZHVsZV9uYW1lICIkcGF0aCIpIHx8IGV4aXQKCQl1cmw9JChnaXQg
Y29uZmlnIHN1Ym1vZHVsZS4iJG5hbWUiLnVybCkKCQl0ZXN0IC16ICIkdXJsIiB8fCBjb250aW51
ZQoKCQl1cmw9JChHSVRfQ09ORklHPS5naXRtb2R1bGVzIGdpdCBjb25maWcgc3VibW9kdWxlLiIk
bmFtZSIudXJsKQoJCXRlc3QgLXogIiR1cmwiICYmCgkJZGllICJObyB1cmwgZm91bmQgZm9yIHN1
Ym1vZHVsZSBwYXRoICckcGF0aCcgaW4gLmdpdG1vZHVsZXMiCgoJCWdpdCBjb25maWcgc3VibW9k
dWxlLiIkbmFtZSIudXJsICIkdXJsIiB8fAoJCWRpZSAiRmFpbGVkIHRvIHJlZ2lzdGVyIHVybCBm
b3Igc3VibW9kdWxlIHBhdGggJyRwYXRoJyIKCgkJc2F5ICJTdWJtb2R1bGUgJyRuYW1lJyAoJHVy
bCkgcmVnaXN0ZXJlZCBmb3IgcGF0aCAnJHBhdGgnIgoJZG9uZQp9CgojCiMgVXBkYXRlIGVhY2gg
c3VibW9kdWxlIHBhdGggdG8gY29ycmVjdCByZXZpc2lvbiwgdXNpbmcgY2xvbmUgYW5kIGNoZWNr
b3V0IGFzIG5lZWRlZAojCiMgJEAgPSByZXF1ZXN0ZWQgcGF0aHMgKGRlZmF1bHQgdG8gYWxsKQoj
Cm1vZHVsZXNfdXBkYXRlKCkKewoJZ2l0IGxzLWZpbGVzIC0tc3RhZ2UgLS0gIiRAIiB8IGdyZXAg
LWUgJ14xNjAwMDAgJyB8Cgl3aGlsZSByZWFkIG1vZGUgc2hhMSBzdGFnZSBwYXRoCglkbwoJCW5h
bWU9JChtb2R1bGVfbmFtZSAiJHBhdGgiKSB8fCBleGl0CgkJdXJsPSQoZ2l0IGNvbmZpZyBzdWJt
b2R1bGUuIiRuYW1lIi51cmwpCgkJaWYgdGVzdCAteiAiJHVybCIKCQl0aGVuCgkJCSMgT25seSBt
ZW50aW9uIHVuaW5pdGlhbGl6ZWQgc3VibW9kdWxlcyB3aGVuIGl0cwoJCQkjIHBhdGggaGF2ZSBi
ZWVuIHNwZWNpZmllZAoJCQl0ZXN0ICIkIyIgIT0gIjAiICYmCgkJCXNheSAiU3VibW9kdWxlIHBh
dGggJyRwYXRoJyBub3QgaW5pdGlhbGl6ZWQiCgkJCWNvbnRpbnVlCgkJZmkKCgkJaWYgISB0ZXN0
IC1kICIkcGF0aCIvLmdpdAoJCXRoZW4KCQkJbW9kdWxlX2Nsb25lICIkcGF0aCIgIiR1cmwiIHx8
IGV4aXQKCQkJc3Vic2hhMT0KCQllbHNlCgkJCXN1YnNoYTE9JCh1bnNldCBHSVRfRElSICYmIGNk
ICIkcGF0aCIgJiYKCQkJCWdpdCByZXYtcGFyc2UgLS12ZXJpZnkgSEVBRCkgfHwKCQkJZGllICJV
bmFibGUgdG8gZmluZCBjdXJyZW50IHJldmlzaW9uIGluIHN1Ym1vZHVsZSBwYXRoICckcGF0aCci
CgkJZmkKCgkJaWYgdGVzdCAiJHN1YnNoYTEiICE9ICIkc2hhMSIKCQl0aGVuCgkJCSh1bnNldCBH
SVRfRElSICYmIGNkICIkcGF0aCIgJiYgZ2l0LWZldGNoICYmCgkJCQlnaXQtY2hlY2tvdXQgLXEg
IiRzaGExIikgfHwKCQkJZGllICJVbmFibGUgdG8gY2hlY2tvdXQgJyRzaGExJyBpbiBzdWJtb2R1
bGUgcGF0aCAnJHBhdGgnIgoKCQkJc2F5ICJTdWJtb2R1bGUgcGF0aCAnJHBhdGgnOiBjaGVja2Vk
IG91dCAnJHNoYTEnIgoJCWZpCglkb25lCn0KCnNldF9uYW1lX3JldiAoKSB7CglyZXZuYW1lPSQo
ICgKCQl1bnNldCBHSVRfRElSICYmCgkJY2QgIiQxIiAmJiB7CgkJCWdpdCBkZXNjcmliZSAiJDIi
IDI+L2Rldi9udWxsIHx8CgkJCWdpdCBkZXNjcmliZSAtLXRhZ3MgIiQyIiAyPi9kZXYvbnVsbCB8
fAoJCQlnaXQgZGVzY3JpYmUgLS1jb250YWlucyAtLXRhZ3MgIiQyIgoJCX0KCSkgKQoJdGVzdCAt
eiAiJHJldm5hbWUiIHx8IHJldm5hbWU9IiAoJHJldm5hbWUpIgp9CgojCiMgTGlzdCBhbGwgc3Vi
bW9kdWxlcywgcHJlZml4ZWQgd2l0aDoKIyAgLSBzdWJtb2R1bGUgbm90IGluaXRpYWxpemVkCiMg
ICsgZGlmZmVyZW50IHJldmlzaW9uIGNoZWNrZWQgb3V0CiMKIyBJZiAtLWNhY2hlZCB3YXMgc3Bl
Y2lmaWVkIHRoZSByZXZpc2lvbiBpbiB0aGUgaW5kZXggd2lsbCBiZSBwcmludGVkCiMgaW5zdGVh
ZCBvZiB0aGUgY3VycmVudGx5IGNoZWNrZWQgb3V0IHJldmlzaW9uLgojCiMgJEAgPSByZXF1ZXN0
ZWQgcGF0aHMgKGRlZmF1bHQgdG8gYWxsKQojCm1vZHVsZXNfbGlzdCgpCnsKCWdpdCBscy1maWxl
cyAtLXN0YWdlIC0tICIkQCIgfCBncmVwIC1lICdeMTYwMDAwICcgfAoJd2hpbGUgcmVhZCBtb2Rl
IHNoYTEgc3RhZ2UgcGF0aAoJZG8KCQluYW1lPSQobW9kdWxlX25hbWUgIiRwYXRoIikgfHwgZXhp
dAoJCXVybD0kKGdpdCBjb25maWcgc3VibW9kdWxlLiIkbmFtZSIudXJsKQoJCWlmIHRlc3QgLXog
InVybCIgfHwgISB0ZXN0IC1kICIkcGF0aCIvLmdpdAoJCXRoZW4KCQkJc2F5ICItJHNoYTEgJHBh
dGgiCgkJCWNvbnRpbnVlOwoJCWZpCgkJc2V0X25hbWVfcmV2ICIkcGF0aCIgIiRzaGExIgoJCWlm
IGdpdCBkaWZmLWZpbGVzIC0tcXVpZXQgLS0gIiRwYXRoIgoJCXRoZW4KCQkJc2F5ICIgJHNoYTEg
JHBhdGgkcmV2bmFtZSIKCQllbHNlCgkJCWlmIHRlc3QgLXogIiRjYWNoZWQiCgkJCXRoZW4KCQkJ
CXNoYTE9JCh1bnNldCBHSVRfRElSICYmIGNkICIkcGF0aCIgJiYgZ2l0IHJldi1wYXJzZSAtLXZl
cmlmeSBIRUFEKQoJCQkJc2V0X25hbWVfcmV2ICIkcGF0aCIgIiRzaGExIgoJCQlmaQoJCQlzYXkg
Iiskc2hhMSAkcGF0aCRyZXZuYW1lIgoJCWZpCglkb25lCn0KCiMgU2ltcGx5IGNoZWNrcyB3aGV0
aGVyIHRoZSBzdWJtb2R1bGUgaXMgaW5pdGlhbGl6ZWQKIyBvciBub3QuIElmIG5vdCBpbml0aWFs
aXplZCBpdCBkb2VzIHNvLgppbml0aWFsaXplU3ViTW9kdWxlKCkgewoJaWYgWyAhIC1kICIkMSIv
LmdpdCBdOyB0aGVuCgkJaWYgWyAkcmVjdXJzZV92ZXJib3NlIC1lcSAxIF07IHRoZW4KCQkJZWNo
byBJbml0aWFsaXppbmcgYW5kIHVwZGF0aW5nICIkMSIKCQlmaQoJCWdpdC1zdWJtb2R1bGUgaW5p
dCAiJDEiOyBnaXQtc3VibW9kdWxlIHVwZGF0ZSAiJDEiCglmaQp9CgojIFRoaXMgYWN0dWFsbHkg
dHJhdmVyc2VzIHRoZSBtb2R1bGU7IGNoZWNrcwojIHdoZXRoZXIgdGhlIG1vZHVsZSBpcyBpbml0
aWFsaXplZCBvciBub3QuCiMgaWYgbm90IGluaXRpYWxpemVkLCB0aGVuIGRvbmUgc28gYW5kIHRo
ZW4gdGhlCiMgaW50ZW5kZWQgY29tbWFuZCBpcyBldmFsdWF0ZWQuIFRoZW4gaXQKIyByZWN1cnNp
dmVseSBnb2VzIGludG8gaXQgbW9kdWxlcy4KdHJhdmVyc2VNb2R1bGUoKSB7CgljdXJyZW50X2Rp
cj1gcHdkYAoJZGlyX3BhdGg9IiRjdXJyZW50X2RpcjokZGlyX3BhdGgiCglpbml0aWFsaXplU3Vi
TW9kdWxlICIkMSIKICAgICAgICBjZCAiJDEiCglpZiBbICRyZWN1cnNlX3ZlcmJvc2UgLWVxIDEg
XTsgdGhlbgoJCWVjaG8gV29ya2luZyBpbiBtb2QgJDEgQCBgcHdkYCB3aXRoICQyCglmaQogICAg
ICAgIGV2YWwgIiQyIgoJaWYgWyAtZiAuZ2l0bW9kdWxlcyBdOyB0aGVuCiAgICAgICAgICAgICAg
ICBmb3IgbW9kX3BhdGggaW4gYGdyZXAgInBhdGggPSIgLmdpdG1vZHVsZXMgfCBhd2sgJ3twcmlu
dCAkM30nYDsgZG8KICAgICAgICAgICAgICAgICAgICAgICAgdHJhdmVyc2VNb2R1bGUgIiRtb2Rf
cGF0aCIgIiQyIgogICAgICAgICAgICAgICAgZG9uZQogICAgICAgIGZpCglvbGRfZGlyPSQoZWNo
byAkZGlyX3BhdGggfCBjdXQgLWQnOicgLWYxLTEpCglsZW5ndGhfb2xkX2Rpcj1gZXhwciAiJG9s
ZF9kaXIiIDogJy4qJ2AKCWNkICRvbGRfZGlyCglpbmRleD0kKGVjaG8gIiRsZW5ndGhfb2xkX2Rp
cisyIiB8IGJjKQoJZGlyX3BhdGg9YGVjaG8gJGRpcl9wYXRoICRpbmRleCB8IGF3ayAne3ByaW50
IHN1YnN0cigkMSwgJDIpfSdgCn0KCiMgUHJvcGFnYXRlcyBvciByZWN1cnNlcyBvdmVyIGFsbCB0
aGUgc3VibW9kdWxlcyBhdCBhbnkgCiMgZGVwdGggd2l0aCBhbnkgZ2l0IGNvbW1hbmQsIGUuZy4g
Z2l0LWNsb25lLCBnaXQtc3RhdHVzLAojIGdpdC1jb21taXQgZXRjLiwgd2l0aCB0aGUgYXJndW1l
bnRzIHN1cHBsaWVkIGV4YWN0bHkgYXMKIyBpdCB3b3VsZCBoYXZlIGJlZW4gc3VwcGxpZWQgdG8g
dGhlIGNvbW1hbmQgb3RoZXJ3aXNlLgojIFRoaXMgYWN0dWFsbHkgc3RhcnRzIHRoZSByZWN1cnNp
dmUgcHJvcGFnYXRpb24KcHJvcGFnYXRlKCkgewoJcHJvamVjdF9ob21lPWBwd2RgCgllY2hvIFBy
b2plY3QgSG9tZTogJHByb2plY3RfaG9tZQoJaWYgWyAtZCAkcHJvamVjdF9ob21lLy5naXQvIF07
IHRoZW4KCQlnaXRfY29tbWFuZD0kMQoJCXNoaWZ0CgkJY29tbWFuZF9hcmd1bWVudHM9IiIKCQlm
b3IgYXJnIGluICIkQCI7IGRvCgkJCWlmIFsgYGV4cHIgaW5kZXggIiRhcmciICcgJ2AgLWd0IDAg
XTsgdGhlbgoJCQkJYXJnPSJcIiRhcmdcIiIKCQkJZmkgCgkJCWNvbW1hbmRfYXJndW1lbnRzPSIk
Y29tbWFuZF9hcmd1bWVudHMgJGFyZyIKCQlkb25lCgkJaWYgWyAkcmVjdXJzZV92ZXJib3NlIC1l
cSAxIF07IHRoZW4KCQkJZWNobyBHSVQgQ29tbWFuZCBnaXQtJGdpdF9jb21tYW5kIHdpdGggYXJn
dW1lbnRzXCgkI1wpICIkY29tbWFuZF9hcmd1bWVudHMiCgkJZmkKCQltYWluX2NvbW1hbmQ9Imdp
dC0kZ2l0X2NvbW1hbmQgJGNvbW1hbmRfYXJndW1lbnRzIgoJCWV2YWwgJG1haW5fY29tbWFuZAoJ
CWlmIFsgLWYgLmdpdG1vZHVsZXMgXTsgdGhlbgoJCQlmb3IgbW9kX3BhdGggaW4gYGdyZXAgInBh
dGggPSIgLmdpdG1vZHVsZXMgfCBhd2sgJ3twcmludCAkM30nYDsgZG8KCQkJCXRyYXZlcnNlTW9k
dWxlICRtb2RfcGF0aCAiJG1haW5fY29tbWFuZCIKCQkJZG9uZQoJCWZpCgllbHNlCgkJZWNobyAk
cHJvamVjdF9ob21lIG5vdCBhIGdpdCByZXBvIHRodXMgZXhpdGluZwoJCWV4aXQKCWZpCn0KCnJl
Y3Vyc2VfdmVyYm9zZT0wCndoaWxlIHRlc3QgJCMgIT0gMApkbwoJY2FzZSAiJDEiIGluCglhZGQp
CgkJYWRkPTEKCQk7OwoJaW5pdCkKCQlpbml0PTEKCQk7OwoJdXBkYXRlKQoJCXVwZGF0ZT0xCgkJ
OzsKCXN0YXR1cykKCQlzdGF0dXM9MQoJCTs7CgktcXwtLXF1aWV0KQoJCXF1aWV0PTEKCQk7OwoJ
LWJ8LS1icmFuY2gpCgkJY2FzZSAiJDIiIGluCgkJJycpCgkJCXVzYWdlCgkJCTs7CgkJZXNhYwoJ
CWJyYW5jaD0iJDIiOyBzaGlmdAoJCTs7CgktLWNhY2hlZCkKCQljYWNoZWQ9MQoJCTs7CgktLSkK
CQlicmVhawoJCTs7CgktKikKCQl1c2FnZQoJCTs7CglyZWN1cnNlKQoJCXJlY3Vyc2U9MQoJCWNh
c2UgIiQyIiBpbgoJCQktdikKCQkJCXJlY3Vyc2VfdmVyYm9zZT0xCgkJCQlzaGlmdAoJCQkJOzsK
CQllc2FjCgkJc2hpZnQKCQlicmVhawoJCTs7CgkqKQoJCWJyZWFrCgkJOzsKCWVzYWMKCXNoaWZ0
CmRvbmUKCmNhc2UgIiRhZGQsJGJyYW5jaCIgaW4KMSwqKQoJOzsKLCkKCTs7CiwqKQoJdXNhZ2UK
CTs7CmVzYWMKCgpjYXNlICIkYWRkLCRpbml0LCR1cGRhdGUsJHJlY3Vyc2UsJHN0YXR1cywkY2Fj
aGVkIiBpbgoxLCwsLCwpCgltb2R1bGVfYWRkICIkQCIKCTs7CiwxLCwsLCkKCW1vZHVsZXNfaW5p
dCAiJEAiCgk7OwosLDEsLCwpCgltb2R1bGVzX3VwZGF0ZSAiJEAiCgk7OwosLCwxLCwpCglwcm9w
YWdhdGUgIiRAIgoJOzsKLCwsLCosKikKCW1vZHVsZXNfbGlzdCAiJEAiCgk7OwoqKQoJdXNhZ2UK
CTs7CmVzYWMK
------=_Part_31513_21338067.1199762059763--
