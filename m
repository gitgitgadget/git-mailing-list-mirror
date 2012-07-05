From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git-submodule path computation bug with recursive submodules
Date: Thu, 05 Jul 2012 20:34:24 +0200
Message-ID: <4FF5DE30.6030100@web.de>
References: <0B4C40CC-862E-4B15-9A4F-903DC8DBBAEC@play-bow.org> <CABURp0qtbSsiRX9sJ1F5WS3wtKq32hpV=3pGmM6Ysn=9Nvw_nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Phil Hord <phil.hord@gmail.com>, Bob Halley <halley@play-bow.org>
X-From: git-owner@vger.kernel.org Thu Jul 05 20:35:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmqtP-0005AN-8f
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 20:35:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108Ab2GESfA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 14:35:00 -0400
Received: from mout.web.de ([212.227.15.4]:50719 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753669Ab2GESe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 14:34:59 -0400
Received: from [192.168.178.48] ([91.3.174.47]) by smtp.web.de (mrweb002) with
 ESMTPA (Nemesis) id 0LeLmv-1S19Hb1VYD-00pwvz; Thu, 05 Jul 2012 20:34:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <CABURp0qtbSsiRX9sJ1F5WS3wtKq32hpV=3pGmM6Ysn=9Nvw_nQ@mail.gmail.com>
X-Provags-ID: V02:K0:eMqEPuewTYZ2uzA639X6RaLzFJbc2gfhpBrDwwtNbIG
 OzyNDnotA37sErTfuVcJB76j+jWKiiH2DGvurF+YA11kf4FuKe
 Uxn9Z6lK84VXC98lh7HGfIl5663QFysJUzdEI2YwxJGmAY8Cfn
 rhRiSEDQwAp+XAgq6CPV4GdO1TRIxiw9c9H/5/8RJazd6FYtE7
 nxQa3In3k8yH9IoJi7kSg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201059>

Am 05.07.2012 16:18, schrieb Phil Hord:
> On Thu, Jul 5, 2012 at 8:09 AM, Bob Halley <halley@play-bow.org> wrote:
>> The first level of submodule clones successfully, but submodule 'foo'
>> contains submodule 'bar', and cloning it fails.
> 
> It fails for me too, running zsh and stock Linux.
> 
> Seems to originate here.
> 
> Commit: 69c3051780d6cacfe242563296160634dc667a90:
> Author: Jens Lehmann <Jens.Lehmann@web.de>
> Date:   Sun Mar 4 22:15:36 2012 +0100
> 
>     submodules: refactor computation of relative gitdir path

Yup, thanks both for reporting and nailing that one down.

This diff fixes the problem for me and should be a portable way to
avoid "pwd -P" or "cd -P", I'll cook up a patch with test for that:


diff --git a/git-submodule.sh b/git-submodule.sh
index 5c61ae2..4a22555 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -150,8 +150,8 @@ module_clone()
                die "$(eval_gettext "Clone of '\$url' into submodule path '\$sm_
        fi

-       a=$(cd "$gitdir" && pwd)/
-       b=$(cd "$sm_path" && pwd)/
+       a=$(cd_to_toplevel && cd "$gitdir" && pwd)/
+       b=$(cd_to_toplevel && cd "$sm_path" && pwd)/
        # normalize Windows-style absolute paths to POSIX-style absolute paths
        case $a in [a-zA-Z]:/*) a=/${a%%:*}${a#*:} ;; esac
        case $b in [a-zA-Z]:/*) b=/${b%%:*}${b#*:} ;; esac
