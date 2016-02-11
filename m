From: Shawn Pearce <spearce@spearce.org>
Subject: Re: RFC: Resumable clone based on hybrid "smart" and "dumb" HTTP
Date: Thu, 11 Feb 2016 10:04:32 -0800
Message-ID: <CAJo=hJt=hYf27bTcuyZEsn1w5CAXC=BoFfCcLGQ7ZmXe-g4SKg@mail.gmail.com>
References: <CAJo=hJtHgE_vye_1sPTDsvJ0X=Cs72HKLgRH8btpW-pMrDdk9g@mail.gmail.com>
 <CAJo=hJuRxoe6tXe65ci-A35c_PWJEP7KEPFu5Ocn147HwVuo3A@mail.gmail.com>
 <CAGZ79kZMvxa5Np4GbShv_A6NZwVAqff94+d8MFTZwrZS+2CqeQ@mail.gmail.com>
 <20160210210115.GA10155@google.com> <xmqqfuwzykr5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 11 19:04:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTvbt-0000uD-BC
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 19:04:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbcBKSEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 13:04:53 -0500
Received: from mail-vk0-f44.google.com ([209.85.213.44]:35610 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbcBKSEw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 13:04:52 -0500
Received: by mail-vk0-f44.google.com with SMTP id e6so42624949vkh.2
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 10:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cYpLLX44785xwrEYjhExGf6vTMhCJ804luPm3GsQ5o8=;
        b=SmOiIkeLJFPCUmzvdG7KEFM5A12roX8P8Sytgx33OT0uJGom5+acYvJetEG3hh3MUC
         xpJvjJnhUbF8eHSbll24QGml0wU9nXTf9CAroTPk7fj2CdJjOa+lYCBLoTcDSL2kDaFZ
         ZRyl+B0c1/Eyhu4lIGRqfux2inO3OkUNRarP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=cYpLLX44785xwrEYjhExGf6vTMhCJ804luPm3GsQ5o8=;
        b=NVJtLEgvWxs7JIPLYqf6nup3WFTj8CuU+fqqIgY2l19j5K/LWHGLgeTifIKTesWwev
         UWmlkUp6ArC1TPdbpR2EtJ6zpkgWV+eDBd1GvY6PZrhhGr+t6SAaqgQ2wuM8yGINwjse
         mbAMhyj4RyXzGRpJuiBdJJmOq0vjGWwG4Uf+R5X+rHgFUa1s/oxAoBA044sEif1uQl/q
         AI1n/Gpwo+y85HiA1j5aVVRE+mnBfrUaL7Fk50CXYyMpwXO8U9hTDTZxLCRv17I1ZNmH
         VGJVEDXhFezbHGM5QgVBclrIStfHINWSzjcKURAKep3CsphaUTjr9WN1ERaNb35Yu/TJ
         zUXg==
X-Gm-Message-State: AG10YOSFytj+jRaWrp194r/lksF8e9WvCjovArQNNUg2L6GBsUNH4qXPkP4JZ442FfMgaI8ZSEmfcz+HntHzaA==
X-Received: by 10.31.133.19 with SMTP id h19mr35177902vkd.127.1455213891917;
 Thu, 11 Feb 2016 10:04:51 -0800 (PST)
Received: by 10.103.71.211 with HTTP; Thu, 11 Feb 2016 10:04:32 -0800 (PST)
In-Reply-To: <xmqqfuwzykr5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285988>

On Wed, Feb 10, 2016 at 7:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> I really like this design.  I'm tempted to implement it (since it
>> lacks a bunch of the downsides of clone.bundle).
>
> Just to see people are not stepping on each others toe, implementing
> slightly different components in parallel based on the same theme to
> solve the same problem, it may be beneficial to have a list of a bit
> more detailed breakdown of the necessary parts.
>
> I think possible small first steps include:
>
>  * A new "--split-header" option to "git bundle" that allows the
>    command to write out two files;
>
>  * An update to the "bundle" transport so that it understand the new
>    split bundle format (i.e. when you have base.bndl that refers to
>    pack-deadbeef.pack, you can still say "git clone base.bndl" and
>    "git ls-remote base.bndl");
>
>  * A new "--bundle-header" option to "git index-pack", which makes
>    it to write out the bundle header file that references the
>    resulting packfile in addition to the pack .idx file (this should
>    also be able to "fix" thin pack, and also by keeping track of the
>    actual "foreign" objects not just number of them, compute and
>    record the list of prerequisite objects in the resulting bundle
>    header file).
>
> Am I on the right track?  Assuming I am, anything I missed?

--bundle-header option for pack-objects so that repack/gc can create
the matching .info file?

I waffled on the URL in the capabilities line, but I think Peff
convinced me earlier in the thread that its reasonably safe to do. So
this split bundle with header URL in the capabilities sounds like a
good approach, its just a matter of implementation. :)
