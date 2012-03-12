From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] git-am: error out when seeing -b/--binary
Date: Mon, 12 Mar 2012 17:22:27 -0500
Message-ID: <20120312222227.GC11362@burratino>
References: <20120312064855.GB16820@burratino>
 <20120312085820.GA11569@1wt.eu>
 <20120312152004.GB9380@kroah.com>
 <20120312152453.GB12405@1wt.eu>
 <87aa3l4vqq.fsf@thomas.inf.ethz.ch>
 <20120312165703.GB18791@burratino>
 <7vvcm9snko.fsf@alter.siamese.dyndns.org>
 <87399dpk48.fsf@thomas.inf.ethz.ch>
 <20120312215607.GB11362@burratino>
 <874ntto4t8.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Willy Tarreau <w@1wt.eu>,
	Greg KH <greg@kroah.com>, Ben Hutchings <ben@decadent.org.uk>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 12 23:22:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S7Ddd-0006LN-GD
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 23:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757756Ab2CLWWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 18:22:41 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53979 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757727Ab2CLWWi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 18:22:38 -0400
Received: by ghrr11 with SMTP id r11so3141116ghr.19
        for <multiple recipients>; Mon, 12 Mar 2012 15:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Fd1Gq247H9CaZO7g3Duc1pUyqWkTR7SExBYThkKfxnY=;
        b=Rgs3fkrrFydND6xxtXS67kyCc3fyLVcBILDlpDMz2rSh0EliHiccqH2MQNGoch7Um2
         zOWBhvtHxTS4KmezEg8h4PXWM5rL1n8jsj1faxGb71VnwoVMMhIMy/BoIt4eXsMjtl/0
         cn6fZE8vfLD4x8qsBoWkKiTR8nzRU0SlGBvXs6pcgvpzFaHnGcJwV1LnAOCJ8NPtL4x4
         cBoEqxfjAzhijwccCB9H6Xe37CdnBThSL3siAKtRLPJCovN0lVMkThWVW8wSWdMsvGdj
         SVVJn0x9ZPRUUJ37g9F6Gd0x4ObSa7qQezbYt+0SF58p4ziEUDwdItmx5ibzK/2d+sI0
         pPFw==
Received: by 10.182.37.99 with SMTP id x3mr9675765obj.31.1331590957828;
        Mon, 12 Mar 2012 15:22:37 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id q9sm22587776obz.14.2012.03.12.15.22.36
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Mar 2012 15:22:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <874ntto4t8.fsf@thomas.inf.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192962>

Thomas Rast wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Hm, on second thought, if people are seeing this message, I would
>> prefer if they write to the mailing list so we can find out about it.
>> So I really would rather see this say
>>
>> 	--binary)
>> 		: ;;
>>
>> and have "-b" completely unrecognized, without any words in our
>> defense except for a note in the release notes mentioning the option's
>> removal and that it has been an unadvertised backward-compatibility
>> no-op since 1.6.0.
>
> I'd hate doing that, mostly because other projects got me really angry
> about similar issues, e.g., 71c020c (Disable asciidoc 8.4.1+ semantics
> for `{plus}` and friends, 2009-07-25).

Oh, now that I think about it that way, you're definitely right.

So, how about something like this?

	--binary)
		: ;;
	-b)
		gettextln >&2 "The -b option (a no-op short for --binary) was removed in 1.7.10."
		die "$(gettext "Please adjust your scripts.")"
		;;

Mentioning deprecation in 1.6.0 in the message left me uneasy because
we never actually did anything to actively deprecate the option; it
just has not been needed since 1.4.3 and we stopped advertising it in
the manpage in 1.6.0.  So I don't like the implication of "this is all
right because we told you so" --- on the contrary, it is "in practice
nobody seems to be using this option and we hope nobody will notice
when we take it away".

Jonathan
