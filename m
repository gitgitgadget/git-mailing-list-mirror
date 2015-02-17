From: Junio C Hamano <gitster@pobox.com>
Subject: Re: odb_mkstemp's 0444 permission broke write/delete access on AFP
Date: Tue, 17 Feb 2015 09:13:28 -0800
Message-ID: <xmqqwq3g31hj.fsf@gitster.dls.corp.google.com>
References: <A403BFCC-D66F-49BD-B54C-BB86B467F1A1@gmail.com>
	<vpqtwyl90mx.fsf@anie.imag.fr>
	<340435D1-2FEB-4A4A-BBD2-E301096C72D8@gmail.com>
	<vpqiof14qu8.fsf@anie.imag.fr>
	<13683B35-70A8-4D9E-80E1-440E4E0DC7F0@gmail.com>
	<vpqr3tozzs5.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Fairuzan Roslan <fairuzan.roslan@gmail.com>, git@vger.kernel.org,
	tboegi@web.de
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Feb 17 18:13:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNliV-0001hm-6r
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 18:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752774AbbBQRNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 12:13:40 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64796 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751758AbbBQRNc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 12:13:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 37BA836C19;
	Tue, 17 Feb 2015 12:13:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eVRwqn/kFYUf003idK+00/HhgE8=; b=XcuTKd
	7aCxxdVfocEF6l8II0+a72O6oZekK19YQqUjLUkSIR4fatjY2Xl6fdgYWm0FBSWf
	BCUC/mDqgAJTHocPk4LbKa94RqB4g6A84sRsQ2POGB4ElJ89gWu5fqi/Mw1x6xgk
	FyNyarh2VdRxARzKiGWPgImlNopERwbdM3sHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CemdLGRPVFD7mfAMD75ZqtQMCYfl3A5i
	nV2qlEdiuQzgCv6yxqL09s4f5uZcSYSX5r57jA12YXidOmi58oLag56jEa2t8GpW
	I6Cd2GiRyfIC8MY/OBzMY24a+ppWNvdCg6myTQZUkkwSh0dJPPJTbCpackfk6nZZ
	vmmzfbeH/aI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B81336C18;
	Tue, 17 Feb 2015 12:13:31 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9E18836C0F;
	Tue, 17 Feb 2015 12:13:30 -0500 (EST)
In-Reply-To: <vpqr3tozzs5.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	17 Feb 2015 09:51:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4BA1EE32-B6C8-11E4-B8B4-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263969>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> This should be fixable from Git itself, by replacing the calls to
> "unlink" with something like
>
> int unlink_or_chmod(...) {
> 	if (unlink(...)) {
> 		chmod(...); // give user write permission
> 		return unlink(...);
> 	}
> }

I agree with the approach in principle, but I wonder if we want to
contaminate the generic codepath with unlink_or_chmod().

Don't we want to have this

	#undef unlink
	int workaround_broken_unlink(...) {
        	... the same ...
	}

in compat/broken-unlink.c and something like this

	#ifdef BROKEN_UNLINK
	#define unlink(x) workaround_broken_unlink(x)
        #endif

in git-compat-util.h instead?  That way, people on well behaving
systems do not have to worry about clobbering errno and stuff,
perhaps?
