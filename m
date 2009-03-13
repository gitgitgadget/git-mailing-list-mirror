From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] strbuf: add "include_delim" parameter to
 "strbuf_split"
Date: Thu, 12 Mar 2009 23:53:10 -0700
Message-ID: <7vfxhhj4mh.fsf@gitster.siamese.dyndns.org>
References: <20090312085103.e83b34a5.chriscool@tuxfamily.org>
 <200903130548.30370.chriscool@tuxfamily.org>
 <7v1vt2j91x.fsf@gitster.siamese.dyndns.org>
 <200903130702.01039.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Mar 13 07:55:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li1IG-0007s4-Ii
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 07:54:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbZCMGx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 02:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbZCMGx0
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 02:53:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46311 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbZCMGxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 02:53:25 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4A7089D178;
	Fri, 13 Mar 2009 02:53:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C47BE9D165; Fri,
 13 Mar 2009 02:53:12 -0400 (EDT)
In-Reply-To: <200903130702.01039.chriscool@tuxfamily.org> (Christian Couder's
 message of "Fri, 13 Mar 2009 07:02:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A48CC54C-0F9B-11DE-90C4-CFA5EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113147>

Christian Couder <chriscool@tuxfamily.org> writes:

> Aren't gets and fgets an example that having the choice to strip out the 
> delimiter or not is good?

I consider it is an example that an earlier simplistic API (gets()) later
gets corrected when it is redone right (fgets()) with other changes like a
proper bounds check.

>> A more general 
>> solution should be by default not to strip it, and I do not think your
>> new caller, if it were written correctly, needs stripping behaviour
>> either. That means there is no need for the "optionally strip" flag to
>> the function in order to support the rest of the series [*2*].

I also do not agree that you have to keep list of skip both in shell and
rev-list when you go the route I suggested.  I think a separate bisect.c
you did is a good first step to make not just the bisect machinery but the
whole bisect command into a built-in, and even if we do not do the full
rewrite in C in one go, moving these "shell script reads from refs/bisect
only to feed the result to rev-list --bisect" pattern to "shell script
updates refs/bisect and let rev-list --bisect read from there" pattern
would be a good initial step.  Oh, and I did not mean it only for "skip",
but also doing this for "good" and "bad" as well.

For example, you read "refs/bisect/skip-*" and keep that in $skip to:

 - feed it to filter_skipped() which you are making built-in with this
   series;

 - feed it to check_good_are_ancestors_of_bad that in turn calls
   check_merge_bases;

and its use is contained in bisect_next() alone.  After this series is
done, we can move the logic in check_good_are... to bisect.c and you do
not have to read refs/bisect/skip-* in the shell anymore.  IOW, we can
migrate away from the "shell reads from refs/bisect/ and feeds that to
rev-list --bisect" pattern incrementally.
