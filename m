From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/6] match_basename: use strncmp instead of strcmp
Date: Tue, 12 Mar 2013 13:59:40 -0700
Message-ID: <7v7glc72rn.fsf@alter.siamese.dyndns.org>
References: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
 <1362896070-17456-1-git-send-email-pclouds@gmail.com>
 <1362896070-17456-4-git-send-email-pclouds@gmail.com>
 <7vy5dvd7yq.fsf@alter.siamese.dyndns.org>
 <CACsJy8A_4SqLu5L6P0PJ78Lwy12fjL7T2p-KbVEVLJmKNqhyRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 12 22:00:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFWIv-0002pv-L6
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 22:00:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933397Ab3CLU7n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 16:59:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52243 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932542Ab3CLU7m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 16:59:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BC4DB060;
	Tue, 12 Mar 2013 16:59:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2y/2Asj4ckum5f/5fzFEAFCCHls=; b=ZN6H5w
	PyuScePgacGnNXoxriUieoDkHrtl7suKUTZFhojpXJmUrF8mVAqVnE6C6sWVPQPR
	2fLa2sEJTE8N6Jz7xI4+hAYLpiFDBBIxvR8yjiVDPHWXEQAZzReIf0o4JDcEvb+W
	EZPTXooc7xLZmh/twqIHekW5hiei5A+ol9qhY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TGZJWXviYaSbSUa05gBt6Y28TChyXmIH
	oozjEWmBBrEk8qAAeaJseKEjqR8T+L1zPh30MAGPSLTw04aVT/CB0Dt4jdq68qFb
	wTsSVuUfD7ct4Mv4zd1uhXTSkh+DumvGwH0AaCT5u/fe9vYoc8LWdBT2+Z6Q4rXd
	8SDlCbyh7fs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17471B05F;
	Tue, 12 Mar 2013 16:59:42 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 817CAB05B; Tue, 12 Mar 2013
 16:59:41 -0400 (EDT)
In-Reply-To: <CACsJy8A_4SqLu5L6P0PJ78Lwy12fjL7T2p-KbVEVLJmKNqhyRw@mail.gmail.com> (Duy
 Nguyen's message of "Sun, 10 Mar 2013 17:38:37 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C274C384-8B57-11E2-9E70-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217993>

Duy Nguyen <pclouds@gmail.com> writes:

> glibc's C strncmp version does 4-byte comparison at a time when n >=4,
> then fall back to 1-byte for the rest. I don't know if it's faster
> than a plain always 1-byte comparison though. There's also the hand
> written assembly version that compares n from 1..16, not exactly sure
> how this version works yet.

It sounds to me more like "a very popular implementation of
strcmp/strncmp pair found to have more optimized strncmp than
strcmp".  While that may be a good reason to justify this patch,
I do not think it justifies this:

>> strncmp is provided length information which could be taken advantage
>> by the underlying implementation.

After all, strcmp() could also be optimized to fetch word-at-a-time
while being careful about not overstepping the page boundary.
