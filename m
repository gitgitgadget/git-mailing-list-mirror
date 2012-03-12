From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: reallocate the postimage buffer when needed
Date: Sun, 11 Mar 2012 23:23:47 -0700
Message-ID: <7v1uoyuyks.fsf@alter.siamese.dyndns.org>
References: <1331475857-15169-1-git-send-email-cmn@elego.de>
 <7v8vj7x9jr.fsf@alter.siamese.dyndns.org>
 <7vipiax3il.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Chris Webb <chris@arachsys.com>, git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Mon Mar 12 07:23:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6yfj-0000AQ-Gq
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 07:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291Ab2CLGXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 02:23:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38133 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019Ab2CLGXu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 02:23:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F0FB3D48;
	Mon, 12 Mar 2012 02:23:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dOtyuJCmcVTphuxhATa0izWOgD0=; b=I1FIpD
	r8PZ5hi2aMDOx2jlHjrwSna1ypFWFOg1mBZQhXrvQ7rF0JkhmL9KTbWfZAuFYHQg
	mpz0ZbMRlKA8f3hz28kpkdHtsTzJgQnD+UxHgijA8S+G/mRF5at8gPHac9ldVTt9
	ybQ/tL3lZYDhDfiInLlmojskF1l4nbp0cIPZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lXy6bzpwfZ4+BlTUZwjjE+ddoOmDUvpR
	P2KoatR1eEG7WX1gvUQCoJx2t8TKfp5b23lo3bE+CtaECQCIV/+NSjQS5r9ifRxE
	p4ZRJ18BQcNYlmcQWvHVeWt6TAhPiDc3IexT0B69ixGrZPd7P/KlyHlm8etS6sQP
	PUt0x3d1DlI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 563273D45;
	Mon, 12 Mar 2012 02:23:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BD4113D44; Mon, 12 Mar 2012
 02:23:48 -0400 (EDT)
In-Reply-To: <7vipiax3il.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 11 Mar 2012 13:54:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EDCC72FA-6C0B-11E1-823D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192842>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> ...
> But fixed_buf and fixed_len may be longer than the original length
> of preimage buffer when "indent must be spaces" is in effect, and
> that would mean context lines in the postimage may have to also
> grow. The call to update_pre_post_images() must be telling how big
> the postimage with fixed context lines will be, not passing 0 to say
> "I know it will not grow", because that is no longer true these
> days.

Just in case you haven't noticed it on your machine, t4105 shows
that this patch breaks "git apply".

...
ok 5 - big offset

expecting success: 
		git checkout-index -f -q -u file &&
		git apply -C2 F0.diff &&
		test_cmp expect file
	
Context reduced to (2/2) to apply fragment at 6
*** glibc detected *** /git.git/git: free(): invalid pointer: 0x00000000020c09e2 ***
...
./test-lib.sh: line 492: 10555 Aborted                 git apply -C2 F0.diff
not ok - 6 fuzz with no offset
#	
#			git checkout-index -f -q -u file &&
#			git apply -C2 F0.diff &&
#			test_cmp expect file
#		

With --valgrind the same test dies like so:

==18735== Invalid free() / delete / delete[]
==18735==    at 0x4C240FD: free (vg_replace_malloc.c:366)
==18735==    by 0x40918A: apply_data (apply.c:2692)
==18735==    by 0x40A1C2: check_patch (apply.c:3163)
==18735==    by 0x40C9A4: apply_patch (apply.c:3178)
==18735==    by 0x40D9A1: cmd_apply (apply.c:3959)
==18735==    by 0x404DD6: handle_internal_command (git.c:308)
==18735==    by 0x404FFC: main (git.c:513)
==18735==  Address 0x55c7c62 is 2 bytes inside a block of size 52 alloc'd
==18735==    at 0x4C244E8: malloc (vg_replace_malloc.c:236)
==18735==    by 0x4C24562: realloc (vg_replace_malloc.c:525)
==18735==    by 0x4E19AD: xrealloc (wrapper.c:82)
==18735==    by 0x4CFD7A: strbuf_grow (strbuf.c:72)
==18735==    by 0x4082B6: apply_data (apply.c:2470)
==18735==    by 0x40A1C2: check_patch (apply.c:3163)
==18735==    by 0x40C9A4: apply_patch (apply.c:3178)
==18735==    by 0x40D9A1: cmd_apply (apply.c:3959)
==18735==    by 0x404DD6: handle_internal_command (git.c:308)
==18735==    by 0x404FFC: main (git.c:513)


where "apply_data (apply.c:2692)" refers to 

	free(postimage.buf);
