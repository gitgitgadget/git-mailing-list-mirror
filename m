From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH] detection of directory renames
Date: Thu, 25 Sep 2008 16:19:20 -0700 (PDT)
Message-ID: <m3bpyb3jci.fsf@localhost.localdomain>
References: <7vfxojtr9t.fsf@gitster.siamese.dyndns.org>
	<20080925213819.27029.47944.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Fri Sep 26 01:20:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kj08O-0007Sh-Px
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 01:20:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753661AbYIYXTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 19:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753557AbYIYXTY
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 19:19:24 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:34917 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753180AbYIYXTX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 19:19:23 -0400
Received: by fk-out-0910.google.com with SMTP id 18so631158fkq.5
        for <git@vger.kernel.org>; Thu, 25 Sep 2008 16:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=KU2/uISQLrURk0foGSyGo1FUMe7S0dWrS8GJSh3ISLg=;
        b=AmFfWBsplnvVfuByBF7FWeg9SWsr91mNF+2GKRgjebLPzI5qJx3x+LsC568Teq7fOR
         EuSMntBGluIgLZxuFWYXJw4tBnsfDQCEKzvSeeHi7pdtXSCszsbIiMTnl9WDpHFJl16Y
         YHyTsn1ukALns7Hksrjy0nEAThuMkGdTFF2OU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=FHNx3whdhdLyyVWExoYPYEhk9pdic7f+ddn6aUnpqNeI+pES3CVKyFtoIg7+k94QK/
         02ufCIpA3km0q5qCM4g0PeyQQIPsYWJQwAxBNuWlU2JMn850aH3XZM4dkYC2oVIDJKhk
         JkDDkTeajkvDSfWMmk1Eax2h4lhWXTB4E6+FE=
Received: by 10.103.229.19 with SMTP id g19mr366942mur.19.1222384761694;
        Thu, 25 Sep 2008 16:19:21 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.235.56])
        by mx.google.com with ESMTPS id j10sm1447006muh.1.2008.09.25.16.19.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Sep 2008 16:19:20 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m8PNIuRv002569;
	Fri, 26 Sep 2008 01:19:01 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m8PNIcv5002565;
	Fri, 26 Sep 2008 01:18:38 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080925213819.27029.47944.stgit@gandelf.nowhere.earth>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96816>

Yann Dirson <ydirson@altern.org> writes:

> This is a first very preliminar patch, mostly so people can comment
> early on the big picture.  It has a number of limitations, many but
> not all already listed as FIXME's in the patch itself.  If anything in
> this patch seems so wrong it is not worth polishing it, it's the
> perfect time to say so :)
> 
> The idea is to add a new pass to diffcore-rename, to group file renames
> looking like a full directory move, and then to hide those file
> renames which do not carry any additionnal information.
> 
> Here is a sample run:
> 
> $ ./git-diff-tree ee491 --factorize-renames -r 
> [DBG] possible rename from arm/ to bar/
> [DBG] possible rename from ppc/ to moved/
> [DBG] discarding dir rename of arm/, mixing moved/ and bar/
> [DBG] ppc/* -> moved/* makes ppc/sha1ppc.S -> moved/sha1ppc.S uninteresting
> [DBG] ppc/* -> moved/* makes ppc/sha1.c -> moved/sha1.c uninteresting
> ee491a42190ec6e716f46a55fa0a7f4e307f1629
> :040000 040000 0000000000000000000000000000000000000000 0000000000000000000000000000000000000000 R100   ppc/    moved/
> :100644 100644 9e3ae038e818f4e21bc50f864fc5204f6fa44daa 9e3ae038e818f4e21bc50f864fc5204f6fa44daa R100   arm/sha1.c      bar/sha1.c
> :100644 100644 3952646349cf9d033177e69ba9433652a378c0e9 3952646349cf9d033177e69ba9433652a378c0e9 R100   arm/sha1.h      bar/sha1.h
> :100644 100644 c3c51aa4d487f2e85c02b0257c1f0b57d6158d76 c065eeef7d68ea91863431788e20cd814c5ac52c R099   ppc/sha1.h      moved/sha1.h
> :100644 100644 8c1cb99fb403875af85e4d1524d21f7eb818f59b 8c1cb99fb403875af85e4d1524d21f7eb818f59b R100   arm/sha1_arm.S  moved/sha1_arm.S

Wonderfull!!!

I like it very much, and hope that it would get improved. And that you
would be able to use it in merges too, to allow for example for new
files to be created in renamed directory instead of old one which does
not exist any longer (c.f. http://www.markshuttleworth.com/archives/123
and following articles).

For the future, could you show examples with --abbrev option in use? TIA.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
