Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 285D7209FC
	for <e@80x24.org>; Tue, 18 Apr 2017 13:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756592AbdDRNEb (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 09:04:31 -0400
Received: from [195.159.176.226] ([195.159.176.226]:54525 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1751467AbdDRNEa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 09:04:30 -0400
Received: from list by blaine.gmane.org with local (Exim 4.84_2)
        (envelope-from <gcvg-git-2@m.gmane.org>)
        id 1d0Snu-0004Vl-H9
        for git@vger.kernel.org; Tue, 18 Apr 2017 15:04:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     git@vger.kernel.org
From:   Sebastian Schuberth <sschuberth@gmail.com>
Subject: Failed shallow submodule clone for fixed SHA1 falls back to checking
 out HEAD
Date:   Tue, 18 Apr 2017 15:04:17 +0200
Message-ID: <605bb444-8d8c-7fea-d3b8-6f8414636d87@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@blaine.gmane.org
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
Cc:     Stefan Beller <sbeller@google.com>
X-Mozilla-News-Host: news://news.gmane.org:119
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

this is using "git version 2.12.2.windows.2" on Windows / "git version 2.12.2-639-g584f897" on Linux.

I have configured my superproject with .gitmodules saying

---8<---
[submodule "src/funTest/resources/projects/external/jgnash"]
       path = src/funTest/resources/projects/external/jgnash
       url = https://github.com/ccavanaugh/jgnash.git
       shallow = true
---8<---

and configured the submodule to checkout commit 2aa4cce7d7fd46164030f2b4d244c4b89e77f722 [1]. When doing a fresh clone of my superproject via "git clone --recursive" I get

---8<---
error: Server does not allow request for unadvertised object 2aa4cce7d7fd46164030f2b4d244c4b89e77f722
Fetched in submodule path 'src/funTest/resources/projects/external/jgnash', but it did not contain 2aa4cce7d7fd464030f2b4d244c4b89e77f722. Direct fetching of that commit failed.
---8<---

So far so good, it simply seems that GitHub does not support allowReachableSHA1InWant [2]. The interesting bit is that my submodule checkout still ends up being shallow, but poiting to HEAD:

---8<---
$ cd src/funTest/resources/projects/external/jgnash
$ git log
commit 12036fffb6c620515edd96416363fd1749b5d003 (grafted, HEAD -> master, origin/master, origin/HEAD)
Author: Craig Cavanaugh <jgnash.devel@gmail.com>
Date:   Tue Apr 18 05:33:06 2017 -0400

    Fix typos
---8<---

Wouldn't it make more sense to unshallow the submodule clone in this case and checkout the configured commit 2aa4cce7d7fd46164030f2b4d244c4b89e77f722 afterwards? At least I'd be getting what I asked for in that case, even if at the cost of additional network traffic. Because if I read [3] correctly, the command line option belonging to "submodule.<name>.shallow" is called "--[no-]recommend-shallow", i.e. it's only a recommendation, to falling back to a full clone should be fine.

[1] https://github.com/ccavanaugh/jgnash/commit/2aa4cce7d7fd46164030f2b4d244c4b89e77f722
[2] https://git-scm.com/docs/git-config#git-config-uploadpackallowReachableSHA1InWant
[3] https://git-scm.com/docs/git-submodule

Regards,
Sebastian


