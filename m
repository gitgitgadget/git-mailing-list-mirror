Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198C5C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 22:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbhLIWux (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 17:50:53 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:64908 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhLIWuw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 17:50:52 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4EA3317B5A4;
        Thu,  9 Dec 2021 17:47:18 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gXjO30xgWDs7xhtFVyyd1wsH6it14ceCEQ2V58
        xTTug=; b=yY7o3A1D8Wmm1gpbvPB6T3tldgOkkWRJCc822svO2o1LrkURnI+Okv
        6AWZbEIbAIpU0F3tdz8K1663z+yPazHb19L1gR6ObVhHIdcVZiViKb+nAnBN4vNk
        COg0MdrEtmHm8qjYs6ThCOSfVaSXK+nr8Ns8XuzhqKYlNOA2Z5SIw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 46C6417B5A3;
        Thu,  9 Dec 2021 17:47:18 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7F3DB17B5A2;
        Thu,  9 Dec 2021 17:47:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/6] git-p4: Decode byte strings before printing
References: <20211209201029.136886-1-jholdsworth@nvidia.com>
        <20211209201029.136886-5-jholdsworth@nvidia.com>
Date:   Thu, 09 Dec 2021 14:47:13 -0800
In-Reply-To: <20211209201029.136886-5-jholdsworth@nvidia.com> (Joel
        Holdsworth's message of "Thu, 9 Dec 2021 20:10:27 +0000")
Message-ID: <xmqqczm5o0pa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F423B9C8-5941-11EC-A890-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Holdsworth <jholdsworth@nvidia.com> writes:

> Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
> ---
>  git-p4.py | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Is the use of strings with {} placeholders and their .format() method
integral part of "decoding byte strings before printing", or it is just
a new/better/improved/subjectively-preferred/whatever style?

If the latter, such a change should be separated into its own step,
or at least needs to be mentioned and justified in the proposed log
message.

Lack of explanation on "why" is shared among all these patches, it
seems, so I won't repeat, but the patches need to explain why to
their readers.

> diff --git a/git-p4.py b/git-p4.py
> index b5d4fc1176..b5945a0306 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2917,7 +2917,8 @@ def streamOneP4File(self, file, contents):
>                  size = int(self.stream_file['fileSize'])
>              else:
>                  size = 0 # deleted files don't get a fileSize apparently
> -            sys.stdout.write('\r%s --> %s (%i MB)\n' % (file_path, relPath, size/1024/1024))
> +            sys.stdout.write('\r{} --> {} ({} MB)\n'.format(
> +                file_path.decode(), relPath, size/1024/1024))
>              sys.stdout.flush()
>  
>          (type_base, type_mods) = split_p4_type(file["type"])
> @@ -3061,7 +3062,8 @@ def streamP4FilesCb(self, marshalled):
>              size = int(self.stream_file["fileSize"])
>              if size > 0:
>                  progress = 100*self.stream_file['streamContentSize']/size
> -                sys.stdout.write('\r%s %d%% (%i MB)' % (self.stream_file['depotFile'], progress, int(size/1024/1024)))
> +                sys.stdout.write('\r{} {}% ({} MB)'.format(
> +                    self.stream_file['depotFile'].decode(), progress, int(size/1024/1024)))
>                  sys.stdout.flush()
>  
>          self.stream_have_file_info = True
> @@ -3803,7 +3805,7 @@ def closeStreams(self):
>              return
>          self.gitStream.close()
>          if self.importProcess.wait() != 0:
> -            die("fast-import failed: %s" % self.gitError.read())
> +            die("fast-import failed: {}".format(self.gitError.read().decode()))
>          self.gitOutput.close()
>          self.gitError.close()
>          self.gitStream = None
