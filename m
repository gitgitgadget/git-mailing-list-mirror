From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 3/3] push: add separate 'downstream' branch
Date: Thu, 16 May 2013 04:05:49 -0500
Message-ID: <CAMP44s3fPsGW_9aBbcsu8cJAagz8JEWV2HM=XRH3Rw4=SXdL7Q@mail.gmail.com>
References: <1368675828-27418-1-git-send-email-felipe.contreras@gmail.com>
	<1368675828-27418-4-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0nTS6Vh7GfnrLWAK5VeevQyGN5N7xT43c+uqBQ5oM5tww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 11:05:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucu8L-0004SD-JW
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 11:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993Ab3EPJFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 05:05:52 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:51664 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917Ab3EPJFv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 05:05:51 -0400
Received: by mail-lb0-f178.google.com with SMTP id w10so1350473lbi.23
        for <git@vger.kernel.org>; Thu, 16 May 2013 02:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=LIHa7OJ8wj0oLF56l9kTMkU1mmXMgfnvztE3hOqJ5FE=;
        b=JUSYw8eT+bXqgIYAVPcMsg7OpP1rdH/5VpHtVJkcCQa7Wl4dJ20TKBi7hWWgxIzj+6
         m3a/kskOAVorBC6NjFc6DuMCKsisqEnjRHBJiKYYBlD9QBC0Cbc8rVWOYaLDDFvMu1h+
         ICLL9eOeQd963UlBIvJ4jkkDPVSuq3hme4pAdqfHQCFVY9ysd+MhhnN8N1Z3E06Xj1Sv
         m4OemSPuT5VoBJ5SsM9gkUvM9xWRoMPUnV1XQnhDQUYfNeAqgTyjqByhR1/ueLDnjlDo
         jThHC587StlTC4FHGS4WYuyl4vRBRxKVnZWQpfwjI+uWrtwnwIPw3t1lS5m95cfaeWhB
         UpTQ==
X-Received: by 10.112.145.72 with SMTP id ss8mr19735171lbb.12.1368695149305;
 Thu, 16 May 2013 02:05:49 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 02:05:49 -0700 (PDT)
In-Reply-To: <CALkWK0nTS6Vh7GfnrLWAK5VeevQyGN5N7xT43c+uqBQ5oM5tww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224516>

On Thu, May 16, 2013 at 3:21 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>>   [branch "master"]
>>           remote = origin
>>           merge = refs/heads/master
>>           pushremote = github
>>           push = refs/heads/master
>
> Hm.  Some thoughts:
>
> fetch and push aren't symmetric.  By default fetches are batched: when
> you say 'git fetch', it fetches all the refs and uses the
> remote.<name>.fetch refspec to update the refs on your side.  Now, I
> would argue that this is the correct design, because I rarely want to
> fetch just one ref (and that is broken, by the way: refs on my side
> aren't updated for some weird reason).  The other reason this is
> correct is because fetching has nothing to do with local branches: how
> you _merge_ your remote branches to your local branches is entirely
> orthogonal to the issue (and that is controlled by
> branch.<name>.merge).
>
> Now, push is a different ball game altogether.  There are people who
> do batched pushes (push.default = matching has been the default for 8
> years now).

And is going to change soon.

> However, the support for a batched push in a triangular
> workflow is very limited: I can't say git push master hot-branch
> pickaxe-doc, and expect them to go to the right remotes (this idea has
> already been discussed and rejected).  Back to your patch: if you want
> to support batched pushes to map refs correctly, you should write a
> patch for remote.<name>.push.  It has a very valid usecase too: there
> are people who use Gerrit and they shouldn't have to do git push
> <name>:refs/for/<name> every single time.  Neither should they have to
> configure each branch.<name>.push.  The ref-mapping is an inherent
> property of the remote, not of the local branch.  And
> branch.<name>.merge is entirely orthogonal to ref-mapping, as I
> already explained.
>
> That said, I think the concept of a downstream can be useful.  I have
> branch.hot-branch.remote set to origin, and
> branch.hot-branch.pushremote set to ram.  Now, I push some changes: my
> prompt still says > (indicating unpushed changes), and this is very
> annoying.  I would definitely like git to be able to recognize that
> I'm ahead of upstream, but in-sync with my downstream.  So, your
> branch.<name>.push should probably be named
> branch.<name>.downstreamref and be used only for informational
> purposes (@{d} and git status)?

That makes absolutely no sense.

[branch "master"]
          remote = origin
          merge = refs/heads/master
          pushremote = github
          downstreamref = refs/heads/whaaa:refs/heads/master

What is the point of 'refs/heads/whaaa'?

> Wait, why do we need it at all?  Is
> there something that we cannot infer from a proposed
> remote.<name>.push?  Why will we ever need to override that refspec
> mapping with a local branch configuration?

[branch "master"]
          remote = origin
          merge = refs/heads/master
          pushremote = github
          push = refs/heads/fc/master

[branch "fc/old-remote/hg"]
          remote = .
          merge = refs/heads/master
          pushremote = github
          push = refs/heads/fc/remote/hg

Tell me how you express that without 'remote.branch.push'.

Cheers.

-- 
Felipe Contreras
