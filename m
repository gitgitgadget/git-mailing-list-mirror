From: "Tuncer Ayaz" <tuncer.ayaz@gmail.com>
Subject: Re: [PATCH] Fix argument handling for fetch-pack call when stdout is connected and -q/--quiet is supplied.
Date: Fri, 3 Oct 2008 22:18:55 +0200
Message-ID: <4ac8254d0810031318j3e0f326ewc4bf250c51681670@mail.gmail.com>
References: <4ac8254d0810031234x26ebc96cy7cf5dcae2ef516e0@mail.gmail.com>
	 <alpine.LNX.1.00.0810031548260.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, davej@codemonkey.org.uk
To: "Daniel Barkalow" <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Oct 03 22:20:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Klr8B-0000GU-Cy
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 22:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840AbYJCUS5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 16:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752534AbYJCUS5
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 16:18:57 -0400
Received: from wr-out-0506.google.com ([64.233.184.233]:51857 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbYJCUS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 16:18:56 -0400
Received: by wr-out-0506.google.com with SMTP id 69so736605wri.5
        for <git@vger.kernel.org>; Fri, 03 Oct 2008 13:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=7V02p0hBvgZ7vc8hSb8m9JCmtUsXXTOL2iadPpCwbnE=;
        b=kJM2D3SLAtKdijxV+/l7qitkai+khLQydhFCyJvkG0pwo/gZiz09aH2VhTdgM5RFxZ
         qImDo4oAbQoVDHilQ8RIK0xY6wPr3WMsE/uNvd0Y34m3XcbWSSa7+GFsmDxtYzgb/fYg
         VXPT/Cx2XAsnPK1n20FDha06VDwsuf2xKy2BU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=wL16EpqG3qiNCGHxZ1UuNlCV5yJ+IFe67F+W8sxveO4Z2jVwhC529SBiK+6UULECFc
         HhqyDsryhDZ35NLlM0re8wF92fL0d2HJ7zsrW9hD8XNlBElZvdsbpSBpqoApJfLz4kpa
         05eDLTkobnPmljmqASlQzYnH4WULac2HFgzSE=
Received: by 10.151.155.9 with SMTP id h9mr2275515ybo.8.1223065135662;
        Fri, 03 Oct 2008 13:18:55 -0700 (PDT)
Received: by 10.65.251.6 with HTTP; Fri, 3 Oct 2008 13:18:55 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.00.0810031548260.19665@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97451>

On Fri, Oct 3, 2008 at 9:50 PM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Fri, 3 Oct 2008, Tuncer Ayaz wrote:

<snip>

>> diff --git a/transport.c b/transport.c
>> index 71433d9..1f24011 100644
>> --- a/transport.c
>> +++ b/transport.c
>> @@ -644,7 +644,7 @@ static int fetch_refs_via_pack(struct transport *transport,
>>     args.include_tag = data->followtags;
>>     args.verbose = (transport->verbose > 0);
>>     args.quiet = args.no_progress = (transport->verbose < 0);
>> -   args.no_progress = !isatty(1);
>> +   args.no_progress = args.quiet || !isatty(1);
>
> If you're doing that, remove the "args.no_progress =" from the previous
> line, which was there to have that effect (but not so clearly). Aside from
> that, it looks good to me.
>

<snip>

Thanks Daniel, that makes a lot of sense.

Signed-off-by: Tuncer Ayaz <tuncer.ayaz@gmail.com>
---
 transport.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/transport.c b/transport.c
index 71433d9..35cac44 100644
--- a/transport.c
+++ b/transport.c
@@ -643,8 +643,8 @@ static int fetch_refs_via_pack(struct transport *transport,
        args.use_thin_pack = data->thin;
        args.include_tag = data->followtags;
        args.verbose = (transport->verbose > 0);
-       args.quiet = args.no_progress = (transport->verbose < 0);
-       args.no_progress = !isatty(1);
+       args.quiet = (transport->verbose < 0);
+       args.no_progress = args.quiet || !isatty(1);
        args.depth = data->depth;

        for (i = 0; i < nr_heads; i++)
-- 
1.6.0.2
