From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 02/10] submodule deinit: lose requirement for giving '.'
Date: Fri, 29 Apr 2016 17:40:37 -0700
Message-ID: <1461976845-18228-3-git-send-email-sbeller@google.com>
References: <1461976845-18228-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 02:41:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awIy1-0006bS-7y
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 02:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752890AbcD3Aky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 20:40:54 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33097 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbcD3Akx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 20:40:53 -0400
Received: by mail-pf0-f171.google.com with SMTP id 206so54821531pfu.0
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 17:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p+gLonE0uHK7ZvIcNl6jz3MgQ1b0o0It9VKlUf18phQ=;
        b=Joyc92A+1JhlVw5ZIFXJ9YNjGAc0J5ZIk85H/JYG8rawXYnKc02mufkXQNivtJSFLr
         etrUGIGnHrhycomCxf1U9NsDYEZR2sx9/VIGPeUZ0SvKE66YhAv3LrSFYonzTANTye37
         9QiXjoGgVDftCTmmcxB/rQnmzKIYtfICm3NdzsAV6A5hzE6Xpdgq16X4Ix/i7Oc9L5LD
         cwUsfx7CEx7I5EepPx0mhVMUF/DHxe3Q8CPPw2zfF+O5cPzXvKZ2kky59YJY25z8ZukV
         jE9yGlyeBRXUEjPA3A/uRCryBdJp+RlUGaB370dGflKX0MmwTtKzn4kI7uxaehOre+wY
         jc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p+gLonE0uHK7ZvIcNl6jz3MgQ1b0o0It9VKlUf18phQ=;
        b=Ah/Qa95+zWEzJqHV3qIwekCmYX7vI3YAafapMs+T//QXxENwBqGxv5Tfi6oDdUyXnO
         GwQIOIO473URb5mtIDnGgaKLITSqi5eZFX7qabE0mv+AAm8qqZckPQTruvdX/otOrZtP
         hu1yynZwQDTbtFc5bBB+plkXp9WnXZ0ZgrpNH0DLhzQyBeyNQJZZLTLl/pc42wNGkLPV
         3K1GWWvDpLiZ3MuNX7SbmwTIKZSmBMsNpXbxtX2a0APM1k+TdTkNrLYYxUakxzPi0g+Q
         6MUCuZffxVYeXkNgknH5VVPQPIPui2Jf7a7cdZfkJzM+RyMIVjeDf62ISKn4RD53Iyht
         uIvw==
X-Gm-Message-State: AOPr4FXrbj2g/D6rpewKnbXsZhPoXA5zzkPOEcjhsDi0Qiz8i0J657+1dtpWWKchpXwfVie8
X-Received: by 10.98.17.9 with SMTP id z9mr33703368pfi.40.1461976852256;
        Fri, 29 Apr 2016 17:40:52 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:1c8a:9b5c:52bb:4ac5])
        by smtp.gmail.com with ESMTPSA id h5sm33495601pat.0.2016.04.29.17.40.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 17:40:51 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.32.g71f8beb.dirty
In-Reply-To: <1461976845-18228-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293088>

The discussion in [1] realized that '.' is a faulty suggestion as
there is a corner case where it fails:

> "submodule deinit ." may have "worked" in the sense that you would
> have at least one path in your tree and avoided this "nothing
> matches" most of the time.  It would have still failed with the
> exactly same error if run in an empty repository, i.e.
>
>        $ E=/var/tmp/x/empty && rm -fr "$E" && mkdir -p "$E" && cd "$E"
>        $ git init
>        $ rungit v2.6.6 submodule deinit .
>        error: pathspec '.' did not match any file(s) known to git.
>        Did you forget to 'git add'?
>        $ >file && git add file
>        $ rungit v2.6.6 submodule deinit .
>        $ echo $?
>        0

There is no need to update the documentation as it did not describe the
special case '.' to remove all submodules.

[1] http://news.gmane.org/gmane.comp.version-control.git/289535

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 git-submodule.sh           | 5 -----
 t/t7400-submodule-basic.sh | 1 -
 2 files changed, 6 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 82e95a9..d689265 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -428,11 +428,6 @@ cmd_deinit()
 		shift
 	done
 
-	if test $# = 0
-	then
-		die "$(eval_gettext "Use '.' if you really want to deinitialize all submodules")"
-	fi
-
 	git submodule--helper list --prefix "$wt_prefix" "$@" |
 	while read mode sha1 stage sm_path
 	do
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 90d80d3..a6231f1 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -948,7 +948,6 @@ test_expect_success 'submodule deinit . deinits all initialized submodules' '
 	git submodule update --init &&
 	git config submodule.example.foo bar &&
 	git config submodule.example2.frotz nitfol &&
-	test_must_fail git submodule deinit &&
 	git submodule deinit . >actual &&
 	test -z "$(git config --get-regexp "submodule\.example\.")" &&
 	test -z "$(git config --get-regexp "submodule\.example2\.")" &&
-- 
2.8.0.32.g71f8beb.dirty
