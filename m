From: Junio C Hamano <gitster@pobox.com>
Subject: Re: tracking submodules out of main directory.
Date: Mon, 27 Jun 2011 09:51:06 -0700
Message-ID: <7vvcvrxlol.fsf@alter.siamese.dyndns.org>
References: <1309180056.2497.220.camel@Naugrim.eriador.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: henri GEIST <henri.geist@flying-robots.com>
X-From: git-owner@vger.kernel.org Mon Jun 27 18:51:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbF1r-0002aj-5f
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 18:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752938Ab1F0QvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jun 2011 12:51:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64884 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959Ab1F0QvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 12:51:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 47A025C84;
	Mon, 27 Jun 2011 12:53:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WzpvQqNHw48SRHVqVtytZzE3n/c=; b=MwZCNU
	YR/EVdKljGfbkcEBdmveEbWM4SYj/jbQiGccSW9i3Lt6l8RdEXRU64ngXsf73rBb
	wvm1FDvhcSvJwUulyd+hNmPQt2i4krrHSkORhaLkRvAgEGKERkp9d4e1sJTx5sPH
	3ZzeTZHqyGaDcuqadEMqAwAK7R1y5SNoFxiyA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZiStwM7yS/H22W1q/oVM0272LZROSe5q
	xz/XxJRSc5tfDSpFHI62WJpzxRaX6R8y+8X+7smKdQ7SmRjAqKOG07VbsIKv+SjJ
	DIXacFZnsiBUkJT5xOBKF4DEgJ5+XHsglST4DYXKZHID4DhFgX7If4XuzHymsvKk
	TK/2yYddw54=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3E7405C83;
	Mon, 27 Jun 2011 12:53:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8293B5C81; Mon, 27 Jun 2011
 12:53:19 -0400 (EDT)
In-Reply-To: <1309180056.2497.220.camel@Naugrim.eriador.com> (henri GEIST's
 message of "Mon, 27 Jun 2011 15:07:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F5EF4128-A0DD-11E0-8140-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176353>

henri GEIST <henri.geist@flying-robots.com> writes:

> We can obviously solve this by doing trees of submodules just reflecting
> the trees of dependency but it create somme problems.
>
>   1. In project 4 I have 2 times project 1 and 3 times libraries 1 and 2
>      And 2 times library 4.
>   2. It is a wast of space.
>   3. Different version of the same libraries or projects could be used.
>   4. when linking object, multiples objects will export the same symbols

All of the above are something your build procedure needs to solve
regardless, even if you are not using git submodules (or even if you are
not using any SCM, for that matter).  If you want to (and you do want to)
avoid duplication, version drift and associated issues of use of the
common library 1 across project 1 and project 2, you would organize your
source tree so that both of your (sub)projects to use the library code
from a common location.

One possible working tree organization may look like this:

	-+- lib1
         +- project1/Makefile -- refers to ../lib1
         +- project2/Makefile -- refers to ../lib1

The top-level superproject (what you called "Anything") binds project1,
project2 and lib1 as its submodules, and it can say where you want your
users to fetch these submodules in its .gitmodules, and at what version
lib1 (and projects) to use in its tree objects as gitlinks.

People who are _only_ interested in project1 can still clone that
top-level superproject, and "submodule init" only lib1 and project1,
without running "submodule init" on project2.

An interesting point your situation raises is that there is no direct way
to express module dependencies in .gitmodules file right now, I think.
Ideally you would want "submodule init project1" to infer automatically
that project1 needs lib1 and run "submodule init lib1" for you. My gut
feeling is that it belongs to .gitmodules of the superproject.
