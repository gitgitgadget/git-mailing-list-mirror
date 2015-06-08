From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] read-cache: fix untracked cache invalidation when split-index is used
Date: Mon, 08 Jun 2015 09:49:02 -0700
Message-ID: <xmqq7frecfi9.fsf@gitster.dls.corp.google.com>
References: <xmqq1thodop8.fsf@gitster.dls.corp.google.com>
	<1433673652-27720-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, t.gummerer@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 18:49:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z20EY-0005u8-Si
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 18:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbbFHQtG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Jun 2015 12:49:06 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37572 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbbFHQtE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 12:49:04 -0400
Received: by igbsb11 with SMTP id sb11so61545581igb.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 09:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=5KBFOORhAai/36TloFwnaS1TR6K42bcKgPdD2ye66WY=;
        b=CfQtGxXjvIYMMunWBFtWi8/zmM53MmzzPGebwfVZaMS/IYJDAzUZeBR+65RgA1MeGM
         WKpFQ7MuDZck9bdT3g+jG1+WBRArLDHMbWsRAtA3wjgpT2yUf9euHB+JNu+UFTbQ+R68
         8NWSV3aIdtN2cv6HdfnKRlq5Xogp6Q+4mwrxkCc5qxsU4xrT1YwQH9OG7zdb8KKMwwRv
         pUeREnBCLVBzWumZCzIEAV8oV/37zSAFBwXdbSg6qUnLry1CrZYSGMg+94yvOXk/7ZbM
         ZLrFImf35yB45vMrzATX1msXU7MWjCsAu38EGXvhWwDhSejE73Xz3fLdsBsNvjXs7QlN
         Vhaw==
X-Received: by 10.107.137.42 with SMTP id l42mr20811073iod.60.1433782144140;
        Mon, 08 Jun 2015 09:49:04 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d91a:edb1:b738:fb03])
        by mx.google.com with ESMTPSA id k81sm2065776iod.31.2015.06.08.09.49.03
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 09:49:03 -0700 (PDT)
In-Reply-To: <1433673652-27720-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 7 Jun
 2015 17:40:52 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271073>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Before this change, t7063.17 fails. The actual action though happens =
at
> t7063.16 where the entry "two" is added back to index after being
> removed in the .13. Here we expect a directory invalidate at .16 and
> none at .17 where untracked cache is refreshed. But things do not go =
as
> expected when GIT_TEST_SPLIT_INDEX is set.
>
> The different behavior that happens at .16 when split index is used: =
the
> entry "two", when deleted at .13, is simply marked "deleted". When .1=
6
> executes, the entry resurfaces from the version in base index. This
> happens in merge_base_index() where add_index_entry() is called to ad=
d
> "two" back from the base index.
>
> This is where the bug comes from. The add_index_entry() is called wit=
h
> ADD_CACHE_KEEP_CACHE_TREE flag because this version of "two" is not n=
ew,
> it does not break either cache-tree or untracked cache. The code shou=
ld
> check this flag and not invalidate untracked cache. This causes a sec=
ond
> invalidation violates test expectation. The fix is obvious.
>
> Noticed-by: Thomas Gummerer <t.gummerer@gmail.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  PS. perhaps I should rename ADD_CACHE_KEEP_CACHE_TREE to
>  ADD_CACHE_KEEP_CACHE, or add a new flag .._KEEP_UNTRACKED_CACHE to
>  avoid confusion.

That may not be a bad idea, indeed.

>  Untracked cache, split index and the last part (*) all aim at a
>  smaller user audience with large work trees. They are not really wha=
t
>  a common user needs, but I hope they do have users.

I do hope that this can be made for everybody, though.  Any project
will get larger, not smaller, over time and these two (I am not sure
what you refer to as 'last part', though) are meant to support
projects with larger working trees better.  After all, that is why I
merged the untracked-cache series reasonably early to 'master' in
this cycle to give us time to shake out little issues like this one.
I think we killed two so far since it has been merged to 'master',
so the plan is working rather nicely ;-).

Thanks.
