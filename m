From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] toposort: rename "lifo" field
Date: Fri, 7 Jun 2013 01:18:12 -0400
Message-ID: <CAPig+cQnQv-Df52dptTDYfNFSzEUv_Db4rrddB2jQv9NhfLhbw@mail.gmail.com>
References: <7vfvwuww39.fsf@alter.siamese.dyndns.org>
	<1370581872-31580-1-git-send-email-gitster@pobox.com>
	<1370581872-31580-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Elliott Cable <me@ell.io>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 07:18:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukp48-0005Mm-2S
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 07:18:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284Ab3FGFSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 01:18:16 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:34447 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898Ab3FGFSP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 01:18:15 -0400
Received: by mail-lb0-f176.google.com with SMTP id z5so3807513lbh.21
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 22:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=6CQWsqSknsZ+qCVbYV/EgL2mSfwRYkjtTZfx/dZLsiQ=;
        b=lMYqZVEQqDN8e0k3Gt66wJlDRNzDD7GevWrQ2+qWJLEP7WAy+Z87UkzUcI45R+Ep/A
         P2dnmwvKUr8nPq8F5wdeVrunCk7610AcDo7jsbzfJh3RYrlzaSmdLtx+xMcl4yVwX4JT
         XrhWkR6psKCHUMs2GLweECi56H/4xE7u+nsFU9jfxi4Jw5MqNaclSWDaYa/lroxHxk2i
         XRCPn734wWlBjEPNkaf0xluBNpP/btPtjK2sjSa7KWy/aNhGNmwMvujvaNFLu01KRX19
         8xOJdHCu2Qm0D+/uP2a1lyxBM9W121KFF54yVc8p735naET1Qu1tkdLfTqv+2wwE/2Cm
         oh7g==
X-Received: by 10.152.6.228 with SMTP id e4mr1692324laa.61.1370582292588; Thu,
 06 Jun 2013 22:18:12 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Thu, 6 Jun 2013 22:18:12 -0700 (PDT)
In-Reply-To: <1370581872-31580-2-git-send-email-gitster@pobox.com>
X-Google-Sender-Auth: fPkQxIu5PiBdztNbN_axDaBRvvk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226596>

On Fri, Jun 7, 2013 at 1:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
> The primary invariant of sort_in_topological_order() is to emit all
> children before their parent is emitted.  When traversing a forked

s/parent is/parents are/

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
> together, and then E and D, and finally A, which is the default
> behaviour for --topo-order output.
>
> The "lifo" parameter of the sort_in_topological_order() function is
> used to implement this behaviour.  After inspecting C, we notice and
> record that B needs to be inspected, and by structuring the "work to
> be done" set as a LIFO stack, we ensure that B is inspected next,
> before other in-flight commits we had known that we will need to
> inspect, e.g. E, that may have already been sitting in the "work to
> be done" set.
>
> When showing in --date-order, we would want to see commits ordered
> by timestamps, i.e. show C, E, B and D in this order before showing
> A, possibly mixing commits from two parallel histories together.
> When "lifo" parameter is set to false, the function keeps the "work
> to be done" set sorted in the date order to realize this semantics.
>
> But the name "lifo" is too tied to the way how the function implements
> its behaviour, and does not describe _what_ the desired semantics is.
>
> Replace the "lifo" field with an enum rev_sort_order, with two
> possible values: REV_SORT_IN_GRAPH_ORDER and REV_SORT_BY_COMMIT_DATE.
>
> The mechanical replacement rule is:
>
>   "lifo == 0" is equivalent to "sort_order == REV_SORT_BY_COMMIT_DATE"
>   "lifo == 1" is equivalent to "sort_order == REV_SORT_IN_GRAPH_ORDER"
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
