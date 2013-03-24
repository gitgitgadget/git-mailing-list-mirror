From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 4/4] transport: drop "int cmp = cmp" hack
Date: Sun, 24 Mar 2013 15:54:36 +0100
Message-ID: <514F13AC.6000100@web.de>
References: <20130321110338.GA18552@sigill.intra.peff.net> <20130321111333.GD18819@sigill.intra.peff.net> <CAPc5daVOksx56js_ascEr348PTLAZB9OeBrf3sELJUpdyB_kMg@mail.gmail.com> <20130324093212.GA28234@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 24 15:55:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJmKY-00082V-Sh
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 15:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753944Ab3CXOzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Mar 2013 10:55:00 -0400
Received: from mout.web.de ([212.227.15.4]:60521 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753893Ab3CXOzA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 10:55:00 -0400
Received: from birne.lan ([195.67.191.23]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0MNtTz-1UL8pa1Xhr-006weI; Sun, 24 Mar 2013 15:54:37 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <20130324093212.GA28234@sigill.intra.peff.net>
X-Provags-ID: V02:K0:XaFpE7G5e0PWjdBYznb+5OiIdfsWyHxNAAtrqPFEEGw
 y5TcCeQoSnkrQK+7nci29PaXly6tFwhevnvguKG5w/6RGlIkjg
 gDuo7P3Ly/AmUoR3sGUsHefurXKu0oh8UNX2g5z9OJTKl1VN+L
 AfGLpj9K4Z+I/XNf4j9FWexCB5q4bu2kzTikb/vobVIMD3X8lp
 U51j7hzxOuS0w55Hp0J1Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218959>

On 24.03.13 10:32, Jeff King wrote:
> On Sat, Mar 23, 2013 at 09:00:05PM -0700, Junio C Hamano wrote:
> 
>> On Thu, Mar 21, 2013 at 4:13 AM, Jeff King <peff@peff.net> wrote:
>>>
>>> According to 47ec794, this initialization is meant to
>>> squelch an erroneous uninitialized variable warning from gcc
>>> 4.0.1.  That version is quite old at this point, and gcc 4.1
>>> and up handle it fine, with one exception. There seems to be
>>> a regression in gcc 4.6.3, which produces the warning;
>>> however, gcc versions 4.4.7 and 4.7.2 do not.
>>>
>>
>> transport.c: In function 'get_refs_via_rsync':
>> transport.c:127:29: error: 'cmp' may be used uninitialized in this
>> function [-Werror=uninitialized]
>> transport.c:109:7: note: 'cmp' was declared here
>>
>> gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
> 
> Right, that's the same version I noted above. Is 4.6.3 the default
> compiler under a particular release of Ubuntu, or did you use their
> gcc-4.6 package?
> 
> -Peff
Side question:
How much does it hurt to write like this:

diff --git a/transport.c b/transport.c
index 6b2ae94..8020b62 100644
--- a/transport.c
+++ b/transport.c
@@ -106,7 +106,7 @@ static void insert_packed_refs(const char *packed_refs, struct ref **list)
                return;
 
        for (;;) {
-               int cmp, len;
+               int cmp=0, len;
 
==============

Using Ubuntu 10.4, using gcc (Ubuntu 4.4.3-4ubuntu5.1) 4.4.3
the compiler will add a line like this:

  2e83:	31 ff                	xor    %edi,%edi

(Which should not be to slow to execute)

Looking at a later gcc, from upcoming Debian, with gcc (Debian 4.7.2-5) 4.7.2
the assembly code is exactly the same ;-)
