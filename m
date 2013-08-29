From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v3 3/4] get rid of "git submodule summary --for-status"
Date: Thu, 29 Aug 2013 23:23:00 +0200
Message-ID: <vpqioyonqdn.fsf@anie.imag.fr>
References: <1377781536-31955-1-git-send-email-Matthieu.Moy@imag.fr>
	<1377781536-31955-4-git-send-email-Matthieu.Moy@imag.fr>
	<521FA6ED.9010005@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, gitster@pobox.com,
	"brian m. carlson" <sandals@crustytoothpaste.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Aug 29 23:23:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF9ge-0002mH-Fr
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 23:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756546Ab3H2VXU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 17:23:20 -0400
Received: from mx2.imag.fr ([129.88.30.17]:43096 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756436Ab3H2VXS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 17:23:18 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r7TLMwiI031492
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Aug 2013 23:22:58 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1VF9gD-00042T-8b; Thu, 29 Aug 2013 23:23:01 +0200
In-Reply-To: <521FA6ED.9010005@web.de> (Jens Lehmann's message of "Thu, 29 Aug
	2013 21:54:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Thu, 29 Aug 2013 23:22:59 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r7TLMwiI031492
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1378416179.69347@L7t8x5FTVLl8rVVNONEhug
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233364>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 29.08.2013 15:05, schrieb Matthieu Moy:
>> The --for-status option was an undocumented option used only by
>> wt-status.c, which inserted a header and commented out the output. We can
>> achieve the same result within wt-status.c, without polluting the
>> submodule command-line options.
>> 
>> This will make it easier to disable the comments from wt-status.c later.
>
> Cool, thanks for implementing this!
>
> But unfortunately this change collides with bc/submodule-status-ignored
> (I added Brian to the CC) which is currently on its way to next.

Thanks for pointing that out. The patch looks buggy:

--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1036,6 +1036,13 @@ cmd_summary() {
                do
                        # Always show modules deleted or type-changed (blob<->module)
                        test $status = D -o $status = T && echo "$sm_path" && continue
+                       # Respect the ignore setting for --for-status.
+                       if test -n $for_status
+                       then
+                               name=$(module_name "$sm_path")
+                               ignore_config=$(get_submodule_config "$name" ignore none)
+                               test $status != A -a $ignore_config = all && continue
+                       fi

Because of the missing quotes around $for_status, it seems the test is
unconditionnaly true:

$ test -n t ; echo $?
0
$ test -n   ; echo $?
0

This makes me wonder why the ignore configuration should be considered
only with --for-status. Why not turn that into

--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1036,6 +1036,13 @@ cmd_summary() {
                do
                        # Always show modules deleted or type-changed (blob<->module)
                        test $status = D -o $status = T && echo "$sm_path" && continue
+			# Respect the ignore setting
+			name=$(module_name "$sm_path")
+			ignore_config=$(get_submodule_config "$name" ignore none)
+			test $status != A -a $ignore_config = all && continue

?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
