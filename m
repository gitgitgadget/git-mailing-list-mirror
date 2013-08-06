From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git rebase -i error message interprets \t in commit message
Date: Tue, 06 Aug 2013 19:19:09 +0200
Message-ID: <vpqd2pqka9e.fsf@anie.imag.fr>
References: <87k3jy6cyc.fsf@fencepost.gnu.org> <vpqli4ekdni.fsf@anie.imag.fr>
	<87fvum694z.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Aug 06 19:19:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6kun-0008B5-7X
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 19:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223Ab3HFRTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 13:19:17 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52504 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756067Ab3HFRTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 13:19:16 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r76HJ7uK015872
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 6 Aug 2013 19:19:07 +0200
Received: from anie.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1V6kub-0000AR-BG; Tue, 06 Aug 2013 19:19:09 +0200
In-Reply-To: <87fvum694z.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Tue, 06 Aug 2013 19:07:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 06 Aug 2013 19:19:08 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: r76HJ7uK015872
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1376414350.29072@uIXuuwxAEB7RWelQoCgfNw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231762>

David Kastrup <dak@gnu.org> writes:

>> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
>> index 7a964ad..97258d5 100644
>> --- a/git-sh-setup.sh
>> +++ b/git-sh-setup.sh
>> @@ -53,7 +53,7 @@ die () {
>>  die_with_status () {
>>         status=$1
>>         shift
>> -       echo >&2 "$*"
>> +       printf >&2 "%s\n" "$*"
>>         exit "$status"
>>  }
>>  
>> It does not sound crazy as the shell function "say" right below uses the
>> same printf "%s\n" "$*",
>
> Sounds reasonable, though I don't know off-hand (not having the source
> here) whether using "say" inside of die_with_status 

The definition of say is:

say () {
	if test -z "$GIT_QUIET"
	then
		printf '%s\n' "$*"
	fi
}

I don't think we want to disable die's output even when the caller
requested to be quiet. Currently, my patch is:

>From 7962ac8d8f2cbc556f669fd97487f9d70edc4ea1 Mon Sep 17 00:00:00 2001
From: Matthieu Moy <Matthieu.Moy@imag.fr>
Date: Tue, 6 Aug 2013 19:13:03 +0200
Subject: [PATCH] die_with_status: use "printf '%s\n'", not "echo"

At least GNU echo interprets backslashes in its arguments.

This triggered at least one bug: the error message of "rebase -i" was
turning \t in commit messages into actual tabulations. There may be
others.

Using "printf '%s\n'" instead avoids this bad behavior, and is the form
used by the "say" function.

Noticed-by: David Kastrup <dak@gnu.org>
Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
 git-sh-setup.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 7a964ad..e15be51 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -53,7 +53,7 @@ die () {
 die_with_status () {
        status=$1
        shift
-       echo >&2 "$*"
+       printf >&2 '%s\n' "$*"
        exit "$status"
 }
 
-- 
1.8.3.3.797.gb72c616

I'll resend properly for inclusion if no one objects.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
