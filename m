Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4552520970
	for <e@80x24.org>; Fri, 14 Apr 2017 20:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752152AbdDNUGj (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 16:06:39 -0400
Received: from mail-vk0-f45.google.com ([209.85.213.45]:33818 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751854AbdDNUGh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 16:06:37 -0400
Received: by mail-vk0-f45.google.com with SMTP id z204so42699829vkd.1
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 13:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=xAwQDeFpKY9/TcU9ZB1eRHWWqnJKve+JKHTfyIMw3EU=;
        b=YFXIR3Fq0o0Xpy5uMgG5JEmYh9+cWQW0ah28tAdWFPrFhBUita19WBfKKsqPaQLkjr
         rdFtG9oy2dFdgI9TknjeUX9ixdaO4CQNrJ33n4HBNlDdUWmKQN4ig2TSoozLGGhuKJcc
         6zOCqSt6IOi8XemogKucXUpxlZUHIbtXGPibiWrgb3cVvZvv3xw9wTO1rzGFsaAMFwqa
         fJujpSVyka68GN7PFuPOW+BXIEmmRsl4IBg44SINMOtaiQ0+kkYfxJy7H5/dFxPOdjr/
         p2Q4w6y8EmbAi9EBYfJDZlXadcXW0jjmt7L1N3cS4P7ntSkyFxoqeoVGMy1OKm/x3+MF
         0THQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=xAwQDeFpKY9/TcU9ZB1eRHWWqnJKve+JKHTfyIMw3EU=;
        b=eMLEe38fsyJCCTz1TLW6+/bjaLQkSKuzDgXooqN1phu7hj44/6ntA/YIpZxzucyAZv
         dOAZFIQnmyum9KxiUHfaYGuM9HBX+iMwGYSUgWrDYqF3BHYg2NETI/W/W91uTw+x1nqu
         PSd5YOO4YrrD//w/1CQr0VmQoBidZos49unzSF+izpLq8OVoD1JQghfyzSsJpw9ASNaN
         uJh6U/6/ZJkPbJTZCnrUqXv+CbG89vL8taxgpNLmlVGyHumYU4jjRBC0XpSd+k2pgTOz
         3ZnGyYDR3QZWK6yuKixS7jZiKReyMQgznOluMbIt5/8W6L3Rv24WYoMF4AYhrSNaNwxZ
         vzgQ==
X-Gm-Message-State: AN3rC/4NaX9Z4u7cduA/Wk+WdmLknqrCwbyjDKIiNGxAmop/uHTWQGD4
        smT7OWRcH6dN7Q/Pb79GePbgDfflUOkh
X-Received: by 10.31.11.73 with SMTP id 70mr4014920vkl.83.1492200396203; Fri,
 14 Apr 2017 13:06:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.75.7 with HTTP; Fri, 14 Apr 2017 13:06:15 -0700 (PDT)
From:   Carlos Pita <carlosjosepita@gmail.com>
Date:   Fri, 14 Apr 2017 17:06:15 -0300
Message-ID: <CAELgYhf1s43p62t6W14S=nDt-O247cPqsPMUDfye1OTnDND3Gg@mail.gmail.com>
Subject: Index files autocompletion too slow in big repositories (w /
 suggestion for improvement)
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I'm currently using git annex to manage my entire file collection
(including tons of music and books) and I noticed how slow
autocompletion has become for files in the index (say for git add).
The main offender is a while-read-case-echo bash loop in
__git_index_files that can be readily substituted with a much faster
sed invocation, although I guess you didn't want the sed dependency in
the first place. Anyway, here is my benchmark:

__git_index_files ()
{
    local dir="$(__gitdir)" root="${2-.}" file;
    if [ -d "$dir" ]; then
        __git_ls_files_helper "$root" "$1" | while read -r file; do
            case "$file" in
                ?*/*)
                    echo "${file%%/*}"
                ;;
                *)
                    echo "$file"
                ;;
            esac;
        done | sort | uniq;
    fi
}

time __git_index_files > /dev/null


__git_index_files ()
{
    local dir="$(__gitdir)" root="${2-.}" file;
    if [ -d "$dir" ]; then
        __git_ls_files_helper "$root" "$1" | \
            sed -r 's@^"?([^/]+)/.*$@\1@' | sort | uniq
    fi
}

time __git_index_files > /dev/null

real    0m0.830s
user    0m0.597s
sys    0m0.310s

real    0m0.345s
user    0m0.357s
sys    0m0.000s

Notice I'm also excluding the beginning double quote that appears in
escaped path names.

Best regards
--
Carlos
