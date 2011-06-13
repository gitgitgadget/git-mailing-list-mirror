From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2011, #02; Sat, 11)
Date: Mon, 13 Jun 2011 06:16:52 -0700
Message-ID: <7vd3ihrhvf.fsf@alter.siamese.dyndns.org>
References: <7voc23sfxd.fsf@alter.siamese.dyndns.org>
 <BANLkTinHCX0vmAdk+su-_Y0th9vLQ6qsnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 15:17:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW70s-00078G-VW
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 15:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982Ab1FMNRB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 09:17:01 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40596 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160Ab1FMNRA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 09:17:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1AB5352EF;
	Mon, 13 Jun 2011 09:19:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tSyExspVHNccjfxtsBpEvrFtNUc=; b=lcZRrc
	mrRbjlKEUrWZjH5I64OrXqzGMK+BZla/rBFUFSYdd5iqEIJxtm+l7GQCWaRbOEIn
	Muhkg+iWJMXUQfRqwnB/cAKeodS8/sKzhxP3Qk3WeVFbTPUvYrMhxkUvjh4xAqzW
	Zxyf5h3UospUllvw8O+eDj2Cm7ozkATxdg4t8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PBx3EVXNlktXawIdoc8J0Rgm5yU1x+c5
	rdV3AiFjoJVM90Yy+6WK2M5yMes8tUliFqyJpti9qiON9zP8SXbkXlk/9x6Zb8Oh
	wOllvHOi+o8WVXAJB4/Zt5HgpRPAHwAh02h6TjGDLg3EXf9d1R1V7tpRnVBY3JyV
	eQqRsJNoK/U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EA63F52EE;
	Mon, 13 Jun 2011 09:19:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0BABD52ED; Mon, 13 Jun 2011
 09:19:04 -0400 (EDT)
In-Reply-To: <BANLkTinHCX0vmAdk+su-_Y0th9vLQ6qsnw@mail.gmail.com> (Ramkumar
 Ramachandra's message of "Sun, 12 Jun 2011 17:44:39 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B7F4DFF0-95BF-11E0-A372-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175703>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Have you seen my "libify reset" patch [1]?  I thought it was an easy candidate.

The reset-index-file part might be (but I agree with Jonathan that we can
wait until we need it), but the other one does not deserve to be called a
"libified" function if you look at it as an API function.

There are many places we show abbreviated commit object name and its title
with different frills around that message, but that particular function
does not help them unless the other callers want the same "HEAD is now at"
frill. Try this:

 $ git checkout HEAD^
 HEAD is now at 2cbd969... Git 1.7.6-rc1
 $ git checkout master
 Previous HEAD position was 2cbd969... Git 1.7.6-rc1
 Switched to branch 'master'

Your helper cannot even help produce "Previous HEAD position was", even
though I am reasonably sure they share the same logic. 

A helper whose signature is something like

    void pretty_print_commit(FILE *f, const char *fmt, struct commit *commit);

so that the caller can say

    pretty_print_commit(stdout, "HEAD is now at %h... %s\n", commit)

instead of "print_new_head(commit)", might be a good addition to the
"libified" helper set, but I suspect it is not worth it.

Look at how clearly and succinctly describe_detached_head() is implemented
in builtin/checkout.c
