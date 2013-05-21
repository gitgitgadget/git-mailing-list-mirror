From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] sha1_name: fix error message for @{u}
Date: Wed, 22 May 2013 00:49:47 +0530
Message-ID: <CALkWK0m7VBz3wDGUACJAfp33M1GYqKCeMCkQwrgA7kqRMp_rtQ@mail.gmail.com>
References: <1369132915-25657-1-git-send-email-artagnon@gmail.com>
 <1369132915-25657-2-git-send-email-artagnon@gmail.com> <7vtxlwp9mf.fsf@alter.siamese.dyndns.org>
 <CALkWK0mTWtJ_U1O7ZkNU3aNFwGH456xtmDJhhmS3z1tfwFPNgA@mail.gmail.com>
 <7vfvxgnrdo.fsf@alter.siamese.dyndns.org> <CALkWK0nEXKXxercc1mNjyK-QX0pOBeKWAxPZtSPvN_h1eniO5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 21 21:20:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ues6q-0001fV-Kk
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 21:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213Ab3EUTU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 15:20:28 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:61066 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068Ab3EUTU2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 15:20:28 -0400
Received: by mail-ie0-f176.google.com with SMTP id at1so2824579iec.35
        for <git@vger.kernel.org>; Tue, 21 May 2013 12:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yuDvRl2z48dcjYVBljB5QMuuZ6h/o9/8pRuwUpigC/I=;
        b=RYynNs2dtOXw3ry0aHG81hB3RTkcX119owxzEkXlVmOMqNBsIdofji5HWStVCQbynE
         0LIWlOdPiQnG7TXEuJ3NRIFEQoIJ2cK9oGIAGfQEPythRAMeG1bAKLYE8Pac0RQFIuup
         EqFD4wBoRLIkTGCHPxWgv+M+7g+xOLAtbETcTB0m9coIlZT4euAEuSnVWfPh+21CCRRC
         xiQob1BAg1juURgGBuooTWvBmphyHPecEUJ+E+bT83UiB1HF/3UfPiR7Q6nZ/RNgnytz
         /MqQKPuEnj7h5LsAH42gNouQ6CUaKDLG+7rvgwDy5fuhdyu/+rBZxbeP//XzjhKJxDGy
         yxow==
X-Received: by 10.50.3.38 with SMTP id 6mr2310959igz.44.1369164027827; Tue, 21
 May 2013 12:20:27 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Tue, 21 May 2013 12:19:47 -0700 (PDT)
In-Reply-To: <CALkWK0nEXKXxercc1mNjyK-QX0pOBeKWAxPZtSPvN_h1eniO5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225067>

Ramkumar Ramachandra wrote:
> Junio C Hamano wrote:
>> So did you or did you not audit the codepath?
>
> No; I was explaining why I didn't in the first place.  Going through it now.

So, this is what I have:

interpret_branch_name -> interpret_branch_name (recursion)
                      -> get_sha1_basic -> get_sha1 [context] (end-user data)
                      -> substitute_branch_name -> dwim (end-user data)
		      -> strbuf_branchname (callers pass a branch name; no @{u})
		      -> revision.c:add_pending_object [with_mode] (end-user data)

[die_]verify_filename -> builtin/rev-parse.c (end-user)
		      -> builtin/reset.c (end-user)
		      -> builtin/grep.c:cmd_grep (end-user)
		      -> revision.c:setup_revisions (end-user data)

We used to die in die_verify_filename() earlier, but we die in
interpret_branch_name() after the patch.  Do we have to dig deeper?
