From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 3/3] push: add separate 'downstream' branch
Date: Thu, 16 May 2013 13:51:10 +0530
Message-ID: <CALkWK0nTS6Vh7GfnrLWAK5VeevQyGN5N7xT43c+uqBQ5oM5tww@mail.gmail.com>
References: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com> <1368675828-27418-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 10:22:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UctRm-0003up-6J
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 10:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756199Ab3EPIVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 04:21:53 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:63433 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755214Ab3EPIVu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 04:21:50 -0400
Received: by mail-ie0-f173.google.com with SMTP id k5so5825855iea.32
        for <git@vger.kernel.org>; Thu, 16 May 2013 01:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=+oNTGICYXkLk1EyWClwrt+bcyruZROMGaWvjQinABgU=;
        b=xECyfraXHlp362vePEBZxmOhpoMGCd55EakmgFQPWVxwizE6KFmPK/0TVATR/Wi7GN
         2pcARfFGO9o5iRzM47nh2YKtwWFIqqrIQjczw8aND+fOvvaSciBJbVG8OgFHlgv2ofqO
         tXSam5J+nQXLDWFgVzI4QGWjw6GHR7zDXX6mMtMFHXrW6wEkqL3ZCLs4ohxKHqHAcntX
         9G4g4eMBi4ttnO0iDpRVN4Pr4FRveHW/AR/YRirsur4pnUcpatiSeaEC/By5/y8NypGa
         f3m6K3++wUw5MNjsVKchpKT5AsxM4qEL7eft/7GHp1X3RayzX+3JQw2iLi25Ea9y8k3r
         PqLg==
X-Received: by 10.42.123.66 with SMTP id q2mr22016526icr.12.1368692510276;
 Thu, 16 May 2013 01:21:50 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 16 May 2013 01:21:10 -0700 (PDT)
In-Reply-To: <1368675828-27418-4-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224496>

Felipe Contreras wrote:
>   [branch "master"]
>           remote = origin
>           merge = refs/heads/master
>           pushremote = github
>           push = refs/heads/master

Hm.  Some thoughts:

fetch and push aren't symmetric.  By default fetches are batched: when
you say 'git fetch', it fetches all the refs and uses the
remote.<name>.fetch refspec to update the refs on your side.  Now, I
would argue that this is the correct design, because I rarely want to
fetch just one ref (and that is broken, by the way: refs on my side
aren't updated for some weird reason).  The other reason this is
correct is because fetching has nothing to do with local branches: how
you _merge_ your remote branches to your local branches is entirely
orthogonal to the issue (and that is controlled by
branch.<name>.merge).

Now, push is a different ball game altogether.  There are people who
do batched pushes (push.default = matching has been the default for 8
years now).  However, the support for a batched push in a triangular
workflow is very limited: I can't say git push master hot-branch
pickaxe-doc, and expect them to go to the right remotes (this idea has
already been discussed and rejected).  Back to your patch: if you want
to support batched pushes to map refs correctly, you should write a
patch for remote.<name>.push.  It has a very valid usecase too: there
are people who use Gerrit and they shouldn't have to do git push
<name>:refs/for/<name> every single time.  Neither should they have to
configure each branch.<name>.push.  The ref-mapping is an inherent
property of the remote, not of the local branch.  And
branch.<name>.merge is entirely orthogonal to ref-mapping, as I
already explained.

That said, I think the concept of a downstream can be useful.  I have
branch.hot-branch.remote set to origin, and
branch.hot-branch.pushremote set to ram.  Now, I push some changes: my
prompt still says > (indicating unpushed changes), and this is very
annoying.  I would definitely like git to be able to recognize that
I'm ahead of upstream, but in-sync with my downstream.  So, your
branch.<name>.push should probably be named
branch.<name>.downstreamref and be used only for informational
purposes (@{d} and git status)?  Wait, why do we need it at all?  Is
there something that we cannot infer from a proposed
remote.<name>.push?  Why will we ever need to override that refspec
mapping with a local branch configuration?
