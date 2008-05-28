From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: only display "next" links in logs if there is a
 next page
Date: Tue, 27 May 2008 17:04:20 -0700
Message-ID: <7v1w3nz43f.fsf@gitster.siamese.dyndns.org>
References: <483C97E7.2020504@gmail.com>
 <1211930742-24978-1-git-send-email-LeWiemann@gmail.com>
 <483C99A2.90909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 02:05:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K19As-0000vD-Cl
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 02:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758696AbYE1AEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 20:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757963AbYE1AEj
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 20:04:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58934 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756533AbYE1AEi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 20:04:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 34CF0519F;
	Tue, 27 May 2008 20:04:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5E8E4519E; Tue, 27 May 2008 20:04:30 -0400 (EDT)
In-Reply-To: <483C99A2.90909@gmail.com> (Lea Wiemann's message of "Wed, 28
 May 2008 01:30:42 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A7E548E4-2C49-11DD-9DA8-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83065>

Lea Wiemann <lewiemann@gmail.com> writes:

> Lea Wiemann wrote:
>> There was a bug in the implementation of the "next" links in
>> format_paging_nav (for log and shortlog), which caused the next links
>> to always be displayed, even if there is no next page.  This fixes it.
>
> Oh, one more thing I forgot to mention: I've tested this with a small
> (single-page) log page and a long log page.  In both cases the "next"
> links get formatted correctly, and they stop linking to the next page
> on the correct (= last) page.  The only thing I haven't tested for is
> off-by-one errors, but I'm reasonably sure that $#commitlist >= 100 is
> right.

I do not trust people who rely on "tests" to catch counting errors
(although I am pretty bad at counting myself and often testsuite helps me
catch my own bugs).  Instead, let's follow the code to see if it is Ok.

You call format_paging_nav() from two places, both after calling
parse_commits() with $maxcount = 101.  So @commitlist could have 101
elements (in which case you would need to have next page because you will
show only 100 among them), or smaller than that (in which case you will
fully show them).  In other words, you would want to say 'next' iff

	(@commitlist > 100)

is true.  On the other hand, $#commitlist is the last index of @commitlist
array, which is one smaller than the number of elements in that array.
IOW, when it has 101 elements, it has $commitlist[0] thru $commitlist[100]
and $#commitlist == 100.  So the above condition is the same as

	($#commitlist >= 100)

So your counting looks correct to me.

I wonder if it is easier to read to use the more modern @array notation
than historic $#array notation (it looks very Perl 4 to me), but that is a
separate issue.  gitweb is littered with such anachronism ;-)
