From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/2] recursive submodules: paths are hard
Date: Fri, 26 Feb 2016 12:51:50 -0800
Message-ID: <1456519912-10641-1-git-send-email-sbeller@google.com>
Cc: jacob.e.keller@intel.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 21:52:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZPMn-0004VA-Qe
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 21:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932771AbcBZUv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 15:51:57 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34712 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754946AbcBZUv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 15:51:57 -0500
Received: by mail-pa0-f49.google.com with SMTP id fy10so56484425pac.1
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 12:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=SV6ohug10HV76DbWgZxMfWsmUS7nOXik/GHIciGkCJw=;
        b=Qf+eokMl59YycYXb+jKpBtf2ftCQyAsbo/WnW6jc+5hFqnLYuHjmrKieduiPmSIeSk
         SfJyiWvw1jbINJ5I8yK8sZ+iC53yYp/1W3AbafMTFB94qvMY1jKyvHVqUKvy1RldTNbm
         rWBxdTqFsSLD1JdaEWaqN2U1qtQe93k8BJUBzbKFebvx7YRlRBtjsco+/UpAqBRxl9+/
         bpot8pSk9JUJSS4rX6R+RUzQ9oYqaRsAkibE3es3YtKnP42YL8mmrFwzEmvL7YGRx8hC
         UpBJVe3pyqDwmkTRIj5N6XZAajTGk7n4qF7JnQs8DsOw4X64oY+FECA48ngoLcvyoYOw
         +wxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SV6ohug10HV76DbWgZxMfWsmUS7nOXik/GHIciGkCJw=;
        b=LISac38vTBNfgAVn4F37SlO3nic1rSawXvZ+0lpJw/t51Z3van6MNr569pyKxkXN3K
         ERYRl/P87IufPqys6QW5r6Ia8AC9DWeDJsj7PQM2cuInfUxTAvoWHDNcCOIW3B1QWgm2
         leRJylGbZqICqvFuPuiB4z4cRuOnoy3e9CJQshrueEN/Pnay1bpC9LK6hqFiFj6nP3CN
         KmBjrU/B/PgvSIKkk7tZlLZMfKaWk1CsSjnqW04IwQSZO2qw349WAQtFOfT5g7dvKC/8
         wjNhcbeOaPgyHAbceK1Elkr4MQfTBncM02WL2cyCrJioUnPB/iVN73YvZIPUIZfCS3gO
         z9lA==
X-Gm-Message-State: AD7BkJK7qSfH0L/0TwsTQqluNnYZPpW/zQxXcWfDDPcEJJWdVZZE9s7UenKJmn88PXVN6aU5
X-Received: by 10.67.4.233 with SMTP id ch9mr4951565pad.29.1456519916227;
        Fri, 26 Feb 2016 12:51:56 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:a09f:64c6:9d8b:3a18])
        by smtp.gmail.com with ESMTPSA id u90sm21293948pfa.60.2016.02.26.12.51.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 Feb 2016 12:51:55 -0800 (PST)
X-Mailer: git-send-email 2.7.2.368.g934fe14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287620>

I thought getting rid of the extra `prefix` argument in submodule helper
functions was easy up to the point of all but one test passing in the test
suite.

It turned out the implementation of that prefix patch was wrong, only caught
by tests, so we want to add tests for subtle details with submodule sync and
update which have not been tests yet.

For the record, I thought the 'prefix' patch was as easy as:

-       git submodule--helper list --prefix "$wt_prefix" "$@" | {
+       git -C "$wt_prefix" submodule--helper list "$@" | {

for all occurrences of `submodule--helper list`.

This is not the case as by doing so the recursive functionality of submodules
is broken in some edge cases.

Consider this sequence:

  mkdir untracked &&
  cd untracked &&
  git submodule <command> --recursive
  
The operation is run from within the work tree, so fro a normal submodule
operation (without --recursive) you expect the pathes to be adapted to be
prefixed by a `../` to make sense relative to the untracked directory.

In the case of recursive submodule operations, currently `git submodule`
usually does

        if test -n "$recursive"
        then
        (
                prefix="$prefix$sm_path/"
                clear_local_git_env
                cd "$sm_path" &&
                eval cmd_update
        )
        
By having a change of directory followed by the recursive call to the operation
we need to make sure the displayed path is still correctly referenced to where
the operation started.

By passing the prefix separately to git submodule--helper, this works currently
as the prefix is only used for calculating the displaypath. If it were passed
by the standard Git machinery, there is going on more, which
fails us at some point.

I think we may need to enable Git to pass in 'negative' pathes for the prefix,
i.e. 
  Although operating on this repository, your reference for displaying paths
  should be '../untracked' for the example above, when the submodule is in the
  root directory of the superproject.

This seems currently not possible with the standard way to pass down the prefix.

TL;DR: Most of the test is unrelated to the patch series, the patch series
adds some tests, which I would have found useful to stop me going the wrong
direction.

Thanks,
Stefan

Stefan Beller (2):
  Check recursive submodule update to have correct path from
    subdirectory
  submodule sync: Test we can pass individual submodules

 t/t7403-submodule-sync.sh   | 13 +++++++++----
 t/t7406-submodule-update.sh | 12 ++++++++++++
 2 files changed, 21 insertions(+), 4 deletions(-)

-- 
2.7.2.368.g934fe14
