From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3] refs.c: add a function to append a reflog entry to a fd
Date: Thu, 20 Nov 2014 13:24:02 -0800
Message-ID: <CAGZ79kZDMWyW46wNgqudPiX1UmZteyFVJXMAYqJpp8e_r8LCmQ@mail.gmail.com>
References: <20141120023655.GG6527@google.com>
	<1416508657-9057-1-git-send-email-sbeller@google.com>
	<20141120212022.GJ6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 22:24:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrZCy-0006pV-Ni
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 22:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758052AbaKTVYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 16:24:04 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:47551 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758053AbaKTVYD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 16:24:03 -0500
Received: by mail-ig0-f169.google.com with SMTP id hl2so529036igb.2
        for <git@vger.kernel.org>; Thu, 20 Nov 2014 13:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=meuboVE7CRXDLit3dqslt4WBfmsii6l3m3KciuaJVEc=;
        b=kh06Tti0CkRH90xKBU+/CuRKbaB1isdRJHalwT0xElD+DMQLOx4Rm83YlmCkOMV3+h
         1jFkxUewDK4M6USL2GOZXW+Ky2+Yc+32LJ+4AoQ81w2QjzA40PW8IXEZjeDlsnI4lgTU
         eYbIBonDjZyiZv9zHZ8Og5ZG2h0NfaElM8xWT5wKl0hkzuRxCOPWpKwDRn3cW/E8xG2+
         OivNnACm/ToYadABQTcXurWGMq90W0J9gRGgvzaUYM6rzi0wWc2q7LEzGBQ4RsST2/HY
         AfYO4VXfGiDn0zSS2U0b9v4WtrRfcEbEaLPq3RhDoZZXiQNpl6g7VVu1pjOhvxs0rvRg
         DWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=meuboVE7CRXDLit3dqslt4WBfmsii6l3m3KciuaJVEc=;
        b=g3bW9waxsIQbmFufl1E5nVHyqiqNy4r5Czt9YlbXChcUd+Tb0R7T6r1KKLD4NhA3w8
         JBSDzBx258TUXHctBrzu+FQQpKeM4o6GUrfsiIGYxqYwYauGc2kok/BetfynFJ4DafTe
         HpS0CnbeoBsbt7seByvbJLHkIVCemqGoTHI2080kHT+HJZJKW3+p4QhCLTCQEzTtuA/E
         V1cgjJYeWkTkYn76aV6V51vDQBEzhmUfhUmHYV7pO2vsA6CGQMfYhtQEERGKaNfk6JO5
         krphaVsMk+L3b7v6EV/mD/Zp1b+0ueawflIsAVNwZbiWQG0MMzv++rFmqEWsg88ZZq+L
         6uKg==
X-Gm-Message-State: ALoCoQn+LTUdyCyp28WzPQqVAlc+rPMlt9sbvfSZ4+tYQBEuQkC9QknbaCYXeyj/74qJAYTsQhSw
X-Received: by 10.50.66.227 with SMTP id i3mr165904igt.25.1416518642407; Thu,
 20 Nov 2014 13:24:02 -0800 (PST)
Received: by 10.107.1.199 with HTTP; Thu, 20 Nov 2014 13:24:02 -0800 (PST)
In-Reply-To: <20141120212022.GJ6527@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 20, 2014 at 1:20 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>
>> For now the new function is only used from log_ref_write, but later
>> on we will call this function from reflog transactions too. That means
>> that we will end up with only a single place, where we write a
>> reflog entry to a file instead of the current two places
>> (log_ref_write and builtin/reflog.c).
>
> Line-wrapping width is still inconsistent.  I don't think it's worth
> resending just for that, but something to look out for in the future.
>

ok, I'll care about that more in the future.


> I don't understand why the above writes to a temporary variable and
> checks it, never to read that temporary again.
>
> I don't think that alone is a reason to block the patch, but it
> worries me in that the review comment seems to have been just lost.

It wasn't lost as I think it should go in a follow up patch. Sorry for
not stating that clearly.
(This patch is about moving code around, not changing code)

I got interrupted preparing the follow up patch, which gets rid of the temporary
variable.
