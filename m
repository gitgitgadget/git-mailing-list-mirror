From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] remote-hg: fix path when cloning with tilde expansion
Date: Fri, 9 Aug 2013 22:09:17 +0200
Message-ID: <CALWbr2w2JjEr_hYX9ighu_-=iTV6etG=78g4AbKko64EsecxFA@mail.gmail.com>
References: <CAMP44s1Jqao0YvBSh18t1C2LwAF4_u2GaTNx1RwdW+pmCFcxvQ@mail.gmail.com>
	<1376068387-28510-1-git-send-email-apelisse@gmail.com>
	<7veha266nq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 22:09:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7szz-00035P-1F
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 22:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031001Ab3HIUJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 16:09:19 -0400
Received: from mail-qc0-f179.google.com ([209.85.216.179]:52619 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030989Ab3HIUJS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 16:09:18 -0400
Received: by mail-qc0-f179.google.com with SMTP id n10so588598qcx.38
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 13:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=881Gu+zFxqx2LigRuB3Ykm94MRn2ouf9zoKB9EVgkWI=;
        b=kMCBx1WtyT8M/f4CW6FRBszyaGCnVVfXJi3bxtD5VAVLYBd2NGO16NtpXN5t6kAg+t
         E9D7kd4yHdcgtTzxnkjpMUcRmVaKGzuJsvpU9FSsQcXdbQh1wNoj0vtn+YSwkMV4hX8N
         NBQ111oJPoiA508pv2UlwJVCJBGO4swhnOMfZy86EvkyiUuGUOpCSX7tD4nz/VL+G2ue
         8yqzDsZjAv1Sw2CSjSLbyzEs2f38qpK/pCqe7wf7bfT0r0hFAdzi6GEZ1+8UxIRIttrD
         Du04k+h8lBqLwNRAD5CuqSEllK3LFY1vFwwEgku/iPFeD3cIeTuvHvri+8SF0ceP8XPx
         bJmA==
X-Received: by 10.49.50.198 with SMTP id e6mr12935319qeo.76.1376078957907;
 Fri, 09 Aug 2013 13:09:17 -0700 (PDT)
Received: by 10.49.104.211 with HTTP; Fri, 9 Aug 2013 13:09:17 -0700 (PDT)
In-Reply-To: <7veha266nq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232021>

On Fri, Aug 9, 2013 at 8:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Antoine Pelisse <apelisse@gmail.com> writes:
>> On Mon, Aug 5, 2013 at 10:30 PM, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>>> Shouldn't that be the job of the shell? (s/~/$HOME/)
>>
>> I'm not sure what you mean here. Does it mean that I should stop cloning using "~" ?
>
> I think shells do not expand ~ when it appears in a string (e.g. hg::~/there);
> you could work it around with
>
>         git clone hg::$(echo ~/there)
>
> and I suspect that is what Felipe is alluding to.  A tool (like
> remote-hg bridge with this patch) that expands ~ in the middle of a
> string also may be surprising to some people, especially to those
> who know the shell does not.

It looks like mercurial will expand the tilde (it it starts with it):

   hg init \~

will create a $HOME/.hg. (while git init \~ will create ./~).

So when we run:

git clone hg::~/my/repo

Git will remove the "hg::" part, and Mercurial will expand tilde and
clone $HOME/my/repo.

So what should we do ? I think we should stick as close as possible to
Hg behavior:
That is consider that a path starting with tilde is absolute, and not
try to fix it by building /home/user/~/repo/path.
Of course if we could not depend on "I think Hg works like that", it
would be better if we could resolve that by asking Mercurial.
I will dig into it.

> By the way, you earlier sent an updated 1/2; is this supposed to be
> 2/2 to conclude the two-patch series?

Those two patches don't interact with each other, but you can of
course join them if it makes it easier for you (and I don't think one
is going to have to go "faster" than the other anyway).
