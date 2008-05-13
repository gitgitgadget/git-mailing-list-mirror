From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] revision.c: really honor --first-parent
Date: Tue, 13 May 2008 15:38:37 -0700
Message-ID: <7vej85suc2.fsf@gitster.siamese.dyndns.org>
References: <1210547651-32510-1-git-send-email-hjemli@gmail.com>
 <1210605156-22926-1-git-send-email-hjemli@gmail.com>
 <20080513201522.GA11485@cuci.nl>
 <8c5c35580805131343kc115df6yd7ce3281fb3e6171@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Stephen R. van den Berg" <srb@cuci.nl>, nanako3@bluebottle.com,
	git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 00:39:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw39s-00042j-M0
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 00:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757326AbYEMWiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 18:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757250AbYEMWit
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 18:38:49 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61987 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756142AbYEMWis (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 18:38:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A52DA431D;
	Tue, 13 May 2008 18:38:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D6CA94317; Tue, 13 May 2008 18:38:40 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5957EEF0-213D-11DD-A835-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82051>

"Lars Hjemli" <hjemli@gmail.com> writes:

>>  - My original patch did just that, it simplified the code to make sure
>>   that all other parents beside the first parent are ignored when
>>   walking the tree.
>
> Except for the case where the first parent had been already SEEN; then
> it would continue to test the next parents until one was found which
> was not already SEEN and _that_ parent would be treated as if it was
> first. And as Nanako showed, a simple `git rev-list HEAD^..HEAD` marks
> both HEAD and HEAD^ as seen. When combined with --first-parent, the
> result (with your patch) is that HEAD^2 is treated as the first
> parent. With my patch on top of yours, the walk stops as HEAD^, which
> is what we probably both want.
>
>>  - Your code now doesn't simplify the (IMO) convoluted walk, and still
>>   marks things as seen, even though in the first-parent case, these
>>   commits are not really seen at all.  It implies that your code
>>   generates differing output, depending on the merges present.
>
> I don't think so. My code should neither follow nor mark as SEEN any
> parent but the first (but I could obviously be wrong).

A major part of the "convoluted walk" is the (il-)logic that skipped
earlier SEEN parents and treated the first unseen one as if it was the
first parent, which is not exactly Stephen's fault.  It was placed by
yours truly in the very original code but it was done without much
thought.

I think your patch is the correct fix for that convolution, regardless of
the traversal order stability issue Stephen mentions.
