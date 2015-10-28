From: Noam Postavsky <npostavs@users.sourceforge.net>
Subject: Re: git-credential-cache--daemon quits on SIGHUP, can we change it to
 ignore instead?
Date: Tue, 27 Oct 2015 23:46:20 -0400
Message-ID: <CAM-tV--B3HaC1DcORfnx9bWW9-quyk0=pQDxmvonc=6dgrMOxA@mail.gmail.com>
References: <CAM-tV-_JPazYxeDYogtQTRfBxONpSZwb3u5pPanB=F9XnLnZyg@mail.gmail.com>
	<CAM-tV-_eOgnhqsTFN6kKW=tcS7gAPYaxskBaxnJZo3bsx02HZg@mail.gmail.com>
	<xmqqfv18awj4.fsf@gitster.mtv.corp.google.com>
	<CAM-tV-8VXtB5uRgqP9dFpww6AaLzasPV46tCiquz=nz=ksBNng@mail.gmail.com>
	<CAM-tV-9sNgHncsWRPh36tEY3YFORUJBA-Q6W5R=mvX_KhSmWEQ@mail.gmail.com>
	<xmqqfv0ylwa7.fsf@gitster.mtv.corp.google.com>
	<20151026215016.GA17419@sigill.intra.peff.net>
	<xmqqoafkci6j.fsf@gitster.mtv.corp.google.com>
	<20151027184702.GB12717@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 28 04:46:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrHh3-0000Ac-J9
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 04:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369AbbJ1DqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 23:46:23 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:37861 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbbJ1DqW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 23:46:22 -0400
Received: by wicfv8 with SMTP id fv8so187488314wic.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 20:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7HXRTk8XXxwS9p78H+EUZugd+UZsfj56wAwWlQsE0Io=;
        b=WB+cvQT0DzFnOAh2Y7PEDN0NfNDXFy6If5EqSQGpQjVE45Pn7BsX9Xu7O6KoHboSy+
         vBqdcE3u+WR4GlRfdCkgPOFPTGHSretkBF1AklxvLK5E7nQgbGROBa5FP5unQTDxwdR9
         4TfKhuTBm8phowZ4XgxfYiRlXG2LSPtHZCzvlXFnBRwTZF4lqO4rCibkGwGbfp1JO2+p
         T4ClQXEcvB7W4tFBDSRtQVEtSJTYlSpYgIOn/zn7kx2gqSdb22T7fK67zDdRlTx+diLz
         xhwPld/TYb++UfOmWkfRdhFnB/chKKJgw5bi/vJ2PXM+YuA/BNfg0QXZRz7ZjOB62kOo
         D77g==
X-Received: by 10.180.20.46 with SMTP id k14mr489279wie.89.1446003981080; Tue,
 27 Oct 2015 20:46:21 -0700 (PDT)
Received: by 10.28.29.87 with HTTP; Tue, 27 Oct 2015 20:46:20 -0700 (PDT)
In-Reply-To: <20151027184702.GB12717@sigill.intra.peff.net>
X-Google-Sender-Auth: IQQ9x8UCLsN4sIL5Pxls0FCY1LI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280352>

On Tue, Oct 27, 2015 at 2:47 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Oct 27, 2015 at 10:52:52AM -0700, Junio C Hamano wrote:
>> Yes.  Probably the right way forward is to make it a non-issue by
>> teaching users how to control the lifetime of the "daemon" process,
>> and wean them off relying on "it is auto-spawned if you forgot to
>> start", as that convenience of auto-spawning is associated with
>> "...but how it is auto-shutdown really depends on many things in
>> your specific environment", which is the issue.
>
> I dunno. I think the auto-spawn is really what makes it usable; you can
> drop it in with "git config credential.helper config" and forget about
> it. Anything more fancy requires touching your login/startup files.
> Certainly I'm not opposed to people setting it up outside of the
> auto-spawn, but I wouldn't want that feature to go away.

Perhaps we could express the auto-spawn more explicitly, something
like "git config credential.pre-helper start-cache-daemon". A way to
run a command before the credential helpers start would be useful to
our magit workaround for this issue (currently we start the daemon
before "push", "fetch", and "pull", but it won't work with user
aliases that run those commands).

>
> I am a little surprised that credential-cache gets wide use. I would
> think most people would prefer to use a system-specific secure-storage
> helper. I don't know what the state of the art is for that on Linux[1], but
> we seem to have only gnome-keyring in contrib/.

I'm not sure it's that widely used. Perhaps most people use ssh-agent?
That's what I do, though I've been experimenting with credential-cache
since it was brought up by a magit user.
