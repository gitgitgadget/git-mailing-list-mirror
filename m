Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC5DC4360C
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 09:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0795561025
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 09:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239913AbhDLJSd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 05:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241785AbhDLJRR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 05:17:17 -0400
X-Greylist: delayed 1373 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Apr 2021 02:15:55 PDT
Received: from adoakley.name (adoakley.name [IPv6:2a01:4f8:c17:1310::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248CBC06138C
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 02:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=adoakley.name; s=2018; h=Content-Transfer-Encoding:MIME-Version:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/2MTTj/K5o9oDBPH0hjt+nB36EUXyxjd5Fkly9wuj0g=; b=TjiKxfLQu6p/uwn1mBvngtYFYV
        f70Qzqwy7nZEFE0xBtTuON16O3C/3bgUgMq5nxsHui2/JR1VKsR1uI9UI0JJqg6UD694xQH9GrdHe
        wUfzkKI28rfkRJfUdUL2XxsN8qrrJQPj/jeg2f+6MNRXJTnV7s/zilPUloeAxfSNGwJc=;
Received: from [2001:8b0:14bb:e93b::df1] (helo=ado-tr.ado-tr.lan)
        by adoakley.name with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93.0.4)
        (envelope-from <andrew@adoakley.name>)
        id 1lVsJX-0000qB-Ca; Mon, 12 Apr 2021 08:52:59 +0000
From:   Andrew Oakley <andrew@adoakley.name>
To:     git@vger.kernel.org
Cc:     Luke Diamand <luke@diamand.org>, Feiyang Xue <me@feiyangxue.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Subject: [PATCH 1/2] git-p4: avoid decoding more data from perforce
Date:   Mon, 12 Apr 2021 09:52:50 +0100
Message-Id: <20210412085251.51475-2-andrew@adoakley.name>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210412085251.51475-1-andrew@adoakley.name>
References: <20210412085251.51475-1-andrew@adoakley.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Perforce does not validate or store the encoding of user submitted data
by default (although this can be enabled).  In large repositories it is
therefore very likely that some data will not be valid UTF-8.

Historically (with python2) git-p4 did not attempt to decode the data
from the perforce server - it just passed bytes from perforce to git,
preserving whatever was stored in perforce.  This seems like a sensible
approach - it avoids any loss of data, and there is no way to determine
the intended encoding for any invalid data from perforce.

This change updates git-p4 to avoid decoding changelist descriptions,
user and time information.  The time data is almost certainly valid
unicode, but as they are processed with the user information it is more
convenient for them to be handled as bytes.

Signed-off-by: Andrew Oakley <andrew@adoakley.name>
---
 git-p4.py                          | 57 +++++++++++++++---------------
 t/t9835-git-p4-message-encoding.sh | 48 +++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 28 deletions(-)
 create mode 100755 t/t9835-git-p4-message-encoding.sh

diff --git a/git-p4.py b/git-p4.py
index 09c9e93ac4..8407ec5c7a 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -764,13 +764,15 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False,
         while True:
             entry = marshal.load(p4.stdout)
             if bytes is not str:
-                # Decode unmarshalled dict to use str keys and values, except for:
-                #   - `data` which may contain arbitrary binary data
-                #   - `depotFile[0-9]*`, `path`, or `clientFile` which may contain non-UTF8 encoded text
+                # Decode unmarshalled dict to use str keys and values, except
+                # for cases where the values may not be valid UTF-8.
+                binary_keys = ('data', 'path', 'clientFile', 'Description',
+                               'desc', 'Email', 'FullName', 'Owner', 'time',
+                               'user', 'User')
                 decoded_entry = {}
                 for key, value in entry.items():
                     key = key.decode()
-                    if isinstance(value, bytes) and not (key in ('data', 'path', 'clientFile') or key.startswith('depotFile')):
+                    if isinstance(value, bytes) and not (key in binary_keys or key.startswith('depotFile')):
                         value = value.decode()
                     decoded_entry[key] = value
                 # Parse out data if it's an error response
@@ -949,11 +951,11 @@ def gitConfigInt(key):
             _gitConfig[key] = None
     return _gitConfig[key]
 
-def gitConfigList(key):
+def gitConfigList(key, raw=False):
     if key not in _gitConfig:
-        s = read_pipe(["git", "config", "--get-all", key], ignore_error=True)
+        s = read_pipe(["git", "config", "--get-all", key], ignore_error=True, raw=raw)
         _gitConfig[key] = s.strip().splitlines()
-        if _gitConfig[key] == ['']:
+        if _gitConfig[key] == [''] or _gitConfig[key] == [b'']:
             _gitConfig[key] = []
     return _gitConfig[key]
 
@@ -1499,35 +1501,35 @@ def getUserMapFromPerforceServer(self):
         for output in p4CmdList("users"):
             if "User" not in output:
                 continue
-            self.users[output["User"]] = output["FullName"] + " <" + output["Email"] + ">"
+            self.users[output["User"]] = output["FullName"] + b" <" + output["Email"] + b">"
             self.emails[output["Email"]] = output["User"]
 
-        mapUserConfigRegex = re.compile(r"^\s*(\S+)\s*=\s*(.+)\s*<(\S+)>\s*$", re.VERBOSE)
-        for mapUserConfig in gitConfigList("git-p4.mapUser"):
+        mapUserConfigRegex = re.compile(br"^\s*(\S+)\s*=\s*(.+)\s*<(\S+)>\s*$", re.VERBOSE)
+        for mapUserConfig in gitConfigList("git-p4.mapUser", raw=True):
             mapUser = mapUserConfigRegex.findall(mapUserConfig)
             if mapUser and len(mapUser[0]) == 3:
                 user = mapUser[0][0]
                 fullname = mapUser[0][1]
                 email = mapUser[0][2]
-                self.users[user] = fullname + " <" + email + ">"
+                self.users[user] = fullname + b" <" + email + b">"
                 self.emails[email] = user
 
-        s = ''
+        s = b''
         for (key, val) in self.users.items():
-            s += "%s\t%s\n" % (key.expandtabs(1), val.expandtabs(1))
+            s += b"%s\t%s\n" % (key.expandtabs(1), val.expandtabs(1))
 
-        open(self.getUserCacheFilename(), 'w').write(s)
+        open(self.getUserCacheFilename(), 'wb').write(s)
         self.userMapFromPerforceServer = True
 
     def loadUserMapFromCache(self):
         self.users = {}
         self.userMapFromPerforceServer = False
         try:
-            cache = open(self.getUserCacheFilename(), 'r')
+            cache = open(self.getUserCacheFilename(), 'rb')
             lines = cache.readlines()
             cache.close()
             for line in lines:
-                entry = line.strip().split("\t")
+                entry = line.strip().split(b"\t")
                 self.users[entry[0]] = entry[1]
         except IOError:
             self.getUserMapFromPerforceServer()
@@ -1780,7 +1782,7 @@ def p4UserForCommit(self,id):
         # Return the tuple (perforce user,git email) for a given git commit id
         self.getUserMapFromPerforceServer()
         gitEmail = read_pipe(["git", "log", "--max-count=1",
-                              "--format=%ae", id])
+                              "--format=%ae", id], raw=True)
         gitEmail = gitEmail.strip()
         if gitEmail not in self.emails:
             return (None,gitEmail)
