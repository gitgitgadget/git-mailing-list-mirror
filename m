From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Wed, 6 Feb 2013 23:26:23 +0100
Message-ID: <CACBZZX6xLvuMEhPnfYLj8W9pMLwdoS7Zb+mTtn+3DanJPiWfXw@mail.gmail.com>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
 <5110BD18.3080608@alum.mit.edu> <20130205083327.GA4931@elie.Belkin>
 <5110DF1D.8010505@alum.mit.edu> <CACsJy8BhL4qDb8BgOVuaUFF_9GXvgu55urYyKqPuZMZCTCoLwA@mail.gmail.com>
 <7v4nhpckwd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 23:27:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3DSN-0005px-0d
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 23:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756749Ab3BFW0o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 17:26:44 -0500
Received: from mail-oa0-f53.google.com ([209.85.219.53]:53815 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754330Ab3BFW0o (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 17:26:44 -0500
Received: by mail-oa0-f53.google.com with SMTP id m1so2136379oag.12
        for <git@vger.kernel.org>; Wed, 06 Feb 2013 14:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=0PxxtyfSkOUmNeDyMV5KO49NxwppVKTn16oJdIUnpAQ=;
        b=LqgJgvKPDLaS+b7ZA/bhUOQMBNmXY4VcecB3QDl+1nB+JhwfZakSkolDxYsijNjLbv
         VxgcpIuCGmmzfsTFZncTtyFLtek/yYtagGHD9I5mazdeOEbQ4kkLAj8ndxhvGkURFaqN
         ByWn/c6mkwQC8KNwO2iEUdauUEnzmsC3MK9a4hR7M9N4RFNohmQEMpjsMJP8yQ861FzE
         a1Ytk+2uKAjwTA49s4JDJwvL9DIRA3eEnGqs6qlpiARKkEzzJ8jlCe7yVBxXyqPptBHT
         cpsZi/8LpcNNMlrqid3fpq3ycFIBIr/4mQpTQ2GN/xoRmrjP3QblsqzDWVfH/w0z0U7N
         veWg==
X-Received: by 10.60.32.243 with SMTP id m19mr18648182oei.13.1360189603469;
 Wed, 06 Feb 2013 14:26:43 -0800 (PST)
Received: by 10.76.168.163 with HTTP; Wed, 6 Feb 2013 14:26:23 -0800 (PST)
In-Reply-To: <7v4nhpckwd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215655>

On Wed, Feb 6, 2013 at 8:17 PM, Junio C Hamano <gitster@pobox.com> wrote:

Maybe this should be split up into a different thread, but:

> The upload-pack-2 service sits on a port different from today's
> [...].

I think there's a simpler way to do this, which is that:

 * New clients supporting v2 of the protocol send some piece of data
   that would break old servers.

 * If that fails the new client goes "oh jeeze, I guess it's an old
   server", and try again with the old protocol.

 * The client then saves a date (or the version the server gave us)
   indicating that it tried the new protocol on that remote, tries
   again sometime later.

We already covered in previous discussions how this would be simpler
with the HTTP protocol, since you could just send an extra header
inviting the server to speak the new protocol.

But for the other transports we can just try the new protocol and
retry with the old one as a fallback if it doesn't work. That'll allow
us to gracefully migrate without needing to change the git:// port.

Besides, I think the vast majority of users are using Git via http://
or ssh://, where we can't just change the port, but even so making
people change the port when we could handle this more gracefully would
be a big PITA. Adding new firewall holes is often a big bureaucratic
nightmare in some organizations.
