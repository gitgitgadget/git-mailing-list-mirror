From: Francesco Pretto <ceztko@gmail.com>
Subject: Re: [RFC v2] submodule: Respect requested branch on all clones
Date: Tue, 7 Jan 2014 01:55:23 +0100
Message-ID: <CALas-iiuq1GPk4h=2L6eR1CUqacxZ8mTteu1NgBE_NR4Bo0P9Q@mail.gmail.com>
References: <CALas-ii90x07Kbxzy_siBJV_RHPkvBw7spFBD9vi6o43mU1k6g@mail.gmail.com>
 <d0de817dfc687fd943349c9d3e1d410161a0f01e.1388938473.git.wking@tremily.us>
 <CALas-ijwb+20dArOGCnZJSqEwU8+ufUpOEktUJ2hAOW_BLpgxw@mail.gmail.com>
 <20140106144708.GC27265@t2784.greatnet.de> <xmqqtxdhjbgp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 07 01:59:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0L0a-0000lT-BY
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 01:59:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755952AbaAGA66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 19:58:58 -0500
Received: from mail-ob0-f182.google.com ([209.85.214.182]:59495 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757546AbaAGAzo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 19:55:44 -0500
Received: by mail-ob0-f182.google.com with SMTP id wp4so19165009obc.41
        for <git@vger.kernel.org>; Mon, 06 Jan 2014 16:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=n3GCxaNArP6kmAdV6JLn3uNg2ULgcMkqUBBkVuoeF6Y=;
        b=DWIWyR9QdedzXVNd6pdZjEqqcg7W+1DGYrPf7gAJ1UBGCFcrgZaZfwYWprjU/qJidx
         wVVUlWl9NjhnEexbs07zb5SjLEKKOXeh8YDqjOyXpCq6BVWHsfSrvtlOqmDqeAjW3d74
         7CerWzGkJ7r5QbcSiPgyYaFrYBtBaqASZFJszmdJNA4E2M5GyMoq+iEQt8HSuRPEkzR+
         Pqm7ufMCmJQ4txNk9Qxpy/54piJtqAIR7I8w5w5bV68zDCu6Tt18VW3ecoYDvJK/dDXv
         ZiREM92bTdr+kNC57GBxGzjv8VJ0Rw1PfxOfmfOlXF1O8A9bEioAY0A85oThIyWUdcYJ
         QX7g==
X-Received: by 10.182.48.130 with SMTP id l2mr3957625obn.44.1389056143768;
 Mon, 06 Jan 2014 16:55:43 -0800 (PST)
Received: by 10.76.80.165 with HTTP; Mon, 6 Jan 2014 16:55:23 -0800 (PST)
In-Reply-To: <xmqqtxdhjbgp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240091>

2014/1/6 Junio C Hamano <gitster@pobox.com>:
>
> As long as origin/master contains the commit specified by the
> superproject, that would work, but it may be a good thing to use a
> mode of submodule.*.update that does not have to drop the user into
> a detached state in the first place.  I somehow thought that was
> what rebase (or merge) was about, that is, starting from the state
> where a branch is checked out in the submodule working tree, an
> update in the superproject would cause that branch checked out in
> the submodule brought up to date with respect to the commit
> specified in the superproject tree.  If that is not how it is
> supposed to work, please correct me---and we may have to add another
> mode that does so (or even make rebase/merge do so as a bugfix).
>

I think the mode you are referring to is actually my
"submodule.<name>.attached" property. As I said to Heiko, the
"submodule.<name>.attached" property says two things:
- at the first clone on "git submodule update" stay attached to
"submodule.<name>.branch";
- implies "--remote", as it's the only thing that makes sense when the
submodules are attached.

> And wouldn't it make it unnecessary to have a new "re-attach" option
> if such a mode that never have to detach is used?

I think the reattach|detach option are still needed (it is debatable
if we should have something like "git submodule head" command or we
can keep them in "git submodule update") because the user may want to
do so and doing it requires things should be really atomic:
    * fix the head state;
    * set the local .git/config "submodule.<name>.attached" property.

The "--attach" switch also can add a great bonus: it can reintegrate
orphaned commits when reattaching and having a "update" mode with
"merge" or "rebase". This is already in my patch.
