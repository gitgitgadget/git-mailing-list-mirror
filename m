From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] bisect: simplify the add of new bisect terms
Date: Tue, 09 Jun 2015 17:39:12 -0700
Message-ID: <xmqq1thkwg5r.fsf@gitster.dls.corp.google.com>
References: <1433794930-5158-1-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<1433794930-5158-3-git-send-email-antoine.delaite@ensimag.grenoble-inp.fr>
	<vpqbngpl5zu.fsf@anie.imag.fr>
	<550645264.367778.1433881052933.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com, jch2355@gmail.com
To: Louis-Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 10 02:39:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2U37-0002XH-3Y
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 02:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934AbbFJAjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 20:39:16 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:34772 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722AbbFJAjP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 20:39:15 -0400
Received: by iebmu5 with SMTP id mu5so24376983ieb.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 17:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=fzBjTNNJ6q1+xAFExa+0WO/obEhWCicuDjlTnLoH2gE=;
        b=UX9h6oeT9ZNcTDkRnMRDuBODTQo9pHu5rsvbO+9qMuIngazfaxGE9a3NOP4llUP9Kc
         ed9Oz3xs8pRR2lX6/g4Y04017mE20uA4WD5Q1nEp0exrBc+MqDAdeKElqM9VnCVI2MzX
         gS/xn2/vvJDgbIUpduKV3n4qZ2t4NRiYwRT2cVkhTaNi5uucna920cIldCRbOd9jUyKr
         QkVBgIpEwQOy33GRF5GhfJBhQv/IWH+PmtLoeOT1wRYi0HnDLPN2LeWfph/CY2xFNq7V
         EsVQkj9F0hqY5UW8QQ6GGZr6HdjwzSJFz76URJ3vyh0sITmua1z0pzimR2c3U/0/bcpW
         rM/Q==
X-Received: by 10.50.43.227 with SMTP id z3mr2164767igl.12.1433896754870;
        Tue, 09 Jun 2015 17:39:14 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id pg7sm2309588igb.6.2015.06.09.17.39.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Jun 2015 17:39:13 -0700 (PDT)
In-Reply-To: <550645264.367778.1433881052933.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Louis-Alexandre Stuber's message of "Tue, 9 Jun 2015 22:17:32 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271247>

Louis-Alexandre Stuber <stuberl@ensimag.grenoble-inp.fr> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>
>> I think you would want to error out if errno is not ENOENT.
>
>
> Junio C Hamano <jch2355@gmail.com> wrote:
>
>> We might want to see why fopen() failed here. If it is because the
>> file did not exist, great. But otherwise?
>
>
> This file is always supposed to exist when the function is called
> unless the user has manually deleted it (or a bug in our programs).
>
> Maybe we should just return an error if the file cannot be opened,
> regardless the reason. We kept it like it is, with the default case,
> because it was what our elders did, and that aborting because of
> BISECT_TERMS is not good for backward compatibility.
>
> But then, in both cases, there is no reason to differenciate ENOENT.
> Is that right ?

One thing that immediately comes to mind is when you (perhaps
accidentally, or perhaps you were asked to) cd into somebody else's
repository and take a look or help, the file exists but cannot be
read by you and you get EPERM.

That is very different from ENOENT, which is an expected error when
you are not using a customized terms.
