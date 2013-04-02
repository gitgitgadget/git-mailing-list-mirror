From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/4] transport-helper: check if remote helper is alive
Date: Mon, 1 Apr 2013 22:51:20 -0600
Message-ID: <CAMP44s2VcLUE=PHE=iSsgd67_ZV4N6b5Ya76Rc22xtSzK-Xz0g@mail.gmail.com>
References: <1364852804-31875-1-git-send-email-felipe.contreras@gmail.com>
	<1364852804-31875-3-git-send-email-felipe.contreras@gmail.com>
	<20130401233313.GB30935@sigill.intra.peff.net>
	<CAMP44s0uJ4ivNLw984CXWYk5HcKevuUJmpYOiyqbT1QJDaYd0Q@mail.gmail.com>
	<20130402023024.GB719@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 02 06:51:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMtCO-0002f4-9V
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 06:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759794Ab3DBEvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 00:51:23 -0400
Received: from mail-la0-f43.google.com ([209.85.215.43]:59101 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759322Ab3DBEvW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 00:51:22 -0400
Received: by mail-la0-f43.google.com with SMTP id ek20so26606lab.2
        for <git@vger.kernel.org>; Mon, 01 Apr 2013 21:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=6rILIDaCDIuUiN2i0HDz2bnan1Ctkg1/JQbytTFrv1Q=;
        b=v2wEv3VjW7G+V4v0UFg06sgImAHnfgJpk2QBU3+Kk4ox1tNNuTdbhcUCtt7oDmbyLN
         eu95WuSCeyBVAI/x9FPQAtyJgwXY08Im5PYMmdxhoek5C+OaiNV23txjC7ekLXC1C66f
         9W+25quOyV4hRhWeTeQ8lR5/sCe7ysIw+9IejfNetW9YQ5sQRjElg1gK1jkjAg7TlbhQ
         qQ1SvDf4yTdIdnGjZt0TjJPSocW6/2y9prn9v/zjPAG+MgR/yZaNkTPpOZTXIUVsMPX4
         yzzpFveWbwLeHCflEYEZsUBgsvrd6P4lSh6lpEa8oSKXjov9m2IPI5VGLf4ob1gVxlXW
         9gYw==
X-Received: by 10.112.41.136 with SMTP id f8mr6744297lbl.121.1364878280514;
 Mon, 01 Apr 2013 21:51:20 -0700 (PDT)
Received: by 10.114.20.36 with HTTP; Mon, 1 Apr 2013 21:51:20 -0700 (PDT)
In-Reply-To: <20130402023024.GB719@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219732>

On Mon, Apr 1, 2013 at 8:30 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Apr 01, 2013 at 06:12:45PM -0600, Felipe Contreras wrote:
>
>> > Checking asynchronously for death like this is subject to a rac
>> > condition; the helper may be about to die but not have died yet. In
>> > practice we may catch some cases, but this seems like an indication that
>> > the protocol is not well thought-out. Usually we would wait for a
>> > confirmation over the read pipe from a child, and know that the child
>> > failed when either:
>> >
>> >   1. It tells us so on the pipe.
>> >
>> >   2. The pipe closes (at which point we know it is time to reap the
>> >      child).
>> >
>> > Why doesn't that scheme work here? I am not doubting you that it does
>> > not; the import helper protocol is a bit of a mess, and I can easily
>> > believe it has such a problem. But I'm wondering if it's possible to
>> > improve it in a more robust way.
>>
>> The pipe is between fast-export and the remote-helper, "we"
>> (transport-helper) are not part of the pipe any more. That's the
>> problem.
>
> So in fetch_with_import, we have a remote-helper, and we have a
> bidirectional pipe to it. We then call get_importer, which starts
> fast-import, whose stdin is connected to the stdout of the remote
> helper. We tell the remote-helper to run the import, then we wait for
> fast-import to finish (and complain if it fails).
>
> Then what? We seem to do some more work, which I think is what causes
> the errors you see; but should we instead be reaping the helper at this
> point unconditionally? Its stdout has presumably been flushed out to
> fast-import; is there anything else for us to get from it besides its
> exit code?

The problem is not with import, since fast-import would generally wait
properly for a 'done' status, the problem is with export. Also, the
design is such that the remote-helper stays alive, even after
fast-export has finished.

-- 
Felipe Contreras
