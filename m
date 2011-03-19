From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git fails to detect subcommand when hook is symlinked to a
 builtin
Date: Fri, 18 Mar 2011 17:53:51 -0700
Message-ID: <7vhbb0rkv4.fsf@alter.siamese.dyndns.org>
References: <20110318151415.GC26236@inocybe.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 01:54:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0kQg-0001ep-RO
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 01:54:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932799Ab1CSAyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 20:54:01 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36183 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932774Ab1CSAyA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 20:54:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 176334CFE;
	Fri, 18 Mar 2011 20:55:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QbC95Wd0cAt5Munkehj7sDPrXMc=; b=iml2Oi
	co2a/ZC+BU8KHoKNJpstWlahvHBJS9etF4MJmpXz8xOAuz3WHKcMC1tFk9hGYPus
	NcjqaS996H/TnbMbvI97DOIxw0vq9u+R7ZM5e9taB3Wce1ISQZqg+Lo+aLIXUZCb
	wxv1uyp+kjcCcxm5IqaSU0zppU46UCtkW13KE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XeYRHWX4QdDPuWIIaNGjoLZ3MHPS0pVk
	PG/Lu/kpriC9tDgp2IRw1wKbBvc8MNJBE9p0GkGIG1W1OvWKY9+tEWOfYD6xASCg
	svIfy76q7Sw54iwkY0li5Q41/4cijETnGJBXa01xBh/4fdYy/kmjjsn505D3gBNs
	JtKn420RQU8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E57E14CFD;
	Fri, 18 Mar 2011 20:55:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1A6214CEF; Fri, 18 Mar 2011
 20:55:28 -0400 (EDT)
In-Reply-To: <20110318151415.GC26236@inocybe.localdomain> (Todd Zullinger's
 message of "Fri, 18 Mar 2011 11:14:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9737A4F4-51C3-11E0-A09B-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169380>

Todd Zullinger <tmz@pobox.com> writes:

> I'm not sure if this is a bug or more of a "don't do that" sort of
> thing.  At fedorahosted.org, the git repositories are mounted on a
> filesystem with noexec.  As such, we have all hooks symlinked
> elsewhere.  For the post-update hook we used to link directly to
> git-update-server-info.
>
> This worked until we upgraded the system to git-1.7.4.1 recently.

I have a suspicion that we may end up saying "don't do that", but let's
ponder a bit with some technical background first.  The "git" wrapper and
builtin commands are all the same binary, and as a consequence, their
main() function needs to decide what to do based on argv[0].  If argv[0]
is "git", we know argv[1] is the name of the subcommand, and if argv[0] is
"git-foo", it might be the internal call from the "git" wrapper that was
invoked with argv[] = { "git", "foo", ... }, but we don't expect that
argv[0] to be things like "post-update".

But it is curious why the resulting behaviour changed recently.  The
symptom hints that the link target (git-update-server-info in your case)
used to be given as argv[0] (which still wouldn't have been kosher---you
are not supposed to use dashed form since 1.5.4 or so without adding
$GIT_EXEC_PATH at the beginning of your $PATH, and that is why I said the
first sentence in this reply), but we recently changed something and now
we are getting "hooks/post-update" in argv[0].

I suspect the recent change to run hooks via run_command() interface has
something to do with it.  From what version did you update to 1.7.4.1?
