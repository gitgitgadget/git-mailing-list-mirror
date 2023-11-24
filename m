Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTR2+z9C"
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2689AD7E
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 22:14:28 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5094cb3a036so2046513e87.2
        for <git@vger.kernel.org>; Thu, 23 Nov 2023 22:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700806466; x=1701411266; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lmX63OWHCuy2gK0Y2fZfgCKOKOe/EUM1SnxrxAQTx8=;
        b=dTR2+z9Co8D6L7zsBB+vLnh07FdQNIbUkzFe2NuHlkPpo9Q4ERm8NythfmNeXVz0nm
         AevVGTbt2a9Nbw256/i4VDa++ANcjIpZUcliU//csMEcZNkbGKCl8KJgSjKYdp4Q52D4
         xuDNkVnaAPk0dSxtTHqxgR+iMaTFV20ma08CwRgBNvvxtIEp5+cHGgvjIEKBWAuvHhbt
         e/7kFMwXmuKmMnTdFJC7feeb8AvOizKI1mgy20l4+6GFSfreSRsUHT5gUO+3sCM+uH6h
         pPX34ps9aHf1T3ULVVTvcrHqrK+omnFzK6Hpvi2PpU8X8Pkf0owbJcnli2sMFgCjVsau
         HpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700806466; x=1701411266;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lmX63OWHCuy2gK0Y2fZfgCKOKOe/EUM1SnxrxAQTx8=;
        b=JJWr3emC7TlSk9Dua6oYjqUI+cOzOtZN3pHNiMSn8STWeaZZWRqPUpjQunBRyKhbXz
         u2TKT1vaIJpCFVjcNZkdIUWdh21OjiVT4aLR2CZCo3JQqRjUHrACcvYeQU6Ss8vNPj/X
         fFxb/XlIolgIYgA5ICDhUKv0KY5KpDOEaBWQAbpIxQ8DZ34/+7JIINpFl6+IRKsi2fmh
         ybGlVrQQG3KEZ3a4Akyo9XZPYFkh0KGgRvwtRASczGS72SafyPsieku6An3iWWz7woOC
         LdPMylIQZMzk2tfubJxg/f9CkXnFx8ghaGnMVnvv29lZdOrdw8kmv2sGDI7hA/0syEn2
         99bg==
X-Gm-Message-State: AOJu0Ywqea06X6qHa2ndJVJUAYQJZKG2tKpOVvZZsUPW8+gRjSGvpvST
	xJjbq+gKDCr0AYvUHWEob3x+kL3YDYQ=
X-Google-Smtp-Source: AGHT+IFCpPYfi5fcx+cJf2ZDK2viQpyTNWKo/wd4tUAIjmarZL+qHCmw4c9IPEfr7XmcmGabs2XweQ==
X-Received: by 2002:a05:6512:3d0f:b0:50a:6793:6954 with SMTP id d15-20020a0565123d0f00b0050a67936954mr1196349lfv.9.1700806465885;
        Thu, 23 Nov 2023 22:14:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g21-20020a05600c311500b0040b3645a7c2sm4039632wmo.40.2023.11.23.22.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 22:14:25 -0800 (PST)
Message-ID: <pull.1609.v2.git.git.1700806464802.gitgitgadget@gmail.com>
In-Reply-To: <pull.1609.git.git.1700639764041.gitgitgadget@gmail.com>
References: <pull.1609.git.git.1700639764041.gitgitgadget@gmail.com>
From: "Alisha Kim via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Nov 2023 06:14:24 +0000
Subject: [PATCH v2] git-p4: fix fast import when empty commit is first
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Alisha Kim <pril@pril.cc>,
    Alisha Kim <pril@pril.cc>

From: Alisha Kim <pril@pril.cc>

When executing p4 sync by specifying an excluded path, an empty commit
will be created if there is only a change in the excluded path in
revision.
If git-p4.keepEmptyCommits is turned off and an empty commit is the
first, fast-import will fail. Change the return type of the commit
function from void to bool and return whether a commit has been
created. This failure was prevented by modifying initialParent
to be initialized only when a commit was actually created.

Signed-off-by: Alisha Kim <pril@pril.cc>
---
    git-p4: fix fast import when empty commit is first
    
    When executing p4 sync by specifying an excluded path, an empty commit
    will be created if there is only a change in the excluded path in
    revision. If git-p4.keepEmptyCommits is turned off and an empty commit
    is the first, fast-import will fail. Change the return type of the
    commit function from void to bool and return whether a commit has been
    created. This failure was prevented by modifying initialParent to be
    initialized only when a commit was actually created.
    
    The error log is as follows Ignoring revision 14035 as it would produce
    an empty commit. fast-import failed: warning: Not updating
    refs/heads/p4/master (new tip new commit hash does not contain parent
    commit hash) fast-import statistics: ...

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1609%2Fdaebo01%2Fgit-p4-pr-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1609/daebo01/git-p4-pr-v2
Pull-Request: https://github.com/git/git/pull/1609

Range-diff vs v1:

 1:  f7c4fa18c4c ! 1:  1de9ac6dbf8 git-p4: fix fast import when empty commit is first
     @@ Commit message
          will be created if there is only a change in the excluded path in
          revision.
          If git-p4.keepEmptyCommits is turned off and an empty commit is the
     -    first, fast-import will fail.
     +    first, fast-import will fail. Change the return type of the commit
     +    function from void to bool and return whether a commit has been
     +    created. This failure was prevented by modifying initialParent
     +    to be initialized only when a commit was actually created.
      
          Signed-off-by: Alisha Kim <pril@pril.cc>
      
     @@ git-p4.py: class P4Sync(Command, P4UserMap):
                       else:
                           files = self.extractFilesFromCommit(description)
      -                    self.commit(description, files, self.branch,
     -+                    isCommitted = self.commit(description, files, self.branch,
     ++                    haveCommitted = self.commit(description, files, self.branch,
                                       self.initialParent)
                           # only needed once, to connect to the previous commit
      -                    self.initialParent = ""
     -+                    if isCommitted:
     ++                    if haveCommitted:
      +                        self.initialParent = ""
      +
                   except IOError:


 git-p4.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 0eb3bb4c47d..1e3c0e815f0 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3466,7 +3466,7 @@ class P4Sync(Command, P4UserMap):
         if not files and not allow_empty:
             print('Ignoring revision {0} as it would produce an empty commit.'
                 .format(details['change']))
-            return
+            return False
 
         self.gitStream.write("commit %s\n" % branch)
         self.gitStream.write("mark :%s\n" % details["change"])
@@ -3533,6 +3533,8 @@ class P4Sync(Command, P4UserMap):
                     print("Tag %s does not match with change %s: file count is different."
                            % (labelDetails["label"], change))
 
+        return True
+
     def getLabels(self):
         """Build a dictionary of changelists and labels, for "detect-labels"
            option.
@@ -3876,10 +3878,12 @@ class P4Sync(Command, P4UserMap):
                             self.commit(description, filesForCommit, branch, parent)
                 else:
                     files = self.extractFilesFromCommit(description)
-                    self.commit(description, files, self.branch,
+                    haveCommitted = self.commit(description, files, self.branch,
                                 self.initialParent)
                     # only needed once, to connect to the previous commit
-                    self.initialParent = ""
+                    if haveCommitted:
+                        self.initialParent = ""
+
             except IOError:
                 print(self.gitError.read())
                 sys.exit(1)

base-commit: cfb8a6e9a93adbe81efca66e6110c9b4d2e57169
-- 
gitgitgadget
