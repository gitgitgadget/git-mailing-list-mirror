From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/4] make filepairs detachable
Date: Fri, 30 Jun 2006 09:42:01 +0200
Message-ID: <81b0412b0606300042r24931d9i5fad0e849b8de84c@mail.gmail.com>
References: <20060630002736.GB22618@steel.home>
	 <7vy7vfmoit.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <fork0@t-online.de>, git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 30 09:42:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwDdf-0006RM-DD
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 09:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWF3HmE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 03:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWF3HmE
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 03:42:04 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:65425 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751228AbWF3HmC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 03:42:02 -0400
Received: by nf-out-0910.google.com with SMTP id i2so184982nfe
        for <git@vger.kernel.org>; Fri, 30 Jun 2006 00:42:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V/isjY4oFJBABgNw+hSyk/EntDoeZXkYxMpBmmTxvG6LkBIFuF+0DsDHVZWRWCl6yht/kGJs4k4Ilrdh+lJ70Kwdh1YVVTFS7khl+D9cYn3+8Akj1olpj/IQayIyqHTdn/dICKRc3s1pMC3uxDkoJNHfQvvYcPPtMGUaal3aao4=
Received: by 10.78.122.11 with SMTP id u11mr73352huc;
        Fri, 30 Jun 2006 00:42:01 -0700 (PDT)
Received: by 10.78.37.7 with HTTP; Fri, 30 Jun 2006 00:42:01 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vy7vfmoit.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22966>

On 6/30/06, Junio C Hamano <junkio@cox.net> wrote:
>
> > Actually, just make sure diff_flush does not crash for diff queue
> > entries which were cleared.
>
> Somehow I really feel uneasy about this one.  I think it is the
> responsibility of the one who mangles the queue to adjust the
> entries and count consistent.
>

That's what I get after being exposed to double-linked lists for
too long: I begin to think it's fine to take whatever I want.
The pairs are actually exactly what I need, so I take them.
I think I just have to encapsulate it nicely, i.e.:

    struct diff_filepair *diff_queued_detach(int pos)
    {
        struct diff_filepair *pair = NULL;
        if (pos < diff_queued_diff.nr) {
            diff_queued_diff.queue[pos];
            if (diff_queued_diff.nr - pos > 1)
                memmove(pair->queue + pos, pair->queue + pos + 1,
                        diff_queued_diff.nr - pos - 1);
            diff_queued_diff.nr--;
        }
        return pair;
    }

BTW, is there any chance we get the struct diff_filepair's
double-linked? They don't seem to be sorted. Will increase
the memory footprint, though.
