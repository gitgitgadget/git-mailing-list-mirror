From: Junio C Hamano <gitster@pobox.com>
Subject: Re: filter-branch performance
Date: Wed, 10 Dec 2014 08:05:21 -0800
Message-ID: <xmqqfvcnjxry.fsf@gitster.dls.corp.google.com>
References: <548744F1.9000902@gmx.de> <20141209185933.GC31158@peff.net>
	<CAFY1edYYC9TZmLE6b3=QAoTB1zQHi_Y97rHL-5wk5Pbpa_oj_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Henning Moll <newsScott@gmx.de>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Roberto Tyley <roberto.tyley@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 17:05:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xyjlc-0006Bc-UF
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 17:05:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbaLJQF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 11:05:29 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64980 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932180AbaLJQF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 11:05:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1BF8723C33;
	Wed, 10 Dec 2014 11:05:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZbcJmzRr/UNQQH8ZnUhIWZJP5Pk=; b=niSbOw
	e07N2vfLnsXbeuN+RBEGv3vYFJEz/64wcwY/XlnjXro3mx9vIqYko1TpvWB1Zz84
	Z8wCiDBbkB4YgGT3qRc+70Kou5NJjTHUlfyGy3qNXgJ14Dgo+6p6OVpVE/Ka4vMO
	6EuZD8FJB3y3FEsjfqBSRlAvvss/QMKDHbMc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gYKwtSr84fKHfN5rc+M08mvRU5xpem6f
	Fu/+VIOoOO7juaooyyZXdd9C+COUlii9gfrGUZdrwRZ++SxBwEXnS8qtXciZXUK1
	ulTHPMmasPKrfYuomE4p1obYl+8ITwTehUf8A9FZu3Pq3eqpP2R2Hxhhm39xCAKg
	8C6HMpcvf8U=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1165D23C32;
	Wed, 10 Dec 2014 11:05:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E4B4B23C2A;
	Wed, 10 Dec 2014 11:05:22 -0500 (EST)
In-Reply-To: <CAFY1edYYC9TZmLE6b3=QAoTB1zQHi_Y97rHL-5wk5Pbpa_oj_w@mail.gmail.com>
	(Roberto Tyley's message of "Wed, 10 Dec 2014 14:18:24 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 58AA6046-8086-11E4-92D3-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261220>

Roberto Tyley <roberto.tyley@gmail.com> writes:

> The BFG is generally faster than filter-branch for 3 reasons:
>
> 1. No forking - everything stays in the JVM process
> 2. Embarrassingly parallel algorithm makes good use of multi-core machines
> 3. Memoization means no Git object (file or folder) is cleaned more than once
>
> In the case of your problem, only the first factor will be noticeably
> helpful. Unfortunately commits do need to be cleaned sequentially, as
> their hashes depend on the hashes of their parents, and filter-branch
> doesn't clean /commits/ more than once, the way it does with files or
> folders - so the last 2 reasons in the list won't be significant.

Just this part.  If your history is bushy, you should be able to
rewrite histories of merged branches in parallel up to the point
they are merged---rewriting of the merge commit of course has to
wait until all the branches have been rewritten, though.
