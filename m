From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question: git clone --no-checkout behavior
Date: Thu, 12 Jul 2012 10:40:32 -0700
Message-ID: <7vliioc1yn.fsf@alter.siamese.dyndns.org>
References: <CAGyf7-EZOSiATo3yF5x+FT6_QAkMTJ+AmrE27kwmxLkLXdaJKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 19:40:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpNNa-0002Rf-0S
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 19:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161486Ab2GLRkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 13:40:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57600 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161455Ab2GLRkf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 13:40:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C88F37D70;
	Thu, 12 Jul 2012 13:40:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5qzKbWPFW+5VSI2Z9vawJ6tTliw=; b=X7Cf06
	JUn0IRkk/ByhNCu1i/Sz30qrEYCBupI5zp53JU0rYC1rvgXCMblyBahAH0M+P+Jl
	FJC4gwe4wMaU+FzrJV6FdDrIlTGzyFKwH1ml92Rj+Bn1pT0HdJpOmge7ZX0L/Tui
	J1yIc2W/Q1PAGb1ekrBNtXSJUpy9OxpQrtI3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iShKSJc8Miwx34c5ru+nSDueqFennii7
	g7i+MFqS4oljKNOLbu8tQYvIdZGO/bhPpDYZ1nBBhmNgGkBkbu1NHowayvoBX/F3
	5ohUIc0uxkthO1Jcf1dhTobL98HuR2uCQZKUVEHXRhCttft3SWlnbM+3UVGcpMBr
	ioI5xC16Zx4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFB367D6F;
	Thu, 12 Jul 2012 13:40:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1245D7D6C; Thu, 12 Jul 2012
 13:40:33 -0400 (EDT)
In-Reply-To: <CAGyf7-EZOSiATo3yF5x+FT6_QAkMTJ+AmrE27kwmxLkLXdaJKg@mail.gmail.com> (Bryan
 Turner's message of "Thu, 12 Jul 2012 22:51:31 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AED76C4C-CC48-11E1-8D3F-C3672E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201369>

Bryan Turner <bturner@atlassian.com> writes:

> I've witnessed the following behavior in both git 1.7.6 and 1.7.10.4.
>
> Assume I have a bare clone, some-repo.git. If I run:
> - git clone --shared --no-checkout /path/to/some-repo.git shared-repo
> - cd shared-repo
> - git status

I do not recall we *designed* it in such a way that you would commit
an empty tree if you run "git commit" immediately after making such
a clone.  But I do not think it is a bug, either.

I think the most likely reason nobody even noticed this is because
the expected use scenario for --no-checkout is when user does not
know (and does not care to find out) what branch is checked out (if
nonbare) or marked as the primary (if bare) in the repository she is
cloning from, and will checkout the branch she wants to work on
immediately after cloning, i.e.

	git clone -n $over_there here
        cd here
	# she knows she wants to fork from 'nitfol'
        git checkout -t -b frotz origin/nitfol

Not having anything in the $GIT_DIR/index (which is why you see
"everything is removed from the index, you will commit an empty
tree" in the status output) does not matter in this scenario,
because the first command she invokes will be "git checkout".

If you populated $GIT_DIR/index from the tree of HEAD, you would see
everything is deleted in the working tree.  You can simulate it by
doing this:

	git clone -n $over_there here
        cd here
	git read-tree HEAD
	git status

But it would not help people who want to check another branch out
immediately after cloning with -n, which is the whole point of the
option, so...
