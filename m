From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Problem with S_IFGITLINK
Date: Thu, 25 Aug 2011 06:15:20 +0700
Message-ID: <CACsJy8Dgz92YqBnqjvMS9KqtNoNTyrP_0ZqEqTurGnVfTzriUQ@mail.gmail.com>
References: <4E54F364.7000503@gmail.com> <4E550E03.3080104@drmicha.warpmail.net>
 <4E551904.303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: =?UTF-8?Q?Adam_K=C5=82obukowski?= <adamklobukowski@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 25 01:15:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwMfs-0007UD-EF
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 01:15:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533Ab1HXXPw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Aug 2011 19:15:52 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50601 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112Ab1HXXPv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Aug 2011 19:15:51 -0400
Received: by bke11 with SMTP id 11so1283115bke.19
        for <git@vger.kernel.org>; Wed, 24 Aug 2011 16:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=VI+UnKEPEkEvFnm28Zef4hZHAzE54pjwJiM1T8GV/i0=;
        b=OJ2gETmaGID19kUGaTHqnRbqXZSXJ9cwAc8p+OR51Ux1+d0qa3cC1YhuNtAEHW6mFn
         ii8GcbAJZy7vOUeIgl9ZO3ns/OjKfI3VxTP3BnLsvzZJ68IG1hqCg+K0/zsp5J0KLyoj
         k6U9mRi5a1JxBST6VtePv5oVdPJpTRWY1zmT8=
Received: by 10.204.155.81 with SMTP id r17mr2508508bkw.19.1314227750118; Wed,
 24 Aug 2011 16:15:50 -0700 (PDT)
Received: by 10.204.156.24 with HTTP; Wed, 24 Aug 2011 16:15:20 -0700 (PDT)
In-Reply-To: <4E551904.303@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180050>

2011/8/24 Adam K=C5=82obukowski <adamklobukowski@gmail.com>:
> I may try to implement it, but I my knowledge of Git internals is equ=
al to
> zero. If someone can point me what has to be done - I'll be gratefull=
=2E

Git stores mode in the index (struct cache_entry#ce_mode, cache.h) and
in tree objects (see tree-walk.c). Basically you define a new set of
S_IS* and S_IF* macros and use them instead of standard ones.
Translations from struct stat#st_mode will be needed, I think
ce_mode_from_stat() does that job.

So:
 - read index and checkout: entry.c
 - read and update index: read-cache.c
 - read tree objects: tree-walk.c
 - write tree objects: cache-tree.c
 - anywhere that checks struct cache_entry#ce_mode needs to convert to
use the new defines

Another way, less changes, is redefine S_IS* and S_IF* and ignore
system values. Then make wrapper for stat() and lstat(), convert
system values to git values. You can put these wrappers in compat
directory. See git-compat-util.h, mingw port for example already
redefine these functions for Windows platform.
--=20
Duy
