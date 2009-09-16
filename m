From: Alexey Borzenkov <snaury@gmail.com>
Subject: Re: [PATCH 04/15] Set _O_BINARY as default fmode for both MinGW and 
	MSVC
Date: Thu, 17 Sep 2009 00:00:38 +0400
Message-ID: <e2480c70909161300o3db4b416k8f33ccce2f987c55@mail.gmail.com>
References: <cover.1253088099.git.mstormo@gmail.com>
	 <213f3c7799721c3f42ffa689498175f0495048eb.1253088099.git.mstormo@gmail.com>
	 <26c067500d8adf17a2d75e2956e4d4a6cef27fc1.1253088099.git.mstormo@gmail.com>
	 <6e6345fb3fbc19b1a2467e33e1633fe9025e547b.1253088099.git.mstormo@gmail.com>
	 <929c5a34cd2621af24bcda7e47ff2e76b51c2e09.1253088099.git.mstormo@gmail.com>
	 <4AB10F01.9010703@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marius Storm-Olsen <mstormo@gmail.com>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	gitster@pobox.com, j6t@kdbg.org, lznuaa@gmail.com,
	raa.lkml@gmail.com,
	Marius Storm-Olsen <marius.storm-olsen@nokia.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 22:00:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo0gJ-0002UX-DD
	for gcvg-git-2@lo.gmane.org; Wed, 16 Sep 2009 22:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755973AbZIPUAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 16:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755902AbZIPUAg
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 16:00:36 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:54429 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755782AbZIPUAf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 16:00:35 -0400
Received: by fxm17 with SMTP id 17so2544237fxm.37
        for <git@vger.kernel.org>; Wed, 16 Sep 2009 13:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=GlX40LLUn9OOwvxp0QUk6VwvaPMDu5osmPRfD+WCCes=;
        b=pZ2+42Py5+nSCyUL8Al+Ud4aMHoI8azqlqvTzKFrpa0Su3bTA8kiIiDNeLduYwFyo7
         NfsK6v9k65EZrIzac0SvfEpna3WYNuthSb8tATFuoZCDvMMfG3aRgThL+YrswmGIAE/w
         31Gh+Qyf02eezArXsKkSp5fu3PHuoGHq7tgv0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=djsKnElzAHGABaYJFZY5zwyyWT544T8yIG2xKrGy1//z8iw86F0myK0x2wDyIH7e07
         9DtezJKn3VQttW4lTOjcp1y4b25X5WJuztlZgjKitGblaKvfRUsI8tsdqXgkfvod1w4U
         X3y5hahBeiXdnr/A8/85qqmCHWxCA6r32abUA=
Received: by 10.223.4.148 with SMTP id 20mr3372997far.0.1253131238160; Wed, 16 
	Sep 2009 13:00:38 -0700 (PDT)
In-Reply-To: <4AB10F01.9010703@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128673>

On Wed, Sep 16, 2009 at 8:14 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> MinGW set the _CRT_fmode to set both the default fmode and
>> _O_BINARY on stdin/stdout/stderr. Rather use the main()
>> define in mingw.h to set this for both MinGW and MSVC.
>>
>> This will ensure that a MinGW and MSVC build will handle
>> input and output identically.
> This one breaks t5302-pack-index.sh (test 15, "[index v1] 2) create a
> stealth corruption in a delta base reference") in my MinGW build. I have
> yet to find out what exactly goes wrong and how it could be fixed.

Looks like calling _setmode in main is too late for something. :-/

I tried defining int _fmode in mingw.c (which sets msvcrt's _fmode
early, without calling _setmode), and it didn't work either (i.e. the
bug was still happening). So the culprit must be in _setmode. I also
tried logging what index_obj_offset and index_obj_nr are showing, and
here are results:

/* with _CRT_fmode = _O_BINARY */
index_obj_offset: 844032
index_obj_nr: 205

/* without _CRT_fmode = _O_BINARY */
index_obj_offset: 844235
index_obj_nr: 298

I then tried to see what git show-index actually returns there, and
here are several top lines of the results:

/* with _CRT_fmode = _O_BINARY */
850186 0106e17481932f5c223fafadc1d26abc6adf40d6
203652 01179d82b18c252824e20e190543e0e84950d820
15576 0246ff570c396c37ff08c0f5f9d88c84fc21a297
851536 035e7e54cee9eb197af435b6b6dcced489c233f6
376062 03a6f56dbbb556425ef8c43c31519b32eb5629a4
39452 0471b3b8ab8da19f3968dc238e9555f4e48ce858
8230 0483297992ed4cd5ab3b5790912b1f03598ea660
72292 0508b858e01f0367552fb14722388ba48dbd36f7

/* without _CRT_fmode = _O_BINARY */
844235 01a8d3f6d063d48baf40ee656804aa58486a34b2
851754 035e7e54cee9eb197af435b6b6dcced489c233f6
851844 04ff7bd225fbb4842697af96c147a4ddecb6a657
848233 088ddcb945af72c47348b65a63992c71b6b9dbe8
849676 088e69e7ab273e35b4f63ecb1b915a3997f13dff
14825 09bd72201f82a0da14a52230e2ccd0e43529e779
9848 0a5916ad398380ba103d98bad6fa4f2b20b74e75
695905 0ae5469e687083bbf954262873ee8c0c7d017e75

As you can see the hashes are completely different! Unfortunately I
also can't pinpoint where this actually happens... :-/

*several minutes later*

Searching which executables set _fmode and which don't I found the
culprit. test-genrandom.c didn't include git-compat-util.h, so mingw.h
was never included. This caused different random data to be generated,
and as it seems more importantly, of different sizes. Can be fixed
with this patch:

diff --git a/test-genrandom.c b/test-genrandom.c
index 8ad276d..b3c28d9 100644
--- a/test-genrandom.c
+++ b/test-genrandom.c
@@ -4,8 +4,7 @@
  * Copyright (C) 2007 by Nicolas Pitre, licensed under the GPL version 2.
  */

-#include <stdio.h>
-#include <stdlib.h>
+#include "git-compat-util.h"

 int main(int argc, char *argv[])
 {

Or maybe there's a hidden bug in git that gets uncovered with slightly
different random data, I don't know. I'm glad I could finally solve
this mindbending issue. :)
