From: Blake Burkhart <bburky@bburky.com>
Subject: Re: RFC: Resumable clone based on hybrid "smart" and "dumb" HTTP
Date: Fri, 12 Feb 2016 19:40:43 -0600
Message-ID: <CAP3OtXjyy+7cSi0S17FSsx8gnP1rKboeSAz_Hz1ZNVDuqcGASw@mail.gmail.com>
References: <CAJo=hJtHgE_vye_1sPTDsvJ0X=Cs72HKLgRH8btpW-pMrDdk9g@mail.gmail.com>
 <CAJo=hJuRxoe6tXe65ci-A35c_PWJEP7KEPFu5Ocn147HwVuo3A@mail.gmail.com> <20160210214945.GA5853@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 13 02:41:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUPCv-0000ZO-FZ
	for gcvg-git-2@plane.gmane.org; Sat, 13 Feb 2016 02:41:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305AbcBMBlF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 20:41:05 -0500
Received: from mail-ob0-f169.google.com ([209.85.214.169]:36011 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbcBMBlE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 20:41:04 -0500
Received: by mail-ob0-f169.google.com with SMTP id gc3so45307375obb.3
        for <git@vger.kernel.org>; Fri, 12 Feb 2016 17:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bburky.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=q1IXi35wKcU/DRiOpTwLNh47eufcN9nc56bF9+b1SzU=;
        b=N7qAYCLyskbQCow5YzsgQRI8TdKA6t5U+/mvkYoK4bvZzr8v9aXLn430sYJRh73WRW
         AlVE5TtVBzW+YPvbnDLuGYfkHF3AbIkZeLGb+DYJjgEoIwfSgexvFvtZGl+bb2Uyvgp3
         L90drOXMZDzFlB+MPQaR7SeBhIVKw0gcO73Ec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=q1IXi35wKcU/DRiOpTwLNh47eufcN9nc56bF9+b1SzU=;
        b=aKVy0sC3kWF0+WWk8IKh6dGLyUn40n7kyMJREqApvdfxZDeEvYng7QQlZkNSUgFrYa
         RBS+RKJbXQ8GxHB+a396t+3TDjFFJ9q56Qb2pKUF+Ct72YWQRQONxsEsQGkKvEv8f9/y
         BK77qkfUlu8BupkZVrH0bKo5acin8ObsIQntB5ljMOGZjuoYUUtSYLNsq9ezChor20h7
         cOMW1V9yUeyhUbSWlee74052du3O6RPC4dFxshhLGOJ2dTflPCLIcCG+ewbUyohHb1mx
         bpRiwUovUhaUpVM7BFjvTpr1LX46dKEwDY2dwx4qdJAxUCIH8I6ZIYqDWzQLILx7bRQy
         V01A==
X-Gm-Message-State: AG10YOQLHVmXGb3o9iNA835i1AcePQuvhWG+Fd8jKcGjPlhfARxqTLKOsA4XHltTeTaPQcjs+L1oGzn8+L8Jnw==
X-Received: by 10.182.86.98 with SMTP id o2mr3857859obz.27.1455327663018; Fri,
 12 Feb 2016 17:41:03 -0800 (PST)
Received: by 10.202.196.78 with HTTP; Fri, 12 Feb 2016 17:40:43 -0800 (PST)
In-Reply-To: <20160210214945.GA5853@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286104>

On Wed, Feb 10, 2016 at 3:49 PM, Jeff King <peff@peff.net> wrote:
>> 2. Servers that support resumable clone include a "resumable"
>> capability in the advertisement.
>
> Because the magic happens in the git protocol, that would mean this does
> not have to be limited to git-over-http. It could be "resumable=<url>"
> to point the client anywhere (the same server over a different protocol,
> another server, etc).

I'd like to call this out as a possible security issue before it gets
implemented. Allowing the server to instruct the client what protocol
to use is a security risk. This sounds like a fine feature, just do it
carefully.

I reported a similar issue was discussed off list which eventually
became CVE-2015-7545. Basically, git-submodule allowed a repository to
specify any protocol via .gitmodules, causing the client to fetch an
arbitrary URL using a protocol of the attacker's choice. Sadly, the
existence of git-remote-ext allows easily executing arbitrary shell
commands if the server can tell the client to use it. Furthermore,
it's possible the client has some insecure or sensitive custom git
remote helpers installed.

To address this GIT_ALLOW_PROTOCOL was introduced, and git-submodule
now uses it as of 33cfccb. This environment variable specifies a
default whitelist of protocols. Whoever implements this should
probably make use of GIT_ALLOW_PROTOCOL to limit resumable clones to
the same default whitelist that git-submodule now uses.

-- 
Blake Burkhart
