From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Filenames with single colon being treated as remote repository
Date: Sun, 21 Apr 2013 11:01:58 -0700
Message-ID: <7vd2tnvk2x.fsf@alter.siamese.dyndns.org>
References: <20130421045329.GB30538@WST420>
	<20130421060538.GB10429@elie.Belkin>
	<20130421124511.GA1933@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	William Giokas <1007380@gmail.com>, git@vger.kernel.org,
	fsckdaemon@gmail.com, Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 21 20:02:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTyaW-0005fp-9y
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 20:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326Ab3DUSCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 14:02:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58993 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917Ab3DUSCB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 14:02:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D461217923;
	Sun, 21 Apr 2013 18:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SIncwT5eWzrmY7D6cgHJbtoXPRY=; b=h2gCwU
	Xyoeb9Qcj7IAJjy7G7GC74N9NMDYm66opDElX7dQiSP/REpBa/fcCCOJPSzfkrod
	j7OhTZayBA0kowsyYfp46W+i5ccHE0brdPaO/SGYwPfQegQaq5yKnPAizzRTX2/S
	a02GhvvOE0GqHl1ghBUq2ue8kt4tzOokbVxEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FpQPfI81+hwNqNU4bVtfW7F+OumGRxY6
	WNMtnEwlu/5Wxb4iphY61t0rcKo1KdqaNcBOIJho7ilG7pI9BsJBc18cxalO8F58
	wYMHygv64YvIfZaF6hPvnk/Qrt4fKAdVyV1N6Qt8b4dssez+PENc+sHMqZfq8LPf
	z+XQtT35qEs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBDF517922;
	Sun, 21 Apr 2013 18:02:00 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 522A317920;
	Sun, 21 Apr 2013 18:02:00 +0000 (UTC)
In-Reply-To: <20130421124511.GA1933@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 21 Apr 2013 08:45:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 906A3098-AAAD-11E2-9F09-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221959>

Jeff King <peff@peff.net> writes:

> On Sat, Apr 20, 2013 at 11:05:39PM -0700, Jonathan Nieder wrote:
>
>> >     Cloning into 'new-baz'...
>> >     ssh: Could not resolve hostname /tmp/foo: Success
>> >     fatal: Could not read from remote repository.
>> 
>> Here's a toy patch.  I haven't thought carefully about whether it's a
>> good idea, but maybe it can be useful for thinking about that.
>> 
>> Still needs documentation and tests.
>> 
>> My main worry is that the proposed rule for when an argument is
>> treated as a local path is hard to explain.  There's some precedent in
>> handling of bundles, though.  What do you think?
>
> I think the rule could be something like:
>
>   1. If it looks like a URL ("^scheme://"), it is.
>
>   2. Otherwise, if it is a path in the filesystem, it is.
>
>   3. Otherwise, if it has a colon, it's host:path
>
>   4. Otherwise, barf.
>
> where the interesting bit is the ordering of 2 and 3.  It seems like
> "git clone" follows the order above with get_repo_path. But we do not
> seem to follow it in git_connect, where we prefer 3 over 2.

At least for a string whose "host" part does not have any slash,
switching the rules 2 and 3 in git_connect() would be a regression,
no?  "frotz:/srv/git/git.git" has been the way to talk to host frotz
for a long time, and if you want to talk to a local directory that
is a subdirectory of "frotz:/" directory you have in your $cwd, you
can disambiguate by saying "./frotz:/srv/git/git.git" or something.
