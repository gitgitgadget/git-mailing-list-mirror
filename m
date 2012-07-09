From: Max Horn <max@quendi.de>
Subject: Re: [PATCH] Change configure to check if pthreads are usable without any extra flags
Date: Mon, 9 Jul 2012 20:31:04 +0200
Message-ID: <35825CE5-4411-4C75-830A-6D704ACA1410@quendi.de>
References: <1341529386-11589-1-git-send-email-max@quendi.de> <7vk3ydkmzq.fsf@alter.siamese.dyndns.org> <C56B4151-8912-4B3A-8A97-E769A878AE68@quendi.de> <7vy5mskewg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1280)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 20:31:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoIjs-0004ok-Pd
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 20:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651Ab2GISbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 14:31:12 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:49071 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752079Ab2GISbL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 Jul 2012 14:31:11 -0400
Received: from 77-22-67-26-dynip.superkabel.de ([77.22.67.26] helo=kaitain-wlan.fritz.box); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1SoIjh-0004tM-3b; Mon, 09 Jul 2012 20:31:05 +0200
In-Reply-To: <7vy5mskewg.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1280)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1341858671;8fcd3e64;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201216>


On 09.07.2012, at 19:44, Junio C Hamano wrote:

> Max Horn <max@quendi.de> writes:
> 
>>>> diff --git a/configure.ac b/configure.ac
>>>> index 4e9012f..d767ef3 100644
>>>> --- a/configure.ac
>>>> +++ b/configure.ac
>>>> @@ -1002,7 +1002,7 @@ if test -n "$USER_NOPTHREAD"; then
>>>> # -D_REENTRANT' or some such.
>>>> elif test -z "$PTHREAD_CFLAGS"; then
>>>>  threads_found=no
>>>> -  for opt in -mt -pthread -lpthread; do
>>>> +  for opt in "" -mt -pthread -lpthread; do
>>> 
>>> Hmph.  Would it work to append the new empty string at the end of
>>> the existing list, as opposed to prepending it?
>> 
>> No, because that loop aborts on the first match that "works". Since no flags are necessary on OS X, but adding "-mt" to the flags "works" in the sense that it does nothing (except triggering a warning about an unknown argument), we need to check the empty string before "-mt" that. 
> 
> If the test in that "for opt ...; do" considers the linking "work",
> why do you even want to tweak it, and instead let "-mt" be passed?
> 
> If the warning troubles you,

It does trouble me, as it means that every single compiled file now triggers a warning, making it impossible to use -Werror, or alternatively much harder to spot legit warning. In fact, I am surprised that it doesn't seem to trouble *you* :-).

Moreover, while compiling and link "works" with "-mt" present on my system, it is very easy to imagine a setup where this test does break: namely on a system where pthreads are in the C lib, but the C compiler treats unknown compiler options as an error, not a warning. Then none of the three options the test checks right now would work

As I see it, an autoconf feature test like this should be checking "which linker flags are *required* in order to use pthreads?". But what it currently does is to check "which linker flags do not prevent us from (and possibly help us to) use pthreads?"  and so they come up with flags that are not necessary, and in fact trigger warnings.


> would it be feasible for the purpose of
> the check to tweak the definition of "works" used in the loop so that
> it considers the warning as "not working"?

That would be possible, and probably a good idea. But it is also completely orthogonal to my patch. Indeed, if done without my patch, then as a result, pthreads would not be detected anymore on Mac OS X, since none of the linker flags it tries would work -- as it doesn't try what happens when no linker flags are passed.



Cheers,
Max