From: apodtele <apodtele@gmail.com>
Subject: Re: [PATCH 1/2] diff --stat: use asymptotic scaling in graph
Date: Fri, 13 Oct 2006 09:56:58 -0400
Message-ID: <d620685f0610130656u55079a1fkc2c98a82f3aa4a33@mail.gmail.com>
References: <d620685f0610121237k458665c5m7bbde2d565d7ef81@mail.gmail.com>
	 <7vlknlmc9y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 15:57:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYNXR-0001pk-4G
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 15:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWJMN5B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 09:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbWJMN5B
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 09:57:01 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:24367 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750836AbWJMN47 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Oct 2006 09:56:59 -0400
Received: by wr-out-0506.google.com with SMTP id i32so150965wra
        for <git@vger.kernel.org>; Fri, 13 Oct 2006 06:56:58 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oUl3IJ4kJ6IhFx7h0WkHCHbCuLbpVKH4Xf1ELp8lzjQ/JkRypvwGLhwJ1+A9545mOPZiaaejsR/lMAXQWqJjlVukqINPkqQNnPMB2VL+6VYUuGrESY0NKnOBJdOkxlQ4Po9aEmKXC9VIm/plldItTVuJa0r8K4a5M3GYjrDd2Mg=
Received: by 10.90.49.19 with SMTP id w19mr2235524agw;
        Fri, 13 Oct 2006 06:56:58 -0700 (PDT)
Received: by 10.90.95.6 with HTTP; Fri, 13 Oct 2006 06:56:58 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7vlknlmc9y.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28847>

On 10/12/06, Junio C Hamano <junkio@cox.net> wrote:
> apodtele <apodtele@gmail.com> writes:
> > Instead of conditionally scaling the stat graph for large changes,
> > always scale it asymptotically: small changes shall appear without any
> > distortions.
> I am not sure if any non-linear scaling is worth pursuing.
> Suppose your change set has three files modified:
>
>         A       adds 20 lines, deletes 10 lines
>         B       adds 10 lines, deletes 20 lines
>         C       adds 30 lines, deletes 30 lines
>
> For obvious reasons, the total length of A and B exceeds half of
> C, which looks quite misleading.
>
>          A | ++++++++++++--------
>          B | ++++++++------------
>          C | +++++++++++++++---------------

Before my patch is completely forgotten, let me critique the current
approach. Currently everything is great and beautiful unless one
particular change adds a couple of hundred lines, say, to a man page.
With large changes in play, small changes are squashed to a single
character. Would you argue that this scenario correctly represent
importance of man pages? Would you say, that it's not misleading that
1-, 2-, and 5-liners all look the same as long as a man page is
prominently shown? Moreover, 1-, 2-, and 5- liners may look different
depending on the size of that man page. The current approach is not
invariant; it is, however, normalized as needed. "Normalized" is good,
"as needed" is bad.

With asymptotic scaling, 1-, 2-, and 5- liners are correctly
represented by a correct number of characters, regardless of the size
of that man page. 10- and 20- liners are _slightly_ distorted. I
cannot stress it more: the representation will not depend on the size
of changes in other files! You will be able to tell where truly large
changes happened too! The price for this is that you won't be able to
precisely compare the sizes of added man pages.

It is your choice...
