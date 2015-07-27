From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 03/11] ref-filter: add option to pad atoms to the right
Date: Mon, 27 Jul 2015 08:45:42 -0700
Message-ID: <xmqqr3ntioyh.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZTtAepdO5U8zo62VBn_z4-LcKoguPxVGaAnNZULEwzrQQ@mail.gmail.com>
	<1437982035-6658-1-git-send-email-Karthik.188@gmail.com>
	<1437982035-6658-3-git-send-email-Karthik.188@gmail.com>
	<vpq3809aho9.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jul 27 17:45:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJkb7-00025O-9R
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 17:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbbG0Ppp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 11:45:45 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33885 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbbG0Ppo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 11:45:44 -0400
Received: by pdbbh15 with SMTP id bh15so54014231pdb.1
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 08:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=nP1+9z77WdsIghVtVTqJR9ARj2Cd3o50IL1yig92ENs=;
        b=tsniRw9D2NkH5OeNoHEyE3bZoCD6Y9zBhT+xT5ZCPmf9AAEBs0c0I1HenleWXfH+A6
         h2WOc4eetwpyHBz9u+C6TsdDp14c51Wv/E3w29JRO16SRvRmVmqqdx4SA2UHJjDSTEys
         QSiipzv6Yqa1BsxQyMbzJMaw5lKRkzsw4tiLuL4xZ3/Hky81KljAgvKl5FVwObIRXo3i
         BZds7VdnMdNgcZKkv8YEn3i6bktqlFFnJcTl9t08zbwIiY6ow/p1/5L1nGNB0qDoqCWT
         jQ+OhCByx22QBwklOqn7L5UwIYnPxyfoVhYIwwE7lvLL1tQT0t2+HILbvn9BlNFvziQ7
         NMfg==
X-Received: by 10.70.41.6 with SMTP id b6mr69528678pdl.89.1438011944244;
        Mon, 27 Jul 2015 08:45:44 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:2496:725d:b368:d039])
        by smtp.gmail.com with ESMTPSA id uk6sm30349469pac.27.2015.07.27.08.45.43
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 27 Jul 2015 08:45:43 -0700 (PDT)
In-Reply-To: <vpq3809aho9.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	27 Jul 2015 14:50:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274684>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> See my remark on previous patch: this test is not sufficient. You do
> not only need to check that %(padright) is taken into account, but you
> also need to check that it is taken into account for the right atom and
> only this one. I'd suggest
>
> --format '%(refname)%(padright:25)|%(refname)|%(refname)|'
>
> Only the middle column should be padded.

This actually raises an interesting point.  It is equally valid to
view that format string as requesting to pad the first "|" with 24
spaces; in other words, %(padright:N) would apply to the next span,
be it a literal string up to the next %(atom), or the %(atom) that
comes immediately after it.

The thing is, the above _might_ be an OK way to ask the middle
refname to be padded, but I somehow find it very unnatural and
unintuitive to expect that this:

	--format '%(padright:25)A Very Long Irrelevancy%(refname)'

would do nothing to "A Very Long Irrelevancy" and affects the
refname that comes much later in the format string.

Or we could simply forbid certain atoms followed by an non-empty
literal as an error.

My preference between the three is "%(padright:4)", etc. to apply to
the "next span", but I can live with "it is an error to pad-right
a far-away %(atom)".
