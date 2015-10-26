From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/3] Add test to describe expectation of blame --reverse with branched history
Date: Sun, 25 Oct 2015 23:27:32 -0700
Message-ID: <xmqqeggijga3.fsf@gitster.mtv.corp.google.com>
References: <1445837217-4252-1-git-send-email-max@max630.net>
	<1445837217-4252-3-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Eric Sunshine <sunshine@sunshineco.com>,
	git@vger.kernel.org
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Mon Oct 26 07:27:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqbFs-0002ra-71
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 07:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901AbbJZG1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 02:27:36 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52449 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750955AbbJZG1f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 02:27:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 86FE71FB9E;
	Mon, 26 Oct 2015 02:27:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EWBDULxxy9tZqnvL+i3NIDpr+UA=; b=m8jcy2
	dMyxY8adYf/uElX/2LVhRgq9qQBJUSh1SW/KWHqFcbF2t8zTwWk+LsIZaOuMCatv
	MyeNcY/ZKZecv56sW30Qxpq+IqYvP0Iin5Lyl/pPmtZi3CnrCW2uzfjqY8ecQTMY
	IfNtNGYBfyAdrTBV4cUllY6vk46UQp00gDdKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wOVwBTNSKE+ofgivIBWmK5ltBki37sC0
	iptTcrR8HAYT87kCBfYfwvUvJLa19gtuKgci9wtL+HiDK7y09vLelOED8f4nBYoS
	DIpfbGDoEnNYUhJOY/1Xkeq6xach0bEik6tFW8BjoEkHBLkM80Y+UN6KM+nAHRuC
	EIiYrKAS3To=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7D6921FB9D;
	Mon, 26 Oct 2015 02:27:34 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 01F751FB9A;
	Mon, 26 Oct 2015 02:27:33 -0400 (EDT)
In-Reply-To: <1445837217-4252-3-git-send-email-max@max630.net> (Max Kirillov's
	message of "Mon, 26 Oct 2015 07:26:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A49087E0-7BAA-11E5-8E80-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280181>

Max Kirillov <max@max630.net> writes:

> If history contains merges from feature branches, `blame --reverse`
> reports not the commit when the line was actually edited, but head of
> the last merged branch which was created before the edit.
>
> As a workaround, `blame --reverse --first-parent` could be used to find
> the merge of branch containing the edit, but it was disabled in
> 95a4fb0eac, because incorrectly specified range could produce in
> unexpected and meaningless result.
>
> Add tests which describe ideal functionality with and without
> `--first-parent`.
>
> Signed-off-by: Max Kirillov <max@max630.net>

I _think_ I know why it would be useful to allow "--first-parent" to
the command; it is useful the same way why "git log --first-parent
$path" would be a good way to get an overview.

But I am puzzled by your complaints (I'd characterise the statement
as such, given your second paragraph calls the combination a
"workaround") in the first paragraph.  I honestly do not understand
where it comes from at all.

The reverse blame begins from an old state and shows the most recent
child in the history that each line survived to, and it does not
show what commit removed the line from the original state.  And that
does not have anything to do with the presence of any merges or
forks in the history.  The command will always report "not the
commit that edited the line."  There is nothing special about "If
the history contains merges".

If you have this history, for example:

    D---E---F
   /         \*
  O           X---Y
   \         /
    A---B---C

where O had the original file, which was not touched by any commits
on the branch on the upper side, and commit B rewrote all lines of
the file, running blame in reverse may show A as the last point
where all lines survived up to, if the "reversed" history happened
to consider A as the earlier "parent" (in reality it is a child but
blame is about assigning blame for each line from child to parents
so in the reversed history, real children becomes parents).  Or it
may show F as the last point where all lines survived up to, if D
was picked as the earlier "parent".  Because there is no inherent
ordering between A and D, both of which are children of O, your
result is not necessarily "head of the last merged branch".

But I do not see how "first-parent" would be a workaround for that.
The option would be useful to force the assignment of blame (in
reverse) along the first-parent chain O---D---E---F---X---Y so that
you can get a bird's-eye view of the history, i.e. squashing all
that happened in A---B---C as if that happened at X.

The explanation of the first paragraph needs to be rewritten to make
it understandable, but I am not sure what relevance it has with this
change.

Thanks.
