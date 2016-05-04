From: Junio C Hamano <gitster@pobox.com>
Subject: Re: remotes
Date: Wed, 04 May 2016 00:04:48 -0700
Message-ID: <xmqqk2jajobz.fsf@gitster.mtv.corp.google.com>
References: <20160503181624.1504eb0a@laborpc>
	<xmqqshxylvwh.fsf@gitster.mtv.corp.google.com>
	<20160504013624.4c51ce42@wind.levalinux.org>
	<CAGZ79kat4rW7raoXQNF2mb0nS5qF0e7yTCoSkiFe2VFJ=E_VdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kovacs Levente <leventelist@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 04 09:05:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axqrj-0000Ak-9e
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 09:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbcEDHEx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 03:04:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54304 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751052AbcEDHEw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 03:04:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E8954F9F8;
	Wed,  4 May 2016 03:04:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=azrz8KwmIMMSWd7O8ciHgWQUdOo=; b=KaLDJp
	1htWE30bATijZBiEI6PEyymvm/iTl0U0PsVjfKRlJT5/593AG8ee6kBuQqlZYRBm
	cpAyCMm2N/DmnFww/o86aUOWehXfett1qdKjTIUK0RgLdmnlY5/mlxPB7D12Q8GB
	kRNN2QN/EWrtnDG+uI7N6T+bKKWbt6IigpINk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OJll+pTyfqS51cos9WWLPDvvMgXbzbiq
	rMGrgHIOVgfuvyZ6lAfO9yeRMDEWo+fBTyaUtXFXLdBPo1BJYdXYYJ4U5oejbpks
	Emmxu1+2KPmhUPEQjjdrmW2r3UOR0lz3PD/ZL7tuWyJYjVcDRbAJHbJ6MXwxkcWP
	5e81WEECcmM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id DFF54F9F6;
	Wed,  4 May 2016 03:04:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 50A1BF9F5;
	Wed,  4 May 2016 03:04:50 -0400 (EDT)
In-Reply-To: <CAGZ79kat4rW7raoXQNF2mb0nS5qF0e7yTCoSkiFe2VFJ=E_VdA@mail.gmail.com>
	(Stefan Beller's message of "Tue, 3 May 2016 16:47:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7E69CD1C-11C6-11E6-A093-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293502>

Stefan Beller <sbeller@google.com> writes:

> A recent addition is the check for unrelated histories via
> checking for added root commits (i.e. commits with no parent) and
> refusing to merge them by default.  you need to pass
> --allow-unrelated-histories to merge.
>
> see
> https://kernel.googlesource.com/pub/scm/git/git/+/e379fdf34fee96cd205be83ff4e71699bdc32b18

That commit however is not about "checking for added root commits",
which would be way more expensive to compute.  That commit is merely
about detecting that the other history does not have _any_ relation
to ours.

The difference is in this sequence.

 (1) Alice owns the canonical history.
 (2) Bob copies Alice's tip tree without history, starts a
     different root, and builds some history.
 (3) Alice builds some more history.
 (4) Bob pulls from Alice.  The check in e379fdf3 triggers here, but
     Bob can override it.
 (5) Alice builds even more history.
 (6) Bob also builds even more history.
 (7) Bob asks Alice to pull from him.
 (8) Alice pulls from Bob.  The common ancestor discovery finds the
     merge base between (4) and (5), which is (3).

    ---(1)---(3)---(5)---(8)
                \        /
          (2)---(4)---(6)

The history traversal is done at (8) to find merge-base for two
purposes.  One is to find the common ancestor to use in 3-way merge,
and the other is for the check introduced by e379fdf3.  It stops at
finding (3), and does not traverse the history all the way down to
(2).  But in order for Alice to notice that the merge would pull a
new root Alice never has seen, i.e. (2), a traversal needs to
continue down to the root of other's history.

Naively, it would be running

	rev-list --max-parents=0 ^HEAD MERGE_HEAD

and see if the result is not empty, in which case you found (2).
But that is way too expensive unless (2) is relatively shallow.
