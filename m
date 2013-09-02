From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] {fetch,receive}-pack: drop unpack-objects, delay loosing
 objects until the end
Date: Mon, 2 Sep 2013 00:38:59 -0400
Message-ID: <CAPig+cTscSov3kHX6Mj_LpK1CeH+x4NTexdWZD42NT-KfohvrA@mail.gmail.com>
References: <1378091107-31682-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 02 06:39:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGLv9-0005Db-Us
	for gcvg-git-2@plane.gmane.org; Mon, 02 Sep 2013 06:39:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322Ab3IBEjD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Sep 2013 00:39:03 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:40914 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752254Ab3IBEjB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Sep 2013 00:39:01 -0400
Received: by mail-lb0-f169.google.com with SMTP id z5so2924102lbh.28
        for <git@vger.kernel.org>; Sun, 01 Sep 2013 21:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=SBoZEclRjRvfueYCtwJNF0mp/iaV3Iv9FUbTJqwgn84=;
        b=if9be/1x7O04bcasTB2ChGtxBzB0mKHUw72DZKdjCxAZegbOzvSMOetYJhu5kKrc5L
         5xeQ7jI9CQtdiaBdOiQgFAWrSioN/IjEOJF6QCSLgeU0SYut67p4iLF9WCqmssX5hn7F
         uclxx006aSMt/iptlX6EADteQDpUBuPQ7UmUvWpOj+lyEElpG1H2oWLeuTtl8h0QPbIf
         jeuWj1ApIR34wiv+Wh5MuVOyu5qkmpeF3cpkIhFi5yk4dM754hzjb/cwgECpLuXSnS4o
         JRuk27ZtoSORN49HxXm8mwUTLvKP+vl5Ik/BhSHqW6ebHAl+2IqnRE8cwPMpFJ//magl
         ah3g==
X-Received: by 10.152.22.65 with SMTP id b1mr48945laf.46.1378096739730; Sun,
 01 Sep 2013 21:38:59 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Sun, 1 Sep 2013 21:38:59 -0700 (PDT)
In-Reply-To: <1378091107-31682-1-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: wdUjXwEc5mvYvZa9CAog9DvzLIU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233597>

On Sun, Sep 1, 2013 at 11:05 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Current code peaks into the transfered pack's header, if the number o=
f

s/peaks/peeks/

> objects is under a limit, unpack-objects is called to handle the rest=
,
> otherwise index-pack is. This patch makes fetch-pack use index-pack
> unconditionally, then turn objects loose and remove the pack at the
> end. unpack-objects is deprecated and may be removed in future.
>
> There are a few reasons for this:
>
>  - down to two code paths to maintain regarding pack reading
>    (sha1_file.c and index-pack.c). When .pack v4 comes, we don't need
>    to duplicate work in index-pack and unpack-objects.
>
>  - the number of objects should not be the only indicator for
>    unpacking. If there are a few large objects in the pack, the pack
>    should be kept anyway. Keeping the pack lets us examine the whole
>    pack later and make a better decision.
>
>  - by going through index-pack first, then unpack, we pay extra cost
>    for completing a thin pack into a full one. But compared to fetch'=
s
>    total time, it should not be noticeable because unpack-objects is
>    only called when the pack contains a small number of objects.
>
>  - unpack-objects does not support streaming large blobs. Granted
>    force_object_loose(), which is used by this patch, does not either=
=2E
>    But it'll be easier to do so because sha1_file.c interface support=
s
>    streaming.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
