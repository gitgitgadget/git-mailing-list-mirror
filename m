From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 9/9] Add a validation script
Date: Wed, 14 Jul 2010 01:36:16 +0200
Message-ID: <1279064176-6645-10-git-send-email-artagnon@gmail.com>
References: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, avarab@gmail.com,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Bert Huijben <rhuijben@collab.net>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Will Palmer <wpalmer@gmail.com>, Greg Stein <gstein@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 14 01:36:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYp1t-0008BW-RH
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 01:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757297Ab0GMXgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 19:36:47 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:39996 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757226Ab0GMXgj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 19:36:39 -0400
Received: by mail-ew0-f46.google.com with SMTP id 23so1272362ewy.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 16:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=120P1VrC/w3nFys4Sp2wPNM80b4eQwI8chuDZHYjrWo=;
        b=rMTuNjZ39nrptr6SuUSeNozSbd3N96D+oxbVFP3/RBzfzzShaN5nRJXugax18SnEC4
         ebZBCWik5eRvghctVwaMp+a/htrTKtUCCrHlaleWupuGPtKLWTrtS3Z4yE4ezwCXiJTC
         tZko7hsE/PykcGv7Ng3MyBZd+kW4izcjnMsZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QNgWpNOCsKUYPQAFbovVdCK5VdgCQmU1MtkaoSYpKKSd+7SgRF9jaVJCNjUjPI8PqS
         hs9bYOXiQrMTkPiOXc6ATFeSTwU0kp5hLkJCb4/SYjEgaTKx0QJMSQtP2KaNc526TgLR
         AqaDa9QY8FvywetPQ7ci/8YqKPUER2EozWwnA=
Received: by 10.213.16.135 with SMTP id o7mr1030974eba.70.1279064198703;
        Tue, 13 Jul 2010 16:36:38 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id a48sm51487409eei.6.2010.07.13.16.36.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 13 Jul 2010 16:36:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150949>

From: Will Palmer <wpalmer@gmail.com>

Add a validation script. Using an existing dump known to be correct
(possibly generated using `svnsync` and `svnadmin dump --deltas`), it
compares the outputs produced by `svnadmin load` when fed with this
dump and the dump from the program.

The arguments added are:
    --svnadmin-dump=<file>      existing "svnadmin dump"
    --svndumpr-dump=<file>      existing "svndumpr" dump
    --repos=<url-or-path>       SVN repos URL, or local repos
    -r<revision>                end revision to dump/cut
    --ignore-existing           regenerate svnadmin-dump even if
                                it already exists
    --make                      run "make svndumpr" prior to svnrdump
    generate                    as with the old parameter, but now
                                implied by default
    validate                    as with the old parameter, but now
                                implied by default

The end result is that the only step technically needed to test
validation is:

./validate.sh --make --repos=/path/to/local/repos

Signed-off-by: Will Palmer <wpalmer@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 validate.sh |  226 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 226 insertions(+), 0 deletions(-)
 create mode 100755 validate.sh

