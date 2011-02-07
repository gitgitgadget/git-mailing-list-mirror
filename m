From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git add -u" broken in git 1.7.4?
Date: Sun, 06 Feb 2011 22:46:20 -0800
Message-ID: <7vhbcguytf.fsf@alter.siamese.dyndns.org>
References: <4D4DEDC4.4080708@hartwork.org>
 <20110206051333.GA3458@sigill.intra.peff.net> <4D4EF7E4.7050303@hartwork.org>
 <vpq1v3kopn3.fsf@bauges.imag.fr> <7vwrlcv1ea.fsf@alter.siamese.dyndns.org>
 <20110207055314.GA5511@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 07 07:46:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmKrw-00019N-NJ
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 07:46:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752461Ab1BGGqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 01:46:35 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44124 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302Ab1BGGqe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 01:46:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2748F25FB;
	Mon,  7 Feb 2011 01:47:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xh9gwkT5SAIw/8ELk66sXdz/dOM=; b=D/xG7y
	vzc6qQHgTm7qBmdtZwo7RBt/riW+tEDyQebe1YzBoGrLfUO2PI5MGHIPSv304ZNY
	7heH7cz2o7f74xpp+cko/K4o/A/Tp1ycUfF7zzz9zJLWV4d2Si0QuMVKIYLBS34k
	cGb0wVqB8zTrhljBncMDABVuPR/Xi5pvl0ivI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wBTZFGCMPL/v9b+iR8BLqmBnSjzVpk+n
	eAwDgUXMubbOHZbkO8mAmiNCNg4tdVYixR2YH7gODOFOTJLxn0JG5L7rW2VgZcaJ
	Njo4GJrOEvVJ/KWymc8hXOVs6EUIBWQXOkrJysgw/dKomPa6yIs2SeC0pEsNNlhz
	ObOHpvYqA8g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D550E25E5;
	Mon,  7 Feb 2011 01:47:24 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5CA6F25E4; Mon,  7 Feb 2011
 01:47:19 -0500 (EST)
In-Reply-To: <20110207055314.GA5511@sigill.intra.peff.net> (Jeff King's
 message of "Mon\, 7 Feb 2011 00\:53\:14 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1F022790-3286-11E0-A17D-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166236>

Jeff King <peff@peff.net> writes:

> Is "git add -p" broken, then? It takes pathspecs relative to the current
> directory, but "git add -p" without arguments operates from the root,
> not from the current subdirectory.

I would say so; "add -p" was an ill-executed afterthought.  The codepath
was originally meant to be used from "-i" as the top-level interface that
was a fully interactive way to prepare for the next commit, which is an
operation that is inherently full-tree.

There are two schools of thought in previous threads discussing full-tree
vs current-directory-relative.  I think each side has merits.

If we defaulted to the current directory (i.e. "git grep"), that would
feel more natural as it is more consistent with how tools that are not git
aware (e.g. "GNU grep" run in the same directory) behave.  A downside is
when you are somewhere deep in a working tree, you have to know how deep
you are and repeat "../" that many times, i.e. "git grep pattern ../../"

If we defaulted to the root-level (i.e. "git diff"), you do not have that
downside (iow, "git diff" run from a deep directory is a full tree
operation), and you can limit the scope to the current directory by a
single dot, i.e. "git diff .".  A huge downside is that this may feel
awkward for new people who do not yet breath git [*1*], as no other git
aware tool would behave like this, limiting its scope to some directory
that is higher above.

In the past, I have took the third position, saying that tools that
semantically needs to be full-tree should be full-tree (i.e. ones that
make or format commits), and others should be relative to the current
directory (i.e. ones that are used to inspect your progress, such as
grep), but that is not a very understandable guideline that people can
easily follow.  If we have to choose between the two and make things
consistent, my personal preference is to make everything relative to the
current working directory.

I actually do not mind too much myself if all commands that can take
pathspecs consistently defaulted to "full-tree" pathspec given no
pathspec.  But if we were to go that route, everybody should join their
voice to defend that decision when outside people say "in 1.8.0 'git grep'
run from a subdirectory shows matches from all the irrelevant parts of the
tree; with all the cruft its output is unreadable". I won't be the sole
champion of such a behaviour when I do not fully believe in it.


[Footnote]

*1* In the case of "git diff", this is largely mitigated as its output is
always relative to the root of the working tree, but other tools may not
have that luxury.
