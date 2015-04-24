From: Marc Khouzam <marc.khouzam@gmail.com>
Subject: [PATCH] Completion: Cleanup tcsh script and add debug flag
Date: Thu, 23 Apr 2015 21:07:28 -0400
Message-ID: <CAFj1UpGpGS-C2EWif4sk_ijq8PjpM1UY09+vLwbjX17idZdkfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 24 03:07:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlS5k-0007gj-RA
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 03:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791AbbDXBHa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 21:07:30 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35102 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328AbbDXBHa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2015 21:07:30 -0400
Received: by widdi4 with SMTP id di4so4075150wid.0
        for <git@vger.kernel.org>; Thu, 23 Apr 2015 18:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=htZXacIzCPyQfAsmYG7UhrFjuFbBBhP8QOMstd2s/PU=;
        b=fqJDfeyrT9bkK5e88jdJxnwa5iABIk1h1i7ValyTB8O+zmGIGW8wF/OVox0oKK9M2u
         KAvgjxicy9jz6zh04ylybH8AnRRn75Ekm78Tm/AAOc67IlSXP47VaWs6A2JyvlmaV6Xg
         LHIjKAlfj2VfXk3gpB+kGPrZqfvKBKvPEB4loVeq0M0SqJy+13Q+PYgZjzl3YtcNgkjZ
         B3OX9WLWQ4zPeOdpgj/juexRlsPNSa4ICL7OSus2onRQRVDZR73uczBX7X4yTijLF7Yy
         lI3WscJEbQjHWU8GnCV+eFeqLAoNfhZE4x/sSqXlpTJwGamMWkinEplR5PRIcGZYJfJI
         QuEg==
X-Received: by 10.180.83.130 with SMTP id q2mr1627415wiy.89.1429837648910;
 Thu, 23 Apr 2015 18:07:28 -0700 (PDT)
Received: by 10.28.176.5 with HTTP; Thu, 23 Apr 2015 18:07:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267716>

Remove overriding of __git_index_file_list_filter
since that method is no longer used in git-completion.bash.
Overriding that method was needed before to get
git-completion.bash to append a '/' to the end
of directories; this does not seem to be needed anymore since
that script no longer provides completions of directories/files.

Also add -d/--debug flag support to help troubleshoot
the script.

Signed-off-by: Marc Khouzam <marc.khouzam@gmail.com>
---

I thought this would help when for people that experience issues with
the script.

Thanks!

Marc

 contrib/completion/git-completion.tcsh |   50 +++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 10 deletions(-)

diff --git a/contrib/completion/git-completion.tcsh
b/contrib/completion/git-completion.tcsh
index 6104a42..fd0b906 100644
--- a/contrib/completion/git-completion.tcsh
+++ b/contrib/completion/git-completion.tcsh
@@ -1,6 +1,6 @@
 # tcsh completion support for core Git.
 #
-# Copyright (C) 2012 Marc Khouzam <marc.khouzam@gmail.com>
+# Copyright (C) 2012, 2015 Marc Khouzam <marc.khouzam@gmail.com>
 # Distributed under the GNU General Public License, version 2.0.
 #
 # When sourced, this script will generate a new script that uses
@@ -22,6 +22,25 @@
 #       add the following line to your .tcshrc/.cshrc:
 #        set autolist=ambiguous
 #       It will tell tcsh to list the possible completion choices.
+#
+# To debug this script one can use the -d flag by running the
+# generated final script directly.  For example, to see the completions
+# generated when pressing <tab> for the command line:
+#     git co
+# one should run:
+#     bash ~/.git-completion.tcsh.bash -d git 'git co'
+# and will obtain:
+#     =====================================
+#     git-completion.bash returned:
+#     commit  config
+#     =====================================
+#     Completions including tcsh additions:
+#     commit  config
+#     =====================================
+#     Final completions returned:
+#     commit
+#     config
+#

 set __git_tcsh_completion_version = `\echo ${tcsh} | \sed 's/\./ /g'`
 if ( ${__git_tcsh_completion_version[1]} < 6 || \
@@ -48,20 +67,17 @@ cat << EOF > ${__git_tcsh_completion_script}
 # Do not modify it directly.  Instead, modify git-completion.tcsh
 # and source it again.

+# Allow for debug printouts when running the script by hand
+if [ "\$1" == "-d" ] || [ "\$1" == "--debug" ]; then
+       __git_tcsh_debug=true
+       shift
+fi
+
 source ${__git_tcsh_completion_original_script}

 # Remove the colon as a completion separator because tcsh cannot handle it
 COMP_WORDBREAKS=\${COMP_WORDBREAKS//:}

-# For file completion, tcsh needs the '/' to be appended to directories.
-# By default, the bash script does not do that.
-# We can achieve this by using the below compatibility
-# method of the git-completion.bash script.
-__git_index_file_list_filter ()
-{
-       __git_index_file_list_filter_compat
-}
-
 # Set COMP_WORDS in a way that can be handled by the bash script.
 COMP_WORDS=(\$2)

@@ -83,6 +99,12 @@ fi
 # Call _git() or _gitk() of the bash script, based on the first argument
 _\${1}

+if [ "\$__git_tcsh_debug" == "true" ]; then
+       echo =====================================
+       echo git-completion.bash returned:
+       echo "\${COMPREPLY[@]}"
+fi
+
 IFS=\$'\n'
 if [ \${#COMPREPLY[*]} -eq 0 ]; then
        # No completions suggested.  In this case, we want tcsh to perform
@@ -108,6 +130,14 @@ if [ \${#COMPREPLY[*]} -eq 0 ]; then
        fi
 fi

+if [ "\$__git_tcsh_debug" == "true" ]; then
+       echo =====================================
+       echo Completions including tcsh additions:
+       echo "\${COMPREPLY[@]}"
+       echo =====================================
+       echo Final completions returned:
+fi
+
 # tcsh does not automatically remove duplicates, so we do it ourselves
 echo "\${COMPREPLY[*]}" | sort | uniq
