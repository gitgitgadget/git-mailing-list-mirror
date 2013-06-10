From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/4] toposort: rename "lifo" field
Date: Sun, 9 Jun 2013 22:12:47 -0400
Message-ID: <CAPig+cQg11r=87kExamD=9C5bM5DMHScY7U=g4v+y+o+skbUEw@mail.gmail.com>
References: <1370581872-31580-1-git-send-email-gitster@pobox.com>
	<1370820277-30158-1-git-send-email-gitster@pobox.com>
	<1370820277-30158-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Elliott Cable <me@ell.io>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 04:12:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlrbL-00074q-BA
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 04:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058Ab3FJCMt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 22:12:49 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:49791 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800Ab3FJCMs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 22:12:48 -0400
Received: by mail-lb0-f178.google.com with SMTP id y6so4265860lbh.23
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 19:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=c9fN9T0DKnbmGfd3ipza/cD4xT4WaWmmSQ11bT/4Z4M=;
        b=1IB07Znomd9hxTFFeJBy2R149R7ytHLd1HJ1Slgnt062nz/EFHveA4XJtgyzfJFHQV
         LTrcox5GGm3KCQpOd08G1ygwDBPogop1wydNOYee45gJEuBgqwcFowCgB6UTz71wWapB
         idwDmLJtxAVHw40OJ1l+69hTUokXv36yFFSBde2ZhgWdYyYmqq59XgnQ6o15Z2iMMjKs
         YU1Ax69q1SSIba7OjX6m/hZ+7EdeIvHy9Bjdwd9O/HrKjlJADSIexm0fqqWYzE4uXaG6
         iUR2R2A1uaKR+8Rzq6HEDNTIOspLL+RXrcotrSiV46JQgP5l2Ec3a+/s6sN3JzoXZi8b
         0aIQ==
X-Received: by 10.112.219.133 with SMTP id po5mr5374446lbc.80.1370830367060;
 Sun, 09 Jun 2013 19:12:47 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Sun, 9 Jun 2013 19:12:47 -0700 (PDT)
In-Reply-To: <1370820277-30158-2-git-send-email-gitster@pobox.com>
X-Google-Sender-Auth: oX_s_rTmU6H04PUe_3FEU-2-2Eg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227231>

On Sun, Jun 9, 2013 at 7:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> The primary invariant of sort_in_topological_order() is that a
> parent commit is not emitted untile all children of it are.  When

s/untile/until/

> traversing a forked history like this with "git log C E":
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
> are shown.
>
> Most of the time, we would want to see C and B emitted together, and
> then E and D, and finally A (i.e. the --topo-order output).  The
> "lifo" parameter of the sort_in_topological_order() function is used
> to control this behaviour.  We start the traversal by knowing two
> commits, C and E.  While keeping in mind that we also need to
> inspect E later, we pick C first to inspect, and we notice and
> record that B needs to be inspected.  By structuring the "work to be
> done" set as a LIFO stack, we ensure that B is inspected next,
> before other in-flight commits we had known that we will need to
> inspect, e.g. E.
>
> When showing in --date-order, we would want to see commits ordered
> by timestamps, i.e. show C, E, B and D in this order before showing
> A, possibly mixing commits from two parallel histories together.
> When "lifo" parameter is set to false, the function keeps the "work
> to be done" set sorted in the date order to realize this semantics.
> After inspecting C, we add B to the "work to be done" set, but the
> next commit we inspect from the set is E which is newer than B.
>
> The name "lifo", however, is too strongly tied to the way how the

s/the way//

> function implements its behaviour, and does not describe what the
> behaviour _means_.
>
> Replace this field with an enum rev_sort_order, with two possible
> values: REV_SORT_IN_GRAPH_ORDER and REV_SORT_BY_COMMIT_DATE, and
> update the existing code.  The mechanical replacement rule is:
>
>   "lifo == 0" is equivalent to "sort_order == REV_SORT_BY_COMMIT_DATE"
>   "lifo == 1" is equivalent to "sort_order == REV_SORT_IN_GRAPH_ORDER"
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
