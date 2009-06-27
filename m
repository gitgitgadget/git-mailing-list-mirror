From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCHv3 2/2] read-tree: migrate to parse-options
Date: Fri, 26 Jun 2009 19:00:17 -0700
Message-ID: <4A457D31.9030407@gmail.com>
References: <1245817672-25483-1-git-send-email-bebarino@gmail.com>	<1245993250-8213-1-git-send-email-bebarino@gmail.com>	<1245993250-8213-2-git-send-email-bebarino@gmail.com>	<4A445CB0.4010506@gmail.com> <7vab3uucxi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 04:00:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKNDS-0005ay-8l
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 04:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755026AbZF0CAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 22:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754436AbZF0CAT
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 22:00:19 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:37776 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961AbZF0CAS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 22:00:18 -0400
Received: by rv-out-0506.google.com with SMTP id f6so728602rvb.1
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 19:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Z6QmsuzVPVpPzRh+aLOJfhkGTGZ4AOoYpXR+x+6tct0=;
        b=WmhdioBqTr/fYILl2RZXFGkXrkOAd5CkkiZel2r0vL6VVlrDFTsNvuXsmj4SSUGWEq
         R+qFtfhwuPFM5wO/ra/Z0f8FfqqPrc46+JoRnejrbaj4z5jSTveIgsBY6YoF1z+z5En/
         hnDEnyp1Zl1J1LUfp6bpXwrRZobUpidqz+Hlo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=u411+P7HJ9+hY/vwM8vl8Bgu7VBiB16eb0AvMi1NLIgBsSuA7Y23b5iltgbdVHGsAT
         SG5hLbpJLYyzIA9bOwz3YqWpwBv4j0fHGxFzEXeQf0bgGOhwcjys9uz0AbfXMHg31Ijx
         4z1C9HbxZQouBSrtVUtBxSXSDADIatUY9VWL0=
Received: by 10.140.247.11 with SMTP id u11mr2752755rvh.102.1246068020065;
        Fri, 26 Jun 2009 19:00:20 -0700 (PDT)
Received: from ?10.10.0.5? (cpe-66-75-25-79.san.res.rr.com [66.75.25.79])
        by mx.google.com with ESMTPS id k37sm17195339rvb.28.2009.06.26.19.00.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Jun 2009 19:00:19 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <7vab3uucxi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122348>

Junio C Hamano wrote:
>
> Let's look at this (not this follow-up patch) the other way around.
>
> Six months down the load, somebody may ask you:
>
>     Is there a good reason why many are not bitfields but only selected
>     few are bitfields in this structure?  Most of these can and should be
>     bitfields, as far as I can see, because the code uses them as
>     booleans, and the only breakage it may cause if we change them to
>     bitfields to shrink this structure would be the option parsing code.
>
> What would be your answer?  Doesn't it feel wrong to do such a conversion
> only to work around the current limitation of parseopt?

I understand. It does feel wrong to do this just to workaround
parseopts, but I was assuming this wasn't a performance critical struct
because Hannes said it wasn't set in stone. Of course, it also feels
wrong to have the foo ? 1 : 0, but I think it's less wrong. This is why
I had the foo ? 1 : 0 constructs in v2, because I felt that making this
more radical change would lead to just this question. As a bonus, having
these ugly constructs encourages someone to come up with a way to handle
bit fields in parseopts.

>
> By the way, has it been verified that all the users of these fields are OK
> with this change when they use these fields?  I am not worried about them
> reading the value command line option parser set, but more worried about
> reading after other codepaths set/modified these fields.  The command line
> parser that uses parseopt may correctly set only 0 or 1 to these fields
> initially and we should be able to verify that from the patch text, but
> there is no guarantee that this conversion is even correct at runtime
> without an audit, no?
>
> The callers have long relied on the fact that reading from these bitfields
> yields either 0 or 1 and never 2 or larger, but they are now widened to
> full-width unsigned.  A pattern like this:
>
> 	uto.field = ~uto.field;
>         if (uto.field == 1) {
>         	field now set;
> 	} else {
>         	field now unset;
> 	}
>
> would be broken by widening "unsigned field:1" to "unsigned field", right?
> I am not saying this is the only pattern that would break, nor I know
> there are codepaths that use this pattern, but I think you got my point.

Yes. I glanced over the users of unpack_trees_options and didn't see
anything dangerous like the above example. It wasn't a really thorough
audit though because I was hoping that the callers were treating them as
booleans, and not bits.
