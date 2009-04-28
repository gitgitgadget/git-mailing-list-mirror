From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Fix behavior with non-committish upstream references
Date: Tue, 28 Apr 2009 09:44:47 +0200
Message-ID: <49F6B3EF.8010503@drmicha.warpmail.net>
References: <49F03A74.5080805@emlix.com> <1240849603-26127-1-git-send-email-git@drmicha.warpmail.net> <7vab61s0aq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Simon Braunschmidt <sb@emlix.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 09:45:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyi09-0008Ml-VH
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 09:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbZD1Ho6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 03:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758724AbZD1Ho6
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 03:44:58 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:59153 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760005AbZD1Ho5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Apr 2009 03:44:57 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 18FFF3260A7;
	Tue, 28 Apr 2009 03:44:57 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 28 Apr 2009 03:44:57 -0400
X-Sasl-enc: VD/oHb6A2ZosnEjHqQ9GRa7LDWxjbW3daWfvsjz3WDZ0 1240904696
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 98A1758BFC;
	Tue, 28 Apr 2009 03:44:55 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b5pre) Gecko/20090427 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <7vab61s0aq.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117752>

Junio C Hamano venit, vidit, dixit 28.04.2009 09:30:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> stat_tracking_info() assumes that upstream references (as specified by
>> --track or set up automatically) are commits. By calling lookup_commit()
>> on them, create_objects() creates objects for them with type commit no
>> matter what their real type is; this disturbs lookup_tag() later on the
>> call sequence, leading to git status, git branch -v  and git checkout
>> erroring out.
>>
>> Fix this by using lookup_commit_reference() instead so that (annotated)
>> tags can be used as upstream references.
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>> I'm sorry I won't be able to write a test any more today. Please let me
>> whether it's okay without a test.
> 
> I am sorry, but I simply do not see much point in this.  I think you meant
> by the title "non-commit upstream ref", as a tag that eventually peels to
> a commit is a committish.  Because a tag is meant to be immutable, forking

Ooops, of course you're right. I meant "not of type commit" but
resolvable to a commit, so in fact a non-commit committish.

> from that mean your further "merges from upstream" won't do anything, so
> the current behaviour of returning without saying anything sounds like the
> right thing to do, even though I strongly suspect that it behaves this way
> by accident not by design.

The current behavior is different: git branch/checkout allow you to
specify a tag as upstream, but error out and die when that info is used
(when stat_tracking_info() is called) with a mysterious message, saying
"A is a commit, not a tag", when in fact A is a tag (see Simon's report,
or try "git branch --track tmp v1.6.3-rc3" and run "git branch -v"),
because the entry in hash_obj is messed up.

So I claim that the current behavior is buggy, both on the user visible
side as well as in the internals (setting up wrong obj). The two
possible solutions are:

- Disallow non-commit upstreams. (But people can set anything using git
config.)
- Make stat_tracking_info() work with non-commit committish upstreams.

The latter is what my patch does, without changing behavior for commit
type upstreams.

> 
> Admittedly, I do not "fork and keep up-to-date with an upstream" that
> often, so I am in no way making a final decision here.  It would be
> healthy for interested people to discuss this patch, but I'd appreciate it
> if it happens after 1.6.3 final.

There is one huge advantage when your upstream is a tag: You may be
"ahead", but you'll never be "behind" ;)

Seriously, I find this useful as a way of developing topics on top of a
certain release and seeing the info in git branch -vv, git status etc.

In any case, erroring out and claiming that a tag is not a tag is a bug
which should be fixed one way or the other (which is why I thought it's
okay during rc, being a bug fix).

Michael