@@ -1911,7 +1913,7 @@ def prepareSubmitTemplate(self, changelist=None):
             template += key + ':'
             if key == 'Description':
                 template += '\n'
-            for field_line in change_entry[key].splitlines():
+            for field_line in decode_text_stream(change_entry[key]).splitlines():
                 template += '\t'+field_line+'\n'
         if len(files_list) > 0:
             template += '\n'
@@ -2163,7 +2165,7 @@ def applyCommit(self, id):
            submitTemplate += "\n######## Actual user %s, modified after commit\n" % p4User
 
         if self.checkAuthorship and not self.p4UserIsMe(p4User):
-            submitTemplate += "######## git author %s does not match your p4 account.\n" % gitEmail
+            submitTemplate += "######## git author %s does not match your p4 account.\n" % decode_text_stream(gitEmail)
             submitTemplate += "######## Use option --preserve-user to modify authorship.\n"
             submitTemplate += "######## Variable git-p4.skipUserNameCheck hides this message.\n"
 
@@ -2802,7 +2804,7 @@ def __init__(self):
         self.knownBranches = {}
         self.initialParents = {}
 
-        self.tz = "%+03d%02d" % (- time.timezone / 3600, ((- time.timezone % 3600) / 60))
+        self.tz = b"%+03d%02d" % (- time.timezone / 3600, ((- time.timezone % 3600) / 60))
         self.labels = {}
 
     # Force a checkpoint in fast-import and wait for it to finish
@@ -3161,7 +3163,7 @@ def make_email(self, userid):
         if userid in self.users:
             return self.users[userid]
         else:
