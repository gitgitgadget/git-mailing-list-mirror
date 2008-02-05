From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH RESEND] Avoid a useless prefix lookup in strbuf_expand()
Date: Tue, 5 Feb 2008 14:17:26 +0100
Message-ID: <e5bfff550802050517o3f4f5f61n8ed6ab2bce57d25f@mail.gmail.com>
References: <1201950593-6119-1-git-send-email-mcostalba@gmail.com>
	 <7vtzknga5g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 14:18:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMNgZ-00054k-En
	for gcvg-git-2@gmane.org; Tue, 05 Feb 2008 14:18:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbYBENR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2008 08:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbYBENR3
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Feb 2008 08:17:29 -0500
Received: from wx-out-0506.google.com ([66.249.82.228]:40512 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbYBENR2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2008 08:17:28 -0500
Received: by wx-out-0506.google.com with SMTP id h31so2941084wxd.4
        for <git@vger.kernel.org>; Tue, 05 Feb 2008 05:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=LxrK4Ihruh7qt4nTyrGWiDzyguYh4LbdvBB64rFmDqY=;
        b=nJKCBLRYxOn//3YrTR5U1A6mtjIxZZa36CgPGjXMT/Ygzp5cez7SqXEHhedt3LTTjgnyAFy/XvdMaMJaFcGqBGI2U6aGkftdTnKP5hM8eBJOSWhIOSkGMJtI1OW12efUSRf/Y2hFvhBqQ0o/4htMajYE8GNJGE2ufLjQ58MzHf8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Js0E4V1Ab7KLLKSi/WB76CJ9cppelBwP/+2NWsT9Dg9yQBiAX+/J+dT7h2WR5/r+nQKGdJD8DD+5CYdzusSrOQyfB6o5qYNJzquzo2CCxNeqofAYdyWPEAH+4SJRvGM/5FjaSniVV5Vh3xr8+0jvvhGxwRbuNz7vKMt/Xrj7KTo=
Received: by 10.140.172.6 with SMTP id u6mr5621272rve.257.1202217446678;
        Tue, 05 Feb 2008 05:17:26 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Tue, 5 Feb 2008 05:17:26 -0800 (PST)
In-Reply-To: <7vtzknga5g.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72653>

On Feb 5, 2008 8:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Another thing I noticed is that --pretty='format:%an %ae %at'
> would end up running this function three times.  Perhaps it is
> worth memoizing the result in format_commit_context while you
> are at it?
>

Yes, I tought about this. But at the end I rejected this idea to keep
the code simple and because the optimization was in any case small
(and also in a special cases only).

I did some profiling with and without my patch and I noticed a nice
improvement so that with the patch applied git-rev-list and git-log
--pretty=format have almost the same execution times.

This is because the biggest time in both cases is spent in zlib
decompress, so also a local further speed up of  format_person_part()
does not gain anything but complicates the code.

Marco

P.S: I will try to adress your concerns on the naming of end_of_data
flag (hints are welcomed, I'm bad at naming) and on the skipping
further elaborations if end_of_data is true to have cleaner code, I
was thinking about using 'goto xxxx' or something like that.
