From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cvsimport: rewrite to use cvsps 3.x to fix major bugs
Date: Fri, 11 Jan 2013 11:17:07 -0800
Message-ID: <7vr4lrbkcs.fsf@alter.siamese.dyndns.org>
References: <1357875152-19899-1-git-send-email-gitster@pobox.com>
 <7va9sfd6lk.fsf@alter.siamese.dyndns.org>
 <20130111185818.GA30398@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Fri Jan 11 20:17:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttk6d-0004dj-6G
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 20:17:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754156Ab3AKTRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 14:17:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47888 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753679Ab3AKTRK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 14:17:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4468AA506;
	Fri, 11 Jan 2013 14:17:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=goOegOOjuNtvCHs/Tk6Nd8SdC/8=; b=N0FwsS
	n9FTkptvyNvc+1t9wZzWUo58rCoP0t0+7IxWuXHLHix7BE/LBqbQOUnvVH1HaDSX
	Yfer0rF3coyKH1SGBimWUFboOY6kr4yv6sndfKw9GOw8Y2QTFse59Zt+4SIJ5Trv
	PD7PqAqgZ4rNzf+9jwNVq4Fyv3BMJPZ0VNtJs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pzwxTSUvHaxAUi8loKKK3iJ2DMaEVAlz
	Ph1pwCpBJylrb40KmjQ+nNRLltH48d6BNXYIohD7HAMRjINEkHuKHn5n1rVa+t9b
	oLZAORNtfYqaGmkVijVSfX3pFb4FC5bihjQlySahxoGBq9xIokqoEWTI1Yrk37Cd
	cfsFrXd3Do0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 370C7A505;
	Fri, 11 Jan 2013 14:17:09 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 962E7A504; Fri, 11 Jan 2013
 14:17:08 -0500 (EST)
In-Reply-To: <20130111185818.GA30398@thyrsus.com> (Eric S. Raymond's message
 of "Fri, 11 Jan 2013 13:58:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7E3F4CE2-5C23-11E2-874B-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213236>

"Eric S. Raymond" <esr@thyrsus.com> writes:

> Junio C Hamano <gitster@pobox.com>:
>> I think the prevalent style in this script is to write "print"
>> without parentheses:
>> 
>> 	print STDERR "msg\n";
>
> That can be easily fixed.
>
>> This looks lazy and unsafe quoting.  Is there anything that makes
>> sure repository path does not contain a single quote?
>
> No. But...wait, checking...the Perl code didn't have the analogous
> check, so there's no increased vulnerability here.  I'll put it on the
> to-do list for after I ship parsecvs.

I checked before I sent that review, and as far as I could tell, it
was fairly consistently avoiding the lazy and insecure forms, e.g.

	system("com mand " . $param);
	open($fh, "com mand " . $param . " |"); while (<$fh>)	{ ... }

but used the more sequre list form, e.g.

	system(qw(com mand), $param);
        open($fh, "-|", qw(com mand), $param); while (<$fh>)	{ ... }

But of course there may be some places that were careless that I
didn't spot (and previous reviewers of the current cvsimport
didn't).
