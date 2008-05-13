From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH v2] revision.c: really honor --first-parent
Date: Tue, 13 May 2008 22:43:52 +0200
Message-ID: <8c5c35580805131343kc115df6yd7ce3281fb3e6171@mail.gmail.com>
References: <1210547651-32510-1-git-send-email-hjemli@gmail.com>
	 <1210605156-22926-1-git-send-email-hjemli@gmail.com>
	 <20080513201522.GA11485@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, nanako3@bluebottle.com,
	git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Tue May 13 22:45:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw1Mu-0003ii-CE
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 22:45:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbYEMUoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 16:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbYEMUoN
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 16:44:13 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:15188 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932290AbYEMUoL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 16:44:11 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1689201ywe.1
        for <git@vger.kernel.org>; Tue, 13 May 2008 13:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=cKT1aMsK7z5v80FmiqJWQoxe1RmBLszb/qisC34cLOM=;
        b=G5Lx1CyJfpqO7nCEoRAhsZzj6JRCiiLQme1hMZDZhqLek07lnrEbnM74Y0tL7QSo/iVD/6IU1ISj3pqP75N4ZJFTZG94UrLW/kS2vlh1KqEwI3OjZKlotsSmMsRwJnHLHtkIZvYRaH8q8UwOhcxyeqmV/ibawMJKwvLwZ80SUB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I5J4CRVLgiAiGkPJDfMkOCpx0oPPDRUaX3yX6/LXnjolK0FScKABJxYj/OD+8Z/AgTrOxHSB8CovdQLHIfAt2/JEKZ7MSeVXSJwQFbJ22aEUcAasySPrE88KrC52Qhe8LMq/h7WRmJmn4vrqWOTocdRMyijP7jExGTVhmpBNcoE=
Received: by 10.150.83.41 with SMTP id g41mr286904ybb.196.1210711432952;
        Tue, 13 May 2008 13:43:52 -0700 (PDT)
Received: by 10.151.39.3 with HTTP; Tue, 13 May 2008 13:43:52 -0700 (PDT)
In-Reply-To: <20080513201522.GA11485@cuci.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82042>

On Tue, May 13, 2008 at 10:15 PM, Stephen R. van den Berg <srb@cuci.nl> wrote:
> Lars Hjemli wrote:
>  >In add_parents_to_list, if any parent of a revision had already been
>  >SEEN, the current code would continue with the next parent, skipping
>  >the test for --first-parent. This patch inverts the test for SEEN so
>  >that the test for --first-parent is always performed.
>
>  Let's put it this way:
>  - If there would have been only one path to any particular point in the
>   tree, then the --first-parent flag makes no differences, because the
>   tree wouldn't contain any merges to begin with.

True

>  - If a tree contains *any* merges (i.e. a commit with multiple parents),
>   then there are always multiple paths to some common ancestor, and
>   therefore depending on which path you travel up first, you sometimes get
>   clashes with the SEEN flag (unpredictable by definition).

True

>  - It would seem logical and sufficient to avoid this unpredictability by
>   utilising the --first-parent flag to present and walk a tree of commits
>   AS IF there were no merges.

True

>  - My original patch did just that, it simplified the code to make sure
>   that all other parents beside the first parent are ignored when
>   walking the tree.

Except for the case where the first parent had been already SEEN; then
it would continue to test the next parents until one was found which
was not already SEEN and _that_ parent would be treated as if it was
first. And as Nanako showed, a simple `git rev-list HEAD^..HEAD` marks
both HEAD and HEAD^ as seen. When combined with --first-parent, the
result (with your patch) is that HEAD^2 is treated as the first
parent. With my patch on top of yours, the walk stops as HEAD^, which
is what we probably both want.

>  - Your code now doesn't simplify the (IMO) convoluted walk, and still
>   marks things as seen, even though in the first-parent case, these
>   commits are not really seen at all.  It implies that your code
>   generates differing output, depending on the merges present.

I don't think so. My code should neither follow nor mark as SEEN any
parent but the first (but I could obviously be wrong).


>  - The question now is, do we want the output of --first-parent to be
>   immutable with respect to merges being present (but hidden from sight
>   during a --first-parent run), or do we want the output of
>   --first-parent to actually change depending on variations in parents
>   other than the first parent?
>
>  I'd say it's better to keep the code simpler, and to make sure the
>  output does *not* depend on any parents other than the first (as
>  implemented in my original patch).

I agree with your reasoning, and your patch with mine on top seems to
achieve that goal.

--
larsh
