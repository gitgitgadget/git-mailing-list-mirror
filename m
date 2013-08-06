From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: About close() in commit_lock_file()
Date: Tue, 06 Aug 2013 08:41:20 +0200
Message-ID: <52009A90.7050701@viscovery.net>
References: <CACsJy8By1cpPZ5QyVd6VhKSkd-y_E6pTYdDimK9P0wXia-uMqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 08:41:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6axW-0001os-6F
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 08:41:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754295Ab3HFGl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 02:41:26 -0400
Received: from so.liwest.at ([212.33.55.14]:7182 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753917Ab3HFGl0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 02:41:26 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1V6axN-00027C-9j; Tue, 06 Aug 2013 08:41:21 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 0C4351660F;
	Tue,  6 Aug 2013 08:41:20 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <CACsJy8By1cpPZ5QyVd6VhKSkd-y_E6pTYdDimK9P0wXia-uMqg@mail.gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231725>

Am 8/5/2013 16:23, schrieb Duy Nguyen:
> close() is added in commit_lock_file(), before rename(), by 4723ee9
> (Close files opened by lock_file() before unlinking. - 2007-11-13),
> which is needed by Windows. But doesn't that create a gap between
> close() and rename() on other platforms where another process can
> replace .lock file with something else before rename() is executed?

First, files manipulated by commit_lock_file() are to be opened only using
lock_file() by definition. Opening such a file in with open() or fopen()
or renaming it via rename() without using the lockfile.[ch] API is
possible regardless of whether commit_lock_file() has closed the file or
not. Such manipulation is already undefined behavior (from Git's point of
view), and there is nothing we can do about "misbehaving" processes.

Second, lock_file() uses O_CREAT|O_EXCL, which fails when the file exists,
regardless of whether it is open or not.

Conclusion: There is no problem.

-- Hannes
