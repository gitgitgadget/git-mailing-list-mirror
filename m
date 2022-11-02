Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF944C4332F
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 15:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiKBPTA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 11:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiKBPSu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 11:18:50 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81311CB17
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 08:18:36 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-36cbcda2157so168915197b3.11
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 08:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hDVeiN2T47cLqf/azwT9xRfdVs96XtcJIHA6i6mlcW4=;
        b=NK6VNQy7Od5Gj//oe80ZcF1vi3lB7I20SCm5OmyKA72MOZNQ+MTAXtOSK/kK4P6Q50
         92S8ffNPB6MkitW2bq9j8bJTFL73KwfloPRkeOIwjAnm64xw3LUHH6A8lFXbVlZWivzv
         FWjUynUyEa4PcktShwMVTwg3xpp3nXPHHJvaIWIEtQ9dOeooRJdFAkzAF77ednquhwP3
         6XWDQAiml6DzWlolNhfrQ3a5k4timbjdT15uFXVG7fA11CoSKfYoZpbyvQvgZtK17q3W
         8aHsrJJyK0OfzkBa/L1B5QdczHzP1Ud6K6LKA5XJtNOIe2Coaxq8BN8/jQGAjvVWUobF
         vaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hDVeiN2T47cLqf/azwT9xRfdVs96XtcJIHA6i6mlcW4=;
        b=umNAfeKIyQGNLw07B6rKM+rWyNYChDGsbGzETCDsnxWlA+AOV7qwk692qiyXoRX/KV
         M4c7fm3+OyOcYgD+CdYnH9XO/0/LzAsyovuXH3s5lDWIKJFyZf1Z5eIji0chJ6wC2381
         qeE5F3c8YTNAywf6Ij8nJnW8IgV8w8faY6j+O3VijPHZ3tOSnDFQuCa+x4j9R9xBIsAZ
         80l7Li16lCnqIVRVJzhoU8b8g8S9vw4az0t7LgGFqjtfPfCZlSw6rEoeOMyQFzvG0cjI
         NEGfblzDUUublmiqvy5hEy7t15KzfeYhZElNBNotdxdOvlkXLAzUnOdO7NOVdwnuUgvE
         nb9Q==
X-Gm-Message-State: ACrzQf1ZAqeAdnw8OhaCuq7WhzRsIHO8OkJE0OZe6iXNUUGbnKCzo+RI
        RQ6nniCl6keKjVwvji4MQ8ht6Btr5b8vVtmXukkUlw8HSVav1zSIzKY=
X-Google-Smtp-Source: AMsMyM7V/2uK9r2pkMw3dVVGSS+Zsz7Iiedm3voQWH/nn5KzpX9TScIre0McBoQRIydm+QykjtpqQu76ASr2OqnCljE=
X-Received: by 2002:a81:6d8e:0:b0:36e:6926:d1a7 with SMTP id
 i136-20020a816d8e000000b0036e6926d1a7mr24883377ywc.33.1667402315921; Wed, 02
 Nov 2022 08:18:35 -0700 (PDT)
MIME-Version: 1.0
From:   John Soo <johh.soo@arista.com>
Date:   Wed, 2 Nov 2022 08:18:25 -0700
Message-ID: <CAJyRyRo7oVAfLx8MONO=Y8KhLvL+tJgDTbCUezR1AFa73R5pbw@mail.gmail.com>
Subject: safe.directory and ACLs
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello git!

We have some build processes that would like access to repos in /home
directories that are 0700. We had done this already:

$ setfacl --recursive --modify group:<build users
group>:r-X,default:group:<build users group>:r-X /home

Should this ACL be enough to consider the repos "owned" by the build
users? Should *any* ACL be enough to consider the repos "owned" by the
build users?

Currently:
$ sudo -u <build user> git config --get safe.directory
$ sudo -u <build user> git -C /home/<non build user>/repo rev-parse HEAD
fatal: unsafe repository ('/home/<non build user>/repo' is owned by
someone else)
To add an exception for this directory, call:

        git config --global --add safe.directory /home/<non build user>

Kindly,

John Soo
