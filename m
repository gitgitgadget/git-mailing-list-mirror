Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B0E21F406
	for <e@80x24.org>; Sat,  9 Dec 2017 22:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751372AbdLIWII (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Dec 2017 17:08:08 -0500
Received: from elephants.elehost.com ([216.66.27.132]:44072 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbdLIWII (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Dec 2017 17:08:08 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [99.229.136.74])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id vB9M85Dr056772
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Sat, 9 Dec 2017 17:08:06 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [Proposed] Externalize man/html ref for quick-install-man and quick-install-html
Date:   Sat, 9 Dec 2017 17:07:57 -0500
Message-ID: <000801d3713a$2f1259d0$8d370d70$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AdNxOh0goyqszi1WQY2QhnIaYv12vw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am proposing the following trivial change to allow the external
specification of the reference used for quick-install-man. The justification
is that I cannot have my production team modifying scripts when non-master
versions of git are installed in production (that violates so many rules
that I would have trouble enumerating). This does add any requirements for
changes to the automation for building either git-manpages or  git-htmldocs.
What it does is allow the top level make to pass GIT_MAN_REF down to the
underlying shell script with a default of master if unspecific. Where I am
uncertain is what else would be required for this change (documentation,
unit tests).

I humbly submit this for consideration.
Sincerely,
Randall

From 6acc4a4238b3e3e62674bf8a5d0b9084258a0967 Mon Sep 17 00:00:00 2001
From: "Randall S. Becker" <rsbecker@nexbridge.com>
Date: Sat, 9 Dec 2017 15:52:44 -0600
Subject: Externalize man/html ref for quick-install-man and
quick-install-html

---
 Documentation/Makefile             | 6 ++++--
 Documentation/install-doc-quick.sh | 7 ++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3e39e28..4f1e6df 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -39,6 +39,8 @@ MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
 MAN_XML = $(patsubst %.txt,%.xml,$(MAN_TXT))
 MAN_HTML = $(patsubst %.txt,%.html,$(MAN_TXT))

+GIT_MAN_REF = master
+
 OBSOLETE_HTML += everyday.html
 OBSOLETE_HTML += git-remote-helpers.html
 DOC_HTML = $(MAN_HTML) $(OBSOLETE_HTML)
@@ -415,14 +417,14 @@ require-manrepo::
        then echo "git-manpages repository must exist at $(MAN_REPO)"; exit
1; fi

 quick-install-man: require-manrepo
-       '$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(MAN_REPO)
$(DESTDIR)$(mandir)
+       '$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(MAN_REPO)
$(DESTDIR)$(mandir) $(GIT_MAN_REF)

 require-htmlrepo::
        @if test ! -d $(HTML_REPO); \
        then echo "git-htmldocs repository must exist at $(HTML_REPO)"; exit
1; fi

 quick-install-html: require-htmlrepo
-       '$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(HTML_REPO)
$(DESTDIR)$(htmldir)
+       '$(SHELL_PATH_SQ)' ./install-doc-quick.sh $(HTML_REPO)
$(DESTDIR)$(htmldir) $(GIT_MAN_REF)

 print-man1:
        @for i in $(MAN1_TXT); do echo $$i; done
diff --git a/Documentation/install-doc-quick.sh
b/Documentation/install-doc-quick.sh
index 327f69b..a7715eb 100755
--- a/Documentation/install-doc-quick.sh
+++ b/Documentation/install-doc-quick.sh
@@ -4,7 +4,8 @@
 repository=${1?repository}
 destdir=${2?destination}

-head=master GIT_DIR=
+GIT_MAN_REF=${3?master}
+GIT_DIR=
 for d in "$repository/.git" "$repository"
 do
        if GIT_DIR="$d" git rev-parse refs/heads/master >/dev/null 2>&1
@@ -27,12 +28,12 @@ export GIT_INDEX_FILE GIT_WORK_TREE
 rm -f "$GIT_INDEX_FILE"
 trap 'rm -f "$GIT_INDEX_FILE"' 0

-git read-tree $head
+git read-tree $GIT_MAN_REF
 git checkout-index -a -f --prefix="$destdir"/

 if test -n "$GZ"
 then
-       git ls-tree -r --name-only $head |
+       git ls-tree -r --name-only $GIT_MAN_REF |
        xargs printf "$destdir/%s\n" |
        xargs gzip -f
 fi
--
2.5.6.18.ga013bef


