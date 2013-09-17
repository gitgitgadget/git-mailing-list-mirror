From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] relative_path should honor dos_drive_prefix
Date: Tue, 17 Sep 2013 21:32:48 +0200
Message-ID: <5238AE60.1010700@kdbg.org>
References: <xmqq38pczjw6.fsf@gitster.dls.corp.google.com> <0688d5a5bd194ff5808c555e8e75132e2c687368.1378977052.git.worldhello.net@gmail.com> <5231CBFA.3070806@web.de> <5231F839.3080208@kdbg.org> <xmqq8uz1q2i4.fsf@gitster.dls.corp.google.com> <CANYiYbE6nT+9LrekWp7mryJ13RxQBSQ+p6EyQspAKBMj7oG0zQ@mail.gmail.com> <xmqq7gelmfm5.fsf@gitster.dls.corp.google.com> <CANYiYbH9pLMx4gu1qONhy-+++ojUhPSd9F=sdRTmGWH3pSUTqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?windows-1252?Q?Torsten_B=F6ge?= =?windows-1252?Q?rshausen?= 
	<tboegi@web.de>, Git List <git@vger.kernel.org>,
	Tvangeste <i.4m.l33t@yandex.ru>,
	Karsten Blees <karsten.blees@gmail.com>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 21:33:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VM11D-0005la-2h
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 21:33:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976Ab3IQTcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 15:32:54 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:7117 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753420Ab3IQTcx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 15:32:53 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 14CB410011;
	Tue, 17 Sep 2013 21:32:50 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 05E9219F3F7;
	Tue, 17 Sep 2013 21:32:48 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CANYiYbH9pLMx4gu1qONhy-+++ojUhPSd9F=sdRTmGWH3pSUTqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234907>

Am 17.09.2013 10:24, schrieb Jiang Xin:
> I have checked the behavior of UNC path on Windows (msysGit):
> 
> * I can cd to a UNC path:
> 
>     cd //server1/share1/path
> 
> * can cd to other share:
> 
>     cd ../../share2/path
> 
> * and can cd to other server's share:
> 
>     cd ../../../server2/share/path
> 
> That means relative_path(path1, path2) support UNC paths out of the box.
> We only need to check both path1 and path2 are UNC paths, or both not.

Your tests are flawed. You issued the commands in bash, which (or rather
MSYS) does everything for you that you need to make it work. But in
reality it does not, because the system cannot apply .. to //server/share:

$ git ls-remote //srv/public/../repos/his/setups.git
fatal: '//srv/public/../repos/his/setups.git' does not appear to be a
git repository
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.

even though the repository (and //srv/public, let me assure) exists:

$ git ls-remote //srv/repos/his/setups.git
bea489b0611a72c41f133343fdccbd3e2b9f80b5        HEAD
...

The situation does not change with your latest round (v3).

Please let me suggest not to scratch where there is no itch. ;) Your
round v2 was good enough.

If you really want to check UNC paths, then you must compare two path
components after the the double-slash, not just one.

Furthermore, you should audit all code that references
is_absolute_path(), relative_path(), normalize_path_copy(), and possibly
a few others whether the functions or call sites need improvement.
That's worth a separate patch.

-- Hannes
