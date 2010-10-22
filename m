From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Buglet in i18n?
Date: Fri, 22 Oct 2010 03:34:50 -0500
Message-ID: <20101022083450.GA8289@burratino>
References: <4CC13AC1.7080402@viscovery.net>
 <AANLkTimqzmPLCj=JeSGWFcY829gxct9ANGt+CCjB2jy=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 10:38:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9D9D-0005vW-TI
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 10:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442Ab0JVIil convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Oct 2010 04:38:41 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:61585 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750801Ab0JVIik (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 04:38:40 -0400
Received: by gyg4 with SMTP id 4so395255gyg.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 01:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Q42Q1+g82k9rZ3b3tK1iwfyg/x3HzJxsLIOCcNND9ZI=;
        b=gN73gQDWffrdOt6pDIXLN/8+C41NO+IJvE0c11DSdNulh+fC2G6AyDEv079YG9Npot
         VzOoU5zjrOyhHkcXLwcveaTcv3YOSQPDFDsp7raer5FAMY40C62ANQRYJg5DtUPBpA2T
         owlT/ZeCCdZq/0WUF0G9dOOUPK+ECEOXVeamA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=sXqm/yPKnk/xbrXPKr7Yuf0fk3wMq+nvqa1llDneKg50iIVYqi7myORfX2emoYBozZ
         AaLfaPDENbzNqB+ZT80vJGFEf7+LpLIDnoMUBbnNAOqjRoaTc+6OKnZXJjanfuD163eq
         /GHAe1QfbjuDZYJbZPXQ3itROCTl4wQ83X8qo=
Received: by 10.151.156.19 with SMTP id i19mr5723643ybo.82.1287736718404;
        Fri, 22 Oct 2010 01:38:38 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id h70sm2178837yha.46.2010.10.22.01.38.36
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 22 Oct 2010 01:38:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTimqzmPLCj=JeSGWFcY829gxct9ANGt+CCjB2jy=@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159664>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>         gettext () {
>             printf "%s" "$1"
>         }
>=20
>         eval_gettext () {
>             gettext_eval=3D"printf '%s' \"$1\""
>             printf "%s" "`eval \"$gettext_eval\"`"
>         }

This looks wrong.  Consider a simplified example:

	eval_gettext 'foo "bar baz"'

Now eval_gettext is supposed to just interpolate $variable
substitutions, right?  In particular, the quotation marks
ought to be preserved.

But instead, what gets evaluated is:

	printf '%s' "foo "bar baz""

which splits as

	printf '%s' 'foo bar' 'baz'

which is equivalent to

	printf '%s' 'foo bar'
	printf '%s' 'baz'

with output

	foo barbaz

Maybe something like this would do it?

	gettext_eval=3D$(
		printf '%s\n' "$1" |
		sed '
			s/[`\\"]/\\&/g
			1 s/^/printf "%s" "/
			$ s/$/"/
		'
	) &&
	eval "$gettext_eval"
