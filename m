From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git pack protocol question: sideband responses in case of errors?
Date: Wed, 13 May 2015 08:45:43 -0700
Message-ID: <CAJo=hJtcM-kV+L_yUX43UPe2Z-4LnaXTBpmFaWaFReG-Jbsisw@mail.gmail.com>
References: <CAENte7j9De5Bqu2jDcmXQAxZheSGo+EntzsYUaen0N7cnuiCDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>, Shawn Pearce <sop@google.com>
To: Christian Halstrick <christian.halstrick@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 17:46:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsYrT-00086b-NM
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 17:46:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965564AbbEMPqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 11:46:09 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:37485 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964839AbbEMPqF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 11:46:05 -0400
Received: by widdi4 with SMTP id di4so61251315wid.0
        for <git@vger.kernel.org>; Wed, 13 May 2015 08:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=76L8j7dpHOzdfZz3F7Lx4tEIVK1QRLnURWn2TlQCQXI=;
        b=LPXSWepHL6oJKHFpK7RdNMnPYYHS3FcULs15gvxwOIP/Ur2hUE1W+d12muadSICA3A
         hpNaqXMOgCFVsC9A4k1dsw2lmwofntApFufHZqm9jwlznQ+MvR8e6AJt70z90TZMQ0m4
         faxder1Zb/CwHBI0gWqXxwEheE398Q8LJHALg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=76L8j7dpHOzdfZz3F7Lx4tEIVK1QRLnURWn2TlQCQXI=;
        b=eGSuFiiFUMN0QBl495utJYCziD8VbWXL+Xf2f7vmdAoGmfwSC3LTkD7l0XadIGKCO1
         rXyDFxR+Jcf62HuVp8uCXI8Hs/7pE5se6I7IIz/k5T+v+Of2xHocUjqfMBSAcjZ6lVvs
         0gIU7Cqn1viBlPpBQzq0ziM/lHf7vwEtYrEUxHwudiIzZpt7mj50Hf1wWToplPKuVJC8
         HA8rbVjg+xjv2GNW8LSO9sV2wbYajHEM3zUXzy/NGIcwi/AV+gfjyVEEcs4St7W0ohSr
         CNoiGSlsOb+YXGh9d9XFC65NY9REJSOnGdbJhzE5JkjUS4OrsRFr+S1miu78aQMU3a+H
         /4+A==
X-Gm-Message-State: ALoCoQkJ7kLLBz0L/or1zq8lv9ZFzLNLBlp2TZzbyszY10rJUbvamkIOkhJ3Neb9DAoIEgDYLFFI
X-Received: by 10.180.92.198 with SMTP id co6mr7142830wib.34.1431531963936;
 Wed, 13 May 2015 08:46:03 -0700 (PDT)
Received: by 10.28.147.18 with HTTP; Wed, 13 May 2015 08:45:43 -0700 (PDT)
In-Reply-To: <CAENte7j9De5Bqu2jDcmXQAxZheSGo+EntzsYUaen0N7cnuiCDQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268991>

On Wed, May 13, 2015 at 2:03 AM, Christian Halstrick
<christian.halstrick@gmail.com> wrote:
> since a long time I am hitting very seldom errors when pushing with a
> jgit client leading to "invalid channel 101" errors on client side. I
> was always wondering why it was always the channel "101". Now I found
> out with wireshark and it leads me to a question regarding the git
> pack protocol [1] and the sideband capability [2] which I couldn't
> answer from the technical docs.
>
> This is what happened: A client wants to push over http to a git
> server. In the beginning they negotiated to use side-band-64k and
> report-status capabilities. Everything works fine, Packfile data
> transmission starts and sideband communication is ok. Now the server
> hits a severe problem persisting the packfile and wants to stop the
> transport. The git server hit's quotas on the filesystem usage and is
> not allowed to persist that big file. My git server (I use a modified
> gerrit server) intends to send back a packet line "0013error: ...".
> But the client when reading that respond still thinks we should use
> sideband communication and interpretes the "e" from "error" as
> channel. The ascii code of "e" is the solution why it was always
> "invalid channel 101"
>
> Here is my question:
> - When exactly should sideband communication during a http based push
> start and when should it end?

If the client asked side-band-64k and report-status capabilities the
server must use side-band to respond to the client. Its (obviously)
assuming this.

The bug here is JGit's ReceivePack/BaseReceivePack code not setting up
the side-band-64k early enough for this failure report to be wrapped
in it.

> Especially in case of an error on the
> server side. Is the server allowed to switch to non-sideband
> communication under special conditions?

No. The protocol has negotiated to use side-band-64k. That is what the
client expects to see.

In side-band-64k channel 2 is the "error" channel. Send a single
packet on channel 2 carrying a single short text message and the
entire stream is aborted at the client side after receiving this
message. This is maybe what JGit should do in this case.

> E.g. when the server responds
> not with 200OK but with 413 (entity too large).

No, you cannot use 413.

> - Is responding with status code 200 mandatory when talking git pack
> protocol? Am I allowed as git server to respond with status code 413
> and fill the body of the response with the status report?

This was hashed out a long time ago. For the purposes of Git the HTTP
200 status code means the HTTP system successfully transported opaque
data for Git, e.g. its like having no socket error from a socket
routine.

Any other HTTP status like 413 means the HTTP transport is busted. Its
like getting EHOSTUNREACH or some other such errno from a socket
function.

I realize there are other interpretations for how applications should
use HTTP status codes, and REST APIs often use them, but Git does not
take that approach.

FWIW I am glad you found this. I have been chasing this bug for years
but couldn't really pin it down to anything. If its the "pack won't
fit on local disk due to disk full" condition that narrows down the
offending section of JGit considerably.


> [1] https://raw.githubusercontent.com/git/git/master/Documentation/technical/pack-protocol.txt
> [2] https://raw.githubusercontent.com/git/git/master/Documentation/technical/protocol-capabilities.txt
