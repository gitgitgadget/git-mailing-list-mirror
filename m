From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-svn.perl: perform deletions before anything else
Date: Thu, 09 Feb 2012 12:08:57 -0800
Message-ID: <7vzkcrvkfa.fsf@alter.siamese.dyndns.org>
References: <1328813725-16638-1-git-send-email-stevenrwalter@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: normalperson@yhbt.net, git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 21:09:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvaIk-0003Y1-K3
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 21:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757501Ab2BIUJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 15:09:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37177 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757235Ab2BIUJA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 15:09:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B58D56A42;
	Thu,  9 Feb 2012 15:08:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ho5durM2mFHpjckLf4HExhEiQyI=; b=ZXBsSk
	kfBfjELEaRUd7vHSVjkSWIROjr1KiCvlGhBlFY8AXRL0ngczvmPF+VMJUhD+8WdZ
	RtttHsTLVL82DkccdyUG5U7m4k+DFk4Y92K48Lpvygsc7MAhJN92ymPmPbmrWgse
	L2FBiG75vNvBqr2iyNCYb+NX0023+vVdDTfYs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V/ofo9CA+x0ScGOKxUJtepExLLtyTtBE
	ZZf6bPhbxlYwzPmy9V2zcuXH9ANFh5oWuVbOAa4fgT6m905cGB5O69Dnx3kAV6GM
	pdiGX4dG4xFBnLmUtVZGqwBocHsKiqoDyClbEV4F5Yug7Q85B7CU6lXSevdCifNR
	8Bg77by9BvQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC4BD6A41;
	Thu,  9 Feb 2012 15:08:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E50B6A40; Thu,  9 Feb 2012
 15:08:59 -0500 (EST)
In-Reply-To: <1328813725-16638-1-git-send-email-stevenrwalter@gmail.com>
 (Steven Walter's message of "Thu, 9 Feb 2012 13:55:24 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7202930-5359-11E1-AC40-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190316>

Steven Walter <stevenrwalter@gmail.com> writes:

> -	my %o = ( D => 1, R => 0, C => -1, A => 3, M => 3, T => 3 );
> +	my %o = ( D => -2, R => 0, C => -1, A => 3, M => 3, T => 3 );

I know this code arrangement dates back to cf52b8f (git-svn: fix several
corner-case and rare bugs with 'commit', 2006-02-20), but somehow I find
it extremely hard to follow.  The absolute values do not matter (this is
only used to sort the classes of operations), and the fact that A/M/T
shares the same value does not help a stable sort result (as it is used as
a key to sort {} that is not given any key other than $o{$ab->{chg}} to
tie-break).  I suspect that writing it this way

	my %o = (D => 0, C => 1, R => 2, A => 3, M => 4, T => 5)

or even

	my $ord = 0;
	my %o = map { $_ => $ord++ } qw(D C R A M T);

would make it much easier to follow.
