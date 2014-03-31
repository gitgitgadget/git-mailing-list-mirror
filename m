From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git am oddity
Date: Mon, 31 Mar 2014 15:15:22 -0700
Message-ID: <xmqqbnwm2ex1.fsf@gitster.dls.corp.google.com>
References: <CAGdFq_gZoiE_ah0VT5ZfQwg-zHNj6Q-RSB80f=BTf=U6+9L5UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Mario Ferraro <fadinlight@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 00:15:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUkUX-0006L8-3k
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 00:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbaCaWPb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 18:15:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58229 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751289AbaCaWPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 18:15:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 044F979577;
	Mon, 31 Mar 2014 18:15:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jWoSVtYIDPMBUx1sOnDdz3OKY7E=; b=QR4yHe
	86ieAohpX/RDBy0eDSFqS+jz5Tye6bs2zaBgx/1C9AP7tH6Huep/x00/Tf2dp/At
	X8YS8yNuKmco4V0cv2T76qFHzrdDEN/aFOILbHmRCduGvDCx0Oo1CfbwZyDsouN9
	/n12R5NZPg6bZslV4RWWHuSvClZMSNFGolCu0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NakyxpV2Ag7xvryX60Z+PWI4FFL09eHd
	JvYNhQyHpdJowgXwWJRoqk18WRqkTJYNqJ0KFGtB+T9AuwXgi8JcK9SDDLOQay8o
	+lyZK8wz5J6qHX4wNUt9TOUHJ3uDAJZZ6sobvlokNwEdt1ocVgSgJ7nnexEaYvHZ
	q87wJ7KL/os=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E274C79575;
	Mon, 31 Mar 2014 18:15:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3BF6A7956F;
	Mon, 31 Mar 2014 18:15:24 -0400 (EDT)
In-Reply-To: <CAGdFq_gZoiE_ah0VT5ZfQwg-zHNj6Q-RSB80f=BTf=U6+9L5UA@mail.gmail.com>
	(Sverre Rabbelier's message of "Mon, 31 Mar 2014 14:58:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F4C0215A-B921-11E3-9172-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245556>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Hi,
>
> I noticed something very odd with git am, and have been able to narrow
> it down to a minimal example.
>
>  git init tmp
>  cd tmp
>  mkdir -p foo/bar/baz
>  cd foo/bar/baz
>  echo file > file
>  git add file
>  git commit -m "1"
>  echo other > other
>  echo more >> file
>  git add file other
>  git commit -m "my test"
>  git format-patch HEAD~..
>  git reset --hard HEAD~
>  # apply the patch in the current directory, chop off the leading directories
>  git am -3 -p 3 0001-my-test.patch
>  cd ../../..
>  git ls-files
>
> Expected output:
> foo/bar/baz/file
> foo/bar/baz/other
>
> Actual output:
> baz/other # the file addition was applied to the root of the
> repository, instead of the current directory
> foo/bar/baz/file # the file modification was correctly applied, yay
>
> Is this expected behavior?

As you are doing -3 (not the -p3), it would have:

 * noticed that the patch is trying to update "baz/file";

 * noticed that there is no "baz/file" but it could salvage the
   patch by doing a three-way merge, in case that the patch was
   prepared against a tree that moved path "foo/bar/baz" to "baz";
   and

 * such a three-way merge succeeds cleanly for a path whose movement
   was detected correctly.

So it does not look odd at all to me (the use of "-p 3" does look
odd, but I know this is an effort to come up with a minimum example,
so it is understandable that it may look contribed ;-).
