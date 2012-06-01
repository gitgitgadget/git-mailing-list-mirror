From: Travis <git@castle.fastmail.fm>
Subject: Re: How to handle terminal detection in a daemon calling git?
Date: Fri, 1 Jun 2012 08:52:04 -0500
Message-ID: <827737B4-F5EE-4FD3-9B1A-710047836080@castle.fastmail.fm>
References: <1338412607.9452.140661082904349.02F677C3@webmail.messagingengine.com> <20120531012908.GD5488@sigill.intra.peff.net> <7vaa0o98e5.fsf@alter.siamese.dyndns.org> <1338471582.12573.140661083191693.32060E78@webmail.messagingengine.com> <20120601095333.GF32340@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 01 15:52:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaSH3-0006ou-3v
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 15:52:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759941Ab2FANwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 09:52:10 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:57098 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759898Ab2FANwI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jun 2012 09:52:08 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id E0CD720CD8;
	Fri,  1 Jun 2012 09:52:06 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 01 Jun 2012 09:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:message-id:from:to:in-reply-to
	:content-type:content-transfer-encoding:mime-version:subject
	:date:references; s=smtpout; bh=Bf31NmUudhH6CLDsJ9UoJgi1ovc=; b=
	td6sNVVB5Cr1dZhIsvO14x7eGyUnE3hjwmur5+/sywFYlrEiRs1b774cWWfcCxha
	W4mv4MGn2OaGlAUDH8lKl8utCRBA62otSeUt/ZJjw8tdrycR/zsMXEla1f+f0+fA
	Mi7UQEADgumLV5CiQsRrhNOrp0h/gxasMkjqOuI9+qM=
X-Sasl-enc: d/EPtF85RCNt0P+Cn+yqYEdmpWVIfi2yovm6qphGTQK6 1338558726
Received: from ziphdeux.austin.ibm.com (unknown [32.97.110.51])
	by mail.messagingengine.com (Postfix) with ESMTPA id 4B1A5483533;
	Fri,  1 Jun 2012 09:52:06 -0400 (EDT)
In-Reply-To: <20120601095333.GF32340@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198988>


On Jun 1, 2012, at 4:53 AM, Jeff King wrote:

> On Thu, May 31, 2012 at 08:39:42AM -0500, Travis P wrote:
>
>> Here's what I learned this morning: it appears to work when I don't
>> close STDIN.
>>
>>    #close $_ for *STDIN, *STDOUT, *STDERR; # What I was doing. Fails.
>>    close $_ for *STDOUT, *STDERR;  # Tried this, it works.
>>    *STDOUT = $log_fh;
>>    *STDERR = $log_fh;
>
> Yeah, don't do that.  This can cause subtle bugs in subprocesses. For
> example:
>
>  1. You don't have a descriptor 0, because it is closed.
>
>  2. Some part of the program opens a new descriptor (e.g., to read a
>     file, making a pipe, etc). This becomes descriptor 0, because it  
> is
>     the lowest unused descriptor.
>
>  3. The program wants to redirect its stdin (e.g., because it is
>     forking and exec'ing a child). So it calls dup2(fd, 0), closing
>     what was at stdin previously, which might have been valuable.
>
> The right thing to do is to redirect stdin from /dev/null, not close  
> it
> entirely.

Ah, yes, that's a normal thing I would think about in C.  In Perl,
I imagined that those details were handled by Perl.

With that in mind, I'm still seeing strange behavior when I do this,
where it looks to me like I'm closing and then immediately assigning
STDIN:

  my $null_in_fh;
  open($null_in_fh, '<', '/dev/null') or die;
  close *STDIN;  # this appears to mess things up, even with the  
following assignment
  *STDIN = $null_in_fh;

But if I don't do the close STDIN (with or without the glob), then  
things work.
Maybe that assignment doesn't work for some Perl-ish reason.

Because, if I just do this
   open(STDIN, '<', '/dev/null') or die;
even after the close and/or assignment, then all appears okay.

I'll stick with this last technique and just chalk it up to something
to something about Perl I don't understand.  (I had the idea that
maybe I wanted to redirect /dev/null to STDIN at some point anyway.)

Thanks for your comments.

-Travis
