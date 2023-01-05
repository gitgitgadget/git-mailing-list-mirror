Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2336EC3DA7A
	for <git@archiver.kernel.org>; Thu,  5 Jan 2023 18:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbjAES4N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Jan 2023 13:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235245AbjAES4I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jan 2023 13:56:08 -0500
X-Greylist: delayed 511 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 Jan 2023 10:56:05 PST
Received: from mail-200165.simplelogin.co (mail-200165.simplelogin.co [176.119.200.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CBF37261
        for <git@vger.kernel.org>; Thu,  5 Jan 2023 10:56:05 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smancill.dev;
        s=dkim; t=1672944453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6Nw2VyrSoSG4aV8q4zX9I/RAuSvyeyAVEP3Igr7CNkM=;
        b=SLdH+Q+e4lW6pbtZzk5IdV2ke+iefmPtKgnvDz7xAl5UxNL3MqLjUeoRLDAJwBoUix0T/n
        Lfltga/bUFWNtTQFyDH6d+M9GUTivgoIhweO9OvhTfNXkPCpiLN9jGIg3EjHGCBRGbolzH
        c3X1kUdLqFNVbE/XwMyg1JnTfa2sGe4=
Date:   Thu, 5 Jan 2023 15:47:15 -0300
Subject: mergetools: wrong window selected for vimdiff1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
From:   =?utf-8?q?Sebasti=C3=A1n_Mancilla?= <smancill@smancill.dev>
To:     git@vger.kernel.org
Message-ID: <167294445271.7.3739319158947040124.89448053@smancill.dev>
X-SimpleLogin-Type: Reply
X-SimpleLogin-EmailLog-ID: 89448053
X-SimpleLogin-Want-Signing: yes
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The layout for the vimdiff1 mergetool is "@LOCAL,REMOTE". From the man page=
:

    o   layout =3D "@LOCAL,REMOTE"

        When MERGED is not present in the layout, you must "mark" one
        of the buffers with an asterisk. That will become the buffer
        you need to edit and save after resolving the conflicts.

            ------------------------------------------
            |                   |                    |
            |                   |                    |
            |                   |                    |
            |     LOCAL         |    REMOTE          |
            |                   |                    |
            |                   |                    |
            |                   |                    |
            ------------------------------------------

But after opening the buffers, the cursor is in the *right window*.

This is confusing, since it makes you think the right buffer is the one tha=
t
needs to be edited, instead of the left one.

Debug output (the make-conflicts.sh script in this repository [0] can be us=
ed
to quickly test a file with conflicts):

    Merging:
    poem.txt

    Normal merge conflict for 'poem.txt':
      {local}: modified file
        {remote}: modified file

        LAYOUT    : @LOCAL,REMOTE
        CMD       : echo
        NESTED MIN: 0
        CLEAN     : @LOCAL,REMOTE

        LAYOUT    : @LOCAL
        CMD       : echo | leftabove vertical split
        NESTED MIN: 0
        CLEAN     : @LOCAL

        LAYOUT    : REMOTE
        CMD       : echo | leftabove vertical split | 1b | wincmd l
        NESTED MIN: 0
        CLEAN     : REMOTE

        FINAL CMD : -c "set hidden diffopt-=3Dhiddenoff | echo |
leftabove vertical split | 1b | wincmd l | 3b | execute 'tabdo windo
diffthis' | tabfirst"
        FINAL TAR : LOCAL
        4 files to edit

Also note that when vimdiff1 was introduced by 30bb8088af
(mergetools/vimdiff: add
vimdiff1 merge tool variant, 2021-02-13), Vim echoed a nice message to
remember which buffer shall be edited:

> +        *vimdiff1)
> +                "$merge_tool_path" -f -d \
> +                        -c 'echon "Resolve conflicts leftward then save.=
 Use :cq to abort."' \
> +                        "$LOCAL" "$REMOTE"

But with the refactor done by 0041797449 (vimdiff: new implementation with
layout support, 2022-03-30), now the message is gone:

>          *vimdiff1)
> -                "$merge_tool_path" -f -d \
> -                        -c 'echon "Resolve conflicts leftward then save.=
 Use :cq to abort."' \
> -                        "$LOCAL" "$REMOTE"
> -                ret=3D"$?"
> -                if test "$ret" -eq 0
> -                then
> -                        cp -- "$LOCAL" "$MERGED"
> -                fi
> -                return "$ret"
> +                layout=3D"@LOCAL,REMOTE"
>                  ;;


[0]: https://github.com/whiteinge/diffconflicts/tree/master/_utils

--=20
Sebasti=C3=A1n Mancilla

