From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH] t: Replace 'perl' by $PERL_PATH
Date: Wed, 20 Jun 2012 22:16:17 +0200
Message-ID: <4FE22F91.1000809@web.de>
References: <1339441313-5296-1-git-send-email-vfr@lyx.org> <4FDD7AE6.6000000@web.de> <7vipeq76ke.fsf@alter.siamese.dyndns.org> <4FDD9A4F.2060605@web.de> <7vk3z560i8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	vfr@lyx.org, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 22:16:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ShRKL-0007wX-MR
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 22:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758015Ab2FTUQ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jun 2012 16:16:29 -0400
Received: from smtp-out12.han.skanova.net ([195.67.226.212]:58812 "EHLO
	smtp-out12.han.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754408Ab2FTUQ2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jun 2012 16:16:28 -0400
Received: from wanderer.site (194.22.188.61) by smtp-out12.han.skanova.net (8.5.133) (authenticated as tboegi@telia.com)
        id 4FAE31D9009995A5; Wed, 20 Jun 2012 22:16:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <7vk3z560i8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200358>

On 06/18/2012 12:23 AM, Junio C Hamano wrote:
> Torsten B=C3=B6gershausen<tboegi@web.de>  writes:
>
>>> PERL_PATH should be exported from test-lib.sh; we dot-source
>>> GIT-BUILD-OPTIONS to get its value, but it is not propagated to the
>>
>> Thanks, that works for me.
>> Do you squeeze some like that onto pu?
>>
>> @@ -493,6 +493,7 @@ GIT_ATTR_NOSYSTEM=3D1
>>   export PATH GIT_EXEC_PATH GIT_TEMPLATE_DIR GIT_CONFIG_NOSYSTEM GIT=
_ATTR_NOSYSTEM
>>
>>   . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
>> +export PERL_PATH
 > I see other uses of bare "perl" that the patch forgot to convert,
 > and the worst part is that one of these uses of bare "perl" appears
 > in test-lib.sh _before_ it dot-sources GIT-BUILD-OPTIONS to pick up
 > the correct version of Perl, so the above single liner cannot be the
 > whole fix.

How do you like the following idea:
- rename t/test-lib.sh into t/test-lib.sh.sh
- Change perl into @@PERL_PATH@@ in this file
- Add the missing EXPORT PERL_PATH in test-lib.sh.sh
- Preprocess t/test-lib.sh from t/test-lib.sh.sh, as seen below

> diff --git a/Makefile b/Makefile
index 0914133..765107a 100644
--- a/Makefile
+++ b/Makefile
@@ -442,6 +442,7 @@ SCRIPT_LIB +=3D git-rebase--interactive
  SCRIPT_LIB +=3D git-rebase--merge
  SCRIPT_LIB +=3D git-sh-setup
  SCRIPT_LIB +=3D git-sh-i18n
+SCRIPT_LIB +=3D t/test-lib.sh

  SCRIPT_PERL +=3D git-add--interactive.perl
  SCRIPT_PERL +=3D git-difftool.perl
@@ -2018,6 +2019,7 @@ sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
      -e 's|@@LOCALEDIR@@|$(localedir_SQ)|g' \
      -e 's/@@NO_CURL@@/$(NO_CURL)/g' \
      -e 's/@@USE_GETTEXT_SCHEME@@/$(USE_GETTEXT_SCHEME)/g' \
+    -e 's|@@PERL_PATH@@|$(PERL_PATH)|g' \
      -e $(BROKEN_PATH_FIX) \
      $@.sh >$@+
  endef
