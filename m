From: Karthik R <karthikr@fastmail.fm>
Subject: Re: [PATCH][resend] git-svn: Respect GIT_SSH setting
Date: Mon, 17 Aug 2009 18:47:19 -0500
Message-ID: <4A89EC07.2010402@fastmail.fm>
References: <4A89E185.2010307@fastmail.fm> <7vzl9ykovh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 01:47:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdBvW-0001gj-GF
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 01:47:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbZHQXrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 19:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752730AbZHQXrU
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 19:47:20 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:51436 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752156AbZHQXrT (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 19:47:19 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id B2F2355A16;
	Mon, 17 Aug 2009 19:47:20 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Mon, 17 Aug 2009 19:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=LZ3xXp8Lix+fzcuCVXNZnNmkFRg=; b=sAU1TfSh9aOxrfyavTxVttwLTw2h5beSyJNJ4wi36M6zvp9oxvQFLOCYoU37G1eNWNWqXRuKoeGGxrLC7oNKe3QsvBUX5Forb08I5qwqSh+30j64nnG9Zfw/C0e4tIJ/4yf4fF4N1+c+GNI4Mh2dUO5zTd9k5dezVlpHy9AYn+8=
X-Sasl-enc: F9lp3CGS0o8TmQyvlk0izUovEGZmtYS+QgBUbl3FlKoJ 1250552840
Received: from [0.0.0.0] (99-156-81-160.lightspeed.austtx.sbcglobal.net [99.156.81.160])
	by www.fastmail.fm (Postfix) with ESMTPSA id 11974136CC;
	Mon, 17 Aug 2009 19:47:19 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.22 (Windows/20090605)
In-Reply-To: <7vzl9ykovh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126321>

Junio C Hamano wrote:
> Karthik R <karthikr@fastmail.fm> writes:
>
>   
>> +# If GIT_SSH is set, also set SVN_SSH...
>> +$ENV{SVN_SSH} = $ENV{GIT_SSH} if defined $ENV{GIT_SSH};
>> +# ... and escape \s in shell-variable on Windows
>> +if ($^O eq 'MSWin32' || $^O eq 'msys') {
>> +       $ENV{SVN_SSH} =~ s/\\/\\\\/g if defined $ENV{SVN_SSH};
>> +}
>> +
>>     
>
> Two questions.
>
>  - What if a user has SVN_SSH exported _and_ wants to use a different one
>    from the one s/he uses for git?  Naturally such a user would set both
>    environment variables and differently, but this seems to override the
>    value in SVN_SSH;
>   
Do you mean user wants to use a different one with "git svn ... 
svn+ssh://" (than the one with "git clone ssh://") ?
In this case
- defining SVN_SSH, but not GIT_SSH will still work (with this patch, 
GIT_SSH overrides)
- but SVN_SSH needs to have \\s.
So unless the user already knew of this quirk, we'll only see unescaped 
\s - so it *does* make sense to escape the \s (if the user knew, then 
too many escaped \s still work).
>  - Can a user have SVN_SSH exported, on MSWin32 or msys, and use svn
>    outside git?  If so, what does the value of SVN_SSH look like?  Does it
>    typically have necessary doubling of backslashes already?
>   
With subversion for Windows, these \\s are not needed (but doesn't cause 
any break). The doubling is something to do with the bash (in msys) I think.
> What I am getting at is, if the patch should look something like this
> instead:
>
> 	if (! exists $ENV{SVN_SSH}) {
> 		if (exists $ENV{GIT_SSH}) {
> 			$ENV{SVN_SSH} = $ENV{GIT_SSH};
> 			if ($^O eq 'MSWin32' || $^O eq 'msys') {
>                                $ENV{SVN_SSH} =~ s/\\/\\\\/g;
> 			}
> 		}
> 	}
>
>   
