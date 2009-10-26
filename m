From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 2/2] completion: allow use without compiling
Date: Mon, 26 Oct 2009 16:59:18 -0700
Message-ID: <7vocntd7vt.fsf@alter.siamese.dyndns.org>
References: <1256589116-6998-1-git-send-email-bebarino@gmail.com>
 <1256589116-6998-3-git-send-email-bebarino@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Clemens Buchacher <drizzd@aon.at>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 00:59:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2ZTS-0007bz-0k
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 00:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755207AbZJZX7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2009 19:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755140AbZJZX7a
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Oct 2009 19:59:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59309 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754784AbZJZX7a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2009 19:59:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5485D688CA;
	Mon, 26 Oct 2009 19:59:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=/cEz9I4rLD+M//B4/Wc6V6tPmUY=; b=EcvNB4i1OYF2uO8TCp0L3su
	yruoSetAgjSOyrWv2wkz4o6BZxA3qw1AsvDK4FRaRF6dM/VtgfaGpl+1Z9UyYpwD
	k0+Ua2/vGHHiOMZSCFzrPN1ANL8BUkxQSH9W/B80KddM2c9Ka+7xMo8crfoepkpd
	gpdCFBpQlZcVmUj+RzYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=lndpGLqxdgcSx3vVPksqMe1Pygj3ekWRhlFs8CQeHVgMQNWDj
	o9tdKT94Mj+CD2wMlFp+IYO+q3QBkEvX2tEo6mYXZPoQEBetQ2DJP/dKZXb1XHkq
	TNvWlBQLbFjbNyZNLboKWZ6J7QSmSpURERsIj3FzG/JAk15MzIGJnCMJ7w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BC72688C1;
	Mon, 26 Oct 2009 19:59:28 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5DC7F688BC; Mon, 26 Oct
 2009 19:59:19 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 985CD7D2-C28B-11DE-908A-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131287>

Stephen Boyd <bebarino@gmail.com> writes:

> Some users don't want to compile their completion, even when the build
> generated completion is 10x faster to load. For example, in my bashrc I
> source the completion script directly so I can stay up to date with the
> latest completion by merely pulling changes.
>
> Do this by generating the lists dynamically when the merge strategy and
> command lists still have their initial values (__GIT_MERGE_STRATEGYLIST,
> __GIT_ALL_COMMANDLIST).
>
> Signed-off-by: Stephen Boyd <bebarino@gmail.com>
> ---
>
>  This duplicates code, but I don't know of a way to re-use the dynamic
>  code without sourcing a bash script and possibly breaking someone's build.

If we are going to do this, wouldn't it make more sense to revert the
rename of the script, so that people can keep relying on the name of the
script being "git-completion.bash", _but_ make it produce a pre-compiled
form to a separate file when invoked in some particular way?

Then at the runtime:

 (0) If the script notices that it has already learned the command list
     it uses it; otherwise,

 (1) If the script notices that there is a file that contains the command
     list, it sources it; otherwise,

 (2) The script lazily builds the command list for its own use.

And at the buildtime, Makefile can run the script in "generation mode",
and install the output to where (1) above expects to see.
