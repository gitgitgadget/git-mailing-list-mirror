From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] index-pack: fix allocation of sorted_by_pos array
Date: Tue, 07 Jul 2015 08:49:19 -0700
Message-ID: <xmqqvbdw3r40.fsf@gitster.dls.corp.google.com>
References: <1429354025-24659-1-git-send-email-pclouds@gmail.com>
	<1429354025-24659-3-git-send-email-pclouds@gmail.com>
	<xmqqoajt5glu.fsf@gitster.dls.corp.google.com>
	<CACsJy8D872sj9WQec_FZrTxx=gqy++L1XLxJdEtEQNpGpFYr=Q@mail.gmail.com>
	<xmqqzj3c3efv.fsf_-_@gitster.dls.corp.google.com>
	<xmqqr3on369x.fsf_-_@gitster.dls.corp.google.com>
	<CACsJy8CsUu1zEnah9Ah3tQxk8N-xPpOBuV5TpQ4EB6+nyiDW3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 17:49:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCV7g-0007SU-Hx
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 17:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757782AbbGGPtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 11:49:24 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34799 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756533AbbGGPtW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 11:49:22 -0400
Received: by iebmu5 with SMTP id mu5so136788041ieb.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 08:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=7l3kmrXOwgf8juf2qTQM28nl/qVRcX15CNfw3z0eLqs=;
        b=i90xCvmJ3iTS0YqjbDzKN1V9n3iSWy8If9VQk4zp2+c24oq1WI0Bel8/mFM4E2v4ZX
         TrRlRBLmfaTibY5icbNWtbRLlg/ejYyE93AcJ6ZBEa1HnF/dOqGafI6eQWUTEA2N66iO
         RV9vM+SgHUYhys/fFvjc8tIr1pR3VCRQAC82F6ECjDWIgifdV+gmKjzd67GnBzyEiUKU
         jNJuxwljDGGRYK9d6aL0jAj8lyub1rfBbJUvTrdE0u/5aDH+lld0OTQKfCXr5DBZ5Jin
         E/hORiJG/f6PyXqJAjPXETXW6TVw5ACB4qfog0KeTuT3xdKJsXOeOclu/UaArkFSuLRp
         98nA==
X-Received: by 10.107.9.150 with SMTP id 22mr7717240ioj.39.1436284162131;
        Tue, 07 Jul 2015 08:49:22 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d74:6f43:1e30:fb1d])
        by mx.google.com with ESMTPSA id b71sm216475iob.31.2015.07.07.08.49.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 Jul 2015 08:49:21 -0700 (PDT)
In-Reply-To: <CACsJy8CsUu1zEnah9Ah3tQxk8N-xPpOBuV5TpQ4EB6+nyiDW3g@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 7 Jul 2015 07:36:23 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273568>

Duy Nguyen <pclouds@gmail.com> writes:

> I keep tripping over this "real_type vs type" in this code. What do
> you think about renaming "type" field to "in_pack_type" and
> "real_type" to "canon_type" (or "final_type")? "Real" does not really
> say anything in this context..

An unqualified name "type" does bother me for the word to express
what representation the piece of data uses (i.e. is it a delta, or
is it a base object of "tree" type, or what).  I think I tried to
unconfuse myself by saying "representation type" in in-code
comments, reviews and log messages when it is not clear which kind
between "in-pack representation" or "Git object type of that stored
data" a sentence is talking about, and I agree "in_pack_type" would
be a vast improvement over just "type".

To me personally real- and final- mean about the same thing
(i.e. what is the real type of the object that is stored?) in the
context of this codepath.

Especially, if the other one is renamed with "in_pack_" prefix,
"real_type" is not just clear enough but is probably better because
it explains what it is from its "meaning" (i.e. it is the type of
the Git object, not how it is represented in the pack-stream) than
"final_type" that is named after "how" it is computed (i.e. it makes
sense to you only if you know that an in-pack type "this is delta"
does not have the full information and you have to traverse the
delta chain and you will finally find out what it is when you hit
the base representation).

Thanks.