diff --git a/validate.sh b/validate.sh
new file mode 100755
index 0000000..6bdb427
--- /dev/null
+++ b/validate.sh
@@ -0,0 +1,226 @@
+#!/bin/sh
+usage(){
+	sed 's/..//' <<USAGE
+		Usage: validate.sh [--svnadmin-dump=<file>] [--svnrdump-dump=<file>]
+		                   [--repos=<url-or-path>] [-r<revision>]
+		                   [--ignore-existing-dump] [--make]
+		                   [generate] [validate]
+USAGE
+}
+
+svnadmin_dump=
+svnrdump_dump=
+repos_url=
+repos_path=
+end_rev=
+do_make=
+do_both=1
+do_generate=1
+do_validate=1
+do_ignore_existing_svnadmin_dump=
+while test "$#" -gt 0; do
+	case "$1" in
+	--svnadmin-dump=*)
+		svnadmin_dump="${1#*=}"
+		;;
+	--svnrdump-dump=*)
+		svnrdump_dump="${1#*=}"
+		;;
+	--ignore-existing|--ignore-existing-dump)
+		do_ignore_existing_svnadmin_dump=1
+		;;
+	--repos=*)
+		repos_url="${1#*=}"
+		repos_protocol="${repos_url%://*}"
+		repos_path="${repos_url#file://}"
+		if test "$repos_protocol" = "$repos_path"; then
+			repos_protocol=
+			repos_url=
+		elif test ! "$repos_protocol" = 'file'; then
+			repos_path=
+		fi
+		;;
+	-r*)
+		end_rev="${1#-r}"
+		;;
+	--make)
+		do_make=1
+		;;
+	generate)
+		do_generate=1
+		test -n "$do_both" && do_validate=
+		do_both=
+		;;
+	validate)
+		do_validate=1
+		test -n "$do_both" && do_generate=
+		do_both=
+		;;
+	-h|--help)
+		usage
+		exit
+		;;
+	*)
+		echo "unknown option $1" >&2
+		usage >&2
+		exit 1
+	esac
+	shift
+done
+
+if test -z "$svnrdump_dump"; then
+	if test -z "$repos_url"; then
+		if test -n "$repos_path"; then
+			repos_url="file://$(readlink -f "$repos_path")"
+			if test $? -ne 0; then
+				echo "error: unable to derive repos url from path" >&2
+				echo "--svnrdump_dump=<file> or a local (file://) --repos=<url> is required" >&2
+				exit 1
+			fi
+		else
+				echo "--svnrdump_dump=<file> or a local (file://) --repos=<url> is required" >&2
+				exit 1
+		fi
+	fi
+fi
+
+svnadmin_dump_cut="t/svnadmin-$end_rev.dump"
+svnrdump_dump_cut="t/svnrdump-$end_rev.dump"
+mkdir t 2>/dev/null
+
+if test -z "$svnadmin_dump"; then
+	if test -z "$repos_path"; then
+		echo "--svnadmin_dump=<file> or a local (file://) --repos=<url> is required" >&2
+		usage >&2
+		exit 1
+	fi
+
+	svnadmin_dump="$svnadmin_dump_cut"
+	if test -z "$do_ignore_existing_svnadmin_dump" && test -r "$svnadmin_dump"; then
+		echo "Using existing $svnadmin_dump"
+	else
+		echo "Generating $svnadmin_dump ..."
+
+		r=
+		if test -n "$end_rev"; then
+			r="-r0:$end_rev"
+		else
+			r="-r0:HEAD"
+		fi
+
+		svnadmin dump --deltas $r "$repos_path" > "$svnadmin_dump"
+		if test $? -ne 0; then
+			echo "error: failed to create canonical dump for comparison" >&2
+			exit 1
+		fi
+	fi
+else
+	echo "Using specified $svnadmin_dump"
+fi
+
+if test -z "$svnrdump_dump"; then
+	svnrdump_dump="$svnrdump_dump_cut"
+
+	if test -n "$do_make"; then
+		make svnrdump > /dev/null;
+		if test $? -ne 0; then
+			echo "error: Make failed. Check the program." >&2
+			exit 1;
+		fi
+	fi
+
+	echo "Generating $svnrdump_dump ..."
+
+	r=
+	test -n "$end_rev" && r="-r0:$end_rev"
+
+	./svnrdump -v $r "$repos_url" > "$svnrdump_dump"
+	if test $? -ne 0; then
+		echo "error: failed to create dump for validation" >&2
+		exit 1
+	fi
+else
+	echo "Using specified $svnrdump_dump"
+fi
+
+cut_dump(){
+	r="$1"
+	test -z "$r" && r=-1
+
+	gawk '
+		BEGIN {
+			max='"$r"'
+			hit_max=0
+		}
+		/^Revision-number: [0-9][0-9]*$/ {
+		rev=$2
+			if (rev == max) {
+				hit_max=1
+			} else if ( hit_max ) {
+				exit
+			}
+		}
+		{ print $0 }
+		END {
+			if (max == -1 || hit_max) {
+				exit 0
+			}
+			exit 1
+		}'
+}
+
+if test ! "$svnadmin_dump" = "$svnadmin_dump_cut"; then
+	cut_dump "$end_rev" <"$svnadmin_dump" >"$svnadmin_dump_cut"
+	if test $? -ne 0; then
+		echo "error: failed to cut canonical dump $svnadmin_dump for comparison" >&2
+		exit 1
+	fi
+	echo "Successfully generated cut canonical dump $svnadmin_dump_cut for comparison" >&2
+fi
+
+echo "Comparing canonical and svnrdump-based dumps..."
+diff -au "$svnadmin_dump_cut" "$svnrdump_dump" > t/dump-diff.error
+gawk \
+	'$0 !~ "Prop-delta: true|Text-delta-base-|sha1|Text-copy-source-|^-$" && $0 ~ "^+|^-" { print; }' \
+	t/dump-diff.error >t/dump-diff-filtered.error;
+
+if test -n "$do_generate"; then
+	echo "Generating canonical import logs..."
+
+	rm -rf t/repo;
+	mkdir t/repo;
+	svnadmin create t/repo;
+
+	svnadmin load t/repo < "$svnadmin_dump_cut" \
+	    1>"$svnadmin_dump_cut.import.log" 2>"$svnadmin_dump_cut.import.error";
+	if test $? -ne 0; then
+		echo "error: Load $end_rev failed. See $svnadmin_dump_cut.import.* for details" >&2
+		exit 1
+	fi
+	echo "Successfully generated canonical repository for comparison."
+fi
+
+if test -n "$do_validate"; then
+	echo "Generating svnrdump-based import logs..."
+
+	log_prefix=t/svnrdump-$end_rev
+
+	rm -rf t/repo;
+	mkdir t/repo;
+	svnadmin create t/repo;
+
+	svnadmin load t/repo < "$svnrdump_dump" 1>"$log_prefix.import.log" 2>"$log_prefix.import.error";
+	if test $? -ne 0; then
+		echo "error: Load $end_rev failed. See $log_prefix.import.* for details" >&2
+		exit 1
+	fi
+	echo "Successfully loaded svnrdump-based repository for validation"
+
+	echo "Comparing canonical and svnrdump-based import logs..."
+	diff -au "$svnadmin_dump_cut.import.log" "$log_prefix.import.log" > t/import-diff.error;
+	if test $? -ne 0; then
+		echo "Validation failed. See t/import-diff.error for details." >&2
+		exit 1
+	fi
+	echo "Validation successful"
+fi
-- 
1.7.1
