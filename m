From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 3/5] refactor userdiff textconv code
Date: Fri, 24 Oct 2008 16:01:59 +0200
Message-ID: <4901D557.90106@viscovery.net>
References: <20081024024631.GA20365@coredump.intra.peff.net> <20081024025330.GC2831@coredump.intra.peff.net> <4901762A.3090003@viscovery.net> <20081024135132.GA11568@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 24 16:04:13 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtNGK-0006um-Du
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 16:03:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078AbYJXOCK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 10:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752158AbYJXOCJ
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 10:02:09 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:51189 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751500AbYJXOCI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 10:02:08 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KtP6j-0006a8-AF; Fri, 24 Oct 2008 18:01:49 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 6E6534FB; Fri, 24 Oct 2008 16:01:59 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20081024135132.GA11568@coredump.intra.peff.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99039>

Jeff King schrieb:
> On Fri, Oct 24, 2008 at 09:15:54AM +0200, Johannes Sixt wrote:
> Actually, I don't think this is right. The typechange has been broken
> into two parts: the removal of the file contents and the addition of the
> symlink. So the first part _should_ use the textconv, since it is just
> comparing the file contents to /dev/null. But the second part should
> not, since it is by definition just the text of the symlink. Ditto for
> gitlinks, which have a special text representation. So how about this?

Your reasoning makes sense, of course. (I thought that forgoing textconv
in these cases would have a simpler implementation; but it can't be a lot
simpler than yours.)

> diff --git a/diff.c b/diff.c
> index 52feba7..ce1317d 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -289,6 +289,9 @@ static int diff_filespec_textconv(struct diff_filespec *one)
>  	if (!DIFF_FILE_VALID(one))
>  		return 0;
>  
> +	if (!S_ISREG(one->mode))
> +		return 0;
> +
>  	diff_filespec_load_driver(one);
>  	if (!one->driver->textconv)
>  		return 0;
...
> +test_expect_failure 'textconv does not act on symlinks' '

Can we trust your solution if you still have 'test_expect_failure' here? ;-)

-- Hannes
