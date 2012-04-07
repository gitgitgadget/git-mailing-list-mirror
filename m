From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] credential: do not store credentials received from helpers
Date: Fri, 6 Apr 2012 21:12:39 -0700
Message-ID: <CAJo=hJvqQ0CgCga4va3ZX+XV5DWc1kWS5v4vYWkEzRYT5+p+cg@mail.gmail.com>
References: <20120407033417.GA13914@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Apr 07 06:13:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGN1q-0002K5-IA
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 06:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736Ab2DGENA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Apr 2012 00:13:00 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51631 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab2DGENA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Apr 2012 00:13:00 -0400
Received: by pbcun15 with SMTP id un15so3209302pbc.19
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 21:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=OF4qQSNzFxpWBuvgRLQq3sRYJ5D8JKVB5Srs3EZE1Fk=;
        b=UKgULg7Kaoz+dCqa1ksYI/gs//bLhIkMbbTeXxkwHkDXWTqAfL38/nK62UgPfsoXA2
         2vNOe+MC7UONpjw7mMIGoXyrZuNstYqxiBIGOK/0Aa7CXOyBVs6QY9P00fMbQM30sKlt
         Zg325l1Cs09bFCQxmSUb7Tt9M1IUnW5AkxhlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=OF4qQSNzFxpWBuvgRLQq3sRYJ5D8JKVB5Srs3EZE1Fk=;
        b=T6kvTVBDcFeJu5tmF78b8HJsu2V0tRRMgTN/KnxMRrJJxqukf1zxV5c0xsQFLu8z1N
         Ol7HSpesz9lGXRt44RM9OJA+Z6RNVwEVAvriIfICjaQHJroEvMNJ719NeTdhf0x8jt2a
         Esfk55+WpADZcyhpsdO8wxNCSYuTjBntsgA8qEdUfkCuYiWwRof75/IOGieepWprMlVr
         XhscTKqTnj/8JbNcmnshEDV1Ghe0m8A2jkBsrLGUjfHCDoj4uvDm9i6HNGMWLU/8qkNN
         FDq7do97tRCnP5U9YsRIBab+E6BVLuQQff1+TAc3te8gZo2dsrL0olJUHrKaqTCPOSqn
         p8+g==
Received: by 10.68.194.227 with SMTP id hz3mr858961pbc.23.1333771979596; Fri,
 06 Apr 2012 21:12:59 -0700 (PDT)
Received: by 10.68.55.68 with HTTP; Fri, 6 Apr 2012 21:12:39 -0700 (PDT)
In-Reply-To: <20120407033417.GA13914@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQn2clioqlif0Lx7kWWdtJaImspKZQFrw0Vilr1l4T0q8fPalvQp9Qmq3H+CzG17SZAki5o7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194931>

On Fri, Apr 6, 2012 at 20:34, Jeff King <peff@peff.net> wrote:
> =A02. If you use a time-based storage helper like
> =A0 =A0 "git-credential-cache", every time you run a git
> =A0 =A0 command which uses the credential, it will also
> =A0 =A0 re-insert the credential after use, freshening the
> =A0 =A0 cache timestamp. So the cache will eventually expire N
> =A0 =A0 time units after the last _use_, not after the time the
> =A0 =A0 user actually typed the password. This is probably not
> =A0 =A0 what most users expect or want (and if they do, we
> =A0 =A0 should do it explicitly by providing an option to
> =A0 =A0 refresh the timestamp on use).

So if I use the cache helper, and its set to expire at the default of
15 minutes, I have to type my password in every 15 minutes, even if I
am doing a Git operation roughly every 8 minutes during a work day?

> We can solve this by marking a credential that comes from a
> helper, so we don't bother feeding it back to the helpers.
> The credential struct already has an "approved" flag so
> that we try to store it only once, rather than for each
> successful http request. We can use the same flag to
> "pre-approve" a credential which comes from a helper, and
> enver try to store it at all.

This breaks one of my credential helpers.

I have a helper that generates a password by asking a remote system to
generate a short lived password based on other authentication systems
that I can't describe. Once I have that password, its good for $X
time.

The helper just dumps it out to Git, and Git turns around and stores
it into the cache for me. This means later requests will keep that
credential in the cache, and avoid making that remote system call
every time I do a Git network command. I guess I now need to change my
helper to cache git credential-cache itself and store the password
into the cache if it wants to use the cache?

Should we update the credential helper documentation at the same time
as this change to make it clear Git won't cache passwords returned
from helpers, but a helper could call the credential-cache itself if
it wanted to reuse the existing cache service?
