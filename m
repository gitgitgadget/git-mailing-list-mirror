From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] toposort: rename "lifo" field
Date: Fri, 7 Jun 2013 01:09:26 -0400
Message-ID: <CAPig+cTJT2S1KuQgrBuJuSBukNqWjnCV5WC+zJoZxTugHBCZfQ@mail.gmail.com>
References: <1370369299-20744-1-git-send-email-me@ell.io>
	<1370369299-20744-2-git-send-email-me@ell.io>
	<7vip1t7koi.fsf@alter.siamese.dyndns.org>
	<7vobbl60aj.fsf@alter.siamese.dyndns.org>
	<CAPZ477OFM6D4n_Wz-OozN=aYn5-LmNA2ggL+9GNrbGrRQh9pRQ@mail.gmail.com>
	<7vobbjxc21.fsf@alter.siamese.dyndns.org>
	<7vvc5qx3cm.fsf@alter.siamese.dyndns.org>
	<7vppvyx1mv.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Elliott Cable <me@ell.io>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 07:09:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukovk-0007Nn-Kt
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 07:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789Ab3FGFJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 01:09:29 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:44554 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750771Ab3FGFJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 01:09:29 -0400
Received: by mail-lb0-f176.google.com with SMTP id z5so3802654lbh.21
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 22:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=aFQTrjsVDYhtZadPF8HLDXPLe1/jWr1qNpIiYARv9gA=;
        b=jjt8RKR7LUsF/vt5uSY9hScYKjYL2e6VzitP6ezzUmjg+FvkPiliRqq0lAw6vceW1d
         Vj2yzn0t8dbOQ5S5G/0jRC55EQHg9nr89gyQaZbN/Bf/Ov6ctVVm3gHh7bSWEwIOYK6z
         YgmEiyzCwCZTrXRedK/Qmh+QNxQ54VhAp05neHHSG1Cfuk2B17gRhlm54/IJ2u/gHBU4
         2WUyzya0nTkA6S1XVGmUfDrGiMrp23jUMp2FGiwdPf0fVSXFTCeFdc5nZr979e9WknmA
         1gQhT+BoyUz2vBVKB5YEO6V0+0nDva6LoDjntFQFaK3qwCctPL4CJPRZdNwrvZiymDMI
         u+jw==
X-Received: by 10.152.19.65 with SMTP id c1mr19433514lae.24.1370581766435;
 Thu, 06 Jun 2013 22:09:26 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Thu, 6 Jun 2013 22:09:26 -0700 (PDT)
In-Reply-To: <7vppvyx1mv.fsf_-_@alter.siamese.dyndns.org>
X-Google-Sender-Auth: qpF6sunRqxRIatToelYvqMGylgE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226591>

On Thu, Jun 6, 2013 at 7:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> When sorting commits topologically, the primary invariant is to emit
> all children before its parent is emitted.  When traversing a forked
> history like this with "git log C E":
>
>     A----B----C
>      \
>       D----E
>
> we ensure that A is emitted after all of B, C, D, and E are done, B
> has to wait until C is done, and D has to wait until E is done.
>
> In some applications, however, we would further want to control how
> these child commits B, C, D and E on two parallel ancestry chains
> are shown.  Most of the time, we would want to see C and B emitted
> together, and then E and D, and finally A.  This is the default
> behaviour for --topo-order output.
>
> The "lifo" parameter of the sort_in_topological_order() function is
> used to control this.  After inspecting C, we notice and record that
> B needs to be inspected, and by structuring the "work to be done"
> set as a LIFO stack, we ensure that B is inspected next, before
> other in-flight commits we had known that we will need to inspect,
> e.g. E, that have already been in the "work to be done" set.
>
> When showing in --date-order, we would want to see commits ordered
> by timestamps, i.e. show C, E, B and D in this order before showing
> A, mixing commits from two parallel histories together.  When "lifo"
> is set to false, the function keeps the "work to be done" set sorted
> in the date order to realize this sematics.

s/sematics/semantics/ (or perhaps s/.../semantic/ ?)

> But the name "lifo" is too tied to the way how the function implements
> its behaviour, and does not describe _what_ is the desired semantcs.

s/semantcs/semantics/

> Replace the "lifo" field with an enum rev_sort_order, with two
> possible values: REV_SORT_IN_GRAPH_ORDER and REV_SORT_BY_COMMIT_DATE.
>
> The mechanical replacement rule is:
>
>   "lifo == 0" is equivalent to "sort_order == REV_SORT_BY_COMMIT_DATE"
>   "lifo == 1" is equivalent to "sort_order == REV_SORT_IN_GRAPH_ORDER"
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
