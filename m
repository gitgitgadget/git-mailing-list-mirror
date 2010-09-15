From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: ls-files --exclude broken?
Date: Thu, 16 Sep 2010 09:06:36 +1000
Message-ID: <AANLkTinW3ugUK6uBq6oFOzKorHubP-oi9KwJzsNrgpE4@mail.gmail.com>
References: <AANLkTimuTHvA+qjqpmz=VkCpTTiRA7imb5+ZyTVmPwYy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 16 01:06:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ow13u-0003uF-R6
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 01:06:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557Ab0IOXGi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Sep 2010 19:06:38 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58419 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666Ab0IOXGh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Sep 2010 19:06:37 -0400
Received: by wwd20 with SMTP id 20so49720wwd.1
        for <git@vger.kernel.org>; Wed, 15 Sep 2010 16:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zecQCuGAf68SgUSZgeziH5U8e4R/O4NgRVBUTUFe+hM=;
        b=NJ+LkrCXfkloQ+M6/5UmG/ehvGNs7o2c5ZKlxMVUS9Dw6oS/uk4sTq3rmitCmIO1jq
         SsXi073gtxXjWTEh5JLbOtUuhHH3WaR/zEgKGEy6KUS989x1pEMc216VjiiQdnQBxMQw
         0p7io52k3eISD9BL/U/NVGv2XshtAiPFBU+kY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cLNtRkxCjFECKa0URNqcOZTp+j4/vrpMdGGJBDnjt5PJ//0tWy+KbvIji3ixIDzH1d
         3f7SDSI2qolChepgwgzGUnuFaPYhuzZqLuWrTNsAWFq9rQZbN6oQoIP0a8HdX1FntIoL
         R65zwR9qL4lFgXGOcx0ubAti2no7n8P+G1JDs=
Received: by 10.216.72.16 with SMTP id s16mr1991657wed.20.1284591996326; Wed,
 15 Sep 2010 16:06:36 -0700 (PDT)
Received: by 10.216.171.134 with HTTP; Wed, 15 Sep 2010 16:06:36 -0700 (PDT)
In-Reply-To: <AANLkTimuTHvA+qjqpmz=VkCpTTiRA7imb5+ZyTVmPwYy@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156267>

On Thu, Sep 16, 2010 at 8:40 AM, Jay Soffian <jaysoffian@gmail.com> wro=
te:
> Am I missing something really obvious here?
>
> kore:~/Repos/git (master)$ git ls-files | wc -l
> =C2=A0 =C2=A02009
> kore:~/Repos/git (master)$ git ls-files -x \* | wc -l
> =C2=A0 =C2=A02009
> kore:~/Repos/git (master)$ git ls-files -i -x \* | wc -l
> =C2=A0 =C2=A02009
> kore:~/Repos/git (master)$ git version
> git version 1.7.3.rc1.5.g95127

excluded() is not called as far as I can tell, which explains why it
did not exclude anything for you. That exclude code was touched by
Jeff in commits b5227d8 (ls-files: excludes should not impact tracked
files) and 500348a (ls-files: unbreak "ls-files -i").

Something like this works for me, but I haven't finished my morning
tea yet, so..

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index bb4f612..ab87843 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -216,9 +216,14 @@ static void show_files(struct dir_struct *dir)
 		for (i =3D 0; i < active_nr; i++) {
 			struct cache_entry *ce =3D active_cache[i];
 			int dtype =3D ce_to_dtype(ce);
-			if (dir->flags & DIR_SHOW_IGNORED &&
-			    !excluded(dir, ce->name, &dtype))
-				continue;
+			if (dir->flags & DIR_SHOW_IGNORED) {
+				if (!excluded(dir, ce->name, &dtype))
+					continue;
+			}
+			else {
+				if (excluded(dir, ce->name, &dtype))
+					continue;
+			}
 			if (show_unmerged && !ce_stage(ce))
 				continue;
 			if (ce->ce_flags & CE_UPDATE)
--=20
Duy
