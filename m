From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (May 2013, #09; Wed, 29)
Date: Thu, 30 May 2013 21:18:17 +0200
Message-ID: <51A7A5F9.2030107@web.de>
References: <7va9ndqqyf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 30 21:18:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ui8Mr-0008IP-9u
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 21:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759445Ab3E3TS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 15:18:29 -0400
Received: from mout.web.de ([212.227.17.12]:58689 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759444Ab3E3TS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 May 2013 15:18:28 -0400
Received: from [192.168.178.41] ([91.3.184.137]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0LtFYd-1UJ13h1Nhj-012kii; Thu, 30 May 2013 21:18:18
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <7va9ndqqyf.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:dHZiYfrCyToSdXBVBLlZuxN4NVpseu5gzeLWKezb/Jh
 Y8vd5Qq72kYjthyvQ4KGTiLHegbbsoEdLaPmtDzowmzHG7qsK0
 KA17DMLVWrliuF4MOUdda0VfuSd0bRc4BQzahzEDw1fGX2RXMs
 ddyRAGlF2eSa3zGEY9TAUrhQQWgB3wqBJ+bVmjQNKtCZ5UwmZv
 5YZg1ckY0UrAf08BsqDzA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226029>

Am 30.05.2013 01:58, schrieb Junio C Hamano:
> * jl/submodule-mv (2013-04-23) 5 commits
>   (merged to 'next' on 2013-04-23 at c04f574)
>  + submodule.c: duplicate real_path's return value
>   (merged to 'next' on 2013-04-19 at 45ae3c9)
>  + rm: delete .gitmodules entry of submodules removed from the work tree
>  + Teach mv to update the path entry in .gitmodules for moved submodules
>  + Teach mv to move submodules using a gitfile
>  + Teach mv to move submodules together with their work trees
> 
>  "git mv A B" when moving a submodule A does "the right thing",
>  inclusing relocating its working tree and adjusting the paths in
>  the .gitmodules file.

There are only two issues I'm aware of:

*) When the .gitmodules file is already modified but unchanged
   running rm or mv on a submodule will stage those changes too.

*) There is a harmless but unnecessary double invocation of strlen()
   in the function (fixed by the diff below).

I plan to fix the first issue in another patch which would also get
rid of the second issue, as exactly that code would have to be touched
anyways.

Does that make sense?

----------8<-----------------
diff --git a/submodule.c b/submodule.c
index edfc23c..4670af7 100644
--- a/submodule.c
+++ b/submodule.c
@@ -102,7 +102,7 @@ void stage_updated_gitmodules(void)
        struct cache_entry *ce;
        int namelen = strlen(".gitmodules");

-       pos = cache_name_pos(".gitmodules", strlen(".gitmodules"));
+       pos = cache_name_pos(".gitmodules", namelen);
        if (pos < 0) {
                warning(_("could not find .gitmodules in index"));
                return;
