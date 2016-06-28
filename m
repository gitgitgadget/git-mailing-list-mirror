Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26A932018A
	for <e@80x24.org>; Tue, 28 Jun 2016 21:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbcF1VPf (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 17:15:35 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38664 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510AbcF1VPe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 17:15:34 -0400
Received: by mail-wm0-f44.google.com with SMTP id r201so45528168wme.1
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 14:15:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=knZX+WqJAfK51rKD/2YG/j0N/vT0TCo9g3bU+vSLt6E=;
        b=MQzEdcCAZMK8cuKrUALIdQTAfTpXA5CmhYzAODxQd0Q9SlPpw1C93WdLocM8RE7okk
         DmvDmzNswzHsK4G37Y+RlsVcp/JbJi2inEskPcJXizoI+o5f/rT43aaK5njjaHyNac1M
         OE/ROQFnMJJwusvygRHJVXO6RwaxfnQwyzWZWo7G1KkWTZ0dguciL4y48UzRIKHfg4OA
         BPcFu5j1PAPqxCQxBMHGmEIcCtblXeDrsf1cmZ5YptKD0rCq5T3H58dyXlvBVNe6vTzZ
         issjG0sO1vJY6Io/ocgMDj6DD0uilbD6RIirCvdqcTCXu7n+N+P/YiqV3bSDZylz7Utt
         ZH/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=knZX+WqJAfK51rKD/2YG/j0N/vT0TCo9g3bU+vSLt6E=;
        b=GvFGSCMxr9It+RPvhP8VQCR0yIWCvexhyHvHgX9tNdVsrWc4DLAVosd+UrP7auRhrv
         T3lE+w7ZiYPm+x1ZGQUr+jllp4oOU07cwcSpE303cLD+QJVtgQk08qyFyxqML8pdwreY
         RxVJme1gvATEhdpohSxB3Ze7yxjHdI3hOSP1FlfNyo2ysYCdY1+HpnqBrNEcTH9NBUy7
         QpgZwoj8/U1mFKorOUMeXQEldeEKNa4pGfTtXJgc3XFgUAS7RH1Y5igEvnzkTuY+c8Yu
         wZTwwrfeIMQR8ZFXc/fTyHfZPXQj7C0qCR70OFXwmByRSkZBNxjrrmTu3I6ZMAw6GKi0
         +j1w==
X-Gm-Message-State: ALyK8tLkD9wkOFtl2LAqArT18JLVi656SGXbuHQvR7UNzFDt9ZhPM2qRe7C7tB7ArCi1/PGqjh3k8IH1A07tuQ==
X-Received: by 10.28.9.213 with SMTP id 204mr18928630wmj.88.1467148533075;
 Tue, 28 Jun 2016 14:15:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.218.19 with HTTP; Tue, 28 Jun 2016 14:15:32 -0700 (PDT)
From:	Christian Zommerfelds <christian.zommerfelds@gmail.com>
Date:	Tue, 28 Jun 2016 23:15:32 +0200
Message-ID: <CAMS9jjwUmDi=oAi7Ew-b4+ywTLOGSuGx=YPyokpKHMqioNdmRg@mail.gmail.com>
Subject: subtree bug: removing and re-adding a subtree screws up the push
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

Today I realized that when you add a subtree with `git subtree add`,
then remove it with `git rm -r`, then re-add it again, pushing to the
subtree behaves weirdly: it adds the whole history of the main
repository to the sub repository.

Below is a list of commands to reproduce the issue:

```
mkdir myproj
mkdir mylib

cd mylib
touch mylib-file1
git init
git add mylib-file1
git commit -m "mylib initial commit"

cd ../myproj
touch myproj-file1
git init
git add myproj-file1
git commit -m "myproj initial commit"
git subtree add --squash -P contrib/mylib -m "added lib" ../mylib master
git rm -r contrib/mylib
git commit -m "removed lib"
git subtree add --squash -P contrib/mylib -m "re-adding lib" ../mylib master

git subtree push -P contrib/mylib ../mylib test

cd ../mylib
git checkout test
git log | cat
# expected: only "mylib initial commit"
# actual: full history of myproj
```

If you replace the last two occurrences of contrib/mylib by a
different folder such as contrib2/mylib, the push works as usual. I
suspect that subtree splits using the first commit in the subfolder in
the whole history, rather than the first commit after the folder was
last added.

Best regards,
Christian Zommerfelds
