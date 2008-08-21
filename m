From: "Mark Levedahl" <mlevedahl@gmail.com>
Subject: Re: [PATCH] git-submodule.sh - Remove trailing / from URL if found
Date: Thu, 21 Aug 2008 08:04:34 -0400
Message-ID: <30e4a070808210504l1dd6b491l1d66dcd96a238ebc@mail.gmail.com>
References: <7vpro4tjkw.fsf@gitster.siamese.dyndns.org>
	 <1219280847-872-1-git-send-email-mlevedahl@gmail.com>
	 <7vfxozkpzi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 14:06:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW8vH-0005WV-RX
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 14:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223AbYHUMEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 08:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752332AbYHUMEh
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 08:04:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:13660 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbYHUMEf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 08:04:35 -0400
Received: by ug-out-1314.google.com with SMTP id c2so1011904ugf.37
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 05:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=IdmCq7CgwLm+bWLv+cuWvU+elzmxre7i1AY3TvTveYg=;
        b=rwX3MX6tmtjvTuiD+cxsLqLuYV/rEtWYOhBmeHAYe920sxW/C/f0O3gT58hD1U0gwI
         SunZFES2hqYiwzgwtza2N8645XUkr5TVd7h4GarI1Vtl77vtbZiYPSwfWGyAy2XwJb5M
         mDGpbbbWOWtUObK8HE1BAW9C2Nz/WspIXz9to=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=TCgagDC7fDXn5A9Kty0sW7xAUY8/WSdkgNV6XYqVXUKDWCiDl69sLCD7QjcWtSSX+y
         rZmebosfvN7aFMIKzocZIn7lvPlrtTwJ3y8rAH+fmVbxmFx3fd9KT7TwFUlLDMZfLM1J
         +pCIvlqqMfgNSeI/hm7AY0jaQcNvfsoyzGPb8=
Received: by 10.187.176.2 with SMTP id d2mr98717fap.55.1219320274216;
        Thu, 21 Aug 2008 05:04:34 -0700 (PDT)
Received: by 10.187.175.4 with HTTP; Thu, 21 Aug 2008 05:04:34 -0700 (PDT)
In-Reply-To: <7vfxozkpzi.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93139>

On Wed, Aug 20, 2008 at 11:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Hmm.  I was sort of hoping to hear "Junio you idiot you do not know what
> you are talking about --- your example of using ".." as relative won't
> happen because of such and such reasons; trust me I know what is going on
> in the vicinity of this code."
>
> And after looking at the callsites of the shell function, I think the
> original can never pass ".." (there are case statements to pass only $url
> that match "./*" or "../*"), so I think both your original and this
> version are safe as long as the part that match the trailing "/*" is
> sane.
>
> So I'll queue your first patch, as it is slightly shorter ;-)
>
> Thanks.
>

Junio,

I try to avoid the "idiot" idiom, it tends to backfire ... :^)

The problem I'm trying to fix is that a number of folks have
superprojects checked out where the recorded origin URL has a trailing
/, and a submodule has its origin in a directory sitting right next to
the superproject on the server. Thus, we have:

   superproject url = server:/public/super
   submodoule url = server:/public/sub1

However, in the checked out superproject's .git/config
[remote "origin"]
   url = server:/public/super/

and for similar reasons, the submodule has its URL recorded in .gitmodules as
[submodule "sub"]
   path = submodule1
   url = ../sub1/

resolve_relative_url gets the submodule's recorded url as $1, which
the caller retrieved from .gitmodules, and retrieves the superprojects
origin from .git/config. So in this case resolve_relative_url has
that:
   url = ../sub1/
   remoteurl = server:/public/super/

So, without any patch, resolve_relative_url computes the submodule's URL as:
   server:/public/super/sub1/

with the first patch as:
   server:/public/super/sub1

and with the second as
   server:/public/sub1
rather than
   server:/public/sub1

So, the second patch I sent is the one that fixes the above problem,
and I have to say I now forget what the confused state of .gitmodules
+ .git/config I found on one machine that lead to the first patch as
being a correct fix.

In summary, it is essential that resolve_relative_url strip the
trailing / from the superproject's url before starting, while it is
nice but not necessary if it assures that the result does not contain
a trailing /.

Mark
