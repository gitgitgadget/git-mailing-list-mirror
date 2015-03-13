From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 0/7] fix transfer.hiderefs with smart http
Date: Fri, 13 Mar 2015 12:21:11 +0700
Message-ID: <CACsJy8B+dWoq+ide2_-zJuLqFzg2WM3XuyL2B77PrR=PdrBfeQ@mail.gmail.com>
References: <20150313044101.GA18476@peff.net> <20150313045952.GA18853@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 13 06:21:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWI2c-0005P1-R6
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 06:21:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbbCMFVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 01:21:42 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:36695 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbbCMFVl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2015 01:21:41 -0400
Received: by iegc3 with SMTP id c3so85715316ieg.3
        for <git@vger.kernel.org>; Thu, 12 Mar 2015 22:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cOtWKHp2YPaWlAMvDxm1yDgY7wr8OA93bFQIZk4+gzY=;
        b=jtUO7kTqKl9ClwERURirbYK6CIwd57lhz+MiLsEr6kRpM7piNr7SauxEHvocquuRZO
         YLKzPjw3Dl+Oyn0ZmIhasoj3ro856Nj01egtayn40XAlJYRBFRS9ESlkW1tZA+9OapLG
         DRtP6HfmsyePuYHgCPFLy+Qd21/6cso6ZjU3iTXjuwFk/+J3DhV/wYkdO5VRxQMBlnIv
         UdRKqPadNl7qokVTttK5Y5y4POzKf16GigiD5gtsywHQZ98j8RGNzzIm+pD78qNqOSva
         +Z1CAWlskKDj4e91gynzh3Ehc2AmWrNtjGrJPq13AxB5F7pM7mTr8QsGL60NZq7dTVFm
         Wl0g==
X-Received: by 10.43.13.200 with SMTP id pn8mr55747448icb.0.1426224101190;
 Thu, 12 Mar 2015 22:21:41 -0700 (PDT)
Received: by 10.107.131.33 with HTTP; Thu, 12 Mar 2015 22:21:11 -0700 (PDT)
In-Reply-To: <20150313045952.GA18853@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265400>

On Fri, Mar 13, 2015 at 11:59 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Mar 13, 2015 at 12:41:01AM -0400, Jeff King wrote:
>
>> I'm experimenting with using transfer.hiderefs on a server, and it's
>> rather easy to cause a git client to hang when fetching from such a repo
>> over smart http. Details are in the first patch.
>
> A note on this hang. What happens is that upload-pack sees a bogus
> "want" line and calls die(). The client then sits there forever, but I'm
> not exactly sure what it's waiting for.
>
> This series fixes the bug that caused us to erroneously call die() in
> upload-pack, so the hang is "fixed". But there are other reasons to call
> die(); it would probably be a good thing if the client side noticed the
> problem and aborted.

Maybe we could install a custom die handler that also sends "ERR" line
to the client before dying. Even with old clients where ERR lines are
not recognized, they would see that as a sign of error and abort. The
only thing to be careful is not sending ERR while we're in the middle
of sending some pkt-line, and that only happens when die() is called
inside packet_write() and we can catch that easily. This is for
upload-pack only as the client side can also use packet_buf_write(), a
bit harder to know if some pkt-line is being sent.
-- 
Duy
