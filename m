From: Bobby Powers <bobbypowers@gmail.com>
Subject: Re: [PATCH] cherry-pick: Add an option to prepend a string to the
 commit message
Date: Fri, 11 Jun 2010 23:43:10 -0700
Message-ID: <4C132C7E.5090606@gmail.com>
References: <1276319237-12010-1-git-send-email-bobbypowers@gmail.com> <20100612055831.GA2426@burratino> <20100612062812.GA12685@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Christian Couder <chriscool@tuxfamily.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 12 08:43:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONKRS-0000J6-Gk
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 08:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737Ab0FLGnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 02:43:16 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57997 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678Ab0FLGnO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 02:43:14 -0400
Received: by pwi1 with SMTP id 1so1172170pwi.19
        for <git@vger.kernel.org>; Fri, 11 Jun 2010 23:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=YkfOE9XOvM37GVHNLDBhhcJqdnEPaJqL1mn4OMc/O1o=;
        b=oixoy4pRbU35rhS1GY4wD+YIJ4py1Gx6la9jL5HPNaPuZJLCGs1gZAQ5OHseTPyNAZ
         sP4a2MwrrKBPCtYGvM3MmfBboxO9CWPMa11r7N2mhRUfbi4Z0o1D5nk9c7d2oGwpcMmo
         bdrSZ3GMmH+Zs1FSYTzlNzxhl9FuGp335ity8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=TcTIhmRmcnTQY8sJ4ZHwKbgW399XyXVgw4/YkjsamBwPCx2/7r7eGWgMbHvIAdAcNN
         5vYIBK4CW1SRJb3jcAiTkBa2AuIuNd/SUpTJUv/N+z+fw4u7cU7DHnLnyAf2UonlMr++
         GoAma9AnuV2vUOkeCeGrd9SWXN1Np9GPQ4aNs=
Received: by 10.114.237.2 with SMTP id k2mr2269946wah.214.1276324993683;
        Fri, 11 Jun 2010 23:43:13 -0700 (PDT)
Received: from [192.168.1.105] (c-98-210-195-105.hsd1.ca.comcast.net [98.210.195.105])
        by mx.google.com with ESMTPS id c14sm23343990waa.13.2010.06.11.23.43.11
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 11 Jun 2010 23:43:11 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100515 Icedove/3.0.4
In-Reply-To: <20100612062812.GA12685@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148992>

On 06/11/2010 11:28 PM, Jeff King wrote:
> On Sat, Jun 12, 2010 at 12:58:32AM -0500, Jonathan Nieder wrote:
>
>> I would be interested to hear from those who might know whether
>> something generic like the applypatch-msg hook could work (which is
>> not to say a convenient command-line option would not be handy to have
>> in addition to that.)
>
> What bothers me is how specific this munging is. What if I want to
> append to the message? Or put something after the subject line, but
> before the commit body? Or add a pseudo-header (like signed-off-by) to
> the set of pseudo-headers at the end, properly adding a newline if it is
> the first such pseudo-header.

What prompted this was a large project I had checked out through 
git-svn.  I had made a number of commits to trunk, interspersed with 
other dev's work.  I needed to cherry-pick my work into a stable branch, 
but each commit needed to start with 'cherry-pick rXXX:', where XXX was 
the subversion commit number.

My solution was the following:

$ git checkout $RELEASE_BRANCH
$ export WHAT="my-subsystem:"
$ export SINCE="Jun 1 2010"
$ for i in `git log --grep="$WHAT" --oneline master --after="$SINCE" \
             | cut -d ' ' -f 1 | tac`;                                \
       do git cherry-pick $i -x                                       \
              --prepend "cherry pick r$(echo $(git log -1 $i) | perl  \
                                   -pe 's|.*/trunk@(\d+).*|\1|'): ";  \
   done

but, as you point out, I could have accomplished the same thing through 
other means.

> FWIW, we can already do this kind of stuff with:
>
>    GIT_EDITOR="sed -i 1i$prefix" git cherry-pick -e $ref
>
> or
>
>    git cherry-pick -n $ref&&
>    sed -i 1i$prefix .git/MERGE_MSG
>    GIT_EDITOR=true git commit
>
> I'll admit the first one is not very intuitive. But it is easy to script
> around the second form. For one of my examples, I would probably do:
>
>    git cherry-pick -n $ref&&
>    git log -1 --format='%s%n%ncontent between subject and body%n%b' |
>    git commit -F -

I like this; it clearly hadn't occurred to me.  I can just use this 
format instead.

yours,
Bobby

> The specifics aren't important, but I think you can see that the "don't
> commit automatically, make a message as you like, and then use the
> regular message-specifiers for commit to commit it" technique is pretty
> straightforward and very flexible.
>
> It's obviously more typing for occasional interactive use, but in that
> case, why not just use "git cherry-pick -e" and use your editor?
>
> -Peff
