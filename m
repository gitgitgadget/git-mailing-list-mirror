From: Rafael Gieschke <rafael@gieschke.de>
Subject: Re: [PATCH] add Android support
Date: Tue, 17 May 2011 01:23:22 +0200
Message-ID: <D01E807D-C82C-4A8F-9678-9CEA92C413DA@gieschke.de>
References: <D2F37FDB-20C2-401A-AA90-DB4A50C27123@gieschke.de> <7vzkmmjqpx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 01:23:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM78X-0006zW-Ek
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 01:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755708Ab1EPXXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 19:23:35 -0400
Received: from smtp2.goneo.de ([212.90.139.82]:43230 "EHLO smtp2.goneo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753205Ab1EPXXe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 May 2011 19:23:34 -0400
Received: from smtp2.goneo.de (localhost [127.0.0.1])
	by scan.goneo.de (Postfix) with ESMTP id 01B451D1DB9;
	Tue, 17 May 2011 01:23:33 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.824
X-Spam-Level: 
X-Spam-Status: No, score=-2.824 tagged_above=-999 tests=[ALL_TRUSTED=-1,
	AWL=0.076, BAYES_00=-1.9] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
	by smtp2.goneo.de (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zdZhdpuzQ8aY; Tue, 17 May 2011 01:23:30 +0200 (CEST)
Received: from [10.151.107.254] (unknown [89.204.153.254])
	by smtp2-587.goneo.de (Postfix) with ESMTPSA id 67AA01D1C2B;
	Tue, 17 May 2011 01:23:27 +0200 (CEST)
In-Reply-To: <7vzkmmjqpx.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173773>


Am 16.05.2011 um 23:11 schrieb Junio C Hamano:

> Please do not throw in conditional compilation in a codepath that is
> otherwise generic.
> 
> Do something like this near the beginning of the file (or if they are
> common, in an appropriate header):
> 
>        #ifdef NO_GETPASS
>        #define getpass(ignored) NULL
>        #endif
> 
>        #ifdef NO_PW_GECOS
>        #define get_gecos(ignored) "&"
>        #else
>        #define get_gecos(struct_passwd) (struct_passwd->pw_gecos)
>        #endif
> 
> That way, you do not have to change connect.c at all, and the code that
> accesses gecos field would get a slight abstraction, i.e.
> 
> 	for (len = 0, dst = name, src = get_gecos(w); len < sz; src++) {
> 		...
> 

Thanks. Great idea, didn't think about that. See new patch.

> I however suspect that NO_GETPASS would be a useless thing in the longer
> term. Wouldn't you rather wish to have a native Android UI that asks a
> password and plug that implementation as a replacement for git_getpass()?
> 
> It might be worthwhile to study how mingw folks do this part before you
> dive in and butcher this codepath in a way you may regret later.
> 


I don't think that it is a lot of fun to call Android UI code from C as it is normally only done from Java.

The same problem occurs in dropbear on Android. There, it is solved by including a NetBSD version of getpass.c: https://github.com/CyanogenMod/android_external_dropbear/blob/master/netbsd_getpass.c .

If including NetBSD code is okay, the new patch will work. There currently is very limited use for this on Android, however, as there is no libcurl by default on Android. So, the only usage is git-imap-send, which works fine with this patch.

Compiling libcurl for Android should be possible with some work, though. So compat/getpass.c would be used for libcurl/HTTP access, too.
