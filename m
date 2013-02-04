From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Segmentation fault with latest git (070c57df)
Date: Mon, 04 Feb 2013 01:16:08 -0800
Message-ID: <7vsj5c4exz.fsf@alter.siamese.dyndns.org>
References: <12070540.431901359961105650.JavaMail.weblogic@epml10>
 <7vehgw5z7n.fsf@alter.siamese.dyndns.org>
 <20130204083701.GA30835@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jongman.heo@samsung.com, Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 04 10:16:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2IAJ-0002I1-Mc
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 10:16:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754258Ab3BDJQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 04:16:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54866 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753963Ab3BDJQM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 04:16:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3AA91B468;
	Mon,  4 Feb 2013 04:16:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iavVZszRKn6CeJ9VCSjmx0h6R6s=; b=mTIdXI
	oJA5K1lBDwR85wF95+nP59CXfkba5nMp+uq83UuXz48qbvSlPPJyPOmdRrmrjgsw
	YnSt39xEDy90KNPszLloxSMkOUFzuuK0ya+mJaHxODVux9QIOpvY1ZkJ46gFWxCA
	IWj/uJFwXrh4OIN48iIt5Y1jfmQ7zTLJ0n9AQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GX7tvSKta+d6CyAUm0ucNhRiQU9Db9gq
	waah+hjNycMgoNTKP+iaUqXFGNIXlz64HufI2DsqTMx9DBFPqSTTN2ynJxDFMyYL
	v3wU5b5/UBUMNVgdfPRaztRdH4wXczlaNWjZ6Loeh1P9TZdDZg9RERbqOpfwxa1K
	ZtUOOGNViXs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FB74B465;
	Mon,  4 Feb 2013 04:16:11 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8A0E7B464; Mon,  4 Feb 2013
 04:16:09 -0500 (EST)
In-Reply-To: <20130204083701.GA30835@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 4 Feb 2013 03:37:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 834B289C-6EAB-11E2-8133-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215370>

Jeff King <peff@peff.net> writes:

> Do we want to do anything with the other dependency hole I found here:
>
>   http://article.gmane.org/gmane.comp.version-control.git/215211
>
> It's definitely a potential problem, but I don't think we have any
> reports of it happening in practice, so it might not be worth worrying
> about. Doing a clean version of the fix here:
>
>   http://article.gmane.org/gmane.comp.version-control.git/215212
>
> would probably involve reorganizing our .depend directory structure,
> unless somebody can cook up some clever use of make's patsubst.

As I understand how the current set-up works:

 * Initially, we do not have foo.o but foo.c.  We automatically
   build foo.o because it depends on foo.c via the "%.o : %.c" rule,
   and as a side effect, we also build .depend/foo.o.d file;

 * Then, if any real dependency used to build the existing foo.o
   that is recorded in .depend/foo.o.d file changes, foo.o gets
   rebuilt, which would update .depend/foo.o.d again for the next
   invocation.

The case where you lose .depend/foo.o.d is a special case of getting
a wrong information in .depend/foo.o.d, which may happen by using a
broken compiler during the initial build, or going over quota and
getting .depend/foo.o.d truncated, or by other breakages.  The user
may have done "rm -rf .depend" to lose it, or the user may have done
something like this to munge it:

	find -name '.git' -type d -prune -o -print0 |
        xargs -0 sed -i -e 's/foo/bar/g'

forgetting that just like .git, .depend is precious and should not
be touched.

I think this really boils down to where we draw the "this is good
enough" line.  I am not sure if losing the file as in $gmane/215211
is common enough to be special cased to buy us much, while leaving
other ".depend/foo.o.d was updated to contain a wrong info" cases
still broken.

And of course the case where .depend/foo.o.d is munged by mistake
cannot be solved without recompiling everything all the time, so...
