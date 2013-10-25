From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 12/19] rev-list: add bitmap mode to speed up object lists
Date: Fri, 25 Oct 2013 14:00:48 +0000
Message-ID: <CAJo=hJvKG2sjWasO4YfExbbSN+U-q_it6gb43v_YJoL60XKwUg@mail.gmail.com>
References: <20131024175915.GA23398@sigill.intra.peff.net> <20131024180627.GL24180@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, Vicent Marti <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 25 16:01:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZhwz-0006KS-4v
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 16:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754521Ab3JYOBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 10:01:12 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:61714 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754513Ab3JYOBL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 10:01:11 -0400
Received: by mail-wg0-f46.google.com with SMTP id m15so3796944wgh.1
        for <git@vger.kernel.org>; Fri, 25 Oct 2013 07:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Yz0PPbZBBWiM5y0SXm/WlqssYsh1uCpBrCVOPfr+834=;
        b=DXYrcnJm0OxeK/vA5Mbps3/u+gaCJeJPw55T4Y+e8BGawN/U1l6tWx1q/+6ydtNIFs
         JrC7X4ZuaRG/TkEmnZUcp3K9qsGmj24M+ReJOSSA0AyeyDjczPIQNbH4LC+EDvRzpvV8
         SKE2ML2sUDStKkQehGK+7N+ENAEwsBnUqrl4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Yz0PPbZBBWiM5y0SXm/WlqssYsh1uCpBrCVOPfr+834=;
        b=hVGJ7fTGSeodq0WbA/K6bHelZxHVUWvkNqT1P10U2sxi1CZpbGxDXNCeSMDovCh0/m
         mYkl5/WKb+WoQe9XH4DhmWVeCYYG8GLi214YRqCEk0ve0DC2g2ImdDNTgxZwGUtGrMGs
         OJomgngV4vzPe/VQ4nRLqritnWblfq3bv1EGVgVOM10nHglhOI/4f/T7NOWmTb/y1QpC
         dBuAMy8PBPnPkTJI0AEl+R3yMFPb2hP/o2PoOIwpK2Lg+sBtm4+Kyf9WP8Xist7sx7AS
         +t7D2PjeatxmLg8e8NGp4teIeGtnUSQpQRXsiFo5nFUbydRwcN1Pk1IKElZ1la8ErwKE
         Tq3g==
X-Gm-Message-State: ALoCoQmQAi3Be9vZ35T8erDnJohdsk/vBVLYaVz+Lrd+y8S/KHC8iz9tW4L53vHbc8BIVxVDYRQC
X-Received: by 10.194.187.132 with SMTP id fs4mr54078wjc.82.1382709669657;
 Fri, 25 Oct 2013 07:01:09 -0700 (PDT)
Received: by 10.227.62.140 with HTTP; Fri, 25 Oct 2013 07:00:48 -0700 (PDT)
In-Reply-To: <20131024180627.GL24180@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236704>

On Thu, Oct 24, 2013 at 6:06 PM, Jeff King <peff@peff.net> wrote:
> Note that most of the time we spend for --count invocations is on
> generating the pack revindex. It may be worth storing a revidx (either
> in a separate file, as part of the .idx, or as an optional section in
> the .bitmap file).

This was discussed before, and it may make sense to cache the revidx.
I'm glad to see the timings are already better with bitmaps, even
though the revidx has to be computed on the fly for each invocation.
