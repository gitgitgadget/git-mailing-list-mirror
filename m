From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] bisect: simplify the add of new bisect terms
Date: Wed, 10 Jun 2015 08:10:54 -0700
Message-ID: <xmqqegljoayp.fsf@gitster.dls.corp.google.com>
References: <1433794930-5158-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433794930-5158-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<vpqbngpl5zu.fsf@anie.imag.fr>
	<550645264.367778.1433881052933.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<xmqq1thkwg5r.fsf@gitster.dls.corp.google.com>
	<1926405730.374352.1433920537226.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpqk2vcat2t.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Louis-Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, jch2355@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 10 17:11:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2hf1-00066d-GH
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 17:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbbFJPLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 11:11:10 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:34530 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754181AbbFJPK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 11:10:56 -0400
Received: by igbhj9 with SMTP id hj9so37770531igb.1
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 08:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=XYpO/1nLe+Q9hgED7VmtJG+GtzmtxMkLDT2rFh7aLvE=;
        b=H3vVJI/dVV3xklwWTYZCyHxLQimOksHpQaVkz7U20uRzYygRx+b0VPk1gglguDREva
         rj1M2YGfHtIC17W/aA0cEdZWQaPNKuHmnh7shFLChUzgWXmnaPPiiXi9jbuu9DmpQp1H
         gYdhjJYaXkzIb42UuFofMeFH6p5C2Z+/EhLH3EHzNkSWdLS9bXJPimi0nXtz85Pppe/o
         5tcmBX8XzMoUZ129kKFZx4PZwBcEUahem7s6zzGrM5GVy4/rDyX1p6w5/cSHDs/sYX5Z
         Lz5g96zfcSALWC9LHBjs7YGSzwjYsmq1heZvph8/SVSArnMqNqxBA9U9L7KY+vYez1Cc
         hu2Q==
X-Received: by 10.107.41.14 with SMTP id p14mr4933547iop.58.1433949055926;
        Wed, 10 Jun 2015 08:10:55 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id i7sm3420925igt.18.2015.06.10.08.10.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 08:10:55 -0700 (PDT)
In-Reply-To: <vpqk2vcat2t.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	10 Jun 2015 10:03:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271296>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Louis-Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr> writes:
>
>>> That is very different from ENOENT, which is an expected error when
>>> you are not using a customized terms.
>>
>> But in the current state, we are going to create bisect_terms even if
>> the bisection is in bad/good mode.
>
> Which means that in normal cases, you'll either succeed to open it, or
> get ENOENT. We're talking about unexcepted cases (you don't have
> permission to read it because it's not your file, because you messed up
> with a chmod, or whatever reason).

I think both I and you misunderstood what they wanted to do, which
is to write out good and bad into terms file even though these are
not customized, and then always read from terms file to learn what
words are used for good and bad.

So from _that_ point of view, ENOENT is an error just like others.

But I do not think it is a good idea to penalize the normal case by
writing the terms file and reading them back from it when the user
is bisecting with good/bad in the first place, so....
