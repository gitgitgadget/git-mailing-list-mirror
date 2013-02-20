From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCHv2 10/10] remote-curl: always parse incoming refs
Date: Tue, 19 Feb 2013 23:41:23 -0800
Message-ID: <CAJo=hJvUvEsBw0Tz_c4sk_j2HeK7cZikyiPvQZDL0JgumaKepg@mail.gmail.com>
References: <20130218091203.GB17003@sigill.intra.peff.net> <20130218093056.GJ5096@sigill.intra.peff.net>
 <20130218105033.GH7049@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 08:42:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U84Jn-0001PT-Uv
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 08:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934375Ab3BTHlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 02:41:55 -0500
Received: from mail-ia0-f180.google.com ([209.85.210.180]:62963 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934351Ab3BTHlz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 02:41:55 -0500
Received: by mail-ia0-f180.google.com with SMTP id f27so7037515iae.11
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 23:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=xjkm1nbEcVGoNHxmx7uKWevXFmP6LUZXs06xKxtx9kw=;
        b=fbeWrFRAiI7pb/k21RZ8xjcumax5R5t0PAw9UsLBKObD0Gbmg9BAz0V+LHkdev05ZL
         3TpYwyC9d7opFh15RZZj5vXCElgDemLEYIs2Kd3LyRZSfV5vYCH5SzNfP5V11Jpgk8dX
         m8a1hgYfMZ4ifz0lHCSDLpr/M6WEVYm0aswd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:x-gm-message-state;
        bh=xjkm1nbEcVGoNHxmx7uKWevXFmP6LUZXs06xKxtx9kw=;
        b=ZoXJhzfNslas06b22KIX5F5KYA8vi6eHjr0MKpdDMsi2e7hdq+iVi1t9veYpWh2gll
         InrjqulV6fYAH2p+YM7adnODuoI1m1+G4Fgd3R5JrKhMQXTBGppujF8lu/gtvG94BKD6
         wbaZl8qWGsoVrTihskx/xWYocAIeVt4IRGGhvfZ/rF4MucTRbM4k1cMS71p3Hc8AaiIU
         qsrX/K3MQfL2ZSUJGbVVphWz5BwHVgv40+2rFrc/bqjlOJnHSuRKF/b9DKPKY3GNJwDs
         2Kn1kixM/yPXQYcOi8IJCsN6XxZ0GRWTLZ29l26RXJloIvM0AP5JGXrjg3zDn6q7wel4
         gR5w==
X-Received: by 10.50.173.105 with SMTP id bj9mr8914821igc.44.1361346103415;
 Tue, 19 Feb 2013 23:41:43 -0800 (PST)
Received: by 10.64.89.99 with HTTP; Tue, 19 Feb 2013 23:41:23 -0800 (PST)
In-Reply-To: <20130218105033.GH7049@elie.Belkin>
X-Gm-Message-State: ALoCoQkFCHzt/cNY0cSGf9Mmj6cPAu//uNn7d+2ja0lmwGo1J5VKTG7JMls3InXn34Qvji2Epyv7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216688>

On Mon, Feb 18, 2013 at 1:30 AM, Jeff King <peff@peff.net> wrote:
> When remote-curl receives a list of refs from a server, it
> keeps the whole buffer intact. When we get a "list" command,
> we feed the result to get_remote_heads, and when we get a
> "fetch" or "push" command, we feed it to fetch-pack or
> send-pack, respectively.
>
> If the HTTP response from the server is truncated for any
> reason,
...
> As a result, fetch-pack hangs, waiting for input.  However,
> remote-curl believes it has sent all of the advertisement,
> and therefore waits for fetch-pack to speak. The two
> processes end up in a deadlock.

Eek. Thanks for fixing this.

On Mon, Feb 18, 2013 at 2:50 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Jeff King wrote:
>
>>  remote-curl.c | 23 +++++++++++++----------
>>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> I like.

Me too.
