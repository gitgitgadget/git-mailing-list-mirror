From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] fsck: it is OK for a tag and a commit to lack the body
Date: Sun, 28 Jun 2015 14:21:56 -0400
Message-ID: <CAPig+cR8MzEX+-Xi8YD7K=iHmYB3hjZKraFcyJ0mqKzY16HS8g@mail.gmail.com>
References: <20150625155128.C3E9738005C@gemini.denx.de>
	<xmqqegkzzoaz.fsf@gitster.dls.corp.google.com>
	<20150625201309.5026A384E81@gemini.denx.de>
	<xmqqegkzy1ri.fsf@gitster.dls.corp.google.com>
	<2b124e09d9c89ff3892f246ea91aa3c4@www.dscho.org>
	<xmqqoak3wkkq.fsf@gitster.dls.corp.google.com>
	<xmqqbng3wheu.fsf@gitster.dls.corp.google.com>
	<d455a77d76b3558fb79d550d6ed4468d@www.dscho.org>
	<20150626155248.GB30273@peff.net>
	<xmqqlhf3elxk.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Wolfgang Denk <wd@denx.de>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 28 20:22:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9HDO-0007Gy-9t
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 20:22:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310AbbF1SV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 14:21:57 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33290 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbbF1SV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 14:21:57 -0400
Received: by ykdt186 with SMTP id t186so97899861ykd.0
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 11:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=VSpnyHjwUNrZuZ/+BZhWutFniPeATlhgvDpkoWDehrk=;
        b=gxmvF4EY0GcCaEwq733NZRIOfps1Mj+DrzE1bb+bhELrCQxkThFYqDy8LBw2g0Z2Ta
         00zbeNoyYsa52IM1qXx94zs07roqzxSTI+ouHCIaiVdwG9a38bP0K4j7n3viRozBKunr
         OX7BRH7utkniUCV1bZ4LR2zFaUVYas76dg8cB14cJ5eUb5BbEU61iobOZ9iLw8a6JC5N
         NU0klZaRVwQb4Prq7pb5qRqWm0GAhPJMvkV5zym1Zd3hBEyJ9mYax6hk38Kt90t3sf5A
         bt6rkWbYj1oJU+VvaAZgjorChXX3AqhGVgg/qw84LYearIJfeByS2p8gYuxb0S1Sjqgx
         J3BA==
X-Received: by 10.129.70.69 with SMTP id t66mr779890ywa.4.1435515716376; Sun,
 28 Jun 2015 11:21:56 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Sun, 28 Jun 2015 11:21:56 -0700 (PDT)
In-Reply-To: <xmqqlhf3elxk.fsf_-_@gitster.dls.corp.google.com>
X-Google-Sender-Auth: gJ4k6LUp9s2x2sQoR4uX9WWHa6Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272923>

On Sun, Jun 28, 2015 at 2:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> When fsck validates a commit or a tag object, it scans each line in
> the header the object using helper functions such as "start_with()",

s/header/& of/

> etc. that work on a NUL terminated buffer, but before a1e920a0
> (index-pack: terminate object buffers with NUL, 2014-12-08), the
> validation functions were fed the object data as counted strings,
> not necessarily terminated with a NUL.  We added a helper function
> require_end_of_header() to be called at the beginning of these
> validation functions to insist that the object data contains an
> empty line before its end.  The theory is that the validating
> functions will notice and stop when it hits an empty line as a
> normal end of header (or a required header line that is missing)
> before scanning past the end of potentially not NUL-terminated
> buffer.
>
> But the theory forgot that in the older days, Git itself happily
> created objects with only the header lines without a body. This
> caused Git 2.2 and later to issue an unnecessary warning on some
> existing repositories.
>
> With a1e920a0, we do not need to require an empty line (or the body)
> in these objects to safely parse and validate them.  Drop the
> offending "must have an empty line" check from this helper function,
> while keeping the other check to make sure that there is no NUL in
> the header part of the object, and adjust the name of the helper to
> what it does accordingly.
>
> Noticed-by: Wolfgang Denk <wd@denx.de>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
