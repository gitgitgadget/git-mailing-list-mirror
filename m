From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] string_list API: document what "sorted" means.
Date: Tue, 18 Sep 2012 01:19:47 -0700
Message-ID: <7vmx0noi8s.fsf@alter.siamese.dyndns.org>
References: <1347895267-5054-1-git-send-email-mhagger@alum.mit.edu>
 <7vy5k8s622.fsf@alter.siamese.dyndns.org> <505829AB.8000506@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 18 10:20:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDt2K-0006JA-5f
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 10:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753662Ab2IRITx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 04:19:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59735 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751177Ab2IRITu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 04:19:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 390C960F5;
	Tue, 18 Sep 2012 04:19:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yT0K2EFUJZGGgVc+n3lNK0gdbjc=; b=tFmDN4
	Ud+TOtYV1wRbt66i171l9V3/0tsqU3BsS2aLjIQLvSP00uEy11ZdDiQHm3jOK3Ci
	EZm18bHclhaIFVIkkyW/TVf4MNuoW+XxR0XfoqMlGWjg3WrD2ZNTtlvEAvjOHorM
	fMzNtfJ00IpGYtgn0jRPSbzFkharEpRCKZ4GQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tCktLe1/sWWyRoXxiA58b27b+Du5sGL9
	0+y+py990i1F4AZsgdhOftno3abZVarQXqqpcUk01bFWfJQ/SLPJSVF1boJ4iZ2G
	gKqMP2k/hXXee1Vp93Z6Fs1QvWetQxgd1kywRQEW6gv1137/7yr0J9wbXSC2htfU
	ed4+vd6c12M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26BB560F4;
	Tue, 18 Sep 2012 04:19:50 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 811ED60F3; Tue, 18 Sep 2012
 04:19:49 -0400 (EDT)
In-Reply-To: <505829AB.8000506@alum.mit.edu> (Michael Haggerty's message of
 "Tue, 18 Sep 2012 09:58:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9D371E96-0169-11E2-AC17-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205812>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> 1. Document that string_list sorts entries according to their strcmp()
> order, as proposed in this patch.  Then fetch can rely on this ordering.
>  If somebody wants a different ordering in the future, it is easy to
> make the sort order a parameter.
>
> 2. Leave string_list's "default" sort order unspecified, but already
> implement a way to let string_list users specify a particular sort
> order.  Change the fetch machinery to specify a strcmp()-based ordering
> explicitly.  This approach has the advantage of letting the default sort
> order of string_list to be changed, though I don't really see how this
> would be helpful.
>
> 3. Change fetch back to doing its own sorting again, rather than relying
> on sort_string_list().  This isn't a lot of work (inline the one line of
> sort_string_list(), then either make string-list.c:cmp_items() public or
> duplicate that function too).

I haven't looked at non-users of string-list API, but my gut feeling
has been that lack of 2. made the API less useful for current
non-users, possible callers that could benefit from something like
string-list that lets them specify their own sort order.

Also, I actually am more worried about us wanting to change the
order in which ref-list is sorted, rather than somebody randomly
deciding to change the default (and only) order string-list is
sorted on.  When that happens, we would have even less useful
string-list left behind, with a documented invariant that is not
helping anybody if we choose to do 1 now.

So to me, if we really wanted to avoid doing 2 prematurely (which is
a sensible concern, by the way), the more sensible option between 1
and 3 would be 3.  That makes my preference 2, 3 and then 1 (but I
do not care too deeply between 2 and 3).
