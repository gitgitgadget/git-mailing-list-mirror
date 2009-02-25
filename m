From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 4/4] git submodule: Fix handling of // and /.. in paths
 for added submodules
Date: Wed, 25 Feb 2009 13:25:16 -0800
Message-ID: <7v1vtm1a6b.fsf@gitster.siamese.dyndns.org>
References: <49A541D3.4030001@viscovery.net>
 <1235568392-19705-1-git-send-email-git@drmicha.warpmail.net>
 <1235568392-19705-2-git-send-email-git@drmicha.warpmail.net>
 <1235568392-19705-3-git-send-email-git@drmicha.warpmail.net>
 <1235568392-19705-4-git-send-email-git@drmicha.warpmail.net>
 <1235568392-19705-5-git-send-email-git@drmicha.warpmail.net>
 <49A55056.8020504@viscovery.net> <49A556D5.7020806@drmicha.warpmail.net>
 <49A55DAD.2000309@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Andrei Thorp <garoth@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Feb 25 22:27:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcRHY-0002qq-7u
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 22:27:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756154AbZBYVZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 16:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756068AbZBYVZ0
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 16:25:26 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43616 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601AbZBYVZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 16:25:25 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C90F5105E;
	Thu, 26 Feb 2009 16:25:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E9252105D; Thu,
 26 Feb 2009 16:25:16 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F9D366F6-044B-11DE-81AF-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111497>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Michael J Gruber schrieb:
>> Johannes Sixt venit, vidit, dixit 25.02.2009 15:06:
>>> I think we have so far avoided \+ in sed expressions for portability reasons.
>> 
>> Hmmpf. Is it that new, or gnu specific? I'm always afraid of portability
>> issues with bash but wasn't aware of sed being an issue as well.
>> 
>> In any case, would 's|\\*|/|g' be better (more portable) then?
>
> You mean 's|//*|/|g'; yes, that is definitly portable.
>
>> Well, how is
>> 
>> echo a/b/c/../../d | sed -e ':start;s|\([^/]*\)/\.\./||g;tstart'
>> a/d
>> 
>> I meant: how portable is...
>
> I don't know... Let's see: My AIX 4.3.3 sed understands it if it is not
> all on a single line, and that says a lot. Specifically, I tried this:
>
> echo a/b/c/../../d | sed -e ':start
>              s|\([^/]*\)/\.\./||
>              tstart
> '
>
> and got the desired result:
>
> a/d
>
> Note that the 'g' flag is not necessary in this case.
>
> OTOH, this sed doesn't understand #comments :-/

Historically, sed was much worse than the shell when it came to the
portability issues, especially before people started to use bash, which
tipped the balance a bit by worsening the situation for the shell side.

The sed scripts in the more important parts of scripted Porcelains avoid
multiple commands on a single line concatenated with ";" mostly by inertia
on my side, but it was acquired exactly from this kind of portability
mess.  IIRC, AIX's was the worst offender. It also got "/A/../B/ { ... }"
wrong in earlier versions.
