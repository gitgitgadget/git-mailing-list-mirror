From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT archive invocation with SHA sum
Date: Fri, 17 Aug 2012 00:22:32 -0700
Message-ID: <7vboiavv7r.fsf@alter.siamese.dyndns.org>
References: <95DC1AA8EC908B48939B72CF375AA5E301473171E4@alice.at.omicron.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Manfred Rudigier <manfred.rudigier@omicron.at>
X-From: git-owner@vger.kernel.org Fri Aug 17 09:22:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2GtF-00061t-GM
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 09:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932886Ab2HQHWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 03:22:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52530 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932639Ab2HQHWf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 03:22:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DB7E49FE;
	Fri, 17 Aug 2012 03:22:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=skpVV/M2Mwqdmk36SYs1ITIELtg=; b=K/LpA9
	gPlnMs7JXLKb/7nGtfGrHqPmdiqyvTKAETHF9gTtrtklLPLmwQI7qV2ajQsCMwgN
	LxPLI9aWzj+8wx9zuv3cce+y6Qe64KGMVsKBN9U1ZKvqbgAa9uT+cXPKZNSY0Nv5
	7ygMT7mltYdZ/vIKOmoa75SPJCTTkwgGvD9xc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rmBzELR6iG7mFczynu3MyaS6SQD0+Eb2
	Nuqg5Dc5wG/mgKPYCXhLfl4smRMg9ZcKGOPeJecztPsrtEuaqz4OV/98cj7HQZU2
	slC+ujKsk30fiHhiJ8mixudkaV0f4VtXzJNmrvpO2hEUHTu85aOIyc+2ZFmIt9nr
	y22D9rENHpM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C21C49FD;
	Fri, 17 Aug 2012 03:22:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A574A49FC; Fri, 17 Aug 2012
 03:22:33 -0400 (EDT)
In-Reply-To: <95DC1AA8EC908B48939B72CF375AA5E301473171E4@alice.at.omicron.at>
 (Manfred Rudigier's message of "Fri, 17 Aug 2012 08:25:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5011D43A-E83C-11E1-AC1F-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Manfred Rudigier <manfred.rudigier@omicron.at> writes:

> we have recently upgraded our Ubuntu server to 12.04, which comes
> with a newer version of GIT. However, we have noticed that git
> archive -remote does not work anymore by specifying the SHA sum of
> a commit.
> ...
> I have read that this restriction was made for some kind of
> security reason, and one possibility would be to add a config
> option on the server repo to turn off this safety check. As we
> manage the git repos ourselves, this would be perfectly ok for us.
>
> What is the current status of this - is there already such a config option?

No, there isn't.

I am no going to say that such a change will never happen, but you
may want to rethink the way you transfer the source material to your
build system, especially your build system is rebuilding each and
every versions of the software.

I can understand that the use of "git archive" can give you a way to
start from an empty directory and build afresh for every version,
but it is stupid to _transfer_ the full copy of the source material
300 times over the network in order to rebuild 300 versions a day,
all of which will be quite similar to each other (after all, the
difference between them will be limited by the productivity of your
workforce).

Fortunately, it is quite simple to fix.  You can maintain a single
bare repository on the build machine (i.e. the one you currently run
"git archive --remote" on), and run "git fetch --mirror" against the
machine that hosts the repository (i.e. the one you currently run
"git archive --remote" against) to keep it up to date.  That way,
you should be able to drastically cut the amount of the network
traffic from the source repository and the build server.

Then, you copy out from that bare repository (i.e. the one you have
on your build server that you "git fetch --mirror" into) using "git
archive" into a fresh directory to build.  Because this invocation
of "git archive" is purely local to the machine, you do not need any
configuration option to bust the "you can only see the branches
available to you" security measure to copy things out.

If your build server is building only the tagged versions for
releases (I doubt that is the case, but I am writing this just for
completeness), "git archive --remove" should be able to reach them,
so you do not need such a configuration option, either.

Hrm?
