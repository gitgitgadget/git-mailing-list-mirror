From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v13 00/12] port tag.c to use ref-filter APIs
Date: Wed, 26 Aug 2015 08:46:00 -0700
Message-ID: <xmqqtwrmuk7b.fsf@gitster.dls.corp.google.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
	<xmqqy4h04mx4.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZRYWNVmMeMCZSa+GcOTQ7NzuVB9RH_TFJ6-u7aFhrU=NA@mail.gmail.com>
	<xmqq8u904ix0.fsf@gitster.dls.corp.google.com>
	<xmqq37z82u2a.fsf@gitster.dls.corp.google.com>
	<CAOLa=ZS=Mtz0ny0tUWRBY0vfAgiRzaszeF0m_pxnK3+VGn1eVg@mail.gmail.com>
	<vpqd1yap8ml.fsf@anie.imag.fr>
	<xmqqy4gyukag.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>, Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 26 17:46:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUctx-0001PI-Lq
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 17:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbbHZPqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 11:46:04 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:32881 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751690AbbHZPqD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 11:46:03 -0400
Received: by pacti10 with SMTP id ti10so91940923pac.0
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 08:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=cfK6BenDkV7ZomXP7f3TIA0g16VekPQOx7etFWpsFQQ=;
        b=PjvGqCqf6dS6XFroDaVLjG3v1XSoGY/2864fbAQhDSJJi6Yg0SZKD3fdHTiDVs6J3R
         SPASdkoOoyITd1gHMgx+RUgDjcZOaM4RVHLq21/5NYbTNVNHEV2cz+TLpS6NnzvWYPjr
         E8EZ+/uaYPmVin8GlGodJbwB/ceWkfE7cd8Nz6++UBIbVMSI9zEx/zPb7IPqz3vORSh4
         p71Kit9WhpKkxoLhik6ytt8AtK+EzH2ktqVsZTl7bNHjjRKsRLOBqh85/DxRliDC8Uke
         nRzyyzrqHfdj/IVszAzS3DZe1rLC2OeG0OBoFoqM0cNmBWhv4WtFXkD+D4hRfwZQGNcC
         eDWw==
X-Received: by 10.66.162.229 with SMTP id yd5mr71322913pab.102.1440603961885;
        Wed, 26 Aug 2015 08:46:01 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ac9b:ef8c:b4db:d257])
        by smtp.gmail.com with ESMTPSA id bg2sm909128pbc.69.2015.08.26.08.46.01
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 26 Aug 2015 08:46:01 -0700 (PDT)
In-Reply-To: <xmqqy4gyukag.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 26 Aug 2015 08:44:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276610>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>>> For the current code %(if:empty)%(align)%(end)%(then)Empty%(else)Not Empty%(end)
>>> would print non-empty, I guess the documentation holds in that case.
>>> Not sure if we require it to print non-empty.
>>
>> You don't want the %(if) condition to depend on whether
>> --shell/--python/... is used. Since %(if:empty)%(align)%(end)%(then)
>> holds when you don't use --shell, you also want it to hold when you
>> quote. IOW, you should check for emptyness before (or actually without)
>> doing the quoting. I guess this is what you're doing, and if so, I think
>> it's "The Right Thing".
>
> I agree that %(align)%(end) should expand to empty and %(if:empty)...%(then)
> should look at that empty string without quoting.  So 
>
>     %(if:empty)%(align)%(end)%(then)Empty%(else)Not Empty%(end)
>
> should give "Empty"; otherwise the code is buggy, I think.

(I shouldn't be typing while eating...)

It should give "Empty", but the --shell/--python/... may make the
whole "Empty", as the result of %(if:...)...%(end), be quoted.  So
you may see "'Empty'" in the output.
