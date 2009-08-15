From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 1/2] add a --delete option to git push
Date: Fri, 14 Aug 2009 19:01:10 -0700
Message-ID: <7vprax4yzd.fsf@alter.siamese.dyndns.org>
References: <1250226349-20397-1-git-send-email-srabbelier@gmail.com>
 <1250226349-20397-2-git-send-email-srabbelier@gmail.com>
 <7vab22ubr5.fsf@alter.siamese.dyndns.org>
 <7v7hx6suiy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Git List" <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 04:01:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc8ae-0003fi-KM
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 04:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756406AbZHOCBS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 22:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756324AbZHOCBS
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 22:01:18 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45322 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755802AbZHOCBR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 22:01:17 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 556AFB3FD;
	Fri, 14 Aug 2009 22:01:16 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A377B3FC; Fri, 14 Aug
 2009 22:01:11 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 844E8C7A-893F-11DE-8F58-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125976>

Junio C Hamano <gitster@pobox.com> writes:

> One more thing.  I suspect that adding --delete and nothing else probably
> makes things worse than not doing anything.
>
> In a mental model where "push there --delete $branch" is natural, there
> are branches on the other side, and when you run 'push' command, you name
> the special operation, 'delete', that you would want to inflict on them.
>
> In such a world, there probably are other (perhaps not so special)
> operations you can inflict on the branches on the other side as well.
> They are probably called something like:
>
> 	push there --create $branch $commit
> 	push there --update $branch $commit
>
> If you give them only --delete without completing the vocabulary by giving
> these operations as well, you would force people to mix "git native" world
> model (i.e. there is no "mode" nor "opration"; there is only "list of
> instructions, each of which encodes the equivalent of 'mode'") with this
> Hg-inspired world model.

One final note on this topic.  A more problematic is --rename.

In the "there are branches on the other side, and a push command can be
told to operate on them in different ways" world model, you naturally
would want to:

	push there --delete $branch
        push there --rename $old $new
        push there --copy $old $new

The first one you can implement as a syntax sugar by turning it into the
native way of pushing ":$branch".  You however cannot shoehorn rename and
copy, because the way in which git push works does not have direct access
to their "original" values of remote branches.  If we do not have the
current object $old points at, you cannot emulate "rename $old $new" nor
"copy $old $new" only with simple syntax sugarcoating.  We would likely
need a protocol extension to fit them in, and that is of dubious value.

Among the ones Jakub listed in another message:

    1. "<scm> init <directory>" (done)
    2. "hg commit --close-branch" vs slightly cryptic 
       "git push origin :refs/heads/feature-tweak", which can be written
       simply as "git push origin :feature-tweak" I think.
       (that is what this patch series is about)
    3. Numeric local references, e.g. 18:a432bc and "hg checkout 18"...
       but more realistic example would be "hg checkout 6324" :-P
    4. sensible defaults: meaning of revert, staging area (i.e. commit -a)
    5. "hg serve" (gitweb and a kind of git-daemon equivalent)

I think only #1 and #5 make sense (and I wonder if it would be enough to
mention "instaweb" and "daemon" to cover #5).

As we discussed in this thread at length, #2 is on the borderline.  It
makes sense if you take only --delete out of possible vocabulary, but when
you think about it as a part of a coherent whole, it becomes somewhat
iffy---it does not fit particularly well with other parts of the system.

I think #3 and #4 comes from fundamental difference of the world views.

Regarding #3, giving monotonically increasing numbers to local commits
would not be very hard without breaking the underlying data model.  You
would automatically tag the original commit whenever a new branch is
created, and count commits relative to that origin-point tag for the
current branch, perhaps following only the first parent chain, or
something like that.

For such a incrementing number be any useful, the user's history should
rarely rewind, and this also introduces a notion/illusion that a branch
somehow has its own identity, which we deliberately have rejected. I doubt
this is worth it.  Most of the time you are interested in the recent past,
and HEAD~14 would be far easier to use than r19354 anyway ;-)

About #4, in general, I do not think it is worth discussing a topic that
begins with the word "sensible" when the person who uses that word does
not realize that what is sensible is in the eyes of beholder.  Different
SCMs use "revert" to mean different things, because there are a lot of
combinations of _things_ you would want to revert, _states_ you would want
to revert to, and _ways_ you would want the revert to be expressed.  You
may be familiar with the way BK used the word revert, or you may be
familiar with the way SVN used the word revert.  There is no single
"right" use of the word.

It also is not worth repeating the discussion on fear of index, either.

This is a good example of why you should _think_ before blindly parrotting
whatever random people say on the net.  They have not necessarily thought
things through before saying "git can learn from X".  You need to do the
thinking for them to decide if they are making any sense when you read
these things.
