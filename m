From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC/PATCH v2 1/1] cygwin: Add fast_lstat() and fast_fstat()
 functions
Date: Tue, 16 Jul 2013 22:36:31 +0100
Message-ID: <51E5BCDF.5070004@ramsay1.demon.co.uk>
References: <51DDC2AF.9010504@ramsay1.demon.co.uk> <51E2CE97.2040900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: mhagger@alum.mit.edu, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, tboegi@web.de,
	dpotapov@gmail.com, GIT Mailing-list <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 16 23:44:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzD2h-0001yf-DN
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 23:44:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933686Ab3GPVoN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 17:44:13 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:34311 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933627Ab3GPVoM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 17:44:12 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id C80571280A8;
	Tue, 16 Jul 2013 22:44:10 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id CE7701280A7;
	Tue, 16 Jul 2013 22:44:09 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Tue, 16 Jul 2013 22:44:02 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <51E2CE97.2040900@gmail.com>
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230588>

Mark Levedahl wrote:
> On 07/10/2013 04:23 PM, Ramsay Jones wrote:
>> Commit adbc0b6b ("cygwin: Use native Win32 API for stat", 30-09-2008)
>> added a Win32 specific implementation of the stat functions. In order
>> to handle absolute paths, cygwin mount points and symbolic links, this
>> implementation may fall back on the standard cygwin l/stat() functions.
>> Also, the choice of cygwin or Win32 functions is made lazily (by the
>> first call(s) to l/stat) based on the state of some config variables.
>>
>> Unfortunately, this "schizophrenic stat" implementation has been the
>> source of many problems ever since. For example, see commits 7faee6b8,
>> 79748439, 452993c2, 085479e7, b8a97333, 924aaf3e, 05bab3ea and 0117c2f0.
>>
>> In order to limit the adverse effects caused by this implementation,
>> we provide a new "fast stat" interface, which allows us to use this
>> only for interactions with the index (i.e. the cached stat data).
>>
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>> ---
> 
> I've tested this on Cygwin 1.7 on WIndows 7 , comparing to the results 
> using your prior patch (removing the Cygwin specific lstat entirely) and 
> get the same results with both, so this seems ok from me.

Thank you for testing this.

> My comparison point was created by reverting your current patch from pu, 
> then reapplying your earlier patch on top, so the only difference was 
> which approach was used to address the stat functions.
> 
> Caveats:
> 1) I don't find any speed improvement of the current patch over the 
> previous one (the tests actually ran faster with the earlier patch, 
> though the difference was less than 1%).
> 2) I still question this whole approach, especially having this 
> non-POSIX compliant mode be the default. Running in this mode breaks 
> interoperability with Linux, but providing a Linux environment is the 
> *primary* goal of Cygwin.

Yes, I agree. Since I _always_ disable the Win32 stat functions (by
setting core.filemode by hand - yes it's a little annoying), I don't
get any "benefit" from the added complexity.

However, I don't use git on cygwin with *large* repositories. git.git
is pretty much as large as it gets. So, the difference in performance
for me amounts to something like 0.120s -> 0.260s, which I can barely
notice.

Other people may not be so lucky ...

I would be happy if my original patch (removing the win32 stat funcs)
was applied, but others may not be. :-P

ATB,
Ramsay Jones
