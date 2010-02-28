From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] sha1_name: fix segfault caused by invalid index access
Date: Sun, 28 Feb 2010 17:20:06 +0100
Message-ID: <vpq7hpxl4cp.fsf@bauges.imag.fr>
References: <1267372155-7578-1-git-send-email-markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Sun Feb 28 17:23:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NllvT-0006kl-RB
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 17:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030243Ab0B1QXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 11:23:22 -0500
Received: from imag.imag.fr ([129.88.30.1]:37718 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964812Ab0B1QXV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 11:23:21 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id o1SGK6pL017295
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 28 Feb 2010 17:20:06 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NllsE-0004C2-AD; Sun, 28 Feb 2010 17:20:06 +0100
In-Reply-To: <1267372155-7578-1-git-send-email-markus.heidelberg@web.de> (Markus Heidelberg's message of "Sun\, 28 Feb 2010 16\:49\:15 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.91 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 28 Feb 2010 17:20:07 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141254>

Markus Heidelberg <markus.heidelberg@web.de> writes:

> I didn't find a recipe for reliably reproducing it in a repository with
> working tree, it happened depending on the filename and the repository.
>     $ git show :nonexistentfile

> It seemed to happen more likely with high letters (x, y, z) as the first
> character of the filename. This always worked for me:
>     $ git show :z

It happens when you ask for a filename that is after the last index
entry by alphabetical order, yes. pos will contain an index which is
after the previous entry, that is, after the last entry. And then, the
active_cache[pos] crashes.

> The affected code path was introduced by commit 009fee477 (Detailed diagnosis
> when parsing an object name fails., 2009-12-07).

Yes, my bad :-(. Thanks for the report and the fix :-).

>  	pos = cache_name_pos(filename, namelen);
>  	if (pos < 0)
>  		pos = -pos - 1;

Actually, if pos < 0, then cache_name_pos didn't find the entry,
and we shouldn't try any complex thing to find out.

A simpler fix is comming in a separate email. I'm still not familiar
enough with the index to be 100% confident, but it should do the same
as yours in a much simpler way. Reviews welcome.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