-            return "%s <a@b>" % userid
+            return b"%s <a@b>" % userid
 
     def streamTag(self, gitStream, labelName, labelDetails, commit, epoch):
         """ Stream a p4 tag.
@@ -3184,9 +3186,9 @@ def streamTag(self, gitStream, labelName, labelDetails, commit, epoch):
             email = self.make_email(owner)
         else:
             email = self.make_email(self.p4UserId())
-        tagger = "%s %s %s" % (email, epoch, self.tz)
+        tagger = b"%s %s %s" % (email, epoch, self.tz)
 
-        gitStream.write("tagger %s\n" % tagger)
+        gitStream.write(b"tagger %s\n" % tagger)
 
         print("labelDetails=",labelDetails)
         if 'Description' in labelDetails:
@@ -3279,12 +3281,11 @@ def commit(self, details, files, branch, parent = "", allow_empty=False):
         self.gitStream.write("commit %s\n" % branch)
         self.gitStream.write("mark :%s\n" % details["change"])
         self.committedChanges.add(int(details["change"]))
-        committer = ""
         if author not in self.users:
             self.getUserMapFromPerforceServer()
-        committer = "%s %s %s" % (self.make_email(author), epoch, self.tz)
+        committer = b"%s %s %s" % (self.make_email(author), epoch, self.tz)
 
-        self.gitStream.write("committer %s\n" % committer)
+        self.gitStream.write(b"committer %s\n" % committer)
 
         self.gitStream.write("data <<EOT\n")
         self.gitStream.write(details["desc"])
@@ -3422,7 +3423,7 @@ def importP4Labels(self, stream, p4Labels):
                         print("Could not convert label time %s" % labelDetails['Update'])
                         tmwhen = 1
 
-                    when = int(time.mktime(tmwhen))
+                    when = b"%i" % int(time.mktime(tmwhen))
                     self.streamTag(stream, name, labelDetails, gitCommit, when)
                     if verbose:
                         print("p4 label %s mapped to git commit %s" % (name, gitCommit))
@@ -3708,7 +3709,7 @@ def importHeadRevision(self, revision):
         print("Doing initial import of %s from revision %s into %s" % (' '.join(self.depotPaths), revision, self.branch))
 
         details = {}
-        details["user"] = "git perforce import user"
+        details["user"] = b"git perforce import user"
         details["desc"] = ("Initial import of %s from the state at revision %s\n"
                            % (' '.join(self.depotPaths), revision))
         details["change"] = revision
diff --git a/t/t9835-git-p4-message-encoding.sh b/t/t9835-git-p4-message-encoding.sh
new file mode 100755
index 0000000000..93f24fe295
--- /dev/null
+++ b/t/t9835-git-p4-message-encoding.sh
@@ -0,0 +1,48 @@
+#!/bin/sh
+
+test_description='Clone repositories with non ASCII commit messages'
+
+. ./lib-git-p4.sh
+
+UTF8="$(printf "a-\303\244_o-\303\266_u-\303\274")"
+ISO8859="$(printf "a-\344_o-\366_u-\374")"
+
+test_expect_success 'start p4d' '
+	start_p4d
+'
+
+test_expect_success 'create commits in perforce' '
+	(
+		cd "$cli" &&
+
+		p4_add_user "${UTF8}" &&
+		p4_add_user "${ISO8859}" &&
+
+		>dummy-file1 &&
+		P4USER="${UTF8}" p4 add dummy-file1 &&
+		P4USER="${UTF8}" p4 submit -d "message ${UTF8}" &&
+
+		>dummy-file2 &&
+		P4USER="${ISO8859}" p4 add dummy-file2 &&
+		P4USER="${ISO8859}" p4 submit -d "message ${ISO8859}"
+	)
+'
+
+test_expect_success 'check UTF-8 commit' '
+	(
+		git p4 clone --destination="$git/1" //depot@1,1 &&
+		git -C "$git/1" cat-file commit HEAD | grep -q "^message ${UTF8}$" &&
+		git -C "$git/1" cat-file commit HEAD | grep -q "^author Dr. ${UTF8} <${UTF8}@example.com>"
+	)
+'
+
+test_expect_success 'check ISO-8859 commit' '
+	(
+		git p4 clone --destination="$git/2" //depot@2,2 &&
+		git -C "$git/2" cat-file commit HEAD > /tmp/dump.txt &&
+		git -C "$git/2" cat-file commit HEAD | grep -q "^message ${ISO8859}$" &&
+		git -C "$git/2" cat-file commit HEAD | grep -q "^author Dr. ${ISO8859} <${ISO8859}@example.com>"
+	)
+'
+
+test_done
-- 
2.26.3

