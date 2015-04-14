From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v2 4/4] t4059: rewrite to be adaptive to hunk filtering
Date: Tue, 14 Apr 2015 07:18:49 +0300
Message-ID: <20150414041849.GB786@wheezy.local>
References: <1428006853-21212-1-git-send-email-max@max630.net>
 <1428076716-4449-1-git-send-email-max@max630.net>
 <1428076716-4449-5-git-send-email-max@max630.net>
 <xmqq61916gnt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Kirillov <max@max630.net>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 06:18:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YhsJB-0007KI-Gk
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 06:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbbDNESk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 00:18:40 -0400
Received: from p3plsmtpa12-05.prod.phx3.secureserver.net ([68.178.252.234]:52969
	"EHLO p3plsmtpa12-05.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750931AbbDNESj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Apr 2015 00:18:39 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa12-05.prod.phx3.secureserver.net with 
	id FgJZ1q0095B68XE01gJcMH; Mon, 13 Apr 2015 21:18:38 -0700
Content-Disposition: inline
In-Reply-To: <xmqq61916gnt.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267114>

On Sat, Apr 11, 2015 at 10:48:22PM -0700, Junio C Hamano wrote:
> Max Kirillov <max@max630.net> writes:
>> Rather, it should verify that file
>> selection behaves the same as hunk selection.
> 
> Hrm, really?  "git diff --raw" and "git diff -p -w" on two trees
> would not show identical set of paths, when the blob object are
> different byte-wise but are equivalent at the content level per
> given definition of equivalence (e.g. "-w").  Given that --cc is
> to look at the differences at hunk/content level to combine and omit
> uninteresting ones from the output, relative to -c output, I would
> imagine that the file selection and the hunk selection are expected
> to behave differently.

I mean, that if a hunk is shown in some long file, which
have other changes, with some option (-c or --cc), it should
also be shown if it is the only change in file.

> So, having said that I am a bit skeptical about the description of
> the goals, there are a few nits on the implementation, too.
> 
> > +# the difference in short file must be returned if and only if it is shown in long file
> > +for fn in win1 win2 merge delete base only1 only2 only1discard only2discard; do
> > +	if git diff --cc merge branch1 branch2 mergebase -- long/$fn | grep -q '^[ +-]\{3\}2\(change[12]|merge\)\?$'
> > +	then
> 
> Just like the earlier parts of this patch, write a newline when you
> do not have to write a semicolon, and split lines after pipe when
> your pipeline gets long, i.e.
> 
> 	for fn in win2 win2 ...
>         do
> 		if git diff --cc ... |
> 			grep 'pattern'
> 		then
> 
> Do I smell some GNUism in your "grep" patterns?
> 
> You have
> 
>     '^[ +-]\{3\}2\(change[12]|merge\)\?$'
> 
> but matching zero-or-one repetition with ? is not in BRE, and \? to
> use it in BRE is a GNU extension.
> 
> Also in BRE , '|' is not an alternation (and making it into such
> with '\|' in BRE is a GNU extension IIRC.
> 
> Worse, you are not using backslash here to invoke GNU extension, so
> I suspect the grep invocations in the patch may not be working as
> you expect.

Thank you, I missed it. I suspect it was working because
single "2" still matching. Will fix it and other issues.

-- 
Max
