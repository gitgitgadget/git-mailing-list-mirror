From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/POC 3/7] setup.c: add split-repo support to .git files
Date: Fri, 13 Dec 2013 10:30:59 -0800
Message-ID: <xmqqiousr4bg.fsf@gitster.dls.corp.google.com>
References: <1386771333-32574-1-git-send-email-pclouds@gmail.com>
	<1386771333-32574-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 13 19:31:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrXW2-0001Z9-60
	for gcvg-git-2@plane.gmane.org; Fri, 13 Dec 2013 19:31:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221Ab3LMSbF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Dec 2013 13:31:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48647 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752960Ab3LMSbE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Dec 2013 13:31:04 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7ABB7567D4;
	Fri, 13 Dec 2013 13:31:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=g5zfOJKmOMxK
	bybqf9onxuVQVIM=; b=lV//nyENbUG37aguo4HpWVzNim3A7ReQuqYVulfZF9QG
	+1priOsJ1bdydpL9ZafeyC0EgI1LwJ5dRN6Hpwd10oQ7uSJW2A07jUTWvZHDN3US
	6FqGPjRX+n4wewjPKNeClC0NeK7woMhClSu9V5aMF4BpAcMgTOLO9VepUlDbjf4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=sYqL1l
	D1RjIhEy6BganovnMietnLWTM3RNH1IE6xs9E5VSPQmJyv0Z6uuUENl62NYhivV0
	uecdwG6a7zjfi/38f361ARYew28Pbjjx2V8uwqTia/VwQ0FBLTTix1tBk7+hpTIh
	7FTawnA3zpHxxijLofQ+3SaiLbgLiZzOtKOms=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 54AB3567D1;
	Fri, 13 Dec 2013 13:31:03 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6AF35567D0;
	Fri, 13 Dec 2013 13:31:02 -0500 (EST)
In-Reply-To: <1386771333-32574-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 11
 Dec 2013 21:15:29 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B84697E2-6424-11E3-A421-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239262>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> If a .git file contains
>
> gitsuper: <path>
> gitdir: <id>
>
> then we set GIT_SUPER_DIR to <path> and GIT_DIR to
> $GIT_SUPER_DIR/repos/<id>.

I initially thought: "what is with that complexity? isn't it just
the matter of replacing 'gitdir: <path>' with 'gitsuper: <path>'
stored in the file .git???"

Until I realized that there is nowhere to keep per-workdir data if
we only had .git as a pointer, and that is why you have that <id>
thing.  It would have helped me avoid that confusion if the above
description was followed by:

    The latter, $GIT_SUPER_DIR/repos/<id>, is a directory,
    underneath which per-work-dir items like index, HEAD, logs/HEAD
    (what else?) reside.

or something like that.  And $GIT_SUPER_DIR/repos/*/HEAD, especially
when they are detached, plus $GIT_SUPER_DIR/repos/*/index, will work
as the starting point of object reachability scanning when running
repack, fsck, etc.

A few more random thoughts...

 - Reusing "gitdir:" for this purpose is not advisable; use a
   different name.  This <id> is used to identify a workdir, so
   perhaps "gitworkdir: <id>" might be a better name;

 - Do we want to record where the working tree directory is in
   $GIT_SUPER_DIR/repos/<id> somewhere?  Would it help to have such
   a record?

 - How would this interact with core.worktree in .git/config of that
   "super" repository?
