Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B34AFC433EF
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 23:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A4D6604AC
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 23:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbhIEXL3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 19:11:29 -0400
Received: from mail.archlinux.org ([95.216.189.61]:33262 "EHLO
        mail.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhIEXL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 19:11:28 -0400
X-Greylist: delayed 560 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Sep 2021 19:11:28 EDT
To:     git@vger.kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1630882863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DtjDzs2Mu/uQ7u1/C9vEScfF9PbN0RXYxLV+QH3PzWQ=;
        b=DVHndPwvX/eNmmGABUkMZaYWOyIeokEH5gssX6RKdxkKLQguklqb5r0k9+5xeQEkOaP+Hm
        0C1OGXcJhb/US+NN8Kv2YxnGIWr6ouvt3EW7iGdCYxt/+5UDrI2I4pXYmgcZAxYK+cdf8q
        zzE8RsfpPBzpKe7waNdtE++CBJAr6v8FKWmwPMZYrUXMeKrG8OUG/Wn695m03Mmzbb8h/p
        Nv6D3nsunZ/donZNPwIyJFlWkRwen0t7Ms0RrhS9ev+uMtseRoMIkU+AoiRWX1e7UanN3t
        jH2rS/ncqUazU1frtSLnpkuG5wI1ePtNcBZ/1QxJNrQSONAYXo30d3k57BDRieb6Uq1Gcp
        AHhGz1lESjM1hZnLRkQzVT7GpBiVHKimpcvKo4RnO1fM/AIYO9Xvv+XeIHnGmGQfcka0sH
        vVzj/8JTzAaFOqhhSbOD9z2DuMn/Y1V4rXPCyxfl+jUEZ/aW7YvMd761oGK5dK2np7XUY0
        WhznROaRgtoRZjZLy6y6bZBi2wGRjkkvQVn1z+dkYpTe3zi6wLYyl9d/6lF2cIOqPLdYqD
        qV1CdP+XWtEuB8KO5lRhEgjEq7YbR2NDXmjtX8ggbe+WUxyEMB1sE7WqS5mmu2MfJ3AJEU
        TroEAKekvxreHVptO4C6vH7P1h+ZOCqWmlddwI5pVy3YgXNCYQAnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1630882863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DtjDzs2Mu/uQ7u1/C9vEScfF9PbN0RXYxLV+QH3PzWQ=;
        b=VozHO2iiqe1NjYquX+ui5Bgl2TtasMr/THiz8EhAYSZM2az/YGrM8jvEa7T/mugn/skXZ3
        0+Kn/AblmDT5JJDQ==
From:   Eli Schwartz <eschwartz@archlinux.org>
Subject: Regression in git send-email parsing sendemail.* config values
X-Clacks-Overhead:  GNU Terry Pratchett
Message-ID: <e86f64ff-0395-26f7-5d5b-7df2e6e63ff4@archlinux.org>
Date:   Sun, 5 Sep 2021 19:01:00 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I recently noticed that git send-email was attempting to send emails
using the wrong email address. I have a global email configuration in
XDG_CONFIG_HOME, and a specific one set in the {repo}/.git/config of
some repos... this was trying to use the global configuration.

`git config -l | grep ^sendemail.smtpserver=` reports two emails

`git config --get sendemail.smtpserver` reports only the second,
repo-specific one


I bisected the issue to commit c95e3a3f0b8107b5dc7eac9dfdb9e5238280c9fb

    send-email: move trivial config handling to Perl


Using this commit, git-send-email disagrees with git config --get on
which email to use.

Using commit f4dc9432fd287bde9100488943baf3c6a04d90d1 immediately
preceding this commit, git send-email agrees with git config --get.


-- 
Eli Schwartz
Arch Linux Bug Wrangler and Trusted User
