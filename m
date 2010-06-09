From: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
Subject: Re: [RFC/ PATCH 1/5] tree-walk: do not stop when an error is detected
Date: Wed, 9 Jun 2010 19:18:19 +0200
Message-ID: <AANLkTimSYHX1yXEGif6Mk1kadUy1QSHTQByiyuFsqe8r@mail.gmail.com>
References: <1276087446-25112-1-git-send-email-diane.gasselin@ensimag.imag.fr> 
	<1276087446-25112-2-git-send-email-diane.gasselin@ensimag.imag.fr> 
	<1276087446-25112-3-git-send-email-diane.gasselin@ensimag.imag.fr> 
	<7vaar4p2vo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Axel Bonnet <axel.bonnet@ensimag.imag.fr>,
	=?ISO-8859-1?Q?Cl=E9ment_Poulain?= 
	<clement.poulain@ensimag.imag.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 19:18:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMOvJ-0001qv-TR
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 19:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753724Ab0FIRSg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jun 2010 13:18:36 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:1800 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474Ab0FIRSf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jun 2010 13:18:35 -0400
Received: by fg-out-1718.google.com with SMTP id l26so1852315fgb.1
        for <git@vger.kernel.org>; Wed, 09 Jun 2010 10:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=qZgExN0AWCQrj9gsgwBhUGDIas53HPYOW7aC8MieMJc=;
        b=I8T5PBuY+wBY2oH2xABUm1mLHLGdjNpJwa1B/VwLkWuuamESRPql9Yjq3R22TEFFy6
         /6LOaQS08vUsiXOH3J2NO/QG6yB8ex2OhQb5t+rTp5JJSOxeC3sCmA60dT6P4Vz7Llw8
         MFww1pDvrZnrOlnPOEVZ+A7JPoe9pEcgTvk4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=AneHpx1K8dhSJ1GhIAlc72qyhADEv9pqbUDOJn93l3ZAXYonDq6HPW9J54DK4ICvrD
         7bZtZmTB7BXodsS5VLn7SHbI1evjsVTX82OkysIgn8hRj8y6ifQb4R3BAOrul64qCEod
         tC8T3DnkXhY1ybD03D8fI6Sx+6QhLfKTyJkqQ=
Received: by 10.239.193.141 with SMTP id j13mr1222836hbi.69.1276103914102; 
	Wed, 09 Jun 2010 10:18:34 -0700 (PDT)
Received: by 10.239.172.204 with HTTP; Wed, 9 Jun 2010 10:18:19 -0700 (PDT)
In-Reply-To: <7vaar4p2vo.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: XVb4y7plzET5OxmVHfKlEe-UfW4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148800>

Le 9 juin 2010 18:49, Junio C Hamano <gitster@pobox.com> a =E9crit :
> Diane Gasselin <diane.gasselin@ensimag.imag.fr> writes:
>
>> When an error is detected, traverse_trees() is not stopped anymore.
>> The whole tree is traversed so that all the merging errors can be de=
tected.
>
> A small worry is if we have some codepath that uses this function lik=
e
> this:
>
> =A0 =A0if (traverse trees finishes successfully) {
> =A0 =A0 =A0 =A0be happy, all is well;
> =A0 =A0} else {
> =A0 =A0 =A0 =A0attempt a different strategy to achieve
> =A0 =A0 =A0 =A0what we wanted to with traverse trees, if
> =A0 =A0 =A0 =A0it worked fine.
> =A0 =A0}
>
> In such a case, spending extra cycles in traverse-trees only to colle=
ct
> more errors would actively degrade performance in the "alternative
> implementation" codepath. =A0For "try 'quick but limited' version fir=
st, and
> if it doesn't work, try more elaborate version spending extra cycles"
> pattern to work well, the 'quick but limited' version needs to fail
> quickly without wasting extra cycles when it hits its limitation. =A0=
In the
> original code, we deliberately returned early upon seeing the first e=
rror
> exactly for this reason.
>
> I don't think of concrete examples offhand (fallbacks "merge -s resol=
ve -s
> recursive" or "am -3" use come close, perhaps), though, so I may be
> worried needlessly in this case. =A0I honestly don't know offhand.
>
> With our attention focused only on UI issues, I however would agree t=
hat
> it makes a lot of sense to collect all errors and give them all to th=
e
> user, especially because the extra cycles (compared to the current co=
de)
> spent to do so is only in the error codepath.
>

Seems pretty fair.
Can I add in this case an option to git pull and git merge to specify
that we do want to collect all the errors?
