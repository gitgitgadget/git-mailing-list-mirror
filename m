From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH/RFC 4/7] refs: factor delete_ref loose ref step into a
 helper
Date: Thu, 29 Aug 2013 14:08:51 -0400
Message-ID: <521F8E33.4060906@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com> <f5a6f3552b16519b6568a7c745ab61c26bc4a072.1377784597.git.brad.king@kitware.com> <xmqqppsw5rv8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 20:10:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VF6fz-0006Se-Li
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 20:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755963Ab3H2SKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 14:10:32 -0400
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:49115 "HELO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753786Ab3H2SKb (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Aug 2013 14:10:31 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]) (using TLSv1) by na3sys009aob129.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUh+OlnUModtpKWlJWfgiAvmf0FMKk/xp@postini.com; Thu, 29 Aug 2013 11:10:31 PDT
Received: by mail-oa0-f44.google.com with SMTP id l17so1060697oag.3
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 11:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=qTAjnLJYTO4XuVfWEnnOXi8radbz55ZP3g7hTiKBXj8=;
        b=IqxO5GywiTxX+EaDSeL39niT61ycrTvlosAcyep2u5fAtwUsPQH8Z5xjlLh2k/jQ54
         HiVqiT+Ib4+vgbX44Rh32Ygl7cjm8YU16zbNahSVn5U9Z8mOYqivV1ZPeIMKrY0uTdDh
         6aCmeJMAW+0KuBQDJRoNTum6eyI1/KAR1Fq0kRTl+CmOxQFwQ6uSygpVVn8jeOYOGYBQ
         AjMMAOns0934RQ3kaQGnA+i3Z/K4N2WAu3Ig8ieyK+L5Alq0S/U9aZZEeQwpHBDs+7s/
         6clxU92bM52P2DjDOyNoadVJYJpxLFoE6JdX9bxkJ/gii9vj6oMjWd2y3PiwHBKeX84n
         k/ew==
X-Gm-Message-State: ALoCoQkEpPztTQWuxIAkaBjBK6Gekzalp4TLvPYCS/dBHdoUj5HmKHA8DuZfxsMscWQjvrUy1UV1H2sySgttq31ou9De7RBgrvOjoeUXSjvVlJbPs7lD45POOgKjYj9vMeNiBdIFLS/Ezc4tcSehZFxs3PbEPakdgA==
X-Received: by 10.60.42.168 with SMTP id p8mr1680270oel.73.1377799830434;
        Thu, 29 Aug 2013 11:10:30 -0700 (PDT)
X-Received: by 10.60.42.168 with SMTP id p8mr1680262oel.73.1377799830369;
        Thu, 29 Aug 2013 11:10:30 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id y1sm33706751oek.4.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 11:10:29 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <xmqqppsw5rv8.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233299>

On 08/29/2013 01:28 PM, Junio C Hamano wrote:
> Brad King <brad.king@kitware.com> writes:
>> -	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
>> +	if (!(type & REF_ISPACKED) || type & REF_ISSYMREF) {
> 
> Hits from "git grep REF_IS" tell me that all users of REF_IS* symbol
> that check if a bit is on in a word does so against "flag" (either a
> variable called "flag", "flags", or a structure member ".flag").
> 
> This change is making things less consistent, not more, I am afraid.

Okay, I removed this part of the change.  It makes the commit
simpler anyway.

-Brad
