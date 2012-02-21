From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] git-p4: add initial support for RCS keywords
Date: Tue, 21 Feb 2012 09:25:57 -0800
Message-ID: <7vobssgkt6.fsf@alter.siamese.dyndns.org>
References: <1329258835-17223-1-git-send-email-luke@diamand.org>
 <1329258835-17223-2-git-send-email-luke@diamand.org>
 <20120221121834.GB18317@padd.com>
 <CAEe=O8qui8PryuZiZNDwLk39+tKVDnh+5eP9m_WrHi=K9ekMNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>,
	git@vger.kernel.org
To: Eric Scouten <eric@scouten.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 18:26:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RztTe-0005Qv-5I
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 18:26:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113Ab2BUR0D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 12:26:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46897 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753011Ab2BUR0B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 12:26:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D447565A9;
	Tue, 21 Feb 2012 12:25:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AI1MAoza4y6Actjo8KoKn6tuzXo=; b=UYcwGH
	kAerptWupr4FEKrKVbM41qvHUghTb7p5pehfJ1+0f4sw23PJ1o08aE1LX4Sof6M8
	Qrt5o2QLNHZXRVDdj0t3iTrblIGkxdc9FWH2gpVmH0NX8icKUiDFt5wHOZcVsXkf
	UrJQDp+yMdzJ8DMpRjNZKNAzoTQXoMm6lP1x8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p8cQCj6RNIiQ8ENT6JLVr+RdRD0SszN+
	gNMD8Ag2aPZz4wAbAcp9vBmFEiBx47RWikHkJAJUE440nMyzAvaPIgCGETzFYvwX
	nc9o+4z5nG8M7k7qtfGP+44QxZ/Un2eAt5cdElOS5OSuODTULyQ1m6T0iR5W+Ywo
	mQ2DlGyHOOM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C6ABC65A8;
	Tue, 21 Feb 2012 12:25:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3DEE965A7; Tue, 21 Feb 2012
 12:25:59 -0500 (EST)
In-Reply-To: <CAEe=O8qui8PryuZiZNDwLk39+tKVDnh+5eP9m_WrHi=K9ekMNQ@mail.gmail.com> (Eric
 Scouten's message of "Tue, 21 Feb 2012 08:54:17 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1EC17190-5CB1-11E1-BD05-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191169>

Eric Scouten <eric@scouten.com> writes:

>> > r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision)[^$]*\$'
>>
>> Still no ":"?  Won't that match too much?
>
>> Fix the colon thing at least, then happy to add my Acked-By.
>
> No, that would be an incorrect change. The colon is added by P4 when
> it expands the keyword pattern, but it is *not* part of the pattern
> required by P4 to trigger a keyword expansion.
>
> http://kb.perforce.com/article/54/using-rcs-keywords

I have this suspicion that both Pete and your last sentence is correct,
but the regexp in the patch and your "would be an incorrect change" are
wrong.

I am not a P4 expert, but I would be very surprised if P4 expands "$Ida$"
as if it is "$Id$" or "$Id: old expansion$", which the regexp would match.

Wouldn't it be more like this?

	\$			# begins with a dollar, followed by...
        ( Id | Header | ... )	# one of these keywords, followed by ...
        ( :[^$]+ )?		# possibly an old expansion, followed by
	\$			# another dollar sign
