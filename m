Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAE5C433F5
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 23:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbiDWXsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 19:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbiDWXsF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 19:48:05 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB9C1FF
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 16:45:03 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 61D8218E220;
        Sat, 23 Apr 2022 19:45:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IYkZXcaf92z22tEvICKWbTNgF2RH9zjIk7ZvtO
        nSDWY=; b=Kr1C0XlXanzWKiFo+8XqlWNHVTcBROGKgxolUqyEIk+/ehskyoUiMH
        +MtGGstI+FFVfWB57Ek0/eahW/qdsfd++PQUfZfUguwrk/io9h8Fch3NhkaXonUs
        dxpmuzIOSCLD6G562Rka84yX91+QUUnOJ9FU8XSsDnsjiM5ZpnqFU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 52BB118E21F;
        Sat, 23 Apr 2022 19:45:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CA5B818E21B;
        Sat, 23 Apr 2022 19:44:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Guy Maurel <guy.j@maurel.de>, git@vger.kernel.org
Subject: Re: a problem with git describe
References: <4ef9287b-6260-9538-7c89-cffb611520ee@maurel.de>
        <3d762060-b817-0246-c4a2-8eb35096cb7f@iee.email>
        <xmqqczh73hns.fsf@gitster.g>
Date:   Sat, 23 Apr 2022 16:44:57 -0700
In-Reply-To: <xmqqczh73hns.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
        23 Apr 2022 09:09:59 -0700")
Message-ID: <xmqqk0bf1i12.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62CB86E4-C35F-11EC-9D71-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Philip Oakley <philipoakley@iee.email> writes:
>
>>> guy@renard ~/Software/uncrustify $ sudo git describe --always --dirty
>> ...
>> There has also been added an escape hatch of allowing "*" for the
>> permitted safe directories. but do check the updated manuals, and the
>> git mailing list archive (update the search in the above link).
>
> In this particular case, I do not think '*' is needed, but you need
> to be careful here.  Whose configuration are you suggesting to add
> such an entry?  Yourself?  ~root/.gitconfig?
>
> I wonder if we should loosen "the same owner" check somewhat to
> cover this situation better.  I expect people also run the
> installation in repositories they own with "sudo make install",
> and complaining "euid does not own that repository" when it is
> merely because they are running as root (and their real identity
> is still in ruid) feels a bit too strict to be useful.

Actually, not quite.  when "git" runs in "sudo git", the real
identity has long lost, so the below would not help.  Sigh.

 git-compat-util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git i/git-compat-util.h w/git-compat-util.h
index 63ba89dd31..90dc1b17cd 100644
--- i/git-compat-util.h
+++ w/git-compat-util.h
@@ -398,7 +398,7 @@ static inline int is_path_owned_by_current_uid(const char *path)
 	struct stat st;
 	if (lstat(path, &st))
 		return 0;
-	return st.st_uid == geteuid();
+	return st.st_uid == geteuid() || st.st_uid == getuid();
 }
 
 #define is_path_owned_by_current_user is_path_owned_by_current_uid
