From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Multi-threaded 'git clone'
Date: Mon, 16 Feb 2015 19:16:24 -0800
Message-ID: <CAJo=hJt8FU9wJBidivdwa-ryZsE-=EMT_DY--bX4FYKBDXsY5w@mail.gmail.com>
References: <CACSCj9yoso1oLHzySx1F3O+DFAPiz-XEz1YNCEUMu1pj7KmX7w@mail.gmail.com>
 <alpine.DEB.2.02.1502160521030.23770@nftneq.ynat.uz> <20150216150305.GA8279@peff.net>
 <alpine.DEB.2.02.1502160727480.23770@nftneq.ynat.uz> <20150216154745.GA10120@peff.net>
 <xmqq1tlp7l3w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
	Koosha Khajehmoogahi <koosha.khajeh@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 04:16:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNYee-00068A-GA
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 04:16:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbbBQDQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 22:16:48 -0500
Received: from mail-yk0-f182.google.com ([209.85.160.182]:58780 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168AbbBQDQq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 22:16:46 -0500
Received: by mail-yk0-f182.google.com with SMTP id 142so10938313ykq.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2015 19:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=D+bpXsnsCwBHFX2hhH8bFf/CWTpcRJu2qrIHO/EVtc0=;
        b=FA2ZJECxSFvaQNs5J9y3JV4opL7D2E3Ct+m5/IGLZdrugERxGUiG2kUNpIYQ7eLE/Q
         CrCP9UKE6k0welwuc2HzpBxLyzcTxdItAA5yriq9ESbGsWoAL2WH6Gz3vmpQjpoD1C1F
         1vjicNctfPhCgghIGj7f2mop7cC43sEUqSE8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=D+bpXsnsCwBHFX2hhH8bFf/CWTpcRJu2qrIHO/EVtc0=;
        b=hPaSXm+0c9OE4bwd+KweWEu3R29Wjmkyr1PbikLVg2xndyF6yoYO2MwGFLKlklyEnn
         m57/St67iGGi2K/K2WZm4UG8RyodCoKtp9dPeFmO27S94o+XsaPJwcpMJ0gWm/203D/d
         gjADQIWJ+Si1aV/ko9z76MSbXICNtHuAnNGeh+ku7NvULLSpsmbfxhxNCz17PW96Iwzb
         nTrc/Ju5D5ah+p//QdTOhnYji400y07PXmuAMAfzrl0pGLO4iP4DAhYloYH/iFUcvq7J
         IhkOiEIvkXeFU4J4m/6xgpwKTRKPH5hRJbrMc3rQAEyqwsvGUhZwm5aGmSCTsG0jZhgL
         Fp6g==
X-Gm-Message-State: ALoCoQkJBHUWF9qx+zAS0VBaSFtb+2dGTBCpN1WwVKv06OioUf3iwUmXEdo7Q6DcFVqu9V9BLTL2
X-Received: by 10.236.1.133 with SMTP id 5mr1044453yhd.64.1424143005124; Mon,
 16 Feb 2015 19:16:45 -0800 (PST)
Received: by 10.170.39.19 with HTTP; Mon, 16 Feb 2015 19:16:24 -0800 (PST)
In-Reply-To: <xmqq1tlp7l3w.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263928>

On Mon, Feb 16, 2015 at 10:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> ... And the whole output is checksummed by a single sha1
>> over the whole stream that comes at the end.
>>
>> I think the most feasible thing would be to quickly spool it to a
>> server on the LAN, and then use an existing fetch-in-parallel tool
>> to grab it from there over the WAN.
>
> One possibility would be for the server to prepare a static bundle
> file to bootstrap all the "clone" clients with and publish it on a
> CDN.  A protocol extension would tell the client where to download
> the bundle from, the client can then grab the bundle to clone from
> it to become "slightly stale but mostly up to date", and then do a
> usual incremental update with the server after that to be complete.
>
> The server would update the bundle used to bootstrap clone clients
> periodically in order to keep the incrementals to the minimum, and
> would make sure their bitmap is anchored at the tips of bundles to
> minimize the object counting load during the incremental phase.
>
> I think "repo" used by folks who do AOSP does something similar to
> that by scripting around "git clone".  I'd imagine that they would
> be happy to see if "git clone" did all that inside.

Yes, the "repo" tool used by Android uses curl to download a
previously cached $URL/clone.bundle using resumable HTTP. For Android
the file is only updated ~every 6 months at major releases and is
easily cached by CDNs and HTTP proxy servers.

This is spooled to a temporary file on disk then unpacked using `git
fetch $path/clone.bundle refs/heads/*:refs/remotes/origin/*`.
Afterwards a normal git fetch is run to bring the new clone current
with the server, picking up any delta that happened since the bundle
was created and cached.

The Android Git servers at android.googlesource.com just recognize
*/clone.bundle GET requests and issue 302 redirects to the CDN farm
that actually stores and serves the precreated bundle files.

We really want to see this in stock git clone for HTTP transports, as
other projects like Chromium want to use it for their ~3 GiB
repository. Being able to build the bulk of the repo every few months
and serve it out using a CDN to bootstrap new clients would really
help developers on slower or flaky network connections.
