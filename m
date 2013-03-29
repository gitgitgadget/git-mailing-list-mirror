From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Minor bug in git branch --set-upstream-to adding superfluous
 branch section to config
Date: Fri, 29 Mar 2013 10:27:47 -0700
Message-ID: <7v4nfup14c.fsf@alter.siamese.dyndns.org>
References: <CAD7mMPW=jr6PaAc50h-Wpf42-UPrn0A5KmisqXNXqqLv78AEgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Phil Haack <haacked@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 29 18:28:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULd6A-0008Fi-TF
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 18:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756380Ab3C2R1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 13:27:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50997 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755826Ab3C2R1t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 13:27:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09DCAF050;
	Fri, 29 Mar 2013 17:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Zx757CX6/mIn2YHb54J88O3LPHA=; b=S9gNoK
	pUgiUHbun+5qNzOFoQYB61djbcm4zglE7+zmfhcNOZcnoOA0nCijBB+/s8JBgGW6
	Xmeq1sm+WnTSHYbznLrfud1QXbmBT5MAMlIu/DlhjoiZsZca57tayj1nbrw8gWx8
	RFOlnID3EsLo7yYODpCEmtFN3ZGcamhcui8BA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ldKNis8mhgAZ/OgenDj1SLFfmCuRKFim
	xVyUx3AdCQpZvvwusGnSiSik0cYlswYBRUiATbdFYsrBJflu+jW53UYoo89JfwLi
	s0fenYdJgiK1u0cp2dno9UTog5uFf+jdCsCyYsxyOBx4V5trSUt2XPdqPzHAu7HI
	mvUb0xxzEPE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1F3CF04F;
	Fri, 29 Mar 2013 17:27:48 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 755B6F04E; Fri, 29 Mar 2013
 17:27:48 +0000 (UTC)
In-Reply-To: <CAD7mMPW=jr6PaAc50h-Wpf42-UPrn0A5KmisqXNXqqLv78AEgg@mail.gmail.com> (Phil
 Haack's message of "Fri, 29 Mar 2013 09:29:14 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F9E91E32-9895-11E2-B68D-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219513>

Phil Haack <haacked@gmail.com> writes:

> Hello there! Please /cc me with responses as I'm not on the mailing list.
>
> I'm using git version 1.8.1.msysgit.1 and I ran into a very minor issue. It
> doesn't actually seem to affect operations, but I thought I'd report it in case
> someone felt it was worth cleaning up.

I do not think this is limited to "branch --set-whatever".

> If you run the following set of commands:
>
>     git checkout -b some-branch
>     git push origin some-branch
>     git branch --set-upstream-to origin/some-branch
>     git branch --unset-upstream some-branch

This step causes the removal of the last variable in a configuration
section, which leaves an empty section.  As the code to add a new
variable to the configuration, trying to reuse an existing section
header, does not pay attention to an empty section, you end up with
an empty section, followed by a new one.

Either removal of configuration variable should be taught to remove
the section header when a section becomes empty, or addition of
configuration variable should be taught to notice an empty section
header.



>     git branch --set-upstream-to origin/some-branch
>
> You get the following result in the .git\config file
>
>     [branch "some-branch"]
>     [branch "some-branch"]
>         remote = origin
>         merge = refs/heads/some-branch
