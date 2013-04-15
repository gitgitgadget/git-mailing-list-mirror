From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate
 $GITDIR
Date: Sun, 14 Apr 2013 18:28:28 -0700
Message-ID: <7vy5ck4m6b.fsf@alter.siamese.dyndns.org>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 15 03:28:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URYDk-0002gS-C1
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 03:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569Ab3DOB2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 21:28:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34081 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753394Ab3DOB2b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 21:28:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CD2A11A7F;
	Mon, 15 Apr 2013 01:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Jebrn86+C2t/k2uEbDn8hSjcjrw=; b=Uftkuu
	xXhu68lQJSxSkL7XzyNVTmEB+Jb2IBzlvizO2X3c3fJztLVwmoQCXBlXtkK64wsC
	w4OntCwPGW4iuuk1wFIr5Jj3QO/MhO9IQ7tSErQlFa0vflgOnhtlR/wLi1yi19AB
	uxfjfn9xZsX4mCb81OFe1Pb3vQqvkhLZG+FJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XCG8hktm8xdpqcA/rl2Inp3k8xMWHQ9y
	zMyHWB5r9umoz1eQguSzC8IEWdCUDJrLuGYhHRaF8eTDsd8TygGBQZx1Hf6eG51V
	k5/CaT49HZ96AtTa9JuZ/ClOQFEZpFwDlEyhC7CAOQsskVPCH9wAXgr6VQONPbFP
	98l0OfnRxLk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 13DC311A7E;
	Mon, 15 Apr 2013 01:28:31 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 69AFE11A7C; Mon, 15 Apr
 2013 01:28:30 +0000 (UTC)
In-Reply-To: <1365881007-25731-1-git-send-email-artagnon@gmail.com> (Ramkumar
 Ramachandra's message of "Sun, 14 Apr 2013 00:53:27 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7AAA3B8-A56B-11E2-BF57-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221174>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> This configuration variable comes into effect when 'git clone' is
> invoked inside an existing git repository's worktree.  When set,
> instead of cloning the given repository as-is, it relocates the gitdir
> of the repository to the path specified by this variable.

Relocate to where in the superproject's gitdir?  Presumably you can
do this more than once in a given superproject, so there needs to be
a key per such a clone, no?  I am guessing that you would follow the
usual "when adding a submodule without name, use its path as the
initial name" convention, but then I would suggest it to be spelled
out (and if you are doing it differently, that choice needs to be
spelled out and defended).

>  Okay, so this is part of my evil plan to make 'git add' DTRT wrt
>  submodules,...

If the envisioned use of this is to use it as a building block of
something else that is user-facing (e.g. the user says "git add",
and before the command finishes, somewhere we internally run "git
clone"), then would it be possible that you are better off running
that clone with --separate-git-dir and let it make the gitfile for
you?

Any new configuration variable brings its own problem by forcing
existing users to countermand it explicitly from the command line.
If the --separate-git-dir would not work for your application, you
need a new feature and you can achieve the same by adding a new
command line option (say, --submodule-git-dir), that would be more
preferrable.
