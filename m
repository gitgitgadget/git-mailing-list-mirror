From: Bo Chen <chen@chenirvine.org>
Subject: Re: GSoC - Some questions on the idea of
Date: Fri, 30 Mar 2012 19:08:42 -0400
Message-ID: <CA+M5ThR6jtxqs0-Kz-8fcRuOFRbLr-GvsJcTmrOQ7_geNspDLg@mail.gmail.com>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com>
	<CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com>
	<loom.20120328T131530-717@post.gmane.org>
	<CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com>
	<20120330203430.GB20376@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sergio <sergio.callegari@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 31 01:08:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDkw7-0000Hu-OT
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 01:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934730Ab2C3XIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 19:08:48 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:53781 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757162Ab2C3XIn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 19:08:43 -0400
Received: by wgbdr13 with SMTP id dr13so996839wgb.1
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 16:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-originating-ip:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type:x-gm-message-state;
        bh=24Iuhi3ukZKQno/Xw1VqWuzavr+Imq3QO12ezsTNU08=;
        b=eqV1ztDb0DXpGf1mPq9dYEwO5MLikXsMKanFuwK3g8pDpBLgBfdMomGpg4wB2PaXf4
         zup/nyBVWGbdwyeAhsM7seD9Sf+Iy1MqzSITVQm6s9cllyfXDErLoK/ghTKMT7G6XFi+
         BOlm+m0a9YH8MPCcZbalSGhOzgbLSKppdXvLlOoXwkejNj75UdPlrpDUKJySAUiX9OqI
         g1+SHeJgIe/epOkkpGacWOO2GWyT5isR15Fcp3r9mRMDspCctj/6lcD/tBteMZgWCVN7
         UhO/qoVCnad8+n/0gom/1vcSXGRsfEW2EMrr1VbRLjtPiwtMMgEp3uJPT0viaWTFPWRp
         EgSQ==
Received: by 10.180.80.104 with SMTP id q8mr806380wix.14.1333148922197; Fri,
 30 Mar 2012 16:08:42 -0700 (PDT)
Received: by 10.180.81.70 with HTTP; Fri, 30 Mar 2012 16:08:42 -0700 (PDT)
X-Originating-IP: [128.235.34.66]
In-Reply-To: <20120330203430.GB20376@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQmEdp0BcgsmqiJeGoOaMkJuzfKu/S8Wukb+Qy9+TIbZ3MqoDs7Vat0uvR2kCt/9ag19V7S8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194423>

I appreciate for the instant reply.

My comments are inline below.

On Fri, Mar 30, 2012 at 4:34 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Mar 30, 2012 at 03:51:20PM -0400, Bo Chen wrote:
>
>> The sub-problems of "delta for large file" problem.
>>
>> 1 large file
>>
>> 1.1 text file (always delta well? need to be confirmed)
>
> They often do, but text files don't tend to be large. There are some
> exceptions (e.g., genetic data is often kept in line-oriented text
> files, but is very large).
>
> But let's take a step back for a moment. Forget about whether a file is
> binary or not. Imagine you want to store a very large file in git.
>
> What are the operations that will perform badly? How can we make them
> perform acceptably, and what tradeoffs must we make? E.g., the way the
> diff code is written, it would be very difficult to run "git diff" on a
> 2 gigabyte file. But is that actually a problem? Answering that means
> talking about the characteristics of 2 gigabyte files, and what we
> expect to see, and to what degree our tradeoffs will impact them.
>
> Here's a more concrete example. At first, even storing a 2 gigabyte file
> with "git add" was painful, because we would load the whole thing in
> memory. Repacking the repository was painful, because we had to rewrite
> the whole 2G file into a packfile. Nowadays, we stream large files
> directly into their own packfiles, and we have to pay the I/O only once
> (and the memory cost never). As a tradeoff, we no longer get delta
> compression of large objects. That's OK for some large objects, like
> movie files (which don't tend to delta well, anyway). But it's not for
> other objects, like virtual machine images, which do tend to delta well.

It seems that we should first provide some kind of mechanism which can
distinguish the delta-friendly objects and non delta-friendly objects.
I am wondering whether this algorithm is available now or will be
devised.



>
> So can we devise a solution which efficiently stores these
> delta-friendly objects, without losing the performance improvements we
> got with the stream-directly-to-packfile approach?

Ah, I see. Design efficient solution for storing the delta-friendly
objects is the main concern. Thank you for helping me clarify this
point.

>
> One possible solution is breaking large files into smaller chunks using
> something like the bupsplit algorithm (and I won't go into the details
> here, as links to bup have already been mentioned elsewhere, and Junio's
> patches make a start at this sort of splitting).
>
> Note that there are other problem areas with big files that can be
> worked on, too. For example, some people want to store 100 gigabytes in
> a repository. Because git is distributed, that means 100G in the repo
> database, and 100G in the working directory, for a total of 200G. People
> in this situation may want to be able to store part of the repository
> database in a network-accessible location, trading some of the
> convenience of being fully distributed for the space savings. So another
> project could be designing a network-based alternate object storage
> system.

>From the architecture point of view, CVS is fully centralized, and Git
is fully distributed. It seems that for big repo, the architecture
described above is in the middle now ^-^.

>
> -Peff

Bo
