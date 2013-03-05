From: Eric Cousineau <eacousineau@gmail.com>
Subject: Re: [PATCH/RFC] Changing submodule foreach --recursive to be
 depth-first, --parent option to execute command in supermodule as well
Date: Tue, 5 Mar 2013 10:42:05 -0600
Message-ID: <CA+aSAWvQj2wuJX3ENNn7n_pMJjA6nauve5BLRugiTuhWN25Ctg@mail.gmail.com>
References: <CA+aSAWuoxZkSnRybhefnFr9ngs3tHmt6hAH4o0ebjYKvjJ-vpw@mail.gmail.com>
	<51351CF5.7010308@web.de>
	<7vhakqwz1e.fsf@alter.siamese.dyndns.org>
	<20130305075901.GB4677@sandbox-ub>
	<7vhakpvnex.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 05 17:42:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCuwl-0007Du-4t
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 17:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977Ab3CEQmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 11:42:09 -0500
Received: from mail-lb0-f171.google.com ([209.85.217.171]:33486 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440Ab3CEQmH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 11:42:07 -0500
Received: by mail-lb0-f171.google.com with SMTP id gg13so5005855lbb.30
        for <git@vger.kernel.org>; Tue, 05 Mar 2013 08:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=YDMbNg5dFHcYi+UIf7K0bTc95+u1WhWAE7wRTlQ+OTc=;
        b=0XSBXKi+Gz0egEnombuyVKoUmLE15T1Bf6TEAd/OyjEjcfSGVJTewNmRUOAYiW07Ow
         glY8DLJAZEKgRGZxYE6gjcxlYKrkEy/20KuJylV5PEaimhh/c++rfD4ETPLIYRhRsOIE
         P5Io1jdNY5ZgpIBdv2qhv4MJyP1i1kCZIR9G5OD7c7iMP09WTF62Js5gAutNFh12yiGa
         3qfNw8HG6DnGer7zX7BHfkjwlZoyRGoqu24I4ols1IR00C+rH691X4FY933+6dAVxMdJ
         5fkUbsy3GQxOB+uSjk055GdngJ/OmF4Ux8t48sn7xEV5gfNvV3dLtgDjgms4zaiNy0eB
         dxWw==
X-Received: by 10.152.123.194 with SMTP id mc2mr22201303lab.7.1362501725161;
 Tue, 05 Mar 2013 08:42:05 -0800 (PST)
Received: by 10.114.76.113 with HTTP; Tue, 5 Mar 2013 08:42:05 -0800 (PST)
In-Reply-To: <7vhakpvnex.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217462>

On Tue, Mar 5, 2013 at 10:09 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
>
>> On Mon, Mar 04, 2013 at 03:00:45PM -0800, Junio C Hamano wrote:
>>> So if you want a single boolean to toggle between the current
>>> behaviour and the other one, it would be --post-order.  But you may
>>> at least want to consider pros and cons of allowing users to give
>>> two separate commands, one for the pre-order visitation (which is
>>> the current "command") and the other for the post-order
>>> visitation. Being able to run both might turn out to be useful.
>>
>> I second that. Having a --post-order=<command/script> switch will give
>> us much more flexibility. For ease of use we could allow --post-order
>> without command to switch the meaning of the main command.
>>
>> So a final solution would have these switches:
>>
>> git submodule foreach ... [--pre-order[=<command>]] [--post-order[=<command>]] [<command>]
>>
>> If only --pre-order without argument is given the command will be
>> executed pre-order. If only --post-order the command will be executed
>> post-order. If both are given its an error and so on...
>>
>> There are some combinations we would need to catch as errors but this
>> design should allow a step by step implementation:
>>
>>       1. just the --post-order switch
>>       2. --post-order with argument switch
>>       3. --pre-order (including argument) for symmetry of usage
>
> Yeah, I think I can agree with that direction, and Eric's patch
> could be that first step of the three-step progression, without
> painting us into a corner we cannot get out of when we want to
> advance to 2 and 3 later.
>
> I was more interested in the design aspect and I didn't look at the
> actual patch text, though.

Would these be the correct behaviors of Heiko's implementation?

git submodule foreach # Empty command, pre-order
git submodule foreach --pre-order # Same behavior
git submodule foreach --post-order # Empty command, post-order
git submodule foreach 'frotz' # Do 'frotz' pre-order in each submodule
git submodule foreach --post-order 'frotz' # Do 'frotz' post-order in
each submodule
git submodule foreach --pre-order='frotz' --post-order='shimmy' # Do
'frotz' pre-order and 'shimmy' post-order in each submodule
git submodule foreach --post-order='shimmy' 'frotz' # Invalid usage of
the command
git submodule foreach --post-order --pre-order #

It should not be too hard to have this functionality affect the
--include-super command as well.

And would it be worth it to abstract this traversal to expose it to
other commands, such as 'update', to consolidate the code some?
I think Imram was doing something like that in his post.

- Eric
