From: Junio C Hamano <gitster@pobox.com>
Subject: [1.8.0] Unify "pathspec" semantics
Date: Mon, 31 Jan 2011 09:07:14 -0800
Message-ID: <7voc6x57el.fsf_-_@alter.siamese.dyndns.org>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 31 18:07:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjxDq-0007oH-2p
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 18:07:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815Ab1AaRHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 12:07:21 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44333 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752227Ab1AaRHU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 12:07:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 06E174187;
	Mon, 31 Jan 2011 12:08:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gAEdAn+mHMivWdpnpZt35vS7MyQ=; b=uAymJR
	LBfKA2p6/VPVSpUKhQaEudaNlHowG8zBXyzElJNV07Rda2BogtNumkR2QK9aiSbK
	dqLm8m9ZUblqThgdKDNCtXrJVM+t0pC4fzB5tOWV3MLMXHS6hV5DNYm80kCevM1C
	aSfEzkPRF5MkfISLHwxbWo7MbPZE7jMpVjQgg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eNGjisZGjFFCXVGbXZVWmBTeqsNZOez+
	x9xvC30LX98ClnyJOD5CpQ+HX6Z+9ZGcsLWiqE4jJ1on3QKJtKjhUy7/oxS+us6J
	rzF7Ad4unpGqAWC6a+B4c51xZfQXR9HS9kT4P/E3rnvHdEZtlw6sEMiFBr9XHF/3
	M1HPQdabAEo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E94984186;
	Mon, 31 Jan 2011 12:08:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 329574185; Mon, 31 Jan 2011
 12:08:08 -0500 (EST)
In-Reply-To: <7vwrll57ha.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 31 Jan 2011 09\:05\:37 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AF1BC914-2D5C-11E0-B4E1-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165737>

Proposal:

Traditionally, Git had two distinct semantics for pathspecs.  Anything
based on tree-diff (i.e. "log" family of commands when limiting the
history by paths or "diff" family of commands limiting the output) used
"leading paths match" without globbing support.  All others (e.g. "grep",
"ls-files") supported globbing.  This resulted in subtly inconsistent
behaviour when one part of the program collected paths from the index and
the working tree while another part of the program used differences
between the index and the HEAD, e.g. "git add".  Unify "pathspec"
semantics to make all of them learn the globbing.

Risks:

If coded poorly, performance bugs can be introduced to the tree-diff
codepath, making it inefficient.

Some projects may track a file whose name is asterisk (e.g. "foo/*") and
output from "git log 'foo/*'" would look different.  Before the change,
only commits that touch that exact path would be shown, but after the
change, any commit that touch a path underneath "foo/" directory will be
shown.  This is a backward incompatible change.

Migration plan:

We could conditionally enable globbing support when implementing unified
pathspec API, default to the traditional and inconsisntent behaviour
during the 1.7.x series, and flip the default to accept globs everwhere in
the 1.8.0 release.  Practically, however, nobody sane would track paths
that have shell metacharacters in them, so we may not need to do the usual
"introduce as an opt-in, warn about incompatibility, and flip the default"
migration.
