From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v4] grep: Add the option '--exclude'
Date: Tue, 14 Feb 2012 09:35:23 -0800
Message-ID: <7vfwed8gis.fsf@alter.siamese.dyndns.org>
References: <1328192753-29162-1-git-send-email-surfingalbert@gmail.com>
 <CACsJy8DhtjG6AhPkb0SEm4g6zhtmuRb5x+4+P3A6eS0+_7OQNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Albert Yale <surfingalbert@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 18:35:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxMHr-0004ZQ-CN
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 18:35:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758864Ab2BNRf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 12:35:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62059 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752562Ab2BNRf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 12:35:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AF997D70;
	Tue, 14 Feb 2012 12:35:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=y2o3FZ7gCOIVKyEr4BtVJghK/xM=; b=kJ2O1P
	DiuWQTTKt+brY91ZHHZOnJN6CsBjJwBnbEquDr/0XRgLkG/jJlCp9R5yNaC7mt1P
	HLyN+JRTfjsqndoG2SokO2QZKt559cvQvBEQD0mO7U9YUzWCbW2meenKfHrbrj1n
	TXgFqti4a0jdsF/AlpVY2lnL2WiYjQKH6HTgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mpTHJ5wFpkx60Ax/ZxEzj2aI3/NlNUZy
	EnhlYUt0+t2T2KurzhOCnc4Vjs1fX3265L/8xo4hXbaVzM4mZMhLCpS7PqdcOi61
	VAUD2jtMgKmKX6CwW2Bgc0acLTFnT6Zg5LsbIF68bFUsRdjVX+5flYKfKXKnJB0W
	N41w25LD/UM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52B5D7D6F;
	Tue, 14 Feb 2012 12:35:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CAEC27D6E; Tue, 14 Feb 2012
 12:35:24 -0500 (EST)
In-Reply-To: <CACsJy8DhtjG6AhPkb0SEm4g6zhtmuRb5x+4+P3A6eS0+_7OQNw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Mon, 6 Feb 2012 22:16:59 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 46F74C18-5732-11E1-8FE4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190728>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> It makes me wonder, why not add match_pathspec_with_exclusion(const
> struct pathspec *include_ps, const struct pathspec *exclude_ps,...),
> use the new function in grep.c and revert struct pathspec back to
> original? The same can be applied to tree_entry_interesting() (i.e.
> add a new one that takes two pathspec sets, which supports exclusion)

Sorry, but I am the one to blame for this in:

 http://thread.gmane.org/gmane.comp.version-control.git/189455/focus=189486

> I think you may make less changes that way.

The arrangement to use two pathspecs certainly is simpler in the short
term, but I think it is a short-sighted hack that is wrong for two
reasons.

 - Doing it that way will not give you a solution where you only have to
   update the command line parsing of an existing command to stuff
   negative patterns to the pathspec structure you have been passing down
   to the existing codepath, and the command starts to understand negative
   patterns without any other change.  You introduce a new pathspec that
   holds negative patterns, and pass that along with the positive one you
   have been passing down in the existing codepath for all commands that
   need to understand pathspec (otherwise we will be back to a similar
   situation we were in before you started looking at pathspec where we
   had three different implementations giving different semantics---some
   command knows how to handle this kind of pathspec but some others do
   not).

 - Look at the fields in 'struct pathspec' and think about what those
   outside "items" list mean. The recursive and max_depth fields are about
   how the namespace is traversed [*1*], so if a codepath that used to
   know only about positive patterns learns to also care about negative
   ones, using different settings for these two fields in two separate
   'struct pathspec' does not make sense.  It is conceptually much cleaner
   to make 'struct pathspec' the data structure used by the updated logic
   to match paths to pathspec that can have positive and negative patterns.


[Footnote]

*1* The has_wildcard field is about optimizing the matching during the
traversal so it is a bit different.  Also it is our longer term goal to
get rid of the "raw" field (which does not work well to substring match
against the path when pathspec "magic" is involved), so we won't worry
about it in this discussion.
