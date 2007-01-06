From: "Fredrik Kuivinen" <frekui@gmail.com>
Subject: Re: fatal: unable to create '.git/index': File exists
Date: Sat, 6 Jan 2007 10:24:24 +0100
Message-ID: <4c8ef70701060124u3fa1dddfp5347a006c4ebb13d@mail.gmail.com>
References: <200701051150.09968.lenb@kernel.org>
	 <Pine.LNX.4.63.0701052115161.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Len Brown" <lenb@kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 06 10:24:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H37n1-0005a7-A1
	for gcvg-git@gmane.org; Sat, 06 Jan 2007 10:24:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbXAFJY0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 04:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbXAFJY0
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 04:24:26 -0500
Received: from wx-out-0506.google.com ([66.249.82.230]:44093 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751320AbXAFJYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 04:24:25 -0500
Received: by wx-out-0506.google.com with SMTP id h27so7382440wxd
        for <git@vger.kernel.org>; Sat, 06 Jan 2007 01:24:24 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iVMVYJ7J867qEdL3aDaTEsMCKkU17Ng+NKtpHiSYOezFPn7jF6ZDf2e3fv+nxXk5Y1cXT4Jt7JXjiB60YEeCS7SCgkWi5Hzev1t3URvNeItqVby4fXwkyhwF8uw9kg4eLOip0KzbuQXFrqNlZIYhb1VFCpBI0Sm0mGVCKIG/Jzs=
Received: by 10.70.116.1 with SMTP id o1mr44645498wxc.1168075464473;
        Sat, 06 Jan 2007 01:24:24 -0800 (PST)
Received: by 10.70.50.13 with HTTP; Sat, 6 Jan 2007 01:24:24 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0701052115161.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36077>

On 1/5/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 5 Jan 2007, Len Brown wrote:
>
> > I kicked off a pull.
> > Realized I was on the wrong branch
> > and immediately did a ^C
> >
> > Now I can't change branches:
> >
> > # git checkout release
> > fatal: unable to create '.git/index': File exists
>
> This usually means that .git/index.lock exists. Try removing that file.
>
> However, it _should_ be removed by the atexit() handler, methinks. I have
> no idea why it does not.

We will get SIGINT when the user hits ^C so I don't think the atexit handler
will run. However, we also install a signal handler for SIGINT which removes
the lock file, so I don't really see how it can be left around...

There is a small race condition between open and signal as we do

    fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
    ...
    signal(SIGINT, remove_lock_file_on_signal);
    atexit(remove_lock_file);

in lock_file:lockfile.c. But I think it is very improbable that the user hits ^C
between  "open" and "signal". It might be worth fixing though.

Are there any other signals we might get when the user hits ^C? SIGPIPE?

- Fredrik
