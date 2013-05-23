From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/3] Fixing volatile HEAD in push.default = current
Date: Thu, 23 May 2013 13:25:55 +0530
Message-ID: <CALkWK0mfGWA3aBntQQU5fkCJDPx+MUOScvMRJjS+JzjNucFzPw@mail.gmail.com>
References: <1369160600-22337-1-git-send-email-artagnon@gmail.com>
 <7v38tgno2k.fsf@alter.siamese.dyndns.org> <CALkWK0m3QP_eE14y8UoJ+HeFzkKM=1nVKAnYJcTrwQMp+Atphg@mail.gmail.com>
 <7vppwkm682.fsf@alter.siamese.dyndns.org> <CALkWK0np7o0eH8ZsWQSwk1Cdwnnpj5B==gS8kAE+OkTskASOsQ@mail.gmail.com>
 <7v7girks4s.fsf@alter.siamese.dyndns.org> <CALkWK0kXonM+J92KHs+dW31A_kZ8h9jNqwYn8AqT_V+GJhe_vg@mail.gmail.com>
 <7vppwjj5ws.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 23 09:56:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfQO9-0005MB-E8
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 09:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756485Ab3EWH4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 03:56:38 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:64259 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664Ab3EWH4g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 03:56:36 -0400
Received: by mail-ie0-f179.google.com with SMTP id c13so7736445ieb.38
        for <git@vger.kernel.org>; Thu, 23 May 2013 00:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=l0J7cCiFe6rwK5K9IHZxlb4XbzSrvf9tMgGSe1D6HBo=;
        b=mVpD/8+1RSQ8mSroSdYj8JT6iFP/2AAWxzGoX9B/pL1bVC/9h3rse0p+q4ZYGDNnGL
         LRK0Y8q7qCWcrndFQmMAROGAHjGgMj+BBlEheNxLaOQ2x2N7E/bnr45DK6LJ7QqvqFRR
         NLryGm2JMm9UU3kFTIKdvjnESqPf5QQaUfnoxiY4mAFkY5ZCp4AlhaMX8kDBN3S0YHGr
         Qi6XjYrutN9YP/Tey3nxQql2oOIvczROjklfFuNbiJI7kVSWzcDCZNthGKCKjOXff1Da
         EV7fHLc6sFsn3EOKruNWUegS8ZD6UV7a5m8Hqzfok/gfAykdrljrH312gLhHu1+nyxx9
         QMzw==
X-Received: by 10.43.68.134 with SMTP id xy6mr8854304icb.48.1369295796154;
 Thu, 23 May 2013 00:56:36 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 23 May 2013 00:55:55 -0700 (PDT)
In-Reply-To: <7vppwjj5ws.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225222>

Junio C Hamano wrote:
>     I have "largedir" I want to get rid of, but there is a directory
>     I want to save, "largedir/precious", in it, so I do
>
>         cp -R largedir/precious precious
>
>     and then run 'rm -rf largedir' in another terminal in parallel.

I would argue that there is something to "fix", but that fix involves
making the cp a purely atomic operation which is super-complicated,
and totally not worth it.  Would you _not_ like the above example to
work?  Then how can you say that there's nothing to be fixed?

Consider a slightly different example: I rename a file while having an
active file handle open in a process that's reading the file.  Will
the rename fail or will the fread() in the process fail?  Nope, both
work fine.  Replace "rename" with "remove", and we still have the same
answer.  Ofcourse there are no guarantees: I can start up another
process to overwrite the sectors corresponding to that file's data
with zeros; unless the complete file is there in the kernel buffer, a
read() will eventually end up slurping in the zeros (or fail?), right?
 It's just that it works in practice.

Yet another example: I have a terminal pointing to a directory, and I
remove that directory in another terminal.  When I switch back to the
original terminal, I can't cd .., because getcwd() fails.  This has
annoyed me endlessly in practice, and I would really like to fix this
if I can.

Don't accept the way things are, and assume that there's nothing to be
"fixed".  In my opinion, if something about a piece of software annoys
you, there is always something to fix.  It just depends on what _can_
be fixed in a reasonable amount of time with a good engineering
solution.  There's no need to go to the other extreme: I'm not
interested in rewriting the whole operating system in Haskell and
providing theoretical guarantees for everything.

Coming back to our push example, I don't see why you think HEAD is
special: I could even say git push master and expect it to race with
an update-ref.  But nobody is complaining about that: if someone does
complain, I would seriously consider copying master to PUSH_HEAD early
(and push that).  With HEAD, however, someone is complaining (namely,
me): pushing usually means that I've finished working on that branch,
and want to switch to another branch and continue working.  Why should
I have to wait for the push to complete?  I've hit this bug several
times (from terminal as well as Magit), and this patch fixes the
problem for me in practice.

That said, I agree that my patch does not guarantee anything (and I
will modify my commit message to clarify this).  I'm just expressing
my opinion on the issue of "fixing problems".
