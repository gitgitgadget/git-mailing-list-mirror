From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Limit file descriptors used by packs
Date: Tue, 01 Mar 2011 06:24:21 -0800
Message-ID: <7vwrkiex62.fsf@alter.siamese.dyndns.org>
References: <1298924835-23413-1-git-send-email-spearce@spearce.org>
 <7vwrkjhp27.fsf@alter.siamese.dyndns.org>
 <20110228204727.GB26052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 01 15:24:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuQVB-0008Mh-Nj
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 15:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756418Ab1CAOYc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 09:24:32 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37353 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756402Ab1CAOYb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 09:24:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1B5644A5B;
	Tue,  1 Mar 2011 09:25:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0E8TctT+j5mAyaSGnGDnQDWB//A=; b=AwzzFp
	s4B5hIlQ4tadP1mtviA9zS6HL6rgK8daSBNS9n2z5RQCCRHQ+RPOJVne0qzXEBCq
	5H0GDzS0cN3vdzgVuCYkoKXoy9Bilnb6ut7g3lOy4qswrlnUNOilv6L8A9rtDuM+
	dvl2okCkimEZHIfamXmBUgeAs6rZmO5lLOuHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HqmIhxAEBeiQUXaqzOzBqsK/8vru8Tcf
	3DtUETZQsv7aPo64RhFHyvsN+PJsQYx60E5woEpbW+Wt9eAKQ0BnuIm8M1huZXr1
	yXedp670LU3Y1WcfXu4vNVyQcWBTHWw9JR5H1S1vx0wFZ7t7u4rGhHPv1LOotuG5
	CNJO/6ZUt+4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DE7714A5A;
	Tue,  1 Mar 2011 09:25:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CD1484A59; Tue,  1 Mar 2011
 09:25:42 -0500 (EST)
In-Reply-To: <20110228204727.GB26052@spearce.org> (Shawn O. Pearce's message
 of "Mon\, 28 Feb 2011 12\:47\:27 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CBFA539C-440F-11E0-B4AC-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168222>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> In this particular part of C Git, if we are bumping up against the
> hard pack_max_fds limit we're already into some pretty difficult
> computation. Trying to push the rlimit higher in order to avoid
> close/open calls as we cycle through fds isn't really going to make
> a huge difference on end-user latency for the command to finish
> its task. So maybe we are better off honoring the rlim_cur that we
> inherited from the user/environment.

Let's step back a bit.

You are holding too many file descriptors open because you have too many
pack-files in your repository.

I am not going to question why they aren't repacked before their number
gets too large---that is not a valid question to ask in the context of
this discussion.  But it is a valid question to ask why we need an open
file descriptor for each of them to begin with, and if we really need to,
isn't it?

We keep one file descriptor open for each .pack in which we have pack
window(s).  The reason we keep one file descriptor open is because we
might want to mmap() different portions of a .pack file that is already in
use through the file descriptor to open new window(s) on demand.

For a .pack that fits inside a single pack window, however, can't we close
the file descriptor immediately after mmap() it to obtain a sole window
into it?  For such a .pack, we would either have one window into it, or
the .pack is not in use and have no window into it.  When the number of
windows drops to zero, the current code closes the file descriptor, and
upon next use, we already let the caller access the .pack correctly, so
we already should know when to re-open a file descriptor to it as needed.

I am wondering if it is a viable approach to, inside open_packed_git_1(),

 - mark a packfile that is small enough (i.e. st.st_size aka p->pack_size
   is smaller than packed_git_window_size) as "persistently mapped";

 - keep a window that covers the entire thing in p->windows as a single
   and sole window into it for such a pack; and

 - close the file descriptor when we did the above

and have use_pack() notice that single window and use it.

This is not an alternate proposal to your patch, but the approach may
alleviate the resource pressure in the first place, no?
