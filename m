From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/WIP PATCH 06/11] remote.h: add get_remote_capabilities, request_capabilities
Date: Wed, 27 May 2015 13:19:39 -0400
Message-ID: <CAPig+cQUtjVbdF5eEo0EH-QXz4q_UqOtoFZ5DcTNzceCxWLS=A@mail.gmail.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
	<1432677675-5118-7-git-send-email-sbeller@google.com>
	<CAPig+cRfJKAQ8Q5PF1VfTAGA1njXAshC0RbnMv9cEp4bH_MN7A@mail.gmail.com>
	<20150527065030.GE885@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 27 19:19:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxezZ-0007iB-Fm
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 19:19:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753176AbbE0RTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 13:19:40 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33494 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753145AbbE0RTj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 13:19:39 -0400
Received: by iebgx4 with SMTP id gx4so18904837ieb.0
        for <git@vger.kernel.org>; Wed, 27 May 2015 10:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=EC2kfVGrcU/2gC7PTjXr19UVxHL4tvrGUbyOGMVMT3s=;
        b=KWGKEN/bbfEdGqqWZ5RxN19BSqRJomSPPtpgYpbV7qYGZK7LbSMOqZWV1aEhlaq0N4
         7t8iVi18JPsUdEUiQC+/FYdOnh6y2Cvs01O2ORlb4cWdOKi51cQwxHm4KbnlbCwF9SWx
         GvnlZdXyBrC8KiW/YktiwDVv1jbimwQxuyW1we43S7Ic16cJVVI7cxEGNxjLNpsRgBVK
         t7rHGN659qtsRAY0go90m8n68qOEd1tpMsMCCPMZjabFqz6jrsOHMvDxSpgw++dNkOKg
         iY+c1IJEprSN3Qjm/AtyzVOHa4AaRBKdYSlj7mERoiYdTZyIiiJgipMPmS9e2WFnRKjm
         yDiA==
X-Received: by 10.50.66.234 with SMTP id i10mr5828335igt.22.1432747179275;
 Wed, 27 May 2015 10:19:39 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Wed, 27 May 2015 10:19:39 -0700 (PDT)
In-Reply-To: <20150527065030.GE885@peff.net>
X-Google-Sender-Auth: RP_Wwg-0UCWHhQqWvmvpyzsapZg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270059>

On Wed, May 27, 2015 at 2:50 AM, Jeff King <peff@peff.net> wrote:
> On Tue, May 26, 2015 at 11:25:05PM -0400, Eric Sunshine wrote:
>
>> > +               len = packet_read(in, &src_buf, &src_len,
>> > +                                 packet_buffer, sizeof(packet_buffer),
>> > +                                 PACKET_READ_GENTLE_ON_EOF |
>> > +                                 PACKET_READ_CHOMP_NEWLINE);
>> > +               if (len < 0)
>> > +                       die_initial_contact(0);
>> > +
>> > +               if (!len)
>> > +                       break;
>> > +
>> > +               if (len > 4 && skip_prefix(line, "ERR ", &arg))
>>
>> The 'len > 4' check is needed because there's no guarantee that 'line'
>> is NUL-terminated. Correct?
>
> I think this was just blindly copied from get_remote_heads(). And I
> think that code was being overly paranoid. Ever since f3a3214 (Make
> send/receive-pack be closer to doing something interesting, 2005-06-29),
> the pkt-line reader will add an extra NUL to the buffer to ease cases
> like this.

Thanks. I had started digging into packet_read() to determine whether
it guaranteed NUL-termination, but didn't get far enough to decide. I
agree that if NUL-termination is guaranteed, then the 'len > 4' check
is superfluous (and confusing, which is why it caught my attention in
the first place).
