From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] do not read beyond end of malloc'd buffer
Date: Sat, 21 May 2011 11:42:40 +0200
Message-ID: <87ei3s75kf.fsf@rho.meyering.net>
References: <877h9lb86r.fsf@rho.meyering.net>
	<7vfwo92p19.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 21 11:42:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNihy-0003Fx-So
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 11:42:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448Ab1EUJmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 May 2011 05:42:50 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:38080 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753183Ab1EUJms (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 05:42:48 -0400
Received: from mx.meyering.net (unknown [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 1163D940119
	for <git@vger.kernel.org>; Sat, 21 May 2011 11:42:41 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 6A492600C7; Sat, 21 May 2011 11:42:40 +0200 (CEST)
In-Reply-To: <7vfwo92p19.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 20 May 2011 11:41:06 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174115>

Junio C Hamano wrote:
> Jim Meyering <jim@meyering.net> writes:
>> I was surprised to see "git diff --word-diff" output a ton of
>> garbage, and tracked it down to a bug that's triggered when the
>> diff.suppress-blank-empty config option to true and when at least
>> one of the context lines is empty.
>
> Heh, I am not that surprised ;-)
>
> I think the real culprit is a year-old 882749a (diff: add --word-diff
> option that generalizes --color-words, 2010-04-14); it probably shows that
> not many people use diff.s-b-e settings?

That must be the issue: too few people know to use diff.s-b-e.
If a few more of us were to set that option by running this command:

    git config --global diff.suppress-blank-empty true

(to suppress emission of trailing blanks on empty context lines)
then bugs like this would be exposed more quickly.

...
> It is a bit unfortunate that we cannot make this into a test script, as it
> depends on what is on the uninitialized part of the heap, which might
> happen to be a NUL in which case the test would pass.
>
> Running tests under the valgrind mode may catch issues, though.

Right, since reading the trailing NUL byte after the
end of the buffer would be detected.

> Thanks. Will queue with this test squashed in.

Thanks for adding the test!
