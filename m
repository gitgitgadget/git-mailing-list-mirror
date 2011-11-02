From: Mika Fischer <mika.fischer@zoopnet.de>
Subject: Re: [PATCH 1/2] http.c: Use curl_multi_fdset to select on curl fds
 instead of just sleeping
Date: Wed, 2 Nov 2011 23:22:48 +0100
Message-ID: <CAOs=hR+QqUpYuth8Uvi2o7pm1LO8ogO2pN7nrMchYj96Cutmww@mail.gmail.com>
References: <1320265288-12647-1-git-send-email-mika.fischer@zoopnet.de>
 <1320265288-12647-2-git-send-email-mika.fischer@zoopnet.de> <20111102203221.GB5628@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, daniel@haxx.se
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 02 23:34:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLjNl-0008WB-KQ
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 23:34:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191Ab1KBWeA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Nov 2011 18:34:00 -0400
Received: from trillian.zoopnet.de ([85.214.111.199]:59143 "EHLO
	trillian.zoopnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907Ab1KBWeA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2011 18:34:00 -0400
Received: from mail-ey0-f174.google.com (mail-ey0-f174.google.com [209.85.215.174])
	by trillian.zoopnet.de (Postfix) with ESMTPSA id 67235249C2BD
	for <git@vger.kernel.org>; Wed,  2 Nov 2011 23:33:59 +0100 (CET)
Received: by eye27 with SMTP id 27so587833eye.19
        for <git@vger.kernel.org>; Wed, 02 Nov 2011 15:33:58 -0700 (PDT)
Received: by 10.236.124.105 with SMTP id w69mr10363138yhh.2.1320273055271;
 Wed, 02 Nov 2011 15:30:55 -0700 (PDT)
Received: by 10.236.60.135 with HTTP; Wed, 2 Nov 2011 15:22:48 -0700 (PDT)
In-Reply-To: <20111102203221.GB5628@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184677>

On Wed, Nov 2, 2011 at 21:32, Jeff King <peff@peff.net> wrote:
> Do we still need to care about data_received?
>
> My understanding was that the code was originally trying to do:
>
> =C2=A01. Call curl, maybe get some data.
>
> =C2=A02. If we got data, then ask curl against immediately for some d=
ata.
>
> =C2=A03. Otherwise, sleep 50ms and then ask curl again.

Yes, that's exactly what it did.

> But now that we are actually selecting on the proper descriptors, it
> should now be safe to just do:
>
> =C2=A01. Call curl, maybe get some data.
>
> =C2=A02. Call select, which will wake immediately if curl is going to=
 get
> =C2=A0 =C2=A0 data.

The only problem I can see is that curl_multi_fdset is not guaranteed
to return any fds. So in theory it could be possible that we don't get
fds, but we're actually reading stuff. In this case things would get
slow, because we would sleep for 50ms after every read...

However, I don't know if this is a case that actually comes up in the
real world. Maybe Daniel has some advice on this.

Best,
 Mika
