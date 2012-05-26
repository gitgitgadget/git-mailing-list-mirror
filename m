From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: git rebase -f --autosquash
Date: Sat, 26 May 2012 14:53:26 +0200
Message-ID: <4FC0D246.2010701@lyx.org>
References: <D7BE2BACB49749DB9FC37D4ACCCD008B@gmail.com> <1336820755.3002.11.camel@centaur.lab.cmartin.tk> <7vipfyiuv6.fsf@alter.siamese.dyndns.org> <33DF11B90FEF4CB6B4103BE0AAF9B256@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>
To: Andy Kitchen <kitchen.andy@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 26 14:53:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYGUy-00024i-Od
	for gcvg-git-2@plane.gmane.org; Sat, 26 May 2012 14:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876Ab2EZMxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 May 2012 08:53:31 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:33009 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432Ab2EZMxb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2012 08:53:31 -0400
Received: by eaak11 with SMTP id k11so412823eaa.19
        for <git@vger.kernel.org>; Sat, 26 May 2012 05:53:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=JHFb3J4QCKQeO5KZjfpGHYKlcEupfCsKleRVuiBDorI=;
        b=M2gYOjBMngdYSviEZN9DJzbsVajg+B57bYGaONVyBCP80e0Fm7VpHzNnIncslpsqPM
         ZJYFi9XygYtwIWMEWpXw5jLCormJUZucJHYUBHiZ3PbqXNtS0D8G7zyA2wVeazJfEnxA
         FgwfitmqvKWdmLmpr6g2eOs+7VZuH98UM8Iii/2wIjSPML3deNQn2XkODwtYZgE6eCwc
         1Agf89DHtOZSrgUwlr7TDoT72za2zRuG2c3ivsphhCnDqajSnnqseK9lTxf+25OxoW10
         smOW5v4mHZcsNJ8iG8ypMCmbaWztHiz0xhiOpLQDe+XPQ+oWxRToJL3y8d0nuNepuJJY
         cHDQ==
Received: by 10.14.37.76 with SMTP id x52mr445526eea.102.1338036809656;
        Sat, 26 May 2012 05:53:29 -0700 (PDT)
Received: from [192.168.1.2] (j175101.upc-j.chello.nl. [24.132.175.101])
        by mx.google.com with ESMTPS id o16sm17133707eeb.13.2012.05.26.05.53.27
        (version=SSLv3 cipher=OTHER);
        Sat, 26 May 2012 05:53:28 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <33DF11B90FEF4CB6B4103BE0AAF9B256@gmail.com>
X-Gm-Message-State: ALoCoQm0ryVDoN/DaLoEg44aMoUJMgfwTa0fJafbxnBAl/L7zp68aqap1TUIf95fiofGJNT/68er
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198559>

Op 26-5-2012 9:30, Andy Kitchen schreef:
> On Tuesday, 15 May 2012 at 2:35 AM, Junio C Hamano wrote:
>> Given "EDITOR=: git commit args..." and "EDITOR=: git merge args..." are
>> equivalent to giving "--no-edit" option to these commands, I would imagine
>> "git rebase opts... --no-editor args..." would not be such a stretch.
> I agree. However, I think it would be more intuitive to make --autosquash
> work with -f or even just on its own in non-interactive mode.
> It definitely makes sense practically and semantically to autosquash
> non-interactively. Otherwise one needs to activate interactive mode
> and effectively disable it in the same command which is a bit esoteric.
> ...
> In summary, I propose:
>
> 1a)
>
> $ git rebase -f --autosquash<base>
> is made to be effectively equivalent to:
> $ EDITOR=: git rebase -i --autosquash<base>
>

I think the following one-line patch will effectively do what you want.

diff --git a/git-rebase.sh b/git-rebase.sh
index 24a2840..c4ffdcd 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -228,8 +228,9 @@ do
      -p)
          preserve_merges=t
          test -z "$interactive_rebase" && interactive_rebase=implied
          ;;
      --autosquash)
          autosquash=t
+        test -z "$interactive_rebase" && interactive_rebase=implied
          ;;
      --no-autosquash)


Vincent
