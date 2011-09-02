From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] xdiff/xprepare: initialise xdlclassifier_t cf in xdl_prepare_env()
Date: Fri,  2 Sep 2011 15:09:23 +0800
Message-ID: <1314947363-4596-1-git-send-email-rctay89@gmail.com>
References: <7vaaapzf6f.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 02 09:09:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzNse-00043J-DO
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 09:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449Ab1IBHJb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Sep 2011 03:09:31 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:39563 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298Ab1IBHJa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 03:09:30 -0400
Received: by ywf7 with SMTP id 7so1985425ywf.19
        for <git@vger.kernel.org>; Fri, 02 Sep 2011 00:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=nytAc7LK02l0vgpmli+52I9YajeRLdLy0jlgemCubQU=;
        b=qReAHhcwTW+0Je140sTsHKNw9lR2r+UB6TCITxzRjVXLNdhuPqHMZis4yNLg7+wW5e
         kVO5IXGEgXkjonjQ8b+IK6horZXglv3kCNRXnzSSWNVyt4G2MxK6qDx7OwhoDwdYT5NB
         G9Y+h6sazNmBXRg03kTvLIPvqvrNBE92GumoE=
Received: by 10.236.182.135 with SMTP id o7mr3740146yhm.48.1314947369921;
        Fri, 02 Sep 2011 00:09:29 -0700 (PDT)
Received: from localhost (nusnet-125-111.dynip.nus.edu.sg [137.132.125.111])
        by mx.google.com with ESMTPS id n67sm1815664yhi.9.2011.09.02.00.09.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 02 Sep 2011 00:09:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.msysgit.0
In-Reply-To: <7vaaapzf6f.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180600>

Ensure that the xdl_free_classifier() call on xdlclassifier_t cf is saf=
e
even if xdl_init_classifier() isn't called, which is the case when diff
is run with --histogram.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>

---

On Thu, Sep 1, 2011 at 1:02 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Tay Ray Chuan <rctay89@gmail.com> writes:
>
>> Ensure that the xdl_free_classifier() call on xdlclassifier_t cf is =
safe
>> even if xdl_init_classifier() isn't called. This may occur in the ca=
se
>> where diff is run with --histogram and a call to, say, xdl_prepare_c=
tx()
>> fails.
>>
>> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
>
> Thanks. Did you find this by code inspection?

If by "code inspection" you meant eye-balling, then yes. :)

On Thu, Sep 1, 2011 at 1:03 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Junio C Hamano <gitster@pobox.com> writes:
> [snip]
>>> @@ -239,6 +239,9 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf=
2, xpparam_t const *xpp,
>>> =C2=A0 =C2=A0 =C2=A0long enl1, enl2, sample;
>>> =C2=A0 =C2=A0 =C2=A0xdlclassifier_t cf;
>>>
>>> + =C2=A0 =C2=A0cf.rchash =3D NULL;
>>> + =C2=A0 =C2=A0cf.ncha.head =3D NULL;
>>
>> Would it be more appropriate to use memcpy(&cf, 0, sizeof(cf)) inste=
ad, so
>
> Oops, I meant memset(), obviously.

Right, thanks.
---
 xdiff/xprepare.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
index 620fc9a..5b676b7 100644
--- a/xdiff/xprepare.c
+++ b/xdiff/xprepare.c
@@ -239,6 +239,8 @@ int xdl_prepare_env(mmfile_t *mf1, mmfile_t *mf2, x=
pparam_t const *xpp,
 	long enl1, enl2, sample;
 	xdlclassifier_t cf;
=20
+	memset(&cf, 0, sizeof(cf));
+
 	/*
 	 * For histogram diff, we can afford a smaller sample size and
 	 * thus a poorer estimate of the number of lines, as the hash
--=20
1.7.6.1.706.gaa5cf
