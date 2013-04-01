From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: ZSH segmentation fault while completing "git mv dir/"
Date: Mon, 1 Apr 2013 04:11:34 -0600
Message-ID: <CAMP44s3ocY7qpESHCDRdHJBsH1DV+k1Z5OwSqsWndMZd_s6oBQ@mail.gmail.com>
References: <vpqd2v686fi.fsf@grenoble-inp.fr>
	<513DF4D1.6000500@gmail.com>
	<vpq8v5uueug.fsf@grenoble-inp.fr>
	<513E3190.20100@gmail.com>
	<20130312013736.GB7105@unpythonic.net>
	<vpqwqtdkq9z.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff Epler <jepler@unpythonic.net>,
	Manlio Perillo <manlio.perillo@gmail.com>,
	git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 01 12:12:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMbif-0008R3-BM
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 12:12:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756919Ab3DAKLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 06:11:36 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:34564 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958Ab3DAKLg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 06:11:36 -0400
Received: by mail-lb0-f182.google.com with SMTP id z13so1759199lbh.41
        for <git@vger.kernel.org>; Mon, 01 Apr 2013 03:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=tU5ao16F4UrUTr5NXGSvJjfeQsuUZQ5F8/Dy/WWz+vw=;
        b=Ck35afeo4x8AmRt5jilRzi1OpeQBDuGMYBMFwplkpY3bspNq0EJpOHyyDAVEVEIBmZ
         DgSGIvt5n7xlSDD25yXIDqwy2lG9UbVBOdX4ytZVm1OvZwG6NmfdfVdptewumQ9ES6Xf
         0pinvVktDX8jBkBIRU1g0OGICiHh6vkJ3X2tlX3uFi4uimSmlvumXdu+Ill4nuowWIA3
         DpziYVXqPdpJNBPcrNT5zKNKnQeSPjVe8RuAsOz9q+KjyZHjuxBxZfoSVGpzF68UI2uy
         dMYy7Z0fWpW8k4x+bmdnH7Himr2DHRwjgr7w/2Uh0cesJooQg6vwYoeodcccjcgAoIGT
         Fobg==
X-Received: by 10.112.130.201 with SMTP id og9mr5505680lbb.65.1364811094489;
 Mon, 01 Apr 2013 03:11:34 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Mon, 1 Apr 2013 03:11:34 -0700 (PDT)
In-Reply-To: <vpqwqtdkq9z.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219682>

On Tue, Mar 12, 2013 at 1:53 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:

> If I add a simple 'echo "$cur" >&2' instead of the case, the problem
> reappears. Somehow, the fact that I'm accessing $cur seems to create the
> segfault. Actually, the minimalistic _git_mv reproducing the problem is:
>
> _git_mv ()
> {
>         echo "$cur"
>         [ $(__git_count_arguments "mv") = 1 ]
>         __git_complete_index_file "--cached --others --directory"
> }

I managed to reproduce the issue, and to me, this is enough:

_git_mv ()
{
__gitcomp_file 'bar.txt' 'foo/'
}

And this is a workaround:

--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -66,7 +66,7 @@ __gitcomp_file ()

        local IFS=$'\n'
        compset -P '*[=:]'
-       compadd -Q -p "${2-}" -f -- ${=1} && _ret=0
+       compadd -Q -p "${2-}" -- ${=1} && _ret=0
 }

 _git ()

Cheers.

--
Felipe Contreras
