From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH v3 1/2] Git.pm: add new temp_is_locked function
Date: Thu, 18 Jul 2013 12:14:47 -0700
Message-ID: <842D3E63-9E6B-45F0-A7F6-03082C4D067F@gmail.com>
References: <1373170849-9150-1-git-send-email-mackyle@gmail.com> <1373170849-9150-2-git-send-email-mackyle@gmail.com> <loom.20130718T202918-857@post.gmane.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Rothenberger <daveroth@acm.org>
X-From: git-owner@vger.kernel.org Thu Jul 18 21:15:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UztfQ-0001ej-Gf
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 21:15:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933317Ab3GRTOw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 15:14:52 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:34078 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933119Ab3GRTOv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 15:14:51 -0400
Received: by mail-pd0-f179.google.com with SMTP id q10so3416531pdj.24
        for <git@vger.kernel.org>; Thu, 18 Jul 2013 12:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mauler;
        bh=bachNru1Ng1plzQuvmCWyRHec62/yKGY+5FMkyUiMdE=;
        b=ET3lrTBXm+sZbjShzmsPGm1TCTwJKRze1K3IkC7TJLPPIuM06phUgCbXVgSG1YDXzP
         cgGs9dkB4/cFESd59uM760dZ10k5F/j8/en9YhzzxZY/K80TN+apvTsk2IAk3JSqbMsy
         U49ODRsavEOO5pLhKwz3+x0omYH69gAsbFxhN23xwyog5h2lqP1ClddI4+A3aZ0Da5fo
         kAoiq2xXM4dOOEmMLufnEoPXR0Eb8Lu3HSN9nSxPGAqVbV5HDTkJj481EDc4s8Uo6qnH
         5e3HoSrLMjPsJV8droyhPIAO2lN3Xck/UiVp0PCg1dR6hK0Hgdg1UECHuomLl+havzYA
         uFhw==
X-Received: by 10.68.164.33 with SMTP id yn1mr13567945pbb.102.1374174890470;
        Thu, 18 Jul 2013 12:14:50 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id eg3sm18259252pac.1.2013.07.18.12.14.48
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jul 2013 12:14:49 -0700 (PDT)
In-Reply-To: <loom.20130718T202918-857@post.gmane.org>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230724>

On Jul 18, 2013, at 11:34, David Rothenberger wrote:
> Kyle J. McKay <mackyle <at> gmail.com> writes:
>
>> +sub temp_is_locked {
>> +	my ($self, $name) = _maybe_self( <at> _);
>> +	my $temp_fd = \$TEMP_FILEMAP{$name};
>> +
>> +	defined $$temp_fd && $$temp_fd->opened && $TEMP_FILES{$$temp_fd} 
>> {locked};
>> +}
>> +
>> =item temp_release ( NAME )
>>
>> =item temp_release ( FILEHANDLE )
>> <at>  <at>  -1248,7 +1277,7  <at>  <at>  sub _temp_cache {
>>
>> 	my $temp_fd = \$TEMP_FILEMAP{$name};
>> 	if (defined $$temp_fd and $$temp_fd->opened) {
>> -		if ($TEMP_FILES{$$temp_fd}{locked}) {
>> +		if (temp_is_locked($name)) {
>> 			throw Error::Simple("Temp file with moniker '" .
>> 				$name . "' already in use");
>> 		}
>
> There's a problem with this use of temp_is_locked. There is an else
> clause right after this:
>
> 	} else {
> 		if (defined $$temp_fd) {
> 			# then we're here because of a closed handle.
>
> Prior to the patch, the comment is correct, but after the patch, the
> if block may also be entered if the file is open but locked. This is
> because temp_is_locked checks that the temp file is defined, open,
> and locked.
>
> This issue leads to lots of
>
>  Temp file 'svn_delta_3360_0' was closed. Opening replacement.
>
> messages for me.
>
> Reverting the change in _temp_cache solves the problem for me.
> Adding an " && !$$temp_fd->opened" clause to the if statement also
> works, but this is less efficient.

That change was made as a result of this feedback:

On Jul 6, 2013, at 17:11, Jonathan Nieder wrote:
> Hi,
>
> Kyle McKay wrote:
>
>> The temp_is_locked function can be used to determine whether
>> or not a given name previously passed to temp_acquire is
>> currently locked.
> [...]
>> +=item temp_is_locked ( NAME )
>> +
>> +Returns true if the file mapped to C<NAME> is currently locked.
>> +
>> +If true is returned, an attempt to C<temp_acquire()> the same
>
[snip]
>
> Looking more closely, it looks like this is factoring out the idiom
> for checking if a name is already in use from the _temp_cache
> function.  Would it make sense for _temp_cache to call this helper?

So I think the answer is it does not make sense for _temp_cache to  
call this helper.

Will release a v4 in just a moment with that single change reverted.
