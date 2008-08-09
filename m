From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach git log --check to return an appropriate error code
Date: Sat, 09 Aug 2008 12:29:06 -0700
Message-ID: <7v8wv66l8d.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0808081315060.9611@pacific.mpi-cbg.de.mpi-cbg.de>
 <1218265054-19220-1-git-send-email-4ux6as402@sneakemail.com>
 <alpine.DEB.1.00.0808091404230.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Valdemar =?utf-8?Q?M=C3=B8rch?= <4ux6as402@sneakemail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 09 21:31:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRu9Z-0001kS-BR
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 21:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbYHIT3P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Aug 2008 15:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbYHIT3P
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 15:29:15 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48677 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbYHIT3P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Aug 2008 15:29:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 39E3E525DE;
	Sat,  9 Aug 2008 15:29:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 42078525DC; Sat,  9 Aug 2008 15:29:09 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0808091404230.24820@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Sat, 9 Aug 2008 14:05:01 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 729905E2-6649-11DD-A400-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91776>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 9 Aug 2008, Peter Valdemar M=C3=B8rch wrote:
>
>> 	Whether or not a check fails is stored in the
>> 	DIFF_OPT_CHECK_FAILED field of flags in struct diff_options.
>> 	This flag-field is only set (diff.c:1644), never cleared.
>
> That is a side effect.  How wise is it to rely on that?

Hmm, good point.

The bit will never be cleared during a single diff run by design, becau=
se
it needs to be cumulative in order to check a patch that describes chan=
ges
to multiple paths --- iow, the API sequence is (1) the caller to the di=
ff
machinery resets the bit to zero and then (2) the caller exercises the
diff machinery and expects the machinery to set the bit if even a singl=
e
failure is detected, or leaves it unset if there is none.

So unless you (log_tree_diff(), the caller of diff machinery), decide t=
o
explicitly reset the bit (or decide to use a freshly allocated and
initialized diff_options for each commit it feeds diff_tree_sha1()), th=
e
assumption would hold.  We need to see how plausible it would be for us=
 to
break that assumption in the future.

=46uture versions of log_tree_diff() may want to tweak opt->diffopt per
commit, when we have options for "use larger -U<lines> value after hitt=
ing
this commit", or "use this pathspec to limit the diff output after hitt=
ing
this commit", for example.  But even in these cases, I think it is
implausible to start from a freshly initialized diff_options structure.
The code most likely would start from the copy of what was in use and
update only the necessary fields, without disturbing the state variable=
s.

So I think you are worried a bit too much in this case, even though it =
is
a valid concern in principle.  It might warrant a comment somewhere ins=
ide
log_tree_diff() to tell people not to re-initialize opt->diffopt per
commit without thinking, though.

One interesting option that might be interesting to add to the log fami=
ly
would be to show only commits that fail the checkdiff tests.  I suspect
necessary change for doing so would go to log_tree_diff() codepath.
