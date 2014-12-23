From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/18] Offer a function to demote fsck errors to warnings
Date: Tue, 23 Dec 2014 10:14:14 -0800
Message-ID: <CAPc5daWBL89KpYqONNyvJ-t8K1P-nMJVAU1bLWkqzHGdb2q-gA@mail.gmail.com>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
 <2a0c4cd4c5d3aaceff8a6ffa49d2f3597d26086d.1418055173.git.johannes.schindelin@gmx.de>
 <xmqqoarbidv7.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222232270.21312@s15462909.onlinehome-server.info>
 <xmqqfvc78hwq.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222330080.21312@s15462909.onlinehome-server.info>
 <xmqqy4pz71g7.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412222348040.21312@s15462909.onlinehome-server.info>
 <xmqqlhlz6zti.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412231051320.21312@s15462909.onlinehome-server.info>
 <xmqqr3vq49w5.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412231723480.21312@s15462909.onlinehome-server.info>
 <xmqq61d24724.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412231828050.21312@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 23 19:14:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3Tyr-0004JY-Oo
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 19:14:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbaLWSOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 13:14:36 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:43104 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbaLWSOf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 13:14:35 -0500
Received: by mail-pd0-f179.google.com with SMTP id fp1so8231489pdb.24
        for <git@vger.kernel.org>; Tue, 23 Dec 2014 10:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=IvAAPOgT6hIyQXLjn0QcfLJ6PGHKu8UpDdAHE+YIL/I=;
        b=QUTBhbAuqLkRufez7BUxJ/B7a5aWCeM4xPHhnK83kakBIel7fdA6qwlSdziwq+rEGH
         6jdjjSTAYcaTqUVsWy85sZ12ErIXgB8pgQ/OGnRtxHQRuK3t7i9ZHaRVN54Gp7HyWaMc
         8ApqMXEcxqu0daWflfCYDhPjFzQQ7f4alRnKUpX567qJBmPAjAQlGPmsYewCAgPpJuCB
         Cq5icpwSbi68ShpPauAIT4UkNcaMr7RT5SVKH3m8UC3knAPwCLH0BwzySDVJjw7v6Yp8
         13b7VuBNfBVxGMTOYa9CtgDZixk3xE043eITsyOqfvLjf98NTQuGQj/OtpQCHMXH8ihV
         busQ==
X-Received: by 10.66.150.164 with SMTP id uj4mr46242447pab.14.1419358475072;
 Tue, 23 Dec 2014 10:14:35 -0800 (PST)
Received: by 10.66.74.134 with HTTP; Tue, 23 Dec 2014 10:14:14 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.1412231828050.21312@s15462909.onlinehome-server.info>
X-Google-Sender-Auth: ExuP54PxC2ahLUySD-tXRh4I0PI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261754>

On Tue, Dec 23, 2014 at 9:28 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> > And *still*, this is *just* a global table with defaults. I would *still*
>> > need to copy-on-write when the first customization of the severity level
>> > takes place because I cannot allow the global defaults to be modified by
>> > one caller (that would defeat the whole purpose of having per-caller
>> > settings bundled in the fsck_options struct).
>
> There is no alloc. Right now, the initialization reads:
>
>         struct fsck_options options = strict ?
>                 FSCK_OPTIONS_STRICT : FSCK_OPTIONS_DEFAULT;

Then it is just the matter of having

   fsck_options_init(&options);
   if (strict)
    options.some_field = make_it_strict;

as the first few statements, no?

I am not sure why it is so difficult....
