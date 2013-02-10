From: demerphq <demerphq@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Sun, 10 Feb 2013 14:26:55 +0100
Message-ID: <CANgJU+WYSD8RHb19EP0M89=Y_XskfjDtFWf51qjg4ur+rDb3ug@mail.gmail.com>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com>
	<7vehgqzc2p.fsf@alter.siamese.dyndns.org>
	<7va9rezaoy.fsf@alter.siamese.dyndns.org>
	<7vsj56w5y9.fsf@alter.siamese.dyndns.org>
	<9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
	<CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
	<CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com>
	<CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com>
	<CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
	<CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com>
	<20130210111732.GA24377@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 14:33:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4X2V-0000U2-U7
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 14:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754918Ab3BJNd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 08:33:26 -0500
Received: from mail-qc0-f179.google.com ([209.85.216.179]:51708 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754544Ab3BJNdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 08:33:25 -0500
Received: by mail-qc0-f179.google.com with SMTP id b40so1930171qcq.38
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 05:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=W3yrCN3JGY+e3sVdgtnOCjH6SzWz3YIpTGUlv/qEM3M=;
        b=nPS0p4eQnCgDa+o/mw+cQ+MbW8SuNinOxOSHWygCeuIE7OX7Mb/5ie32gaFzF/FsyS
         /5KrRVuP4qjsUNDNrRIG31b6IqSGO/LGBqykZbVyj/IZqaf/QIqHYJ8kxZcg1kI/5rCB
         Rjrx/OK8Fheig/G8gSZDSbjuXhHTPDMhMF9dnAh+5o+HwwTlBkU/E/HIUg5XBSiKCFTU
         zxLZuIHkPXmYV1MIFO/ByxqxAM/s4+aMBVJvcVupjsC1NapNkAc37tS6iRe/BC4WePFQ
         hQzlOqAffow+/GIWdJBfIspSHpJe+OyLOvZu0di/g8Dam2cxlmY8UQetTgTahCEGX++Y
         2gZA==
X-Received: by 10.224.31.16 with SMTP id w16mr4074755qac.52.1360502815921;
 Sun, 10 Feb 2013 05:26:55 -0800 (PST)
Received: by 10.49.94.196 with HTTP; Sun, 10 Feb 2013 05:26:55 -0800 (PST)
In-Reply-To: <20130210111732.GA24377@lanh>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215904>

On 10 February 2013 12:17, Duy Nguyen <pclouds@gmail.com> wrote:
> Bear in mind though this is Linux, where lstat is fast. On systems
> with slow lstat, these timings could look very different due to the
> large number of lstat calls compared to open+getdents. I really like
> to see similar numbers on Windows.

Is windows stat really so slow? I encountered this perception in
windows Perl in the past, and I know that on windows Perl stat
*appears* slow compared to *nix, because in order to satisfy the full
*nix stat interface, specifically the nlink field, it must open and
close the file*. As of 5.10 this can be disabled by setting a magic
var ${^WIN32_SLOPPY_STAT} to a true value, which makes a significant
improvement to the performance of the Perl level stat implementation.
I would not be surprised if the cygwin implementation of stat() has
the same issue as Perl did, and that stat appears much slower than it
actually need be if you don't care about the nlink field.

Yves
* http://perl5.git.perl.org/perl.git/blob/HEAD:/win32/win32.c#l1492

-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
