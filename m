Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746BDC4332F
	for <git@archiver.kernel.org>; Sun, 11 Dec 2022 21:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiLKVSJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Dec 2022 16:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLKVSH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Dec 2022 16:18:07 -0500
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 11 Dec 2022 13:18:03 PST
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DF3CE25
        for <git@vger.kernel.org>; Sun, 11 Dec 2022 13:18:03 -0800 (PST)
Received: (wp-smtpd smtp.tlen.pl 36182 invoked from network); 11 Dec 2022 22:11:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1670793080; bh=ZFN/fCReIJ1HrHy6fwkpFzb3oSMAe3d7I2LkBMKMKh4=;
          h=To:From:Subject;
          b=GjvjmEEL+4dhufk/X4dsZEp3S/P4WygFrkhlwxn/m2QIPuWt+7SOodVQzXCrkMMNM
           OrUsltHfLl+pVJRm4AHvMS1ShV15gBuEkEa2HsH0kFG7GiBets62jB4ik171opVHZ9
           9ByX3QvItHv3oYT88osWf63gR82hVD0T1Ncm+pt8=
Received: from mail.dtcasino.pl (HELO [192.168.1.5]) (piotrekkr@o2.pl@[212.180.138.13])
          (envelope-sender <piotrekkr@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <git@vger.kernel.org>; 11 Dec 2022 22:11:20 +0100
Message-ID: <51d5993f-a1e0-519e-ffa9-ec5205c5e96d@o2.pl>
Date:   Sun, 11 Dec 2022 22:11:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-GB-large
To:     git@vger.kernel.org
From:   Piotrek <piotrekkr@o2.pl>
Subject: Issue with git > 2.36.1 and pre-commit hook on macOS M1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-WP-MailID: 04da83e7259c37060abcd21ce8819c34
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000001 [kWKF]                               
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello.

On MacOS 12.6.1 with M1 chip, git >=2.37.0 (installed by homebrew) and 
pre-commit hook that is calling *make* target, that is calling *docker 
compose run* command, we get error:

     the input device is not a TTY

All works file with homebrew git version 2.36.1


* DETAILS OF PROBLEM *

There is pre-commit hook in place that is using bash script to call 
`make` command which is in turn calling `docker compose run` to run some 
check before commit. After upgrading git version from `2.36.1` to 
`>=2.37` we constantly get error:

 > the input device is not a TTY

Example pre-commit hook output:

 > docker compose run --rm --entrypoint "" app /code/test.sh
 > the input device is not a TTY
 > make: *** [Makefile:6: check] Error 1
 > !!! FAILING REGARDLESS OF CHECK RESULT !!!

(the latest error message is just so we don't actually commit anything)

AFAIK `docker compose` command is auto-detecting TTY because no `-t` or 
`-T` were set.

By doing some tests we managed to check that it is a problem with `git` 
version.

Latest version that it worked was `2.36.1`:

 > docker compose run --rm --entrypoint "" app /code/test.sh
 > =================== CHECK OK =================
 > !!! FAILING REGARDLESS OF CHECK RESULT !!!

Machine and software we were testing on:

 > make --version
 > GNU Make 3.81
 >
 > docker compose version
 > Docker Compose version v2.12.2
 >
 > git --version
 > git version 2.38.1
 >
 > which git
 > /opt/homebrew/bin/git

Also, we tested with linux Ubuntu and all git versions are working fine 
with same pre-commit hook. It seems related to `macOS` and `git` only.

* REPLICATING THIS PROBLEM *

Easiest way top replicate is to just clone sample repo I prepared here:

https://github.com/piotrekkr/git-tty-issue-macos

and go with replicate instructions from README.md.

If this is not okay then below I will copy and paste instruction with 
file contents.


* FILES *


* Makefile *

     COMPOSE_RUN = docker compose run --rm --entrypoint ""
     check:
     	$(COMPOSE_RUN) app /code/test.sh



* docker-compose.yml *

     version: "3.7"
     services:
     app:
         image: php:8.1.3-fpm-bullseye
         volumes:
         - "${PWD}:/code"
         working_dir: /code


* .git/hooks/pre-commit *

     #!/usr/bin/env bash

     make check

     echo "!!! FAILING REGARDLESS OF CHECK RESULT !!!"
     exit 1


* test.sh *

     #!/usr/bin/env bash

     echo "=================== CHECK OK ================="


(sorry for attaching like that, I'm not good with those plain text mail 
lists)

* INSTRUCTIONS *

1. have macOS with M1 chip (can be expensive)
2. install `docker`, `docker compose v2`, `make`
3. upgrade git with homebrew to version `>=2.37.0`
4. clone repo or manually create files (in same directory)
    - Makefile
    - docker-compose.yml
    - .git/hooks/pre-commit (with execute permissions)
    - test.sh
5. if using repo, copy pre commit script to `.git/hooks` directory

     cp pre-commit-hook.sh .git/hooks/pre-commit
     chmod +x .git/hooks/pre-commit

6. Try to commit and you should get TTY error
7. Switch git to `2.36.1` version (seems to be only possible by `brew 
extract`)

     brew tap-new --no-git $USER/local-tap
     brew extract --version=2.36.1 git $USER/local-tap
     brew install git@2.36.1
     brew link --overwrite git@2.36.1

8. Try committing again, TTY problem should be fixed


Let me know if you need more details etc.

Regards
Piotrek
