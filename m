From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 6/6] push: honor branch.*.push
Date: Mon, 24 Jun 2013 21:39:46 +0530
Message-ID: <CALkWK0=a40hACGYApN7odrTytDmoRG_00_Q=EuaHuQ_=h8LBkg@mail.gmail.com>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
 <1372048388-16742-7-git-send-email-gitster@pobox.com> <CALkWK0=aDkCMB3ROSuH1crTmQKjCFyCmvJfvOTiQnBo4+NckBA@mail.gmail.com>
 <7vhagndis4.fsf@alter.siamese.dyndns.org> <CALkWK0kqyV+MTW8jDDBt-qEB1R7yvD+n4nTxwvW0QjA13J2=2A@mail.gmail.com>
 <7vy59zbjns.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 18:10:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur9Lb-00028q-I1
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 18:10:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860Ab3FXQK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 12:10:27 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:39300 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190Ab3FXQK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 12:10:27 -0400
Received: by mail-ie0-f172.google.com with SMTP id 16so25412703iea.31
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 09:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PM6yJPwiOB936PUhLCGpZdzleINo6GH3GYfmmDjV0eo=;
        b=iYawHN3Msef1DZOUMqI9rpt+ZaTqZjpI+TG1FngcTpQcYgaQRg+oZhucXsFO96hA50
         pf4nJGulESvsiZGVQZgQsim/sMXDUNVCgt0vFEIkk6xsbHSvHR8kzxZgR8ZzbpvqkGOh
         Gko/+gsImBaFYEzvnnxStMxoqYzRFFJgZgCJO2lILDxMOiNw3zM9w7VPynJRzUYiHDbE
         p16za8NPkwsAXG+avDd75zR2Z8JlvATttaFBnc8/GLC2/ZRgRhJkDvKednJvvbz7v7TE
         /zJiWLuJAv88Zs6zg3DomRrxsniLefQHbmpe0JmFNDBMRMou40y8b2l90j8QFtrrFt+d
         ABNA==
X-Received: by 10.43.88.3 with SMTP id ay3mr8365889icc.61.1372090226454; Mon,
 24 Jun 2013 09:10:26 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Mon, 24 Jun 2013 09:09:46 -0700 (PDT)
In-Reply-To: <7vy59zbjns.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228844>

Junio C Hamano wrote:
> If the user said "git push" without an explicit request to push to
> "ram", and if branch.master.pushremote was not set to "ram", and
> still the command "git push" pushed the branch to "ram", then I
> would understand what you are worried about, but otherwise I do not
> see how what you are saying makes sense.

We currently have no system to differentiate between those two cases.

> A safety valve is different from a straight-jacket.  If you are
> working largely with a central repository and have push.default set
> to upstream, are you now disallowed to push out things to other
> places to ask help from your colleague to check your wip?  Why?

I've been harping about how this safety valve is poorly done, and I'm
the first person interested in loosening it.  But I do not think this
is the way to do it: drop in branch.<name>.push magic, and make
upstream suddenly work with triangular workflows?

> Or are you saying that with push.default set to upstream, only these
> two forms should be allowed?
>
>     $ git push ;# no destination, no refspec
>     $ git push there ref:spec ;# both explicitly specified

No, no.  What I meant is:

  From the documentation of push.default, I _expect_ upstream to kick
  in only in the first case.  In the second case, I _know_ that my
  push.default is inconsequential.

With branch.<name>.push magic, you've sneaked in a push refspec under
the carpet, and the first form suddenly doesn't care about
push.default anymore.  remote.<name>.push is also an under-the-carpet
implementation that I don't like: it's done in push_with_options()
which can completely bypass setup_default_push_refspecs(), shooting
the user in the face.

I want properly defined precedence and well-defined overall behavior.
Not sneaky stuff.  I don't have an answer, but will start a discussion
with some code soon.  In the meantime, since we've already figured out
this series, merge it without 6/6.

Thanks.
