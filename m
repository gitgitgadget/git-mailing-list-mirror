From: Junio C Hamano <gitster@pobox.com>
Subject: [Bug?] "git commit --amend" always gives author-date to summary?
Date: Thu, 14 Apr 2016 14:07:50 -0700
Message-ID: <xmqqh9f3gaqh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 23:08:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqoUh-0007uK-E9
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 23:08:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbcDNVIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 17:08:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63757 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751980AbcDNVH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 17:07:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D787412EE3;
	Thu, 14 Apr 2016 17:07:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=G
	mXratFRHOKeL82CQ3coc5+PC8M=; b=LwXHgG7QYnZLfJQSnk/d241K8rDUVIB98
	k7VS5giBX+IipLAavk/Ez5srmNLTUNX9GNtlgGRCdcAYVSOs5ySySoNJBl7m4Xcr
	7kKGdv5IP/qJyRzWYfd6hv3Y6ytHoi+wqeB1nHd3zQ7qLHdyzboIRhlsGQkyRh/E
	BDVcvfswRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=yTPLazjy9I+6ZKqv0cjL2JJy/0VWqRIc4CLO0hsNiCSuntiKrJ9O3etK
	y4ugiy518bBxwN+0NEUCdGhH5lEmcUBMz+cYXLXcabslaSyEld6SWD8HfLv8oAfn
	HTPAIRBtCOFC1NjnX1nIGKj5Y3w/CnnLko+HO/yvyclrC11Dxvo=
Received: from pb-smtp2. (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CF73E12EE2;
	Thu, 14 Apr 2016 17:07:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BB82612EE1;
	Thu, 14 Apr 2016 17:07:51 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F30A2262-0284-11E6-9808-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291566>

A simple reproduction.  Doing one of these

    $ git commit --amend --no-edit
    $ echo >MSG frotz; git commit --amend -F MSG

on any commit, whether it is your own commit or somebody else's,
seems to always show the "Date:" of the original commit, e.g.

    $ git checkout v2.8.0^0
    $ git commit --amend --no-edit
    [detached HEAD a6f2a14] Git 2.8
     Date: Mon Mar 28 12:19:45 2016 -0700
     3 files changed, 14 insertions(+), 9 deletions(-)
    $ git checkout v2.8.0^^2
    $ git commit --amend --no-edit
    [detached HEAD df9f57e] Documentation: fix git-p4 AsciiDoc formatting
     Author: Lars Schneider <larsxschneider@gmail.com>
     Date: Wed Mar 23 11:59:01 2016 +0100
     1 file changed, 3 insertions(+), 5 deletions(-)

I can understand the latter, but I am not sure if it makes sense to
do the former.  The output is coming from b7242b8c (commit: print
"Date" line when the user has set date, 2014-05-01), whose objective
I can agree with, but does not seem to match the use case.

    commit: print "Date" line when the user has set date
    
    When we make a commit and the author is not the same as the
    committer (e.g., because you used "-c $commit" or
    "--author=$somebody"), we print the author's name and email
    in both the commit-message template and as part of the
    commit summary. This is a safety check to give the user a
    chance to confirm that we are doing what they expect.
    
    This patch brings the same safety for the "date" field,
    which may be set by "-c" or by using "--date".  Note that we
    explicitly do not set it for $GIT_AUTHOR_DATE, as it is
    probably not of interest when "git commit" is being fed its
    parameters by a script.

When doing "--amend", not updating the author-date is the norm.
Also, I think the output is meant to accompany with the reminder to
say "You are committing somebody else's change", but in the first
case of amending v2.8.0^0, "the author is not the same as the
committer" does not apply, either.

The commit in question, b7242b8c, brings in a test for amend to
7501, like this:
 
    test_expect_success 'commit mentions forced date in output' '
            git commit --amend --date=2010-01-02T03:04:05 >output &&
            grep "Date: *Sat Jan 2 03:04:05 2010" output
    '

But if I change it like this:

    test_expect_success 'amend always mentions date in output' '
            git commit --amend >output &&
            grep "Date: " output
    '

the test still passes.

I suspect that there are people who are already depending on this
behaviour, so it may not be worth fixing, but I found it somewhat
irritating (especially after wasting about an hour or so doing wild
goose chase trying to find a stray invocation of "date" somewhere in
my script that eventually uses "git commit --amend").

Thoughts?
