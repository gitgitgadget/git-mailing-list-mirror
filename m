From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] gitweb: Option for filling only specified info in
 fill_project_list_info
Date: Thu, 09 Feb 2012 15:56:46 -0800
Message-ID: <7vvcnftvb5.fsf@alter.siamese.dyndns.org>
References: <1328359648-29511-1-git-send-email-jnareb@gmail.com>
 <201202092336.48772.jnareb@gmail.com>
 <7v4nuzvbnr.fsf@alter.siamese.dyndns.org>
 <201202100052.26399.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 00:56:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvdrC-0007Dr-7d
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 00:56:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758321Ab2BIX4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 18:56:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33059 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752265Ab2BIX4s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 18:56:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34B2B74AB;
	Thu,  9 Feb 2012 18:56:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q9kX2EHzF1JYzMhMI9YrMN2hf5U=; b=gTSNX+
	ghuc3rwNuBEFceoVStG6xj5IK/6vHStrXkphvtQed2B3MIdS6djjwBLamUOtXz0o
	Q7wzXv6WZacL9Ktqa2ljE7ZHVJGpB4IgM08nxn1Gxf6f/Iq7RpiyNWsYgzi3YMBo
	gS2eurfOYhgBr0YlAOD1buWzqgTr/zWWwJimw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M94fF54PU4DZaxZbAmQf3Czg+QeXCCVA
	NaWPs++s+SZaQ5FiCRBRGT5QUbsmSuX+/TwkBcBQhjcxrXIbssdByI21a5p8+vy3
	bYHOFXTw3MSbw8wc4hNkTPphsLxwuxq0nIaxtDvd28kIolf9lCy9BcrkUFB2c82i
	7onXwV1libA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BC3174AA;
	Thu,  9 Feb 2012 18:56:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A255E74A9; Thu,  9 Feb 2012
 18:56:47 -0500 (EST)
In-Reply-To: <201202100052.26399.jnareb@gmail.com> (Jakub Narebski's message
 of "Fri, 10 Feb 2012 00:52:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA21D92C-5379-11E1-9EB2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190345>

Jakub Narebski <jnareb@gmail.com> writes:

> On Fri, 10 Feb 2012, Junio C Hamano wrote:
> ...
>> That still does not answer the fundamental issues I had with the presented
>> API: why does it take only a single $key (please re-read my "A, B and C"
>> example), and what does that single $key intersecting with @fill_only have
>> anything to do with "needs-filling"?
>
> project_info_needs_filling() in absence of @fill_only is just a thin
> wrapper around "!defined $pr->{$key}", it checks for each key if it needs
> to be filled.
>
> It is used like this
>
>   if (project_info_needs_filled("A", "A, B, C")) {
>      fill A
>   }
>   if (project_info_needs_filled("B", "A, B, C")) {
>      fill B
>   }
>   ...
>  
>> After all, that 'age' check actually wants to fill 'age' and 'age_string'
>> in the project. Even if some other codepath starts filling 'age' in the
>> project with a later change, the current callers of fill_project_list_info
>> expects _both_ to be filled. So "I know the current implementation fills
>> both at the same time, so checking 'age' alone is sufficient" is not an
>> answer that shows good taste in the API design.
>
> It is not as much matter of API, as the use of checks in loop in 
> fill_project_list_info().
>
> What is now
>
>   my (@activity) = git_get_last_activity($pr->{'path'});
>   unless (@activity) {
>   	next PROJECT;
>   }
>   ($pr->{'age'}, $pr->{'age_string'}) = @activity;
>
> should be
>
>   if (!defined $pr->{'age'} ||
>       !defined $pr->{'age_string'}) {
>   	my (@activity) = git_get_last_activity($pr->{'path'});
>   	unless (@activity) {
>   		next PROJECT;
>   	}
>   	($pr->{'age'}, $pr->{'age_string'}) = @activity;
>   }

Huh?  Compare that with what you wrote above "It is used like this".  This
is *NOT* using the API like that.  The caller knows it wants both age and
age-string, and if even one of them is missing, do the work to fill both.

So why isn't the info-needs-filled API not checking _both_ with a single
call?  It is only because you designed the API to accept only a single $key
instead of list of "here are what I care about".
