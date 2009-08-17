From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "make quick-install-man" broke recently
Date: Mon, 17 Aug 2009 10:09:10 -0700
Message-ID: <7vhbw6weo9.fsf@alter.siamese.dyndns.org>
References: <86my5z8cjd.fsf@blue.stonehenge.com>
 <7vy6pj449g.fsf@alter.siamese.dyndns.org>
 <86iqgn8brv.fsf@blue.stonehenge.com>
 <7vd46v3tp1.fsf@alter.siamese.dyndns.org>
 <8c9a060908162258ua50e34ah53c1ada9dbcd4aa0@mail.gmail.com>
 <7vhbw72ap3.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.01.0908170932390.3162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Helwig <jacob.helwig@gmail.com>,
	Kjetil Barvik <barvik@broadpark.no>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Aug 17 19:09:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md5iA-0005P5-S4
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 19:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757021AbZHQRJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 13:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756918AbZHQRJV
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 13:09:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:34921 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756455AbZHQRJV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 13:09:21 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7C0CE2D3A3;
	Mon, 17 Aug 2009 13:09:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3452E2D3A2; Mon, 17 Aug 2009
 13:09:11 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.01.0908170932390.3162@localhost.localdomain>
 (Linus Torvalds's message of "Mon\, 17 Aug 2009 09\:34\:23 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B435B69E-8B50-11DE-922C-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126235>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Grr. Now 'check_path()' is no longer something generically useful.
>
> Could you perhaps instead only change 'checkout_entry()' to do this hack, 
> and leave 'check_path()' as a generic replacement for "lstat()" that 
> doesn't follow symlinks?

Given that non-empty base_dir is only used for "checkout-index --prefix",
iow, the "path" internally used by git and fed to our symlink.c cache are
supposed to be always relative to the work tree, I think that may be a
good thing to do in the short-term.

But only if we won't add any more like "checkout-index --prefix".  If you
want to implement "git checkout --prefix=over-there/" and if you want to
call check_path() directly (iow not as a part of callchain from
checkout_entry()) while doing so, for example, you would regret keeping
the check_path() function unaware of base_dir, as you would reintroduce
the same bug.

I thought about getting rid of base_dir from struct checkout by running
create_directories() in checkout-index and chdir(2) there, because this is
a very special case codepath anyway.  I actually haven't tried it, but it
probably will have bad interactions with the way we find $GIT_DIR.
