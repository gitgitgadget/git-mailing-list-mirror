From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] submodule: Try harder to fetch needed sha1 by direct fetching sha1
Date: Mon, 22 Feb 2016 14:35:48 -0800
Message-ID: <1456180548-20996-3-git-send-email-sbeller@google.com>
References: <1456180548-20996-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, dborowitz@google.com,
	jacob.keller@gmail.com, Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 22 23:37:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXz6v-00088t-EG
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 23:37:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756200AbcBVWhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 17:37:32 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35092 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755725AbcBVWh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 17:37:29 -0500
Received: by mail-pf0-f178.google.com with SMTP id c10so103143768pfc.2
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 14:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wQohfx51gikHWm0s3jD9WiRpnrsip3R6qix1SuNrlKw=;
        b=TdRMEM+E/hGHlGRuTspPKvwe11nMpi9Ztrm7Xy+BFJtQ72jx+hd1+Rj+20jOuh886O
         5MlWFA3gbSu1kCNVUUa46+IhmKrZD4t1aXMrEM/3ZOcTHzoqQQ5RMQA1MdoKKP/94m5Y
         QKxeosGqaLP3f0tTK24CECl4BiPCiQMw5dYoimYMenjc97SF4PKtSh0HgNmoYtiLy0DV
         46H3mfSkCFFHuXJ3L1qGiuQegAlhIzKeoax3c/6qp4ooKjnjd2RqXcz83BhgzCCXjkpf
         afErQAi7UtY1QUmKPzckKh1xvXLbQf4mgOjM17odzEFMBQZrl8CdQRGiU0UBCU6FLVEL
         i6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wQohfx51gikHWm0s3jD9WiRpnrsip3R6qix1SuNrlKw=;
        b=gd+IKYQtwaPB75a6wlo+dYD+fIBg+6n7XGQaRrk6bXFPXte8M7Z1fQeOG6zx0romac
         /7gBhlhz6vPTPxPxMI7CHdqE2c0fudansDtu3AYUydFXSL9uqBE1B6NJimgVjVoUtRRv
         pwF6tNO8AOWApHI/Zu8A2SuKnqyEQq6ki/iv2TJ+btkoBTIGT9ANLuUbVxZS3CTagIWf
         NklEyh2g+OL6V88dv5tGswLcCvRSUsdTFP0tAyODmSDhHLRvn3hJ6DPMuTkeRf/Gk3HK
         ZSGEIGslW1/AUfauIth9HPVPPBGsmagvEsnmaOgVYVZUIX6QJw+lIMIHjIsLVZfwjsap
         RKzw==
X-Gm-Message-State: AG10YOREexfhezycWL4vWnzpsKKiNeb7Pdq8T7ngUlt4wMhO+dOJXZ9dJHGXlC2PWyfLsxGK
X-Received: by 10.98.67.8 with SMTP id q8mr41580471pfa.133.1456180648793;
        Mon, 22 Feb 2016 14:37:28 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c420:8149:fd30:c3e3])
        by smtp.gmail.com with ESMTPSA id tb10sm39360858pab.22.2016.02.22.14.37.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 Feb 2016 14:37:28 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.34.ga06e0b3.dirty
In-Reply-To: <1456180548-20996-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286966>

When reviewing a change in Gerrit, which also updates a submodule,
a common review practice is to download and cherry-pick the patch locally
to test it. However when testing it locally, the 'git submodule update'
may fail fetching the correct submodule sha1 as the corresponding commit
in the submodule is not yet part of the project history, but also just a
proposed change.

If $sha1 was not part of the default fetch, we try to fetch the $sha1
directly. Some servers however do not support direct fetch by sha1, which
leads git-fetch to fail quickly. We can fail ourselves here as the still
missing sha1 would lead to a failure later in the checkout stage anyway,
so failing here is as good as we can get.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

We may want to discuss the error message. It is the same as in the case
before (git-fetch <no args>), this is good for translation, but may be bad
for the user as we may want to give extra information.
("We fetched for you and it worked, however the sha1 was not included,
so we fetched again the server broke it, so we error out.  You used to
see error message: ....")

Although this may be too much information?

Thanks,
Stefan

 git-submodule.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index f5d6675..f021fe3 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -749,6 +749,13 @@ Maybe you want to use 'update --init'?")"
 					( (rev=$(git rev-list --objects -n 1 $sha1 --not --all 2>/dev/null) &&
 					 test -z "$rev") || git-fetch)) ||
 				die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
+
+				# In case the sha1 is still missing, try harder
+				# by fetching the sha1 directly.
+				(clear_local_git_env; cd "$sm_path" &&
+					( (rev=$(git rev-list --objects -n 1 $sha1 --not --all 2>/dev/null) &&
+					 test -z "$rev") || git-fetch $(get_default_remote) $sha1 )) ||
+				die "$(eval_gettext "Unable to fetch in submodule path '\$displaypath'")"
 			fi
 
 			# Is this something we just cloned?
-- 
2.7.0.rc0.34.ga06e0b3.dirty
