From: Lars Schneider <larsxschneider@gmail.com>
Subject: [RFC] How to pass Git config command line instructions to Submodule commands?
Date: Mon, 25 Apr 2016 12:39:48 +0200
Message-ID: <60724588-B06E-47E8-9302-8709C4601826@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Stefan Beller <sbeller@google.com>
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 25 12:39:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1audvm-0001L5-Tq
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 12:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbcDYKjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 06:39:51 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35518 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754325AbcDYKju convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2016 06:39:50 -0400
Received: by mail-wm0-f45.google.com with SMTP id e201so80727614wme.0
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 03:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version;
        bh=7orbnASZey5N8EswLCAe5YVBeufKygvdALX1ovRvg84=;
        b=CybSmz/TX9KmuIHixNI/nsILHAxdaIe4CUFaLzw5QmPLWZy/1F71w/JXo3dL0eu8vk
         fdsTVPBxIJ6BhgvSDdOtdOtQOM3eVbL9a3wYScvcb2mNy9UDFG1pAJmK++KCk3zNpris
         2vLhYyoPGX/JLrNRnnsfMibu7xK/b1FNFCfnwaCznw/1Y1+ZIgv/JS4ZfLZuBHrm10kW
         NaT2Bj4rY0pYH9l4IzecmiSMVjqUSkHhJ/LXktv8prmK8aRYnnaFAxT5yb4geTdUO9UU
         ihPngLDHB4flzubRainNQKr0R8wTaIQIJWI605Q5l8OCiB3sy3rj0sfWrZN6pVfftknh
         Tzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:content-transfer-encoding:subject:date
         :message-id:cc:to:mime-version;
        bh=7orbnASZey5N8EswLCAe5YVBeufKygvdALX1ovRvg84=;
        b=MYM73egq7FzdTa5ujr6PqdknIjxWnGOS78n71SBd7oJ0AL9BaWSHmki2xlZVTSlUQc
         yWGRxnQebJzkTQtHpyqTAnlA2ADcu+lPKMBTVu8Et/Lo9XuqO2HFI/FAyWZlWiGfexYl
         cvTx+4qEJ8RdnOYzaYHrasm3pvFaD785RIWDijG/ixRkubgaEVQM+ox39BkfATj7h/gu
         Zc0lKMICvIALzTUYEPk1Eqno3lsn01bmAbPfA8IMhoMf6y572ntY4zLJATdj/Ykh8AxV
         kOVN7raSOoUJBd8n0aISKEyFr3e5CARK1snUA1PGrZtaIUme8jq3YvwYWNDxcpoL6RsK
         O6wQ==
X-Gm-Message-State: AOPr4FXJmj+DLrS7pe5zpOXp7TzwGlloV4E5q5YV2digezSRyVD/MTrInTwxKaKI8uqKbg==
X-Received: by 10.28.135.200 with SMTP id j191mr11845416wmd.54.1461580788589;
        Mon, 25 Apr 2016 03:39:48 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id a207sm13219507wma.8.2016.04.25.03.39.47
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Apr 2016 03:39:47 -0700 (PDT)
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292466>

Hi,

a few folks from the Git LFS project and I try to make cloning of repositories 
with a lot of LFS files faster. 

The core problem is that Git LFS uses a Git smudge filter to replace LFS 
pointers with the actual file content. Right now, a smudge filter can only 
be executed on an individual file which makes the operation slow for many 
files [1].

We solved this issue by temporarily disabling the smudge filter for the clone 
command via Git config (optimized in 1a8630 [2]):

    git -c filter.lfs.smudge= -c filter.lfs.required=false clone <url> <path>

Afterwards Git LFS runs a special command to download and replace all LFS 
content in bulk [3]. This works great for LFS repositories.

However, I noticed that git config command line instructions such as 
"-c filter.lfs.smudge=" are not passed to Git submodule operations. Thus
this does not work as expected:

    git -c filter.lfs.smudge= -c filter.lfs.required=false clone --recursive <url> <path>

I tried to work around that by copying the relevant pieced from the Git 
Submodule command [4] and applying the command line Git config
manually (look closely at the modified checkout command):

    git -c filter.lfs.smudge= -c filter.lfs.required=false clone $@
    if [[ -z $2 ]]; then
        CLONE_PATH=$(basename ${1%.git});
    else
        CLONE_PATH=$2;
    fi
    pushd "$CLONE_PATH"
        git submodule init
        wt_prefix=$(git rev-parse --show-prefix)
        git submodule--helper list --prefix "$wt_prefix" | {
            while read mode sha1 stage sm_path
            do
                name=$(git submodule--helper name "$sm_path") || exit
                url=$(git config submodule."$name".url)
                if ! test -d "$sm_path"/.git && ! test -f "$sm_path"/.git
                then
                    git submodule--helper clone --prefix "$wt_prefix" --path "$sm_path" --name "$name" --url "$url"
                    pushd "$sm_path"
                        git -c filter.lfs.smudge= -c filter.lfs.required=false checkout -q $sha1 || exit
                        git-lfs pull || exit
                    popd
                fi
            done
        }
    popd

Do you see an easier way to pass command line Git config instructions to the 
underlaying Git Submodule commands? If not, do you think a patch adding this
would be worth working on?

I also started a discussion about that on the Git LFS issue page [5].

Thanks,
Lars


[1] https://github.com/github/git-lfs/issues/931
[2] https://github.com/git/git/commit/1a8630dc3b1cc6f1361a4e5d94630133c24c97d9
[3] https://developer.atlassian.com/blog/2016/04/git-lfs-12-clone-faster/
[4] https://github.com/git/git/blob/6a6636270fbaf74609cd3e1bd207dd2c420d640a/git-submodule.sh#L686-L731
[5] https://github.com/github/git-lfs/issues/1172
