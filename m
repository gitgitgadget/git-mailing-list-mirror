From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Apr 2012, #06; Sun, 15)
Date: Thu, 19 Apr 2012 15:48:47 +0200
Message-ID: <4F9017BF.90702@viscovery.net>
References: <7vpqb8xjj9.fsf@alter.siamese.dyndns.org> <4F8E6A12.9090708@viscovery.net> <4F8F1BC1.3030607@ramsay1.demon.co.uk> <4F8FADCF.5000006@viscovery.net> <4F8FB4A0.7090403@viscovery.net> <20120419093608.GA19391@duynguyen-vnpc.dek-tpc.internal> <CABPQNSZ6VdyoLcVUUJ4z5A2A7KGP8qBZAkzdx8zAtAs2mZN25w@mail.gmail.com> <CACsJy8DDLmKkBMW_P8RyGTRw=i6OKWZNf-SHoGkVWnJgfK7cVQ@mail.gmail.com> <CABPQNSb9BSfmGu2bYtZUndgkTom=r+Ho_CKsDr7wo=jfxiXEjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu Apr 19 15:49:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKrjI-0007D5-EI
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 15:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357Ab2DSNs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 09:48:56 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:33001 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753047Ab2DSNsz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 09:48:55 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SKrj6-0008D3-LL; Thu, 19 Apr 2012 15:48:49 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 657111660F;
	Thu, 19 Apr 2012 15:48:48 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <CABPQNSb9BSfmGu2bYtZUndgkTom=r+Ho_CKsDr7wo=jfxiXEjA@mail.gmail.com>
X-Enigmail-Version: 1.4
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195945>

Am 4/19/2012 15:31, schrieb Erik Faye-Lund:
> int main(int argc, const char *argv[])
> {
>         int i, fd = open(__FILE__, O_RDONLY);
>         for (i = 0; i < 2; ++i) {
>                 char buf[11] = {0};
>                 mingw_pread(fd, buf, 10, 0);
>                 printf("buf = '%10s'\n", buf);
>         }
>         return 0;
> }

The test is flawed. It shows only that pread can read twice the same file
location. But it must not update the file pointer, whereas the
documentation of ReadFile says (quoting the paragraph that is relevant for
us):

  If hFile is not opened with FILE_FLAG_OVERLAPPED and lpOverlapped is
  not NULL, the read operation starts at the offset that is specified in
  the OVERLAPPED structure. ReadFile does not return until the read
  operation is complete, and then the system updates the file pointer.

Hence, your mingw_pread() looks like a workable solution for our purposes,
but is still not a 100% correct emulation of pread(). (Testing all this
will have to wait for another 18 hours or so.)

> Yeah. Other platforms are still an issue. You didn't address those
> either in your patch, even though it would be possible to modify it to
> deal with them by checking the NO_PREAD and NO_PTHREADS defines.
> 
> But they would still have the problem with the file-pointer racing for
> non-pread operations. Perhaps simply disabling threading is the better
> choice for these?

I think it is better to keep threading on in general, but only disable it
for index-pack. Why should existing users take a performance hit?

-- Hannes
