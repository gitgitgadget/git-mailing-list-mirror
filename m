From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: be cleverer with rebased upstream branches
Date: Sun, 13 Mar 2011 15:57:30 -0700
Message-ID: <7vd3luhbmt.fsf@alter.siamese.dyndns.org>
References: <1297691481-3308-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <7vzkpxm45e.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.1102152040370.14950@debian>
 <AANLkTinmxbYLB-K+VzY50NtOAPwd-q3WwAosAHqKRq_0@mail.gmail.com>
 <alpine.DEB.2.00.1102161122350.14950@debian>
 <AANLkTik-JGZFCE+m7g__mwfQhRReOM=Qe_EO3otw50XC@mail.gmail.com>
 <alpine.DEB.2.00.1103120930250.15442@debian>
 <AANLkTikrYbY6r5hYnhWCB1GVKbPgounxdvAGeejsUKoC@mail.gmail.com>
 <alpine.DEB.2.00.1103122005490.15442@debian>
 <alpine.DEB.2.00.1103122159300.15442@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 13 23:57:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PyuER-0003Ti-9W
	for gcvg-git-2@lo.gmane.org; Sun, 13 Mar 2011 23:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755508Ab1CMW5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Mar 2011 18:57:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35483 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579Ab1CMW5p (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Mar 2011 18:57:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5FC84481B;
	Sun, 13 Mar 2011 18:59:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DSE3w2cvQBmOVxQqjyEEbG/vrS8=; b=tzt4Av
	/0eZEUrCNdMYI8d3UEE2gbwdOhSP1nNYnFNSB1CK7bi/AWCMYEF1cq+lwc1R7eXl
	EA7q3gxxAx3OGVCuaG5AkMhNNNeAQtAytDifFqnlgoTH0R3B5dn9NKjxdubYMTrW
	5OPZQT52RFp3mLh22Dyh1XatGkgVIGL+CynoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VD9rjLCJayjbwkt+7B824EfPqNKFpy/1
	Tl9S3tUSgM21/llCRFO349O7rcOYAdvkMKbr1R54+xhNFqoyRxRF+zZ0i0mka+XQ
	SACHiK+p/iBoAXdcxSHOMfIRbgWSL/MLmnJXHKl5N6DL1sodWLHT+QfnZR63JXHQ
	iR7VF/xA+QY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1E1B84817;
	Sun, 13 Mar 2011 18:59:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 722494814; Sun, 13 Mar 2011
 18:59:05 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.1103122159300.15442@debian> (Martin von
 Zweigbergk's message of "Sat, 12 Mar 2011 22:14:04 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8242085C-4DC5-11E0-B3CA-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168980>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> So here are the updated figures for the force-updated history
> (pu-like):
>
>                  u@{10}     u@{100}    u@{1000}
> manual         0m0.535s    0m1.164s    0m1.415s
> linear         0m1.245s   0m37.367s   5m10.068s
> merge-base    0m14.490s   0m15.409s   0m15.508s
> exp(1,2)       0m1.056s    0m6.175s   0m27.221s
> exp(10,10)     0m1.950s   0m20.031s   0m18.215s
> exp(7,7)       0m1.310s    0m6.851s   0m16.757s
>
> and for the non-force-updated history (master-like):
>
>                  u@{10}     u@{100}    u@{1000}
> manual         0m0.885s    0m6.126s   0m52.248s
> linear         0m1.349s   0m39.688s   5m28.753s
> merge-base     0m1.160s    0m1.699s    0m1.901s
> exp(1,2)       0m0.769s    0m4.342s    0m7.360s
> exp(10,10)     0m0.700s    0m2.535s    0m3.110s
> exp(7,7)       0m0.653s    0m2.332s    0m3.506s

I have a suspicion that merge-base shouldn't be taken as "one of the
candidates among others".

It is merely a technique to check multiple heads simultaneously and
cheaply, instead of checking things one by one, and should be applicable
regardless of these "multiple heads" come from.  It may come from a linear
walk of reflog, or it may come from a leaky exponential or fibonacci walk.

Instead of "linear" that checks "Is the tip good?  Is the tip@{1} good?
Is the tip@{2} good? How about tip@{3}?" repeatedly, we can check "is the
tip through tip@{N} good?" with a single invocation using the merge-base
technique.

Similarly if your exp(i,j) checks "Is the tip good? tip@{1}? tip@{2}?
tip@{4}?  tip@{8}? ..."  iteratively, you can grab these commit object
names out of reflog and still use the merge-base optimization, effectively
making "one at a time" check into "N at a time" check (perhaps checking a
dozen or two at a time).

If you generate list of reglog entries way beyond what matters to the end
result, and feed all of them to the machinery, it is not surprising that
it would spend more time than linear that can stop early upon the first
success.

We should optimize for common case by picking the default that performs
well for history that is never rewound.  If the the default algorithm on
pathological histories performs badly, it is Ok to have an alternative
heuristics that is only triggered on such a history, but if we are going
to do so, we need to make sure that we can cheaply detect if we need to
use the alternative heuristics in the first place.

Is it easy to tell in an earlier phase if the history is "force-updated"
or not?
