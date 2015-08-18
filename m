From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 0/7] Submodule improvements
Date: Mon, 17 Aug 2015 17:21:56 -0700
Message-ID: <1439857323-21048-1-git-send-email-sbeller@google.com>
Cc: gitster@pobox.com, Jens.Lehmann@web.de, hvoigt@hvoigt.net,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 02:22:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRUfS-0007oZ-Np
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 02:22:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751960AbbHRAWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 20:22:13 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:33082 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbbHRAWM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 20:22:12 -0400
Received: by pdrh1 with SMTP id h1so61810786pdr.0
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 17:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=fZHPoZ0GRnnSUA5rMXO0hWkIMkL4butK2shRYlzN1Zs=;
        b=pSUPZs0Rm7b4lbhaVZLacXiHMgxJvCLvzbxYmjw9n8ZqNMaMxo9SajqXvgeyTfP2C0
         rmFks3Sf+1Uf6QJJdGhHHozvPwu3MSZJtxpPiwahl81u6z8Mz1i9Oi9jzOEQaP6ichS7
         eutcBFaIiWM100b8YYiKlIbKtJlaMisFTyuX/eansN5W20BfqZRg+MXyBvf71zJy52IL
         YIEYqxhUVFJqUGNe9q5LG2tEkp0aE4swXw+QH6UrDJmh31N09XQo14oNTDxe5BdmLLB5
         QO7aU5alFN6NR9v4nnVDwSG9THF834pJRfraxDXJ/F503WuvV1o/lkHckfURQDMjQVyx
         FYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fZHPoZ0GRnnSUA5rMXO0hWkIMkL4butK2shRYlzN1Zs=;
        b=a9cpLmh8MbPzf6FRXVp9V6oe8nrfci4CW0lGwWSmhSggG1nnqi56GAkcKhnemBWucx
         JTuwPK4W8FQttebUxH/l08COYfmwFOcheGBSw/LjIGyCz2Nqc69VGrukCbZlvWOFqitm
         TRky2tYonsFZnUv/78b/xzaKrLqYRDZdg49c+vAnUw0lCOJ7BtA+63PrRtD9Y/eyYXTU
         9XGJGmWIf3qlhD1JB7rJTVAwHuvjEOAaS7F0d9kZnybsJKkGZD2v/hJ9JKxGaY68De2X
         hQ4onFs0PMScTReHH1n+Yv5vTDm+ofTIx0uxHbrHCMwdZqfIEsj9am43cEzHFuMGmtSg
         MNOQ==
X-Gm-Message-State: ALoCoQku4L+Xcw4lq9QBARd0IbwSI3CWPKe68+K9X7qKExEc5+wixQ1Ikp6bTBy5QQJfu8xfR/Mf
X-Received: by 10.70.38.101 with SMTP id f5mr7434387pdk.140.1439857331784;
        Mon, 17 Aug 2015 17:22:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:bca6:6b6f:4dbb:30a3])
        by smtp.gmail.com with ESMTPSA id nj9sm15937558pdb.77.2015.08.17.17.22.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 17:22:10 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.330.g130be8e.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276111>

This series is a reroll consisting of hv/submodule-config and 
sb/submodule-helper and it applies on top of origin/jk/git-path.

Our long term goal is to make submodule handling more scalable
by parallelizing the submodule code. To write good parallelizable
code I'd first want to port it to C, as there are no good portable
solutions for shell scripts to run in parallel. This series is a
first step on porting git-submodule.sh to C.

I did not alter the patches of Heiko, except for squashing
$gmane/275799 (2 cleanup patches I proposed 5 days ago).

The module_{list, name, clone} functions are a direct translation
of the shell counter parts. I took way longer than expected for
module_clone, as I was fighting with absolute and relative paths
for too long. (Whenever shell is translated to C,
I estimate two times the number of lines of code which fits
quite reasonably.)

Thanks,
Stefan

Heiko Voigt (4):
  submodule: implement a config API for lookup of .gitmodules values
  submodule: extract functions for config set and lookup
  submodule: use new config API for worktree configurations
  submodule: Allow errornous values for the fetchrecursesubmodules
    option

Stefan Beller (3):
  submodule: implement `module_list` as a builtin helper
  submodule: implement `module_name` as a builtin helper
  submodule: implement `module_clone` as a builtin helper

 .gitignore                                       |   2 +
 Documentation/technical/api-submodule-config.txt |  62 +++
 Makefile                                         |   3 +
 builtin.h                                        |   1 +
 builtin/checkout.c                               |   1 +
 builtin/fetch.c                                  |   1 +
 builtin/submodule--helper.c                      | 299 ++++++++++++++
 diff.c                                           |   1 +
 git-submodule.sh                                 | 164 +-------
 git.c                                            |   1 +
 submodule-config.c                               | 482 +++++++++++++++++++++++
 submodule-config.h                               |  29 ++
 submodule.c                                      | 122 ++----
 submodule.h                                      |   4 +-
 t/t7411-submodule-config.sh                      | 153 +++++++
 test-submodule-config.c                          |  76 ++++
 16 files changed, 1154 insertions(+), 247 deletions(-)
 create mode 100644 Documentation/technical/api-submodule-config.txt
 create mode 100644 builtin/submodule--helper.c
 create mode 100644 submodule-config.c
 create mode 100644 submodule-config.h
 create mode 100755 t/t7411-submodule-config.sh
 create mode 100644 test-submodule-config.c

-- 
2.5.0.330.g130be8e.dirty
