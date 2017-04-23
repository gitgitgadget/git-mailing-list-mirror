Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A8A5207E2
	for <e@80x24.org>; Sun, 23 Apr 2017 16:01:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1045856AbdDWQBJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Apr 2017 12:01:09 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:33034 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1045854AbdDWQBH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2017 12:01:07 -0400
Received: by mail-vk0-f47.google.com with SMTP id j127so28890921vkh.0
        for <git@vger.kernel.org>; Sun, 23 Apr 2017 09:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Bc7xYABfAmUfYFPBmF5pSEjgKwQRu2Dn9a6F84IbB+M=;
        b=TNObeqv01iNZsrILXAV4i42ISv0dQTjpECiSzQ4WsXAaR8NScXhm1oIG7/sWjcUuql
         7sWWfXPiqm3wgrvpj+HNvQqjtLERRa30nqGleRmYltLGBFBw1ErnDCZamqk20bqeZJ6K
         ObriiQ2WPEej3qpO0Va6sxGDbo3+5I75VIQULv4Krbo8L0ncwtR4MdtZ8SF7+PNvuA4v
         uxG6o6TiD+dx+0LFM3lMuPjj1RWPHSXvS0YXyHMLslBjvTzF78Bqzz/ZPCUPt3VY1wA0
         qzTZ3bmKfVBghsl5PPXMZx6xB0aAO/aoek76A2jhnPPFr6XTuTa5xv0UMtOVOxwlle/v
         UTpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Bc7xYABfAmUfYFPBmF5pSEjgKwQRu2Dn9a6F84IbB+M=;
        b=RETK6Ngupbh34OaSv7Yd2iNPVn11Cnfim1eiR59RRTMb2YVXROkSmF6JQ+BjJpFL54
         ZxE4O1X6RZ1iXzhVWC9b032N/chPwABMVKU1MrM9jd0c1w0hTgLYikcQFl5KBVFduOoS
         +mxol0YHk6uC54YiEUNOpmOCCVYuaMXZQ8a9AjbhltFXgFNsOVpuo4AbGA3SZnO+6nxE
         NAGF5CqBnB16EBqZWXwEUsG3Xd/cz55EpYc7DwoE7UBGLNMEk1GVuklPAv7/dDyo5r+c
         0F0ImMApAMVM2JTMqd8WyhoV5AN4MCWkwAuv7icbPbGrxoXTtt5J1U7YL0Z5Nl5yudev
         pvzg==
X-Gm-Message-State: AN3rC/6T1ZXh55AB/ED38m/GUU01UQbnIe2+XCe+1syU/RtdDxzBfNYn
        IKXTSm9QhHM8mr2AP1z/OjsbDzwhPWor2Eg=
X-Received: by 10.31.140.131 with SMTP id o125mr279148vkd.100.1492963265663;
 Sun, 23 Apr 2017 09:01:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.80.73 with HTTP; Sun, 23 Apr 2017 09:01:05 -0700 (PDT)
From:   vvs <vvs009@gmail.com>
Date:   Sun, 23 Apr 2017 19:01:05 +0300
Message-ID: <CAM1zWBtfgHT=pT0pidQo1HD=DfrXLG3gNaUvs0vZKvYfG1BHFw@mail.gmail.com>
Subject: Logical inconsistency in git reset
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear list

Like it was suggested on git-users list I'm forwarding the original
message here.

I found out that "git reset --hard" produced different outcome
depending on current index content, i.e. when there is no entry for a
file in working tree it actually changed that file. While on the
contrary, if you use "git reset --mixed" right before that, the file
won't be touched. This affects make, which thinks that the file was
changed.

More detailed discussion and test cases can be found here:
https://groups.google.com/forum/?hl=en#!topic/git-users/9ziZ6yq-BfU

I could just add to that argument that this issue is certainly looks
like a logical inconsistency to an average user. The git operations
are checking an index entry for the file in working tree but they
doesn't fill that entry in the first place. Shouldn't this be
considered as a kind of uninitialized pointer problem? And there is
that useful abstraction that --hard should include --mixed semantics.
