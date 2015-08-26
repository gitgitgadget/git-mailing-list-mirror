From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 00/12] port tag.c to use ref-filter APIs
Date: Wed, 26 Aug 2015 13:19:33 -0700
Message-ID: <xmqq61413iqy.fsf@gitster.dls.corp.google.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
	<vpqzj1hkc5q.fsf@anie.imag.fr>
	<xmqq7fok2u57.fsf@gitster.dls.corp.google.com>
	<xmqqy4h01egr.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZQwW9hpg4p8+DE2oZA28Av7mLrqAhEdcro=esuqHe35Xg@mail.gmail.com>
	<xmqqzj1fxjpj.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZSu7XyZhWUL=25dnkiGm2mNDyFhXwS_JqudyfKPE5sisQ@mail.gmail.com>
	<xmqq6142w1xf.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZS3Fj8EFMp+BXEomeW2PfkBJemoO2-8Tv=RBRb9xGmEyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 22:19:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUhAa-0004H7-7l
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 22:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200AbbHZUTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 16:19:36 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35636 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751888AbbHZUTf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 16:19:35 -0400
Received: by pacdd16 with SMTP id dd16so170973278pac.2
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 13:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=nZMwoJuflfTjMkTUWImeOY+NgVlVhDJSmn+3Gj/m/GQ=;
        b=p3tJK3nCXanzPncmH//0ZGHyzeQ9JoDa8grtGA6p9xKMohUzgjJT0xIi7AaPWMNgG2
         fIqOgheID3pzA+KnLswOWs3r1mvEyIGuLG49ubIB1wfN/cWCFMGOD2bXIWKQbvdLO35v
         s/XxUUYlcLkgO5uOSNU7b2uHA91a66wjAmX7JX1WW2P01e6No1D2p0PnlstgXUj+8J9X
         KX1nGPfRweiPLIiXGxaLX3S00wtfW2KYBL1sS1+KV99P1qW1FteO9hknYs61eO/mjoZ3
         f/DVU/WGYtCLH2D/K2YcRlq9ZITYBLD77/vN5Wfj6WV3f6y16jKgedPrtvnXrIpRrTQ3
         /DCg==
X-Received: by 10.68.98.194 with SMTP id ek2mr587480pbb.152.1440620374801;
        Wed, 26 Aug 2015 13:19:34 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ac9b:ef8c:b4db:d257])
        by smtp.gmail.com with ESMTPSA id sb2sm25638734pbc.32.2015.08.26.13.19.33
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 26 Aug 2015 13:19:33 -0700 (PDT)
In-Reply-To: <CAOLa=ZS3Fj8EFMp+BXEomeW2PfkBJemoO2-8Tv=RBRb9xGmEyw@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 27 Aug 2015 00:44:44 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276635>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Wed, Aug 26, 2015 at 8:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> ...  You can give a new format_ref_array_item()
>> that does not print but fills a strbuf to this caller, make
>> show_ref_array_item() a thin wrapper that calls it and prints it
>> with the final LF for other callers.
>>
> You're saying remove show_ref_array_item() (even the wrapper you mentioned
> above) and just have something like format_ref_array_item() which
> would output to a strbuf. and let the caller worry about the printing?

Among the current callers, the one in builtin/tag.c that wants to
trigger show_tag_lines() hack embedded in show_ref_array_item()
function can stop calling show_ref_array_item() and instead can do

	for (i = 0; i < array.nr; i++) {
		struct strbuf out = STRBUF_INIT;
        	format_ref_array_item(&out, ...);
                if (filter->lines) {
                	... append tag lines to out ...
		}
                printf("%s\n", out.buf);
                strbuf_reset(&out);
	}
                
The current and future callers of show_ref_array_item() that do not
want to trigger the show_tag_liens() hack embedded in there may
still want it to print the formatted string including the trailing
LF, so you can keep show_ref_array_item() as a thin wrapper around
format_ref_array_item() for them to call, e.g.

	show_ref_array_item(...) {
		struct strbuf out = STRBUF_INIT;
        	format_ref_array_item(&out, ...);
                printf("%s\n", out.buf);
                strbuf_release(&out);
	}

But if it has only one caller each, you may not even want to have
show_ref_array_item(), if you are going to do the "output to strbuf"
variant.


		        	
