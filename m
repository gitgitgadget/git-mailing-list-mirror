From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v4] submodule: add 'deinit' command
Date: Mon, 18 Mar 2013 21:54:23 +0100
Message-ID: <51477EFF.2010505@web.de>
References: <5112C6F6.4030607@web.de> <CABURp0pC2FELxM5aUwxuTqS1roZm+fwkCQA+BoXjrd0+yQMmbg@mail.gmail.com> <7v1ubk8u6o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	"W. Trevor King" <wking@tremily.us>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 21:55:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHh5D-0002qj-FW
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 21:55:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518Ab3CRUy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 16:54:29 -0400
Received: from mout.web.de ([212.227.15.3]:54045 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751354Ab3CRUy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 16:54:28 -0400
Received: from [192.168.178.41] ([91.3.185.39]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0MVLj0-1UDi1u0dKA-00Y8Nm; Mon, 18 Mar 2013 21:54:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <7v1ubk8u6o.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:mJFJOusOR7xj264/LML0ionnOaoLqle8T8uibHtlQAx
 KhxPQmsqaEc5S3lUEyHNTwD2n10/ATnTdigl28oekxguRIMaiv
 hWA/Yk12LxWLA0RNhNDMDlerPLk6KpO0jKB0jnWee7vnuGoOP8
 Hdc6goEqEeTqBDJ+4XhuDJp78Yjy9M1cGrC1UgfqYLqp7CZ+og
 ZzLF4EIxg95UEyvAG6pAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218449>

Am 12.03.2013 17:22, schrieb Junio C Hamano:
> Phil Hord <phil.hord@gmail.com> writes:
> 
>> I think this would be clearer if 'git deinit' said
>>
>>     rm 'submodule/*'
>>
>> or maybe
>>
>>     Removed workdir for 'submodule'
>>
>> Is it just me?
> 
> The latter may probably be better.  

Hmm, it doesn't really remove the directory but only empties it
(it recreates it a few lines after removing it together with its
contents). So what about

    Cleared directory 'submodule'

The attached interdiff suppresses the "rm 'submodule'" message
and issues the "Cleared ..." message after it successfully removed
the work tree. (But please note that it also prints this message
even if the submodule work tree is already empty, e.g. when you
deinit a submodule the second time)

----------------8<-------------------------
diff --git a/git-submodule.sh b/git-submodule.sh
index 204bc78..d003e8a 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -601,10 +601,12 @@ cmd_deinit()

 			if test -z "$force"
 			then
-				git rm -n "$sm_path" ||
+				git rm -qn "$sm_path" ||
 				die "$(eval_gettext "Submodule work tree '\$sm_path' contains local modifications; use '-f' to discard them")"
 			fi
-			rm -rf "$sm_path" || say "$(eval_gettext "Could not remove submodule work tree '\$sm_path'")"
+			rm -rf "$sm_path" &&
+			say "$(eval_gettext "Cleared directory '\$sm_path'")" ||
+			say "$(eval_gettext "Could not remove submodule work tree '\$sm_path'")"
 		fi

 		mkdir "$sm_path" || say "$(eval_gettext "Could not create empty submodule directory '\$sm_path'")"
