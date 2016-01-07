From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 00/15] ref-filter: use parsing functions
Date: Thu, 7 Jan 2016 15:36:59 -0500
Message-ID: <CAPig+cSJ-6v2x4CY7h9OZQwSR4y9dXGnhxUv2Ykt997vx6gcZg@mail.gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
	<CAPig+cRjXHmBnnmHbbibeV-gcvwMFQc7-5ce4s2OHu+wQwMy4Q@mail.gmail.com>
	<CAOLa=ZSi0c61G8oXsCC0UfprDhf3hESaqKw8eGNRZJ7MTvNY4g@mail.gmail.com>
	<xmqqvb7544de.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 07 21:37:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHHIz-0003AL-VX
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 21:37:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109AbcAGUhD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 15:37:03 -0500
Received: from mail-vk0-f52.google.com ([209.85.213.52]:33481 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120AbcAGUhA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jan 2016 15:37:00 -0500
Received: by mail-vk0-f52.google.com with SMTP id i129so42688434vkb.0
        for <git@vger.kernel.org>; Thu, 07 Jan 2016 12:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=MOahPg5U9SbIHWh/3VCMCvSrQfNuwBPcMQotMg3ve7s=;
        b=srNVuhXQqYNbgdhlBIWZjiwazLd5Dvsu9OLk14Xns3hLFYe/zP9bPO+ZRHH/pVISl5
         qF+F4wDQL8+bdizV9XILAYFlaEMvVkVLQiPGZFc7tzHBH32RcJkHgiNR77YITcJk6iM4
         gCfaZOID7Ce4iXZVSqtzqz+su01Sg3gvm69RKAbWJTTBfmULvlHZPcdSF8UnU0gNEsdx
         8dJVd1tDmCmcmvWcTupMUv43WoXq4ZCWqKr6i/T0W1LyHAL7cZvSu4GA03yoEUcIBQMC
         9Ti+y7n81Vv5Wn9MC93g2C6xcSUO+9DTCIXD3uHVtacD68Y7SHh8NqWUwBxVoFo04Ti/
         wSHg==
X-Received: by 10.31.182.143 with SMTP id g137mr43233535vkf.45.1452199019988;
 Thu, 07 Jan 2016 12:36:59 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 7 Jan 2016 12:36:59 -0800 (PST)
In-Reply-To: <xmqqvb7544de.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: y-z1Y2_0JZojkq-THrZYKSJ45tw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283506>

On Thu, Jan 7, 2016 at 1:43 PM, Junio C Hamano <gitster@pobox.com> wrote:
> If we really want to avoid having separate subject_atom_parser() and
> body_atom_parser(), they can be folded into the same function and it
> becomes necessary to switch on atom->name like you did in the code
> being discussed in the quoted part above.  For that, as Eric said,
> skipping '*' manually would not be a big deal, as that should not
> happen so often in the code _anyway_.  It is not a good idea to
> switch on atom->name inside contents_atom_parser() like you did.
> You are better off having separate {subject,body}_atom_parser()
> functions.
>
> For one thing, you are not reusing or sharing any code by squishing
> these three functions into one.  A conceptually larger problem is
> that you are adding two extra !strcmp() calls to figure out the
> caller _already_ knows (notice I said this is "conceptual", this is
> not about performance).  parse_ref_filter_atom() knows that it is a
> "%(subject)" or "%(subject:...)" atom, but because you throw away
> that information and call contents_atom_parser() by saying that it
> is one of the contents, subject or body, the called function has to
> redo strcmp in order to figure it out itself.

Thanks for spelling this all out. I had come to the same conclusion
yesterday after posting my message but never got back to the computer
long enough to compose a proper email explaining the issue. I fully
agree that this would be a better design.
