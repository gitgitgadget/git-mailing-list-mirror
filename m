From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] protocol upload-pack-v2
Date: Sat, 7 Mar 2015 06:55:17 +0700
Message-ID: <CACsJy8ARDgjBLxYmfyrVcCb5WMnG=w6Ro_j+vVe=Sk6pEfR=Cw@mail.gmail.com>
References: <20150302092136.GA30278@lanh> <1425685087-21633-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 00:55:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YU25w-0001WI-Q7
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 00:55:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbbCFXzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 18:55:48 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:41605 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755866AbbCFXzr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 18:55:47 -0500
Received: by iecrl12 with SMTP id rl12so7062279iec.8
        for <git@vger.kernel.org>; Fri, 06 Mar 2015 15:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=t4WbdnBSLwFU6i4WMxcpe61v7kFjNEvP7G8wjivUKfI=;
        b=q5xmBpLwo3wfCTge16gKNGxT7W9L4sfG0qoiLmYbArm8A21bEZGhgLTz+JYI4H5fgN
         jSFitSAdFBhHFI3BSew5bbvmDfLBU9UfyGMkQTwDMs8cebxb0XGlSh8D3h7ikCmrGvfO
         q+hhUlkRCEmC1RgAl9CuqC/jsR7GYaJtWkAonrgPIe5CipjyJH3JCCkAttLZMZnILPyI
         TM5NdIrEphBmJ9YeV7GxLuttN9JtyiWN9lIL93CHgqEEN3QVnm+o57fAw9U87Z7ehUid
         XqGXpTnvoTv67/9WefFB/tL1HnoU0skT0EWkEVCH4gCSEvfDZ/H3g5+K1VAoPO/MpDRx
         OZ0A==
X-Received: by 10.50.66.170 with SMTP id g10mr57838154igt.49.1425686147285;
 Fri, 06 Mar 2015 15:55:47 -0800 (PST)
Received: by 10.107.131.155 with HTTP; Fri, 6 Mar 2015 15:55:17 -0800 (PST)
In-Reply-To: <1425685087-21633-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264977>

I'm still wondering if we should reserve more from the packet length.
We have used length 0000 for pkt-flush. Shawn pointed out that we
still have 0001, 0002 and 0003 but we may use some of them to avoid
abuse of pkt-flush in some cases. Perhaps we could limit packet length
to 0xfff0, so we have 0xfff1-0xffff to assign special meanings in
future, if we have to.

On Sat, Mar 7, 2015 at 6:38 AM, Stefan Beller <sbeller@google.com> wrote:
> +In version 2, when the client initially connects, the server
> +immediately sends its capabilities to the client. Then the client must
> +send the list of server capabilities it wants to use to the server.
> +
> +   S: 00XXcapabilities 4\n
> +   S: 00XXcap:lang\n
> +   S: 00XXcap:thin-pack\n
> +   S: 00XXcap:ofs-delta\n
> +   S: 00XXagent:agent=git/2:3.4.5+custom-739-gb850f98\n
> +
> +   C: 00XXcapabilities 3
> +   C: 00XXcap:thin-pack\n
> +   C: 00XXcap:ofs-delta\n
> +   C: 00XXcap:lang=en\n
> +   C: 00XXagent:agent=git/custom_string\n
> +
> +----
> +  cap              =  PKT-LINE("capabilities" SP size LF list)
> +  size             =  *DIGIT
> +  capability-list  =  *(capability) [agent LF]
> +  capability       =  "cap:" keyvaluepair LF
> +  agent            =  keyvaluepair LF
> +  keyvaluepair     =  1*(LC_ALPHA / DIGIT / "-" / "_" / "=")

If we send one cap per pkt-line, cap can contain spaces. The question
is, should we allow them?

Ending cap lines with LF seems redudant because we already know the line length.

> +  LC_ALPHA         =  %x61-7A
> +----
> +
> +The client MUST ignore any data before the pkt-line starting with "capabilities"
> +for future easy of extension.
> +
> +The server MUST advertise "size" as the decimal number of lines following
> +the "capabilities" line. This includes lines starting "cap:" and "agent:" for now.
> +The client MUST ignore lines which start with an unknown pattern.

I think the common pattern in our protocol is to end these with a
pkt-flush, instead of send the number of items upfront. If we do that
we don't have to specify "cap:" or "agent:" either. All pkt-lines
until pkt-flush at the beginning of v2 are cap lines. And agent is
just another "capability".
-- 
Duy
