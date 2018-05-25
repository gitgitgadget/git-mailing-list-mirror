Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01BD41F42D
	for <e@80x24.org>; Fri, 25 May 2018 03:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964791AbeEYDuf (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 23:50:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:6227 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932570AbeEYDuc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 23:50:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 May 2018 20:50:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,438,1520924400"; 
   d="scan'208";a="58357659"
Received: from jfdmzpr03.jf.intel.com (HELO mchikara-mobl3.gar.corp.intel.com) ([10.7.210.22])
  by fmsmga001.fm.intel.com with ESMTP; 24 May 2018 20:50:29 -0700
Subject: Re: Wrong -dirty suffix set by setlocalversion (was: BUG in git
 diff-index)
To:     Mike Mason <michael.w.mason@intel.com>
Cc:     andy.work@nglowry.com, git@vger.kernel.org, gitster@pobox.com,
        josh@joshtriplett.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, lists@nerdbynature.de, peff@peff.net,
        nico-linuxsetlocalversion@schottelius.org
References: <89d82c84-7a3b-9c4c-679e-a7a723669592@intel.com>
 <20180524230334.12452-1-michael.w.mason@intel.com>
From:   Marc Herbert <Marc.Herbert@intel.com>
Message-ID: <0dc31052-4cfd-3b92-0a4a-96c8ecfafff6@intel.com>
Date:   Thu, 24 May 2018 20:50:28 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180524230334.12452-1-michael.w.mason@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/05/2018 16:03, Mike Mason wrote:

> diff --git a/scripts/setlocalversion b/scripts/setlocalversion
> index 71f39410691b..9da4c5e83285 100755
> --- a/scripts/setlocalversion
> +++ b/scripts/setlocalversion
> @@ -73,8 +73,10 @@ scm_version()
>  			printf -- '-svn%s' "`git svn find-rev $head`"
>  		fi
>  
> -		# Check for uncommitted changes
> -		if git diff-index --name-only HEAD | grep -qv "^scripts/package"; then
> +		# Check for uncommitted changes. Only check mtime and size.
> +       # Ignore insequential ctime, uid, gid and inode differences.
> +		if git -c "core.checkstat=minimal" diff-index --name-only HEAD | \
> +				grep -qv "^scripts/package"; then
>  			printf '%s' -dirty
>  		fi

FWIW:

Reported-by: Marc.Herbert@intel.com
Reviewed-by: Marc.Herbert@intel.com  (assuming a future and decent commit message)
Tested-by: Marc.Herbert@intel.com


So the real use case is making a copy of a whole tree before building.
Typical in automated builds, old example:
https://groups.google.com/a/chromium.org/d/msg/chromium-os-dev/zxOa0OLWFkw/N_Sb7EZOBwAJ 

Here's a more complex but faster and more transparent way to test Mike's fix
than copying an entire tree:

# Make sure you start from a clean state
git describe --dirty      # must not -dirty

make prepare

# Simulate a copy of the tree but with just one file
rsync --perms --times  README   README.mtime_backup
rm  README
rsync --perms --times  README.mtime_backup   README
stat  README  README.mtime_backup 

# Demo the BUG fixed by Mike
./scripts/setlocalversion # -dirty BUG! because spurious inode ctime difference
git diff-index  HEAD
git describe --dirty      # not -dirty
./scripts/setlocalversion # not -dirty any more cause describe refreshed index

# Make sure mtime still causes -dirty with AND without Mike's fix
touch README
./scripts/setlocalversion # -dirty
