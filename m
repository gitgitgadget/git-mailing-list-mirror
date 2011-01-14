From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Applying .gitattributes text/eol changes
Date: Fri, 14 Jan 2011 09:31:15 +0100
Message-ID: <4D3009D3.3050403@drmicha.warpmail.net>
References: <4D220500.2000104@syntevo.com> <4D2C4902.4010705@drmicha.warpmail.net> <4D2C62DF.20706@syntevo.com> <4D2EFCBD.4020402@drmicha.warpmail.net> <4D2F0BF3.2000808@syntevo.com> <4D2F0E3A.8090108@drmicha.warpmail.net> <4D2F12EE.4020400@syntevo.com> <7vd3o01iw9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marc Strapetz <marc.strapetz@syntevo.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 14 09:34:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pdf6l-0005Qj-8h
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 09:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764Ab1ANId6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 03:33:58 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54977 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751341Ab1ANId4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jan 2011 03:33:56 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 77CF02079C;
	Fri, 14 Jan 2011 03:33:55 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 14 Jan 2011 03:33:55 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=rOHYqvMacHs65bNauaq1ySbUSqI=; b=rYaDGElOQQ/K9yw+kemuF1QFIXghMmhB1N3Max8hOpwDkoUkgs/Z6FRRixvTbc4qkTRm00JgkH7yECVKiPBrLQK9JIlOXeOIhbtETx2rw3YTcXdEyklfhbOyYReazM1lGlJx5zs7UtHBmpYBQaitVXYPnrKzuPw+RpEfRAQuHSI=
X-Sasl-enc: oPT3dvWPARB/UKE2iHi04SB7FHPwO2n/Bm94EC2uIXsV 1294994035
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id A1027407766;
	Fri, 14 Jan 2011 03:33:54 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <7vd3o01iw9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165079>

Junio C Hamano venit, vidit, dixit 14.01.2011 00:30:
> Marc Strapetz <marc.strapetz@syntevo.com> writes:
> 
>> So your suggestion is to fix "git update-index --really-refresh", so
> 
> The option is about telling git: "Earlier I promised I wouldn't touch
> these paths by setting their assume-unchanged bit, but I touched them.
> Please refresh the cached stat information in the index, ignoring the
> promise I didn't keep."
> 
> I do not think it is a good idea to conflate your "Everything is suspect
> because smudge filter has changed; please recompute all" request into the
> same option.  People who use assume-unchanged would probably want "Please
> rescan because I changed smudge filter" request to be carried out while
> still honoring the assume-unchanged bit they set earlier.

What I meant was to introduce a new option --refresh-stat or something.
We have solved the "stale stat info problem" (changed dev nums after
reboot) in a different way meanwhile, but I think there was a different
case (can't come up with the thread right now) where something like this
could have helped.

> 
>> Anyway, I'm still wondering if it will resolve the "git reset --hard"
>> problem of re-checking out every file, even if content is already
>> identical in the working tree. I think that part has to be fixed, too.
> 
> There is not much to fix there. If you removed the index, then there is no
> information to tell you that "content is already identical" unless you
> actually check things out and compare.  By the time you found it out, you
> already have done the checkout.
> 
> IOW, the current code does:
> 
> 	open object
>         read from the object
>         deflate and write to the destination file
> 
> while your "fix" needs to look like this:
> 
> 	open object
>         read from the object
>         deflate and write to a temporary file
>         open the existing file
>         read from the file and compare it to the temporary we just wrote
>         if same, delete, otherwise rename the temporary file.
> 
> just for the rare case where there is an untracked file that the user is
> willing to overwrite (we are discussing "rm .git/index && reset --hard"
> here) happens to have the same contents.  Not a good enough reason to add
> unwelcome complexity to the codepath.
> 
>> What do you think about "git checkout --fix-eols" option as an
>> alternative? Its uses cases are more limited, though.
> 
> What does it do?  "git checkout --fix-eols $path" will overwrite $path
> with the data at $path in the index?  Perhaps you can use the "-f" option.
> 
> Adding an option to "checkout" might be better than update-index from the
> UI point of view, but the issue is not just "eols".  "eol" is a mere
> special case of smudge filter that controls how the contents from the
> repository are modified before getting written out to the working tree.

Exactly, this is a more general issue. The typical answer to these
issues is that you change attributes and filters only occasionally, so
the cost of a rm .git/index && git reset --hard is irrelevant. But still
there should be a less scary way of (really) refreshing the index. Also
note that the cost of the command itself is only a part of the picture -
in the OP's case (which is a bit convoluted, of course) "cost" is really
command execution + the cost of the consequences (rebuilding triggered
by unnecessary touches). For the typical use cases, the existing options
and command paths do the perfectly sane and efficient thing.

Michael
