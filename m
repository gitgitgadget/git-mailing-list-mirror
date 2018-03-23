Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA2601F404
	for <e@80x24.org>; Fri, 23 Mar 2018 02:09:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751771AbeCWCJo (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 22:09:44 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:41903 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751553AbeCWCJo (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 22 Mar 2018 22:09:44 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6829720D2D;
        Thu, 22 Mar 2018 22:09:43 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Thu, 22 Mar 2018 22:09:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        aaronjgreenberg.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ZuVixVDGYLgtb1m1b
        /L2mch5zuWMzQfFLYoFvb9j0eg=; b=kdYojRH/ipucUMqvp5E/Pq1HlM8s75D4b
        CcVW3DX6j8/OAqcTASdjFZjb91/HK1fTt+fE0tK1mBW8bFvfKsVnMdbSfOnUAvkf
        7ygiGv+DUiZd5nOgvFUtlYWdfMMMcxgxrWtpz4dhKQ6Bsfq+TQtxNis6fuV+tzLo
        LmxozZjvFTwbGmUVafXhvX0srkZjdJEqdleyHSbx/h6C8OH1ms4QBcz7GWmpJ9PC
        h6udrS2Zw7BXTvlhD54//clnBw1oR0LLLjLZDbKl1wSMYASzLJ8wD4twn/Jr+i6B
        krwkWSflnTc1thUSF0yJU1PaU8p1MnNLBgC72ZEmGhTQkRwRgHkEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ZuVixVDGYLgtb1m1b
        /L2mch5zuWMzQfFLYoFvb9j0eg=; b=SOQ3y9EHTEciR/drwjtxfMMXiucbXceyO
        Ez0OqLJsWJ/9Ci5i7K8DK9TB2Ef5z7jIzotX0NZINl/pr20pylyfMCYdf1ler1TY
        ACUHlnOQ4D3T/txKlUJDkEPGobmSJ/gl+VS3rYDPLdz5kOdGzyMWiJgK93miSgSr
        Z/Qxa7wVe+Ys+/MjHg+dJI7jjID4sHZanXpiOciPtdjFe3fBGdOyQmr2MM6e3C1X
        anzplQ4MTxW58e8sm8fcxT57DFIBVaPzV4sCI2MXSXFivJbBkqvf0jsg5BOqBaVm
        3Ec79aYOVgvJ+1PkbbKiM4+nzvuI3Kd7vshaEoAeg6gsgV1dvFjaw==
X-ME-Sender: <xms:52G0Wgl9-H-11JsCK8bC7ff7rUbeCpDgaB3J3K9IpJSb9yGnbmKdHw>
Received: from localhost.localdomain (unknown [159.203.64.218])
        by mail.messagingengine.com (Postfix) with ESMTPA id 113E2240DC;
        Thu, 22 Mar 2018 22:09:43 -0400 (EDT)
From:   Aaron Greenberg <p@aaronjgreenberg.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, p@aaronjgreenberg.com
Subject: [PATCH] branch: implement shortcut to delete last branch
Date:   Fri, 23 Mar 2018 02:09:25 +0000
Message-Id: <1521770966-18383-1-git-send-email-p@aaronjgreenberg.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch gives git-branch the ability to delete the previous
checked-out branch using the "-" shortcut. This shortcut already exists
for git-checkout, git-merge, and git-revert. One of my common workflows
is to do some work on a local topic branch and push it to a remote,
where it gets merged in to 'master'. Then, I switch back to my local
master, fetch the remote master, and delete the previous topic branch.

$ git checkout -b topic-a
$ # Do some work...
$ git commit -am "Implement feature A"
$ git push origin topic-a

# 'origin/topic-a' gets merged into 'origin/master'

$ git checkout master
$ git branch -d topic-a
$ # With this patch, a user could simply type
$ git branch -d -

I think it's a useful shortcut for cleaning up a just-merged branch
(or a just switched-from branch.)

