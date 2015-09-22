From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] notes: don't expand qualified refs in expand_notes_ref
Date: Tue, 22 Sep 2015 11:37:57 -0700
Message-ID: <xmqqa8se47wa.fsf@gitster.mtv.corp.google.com>
References: <1442441194-5506-1-git-send-email-jacob.e.keller@intel.com>
	<1442441194-5506-2-git-send-email-jacob.e.keller@intel.com>
	<xmqqzj0mkn7r.fsf@gitster.mtv.corp.google.com>
	<CA+P7+xpv_0Sf94FqMKJa0v0pSSEWXPRD2KQ0kmNBKC=2hrunhw@mail.gmail.com>
	<xmqqsi665yjm.fsf@gitster.mtv.corp.google.com>
	<CA+P7+xrwM44tMHMW+dEJx_tMtcMVEQELNq=J=rqs1uQ+feuZqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git List <git@vger.kernel.org>, Mike Hommey <mh@glandium.org>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 20:38:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeSSM-00040u-4X
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 20:38:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758942AbbIVSiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 14:38:13 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36414 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752885AbbIVSiK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 14:38:10 -0400
Received: by pablk4 with SMTP id lk4so706650pab.3
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 11:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=JoJikk9yFcKW7cR/XCApct4XVeMxjSVxr/pLer9v1Uw=;
        b=Vq65BUkSQwDblGHAEi7roHnjAr3tEBP19HQK4NDK0AszcO9pSlaS0mK839ySA3pdG5
         +LnuXE1TkBObnqVPZTfd9mnl4PnIMIn8/++7WGVQRCQGLp1UoH1opqH84DJF6ZNFrDrz
         1O7TIs/CIbkA1Dk02HGfvuy/Z6qKusq1DGbWIiFUsfnfA4h2vnuCBRsvda27pv3dolKD
         1zad+mPPpsf8EKidOx9BESh0Pktuei9yO30jB8dRF5np7WC1UUL7btlKIclmHTPY0HZ5
         3H7IZMrUe3qyyTIrXHYXBpc7cSVOLiOUMThl/2Ntw3TETtxkwb06Vy8XFl0ixyCBG1Rl
         Y3tA==
X-Received: by 10.68.88.130 with SMTP id bg2mr32301214pbb.129.1442947079353;
        Tue, 22 Sep 2015 11:37:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:fd7e:7071:2eda:9c63])
        by smtp.gmail.com with ESMTPSA id yi8sm3622152pab.22.2015.09.22.11.37.58
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 22 Sep 2015 11:37:58 -0700 (PDT)
In-Reply-To: <CA+P7+xrwM44tMHMW+dEJx_tMtcMVEQELNq=J=rqs1uQ+feuZqQ@mail.gmail.com>
	(Jacob Keller's message of "Tue, 22 Sep 2015 10:54:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278411>

Jacob Keller <jacob.keller@gmail.com> writes:

> The other issue here is that expand_notes_ref is called on the --ref
> argument waaay before the current code even decides if the operation
> is "read" or "write". Thus we'd have to break this out and handle
> things very differently.

I think you hit the right nail here.  The handling of --ref argument
is what you need to adjust to the new world order.

And "safety" is a red herring.  Those who are used to run

	git log --notes=refs/heads/master

and relies on it to refer to refs/notes/refs/heads/master must
continue to be able to do so.  Changing expand_notes_ref() the
way the proposed patch does will break them, won't it?  "safety"
is not the only (or even the primary) requirement, but the
correctness must also be kept.

> It seems like a lot more heavy lifting to change the entire flow of
> how we decide when to expand "--ref" for "read" operations vs "write"
> operations.
>
> That is, git notes list.
>
> It's easy to change behavior of git notes merge as it handles its
> argument for where to merge from separately, but it's not so easy to
> change git notes show...

Yes, exactly.

I am _more than_ OK to see that read-only accesses to the notes tree
allowed anything under refs/ (like the proposed patch did) and also
a raw 40-hex object name in the endgame, but I really would not want
to see "we meant well and attempted to enhance 'notes merge' but we
ended up regressing the behaviour of unrelated operations all of a
sudden".

If you cannot do your change without breaking the existing users,
then you at least need a sound transition plan.  But I am not sure
yet if you have to break the world (yet).  Let me think aloud a bit
more.

There aren't all that many callers of expand_notes_ref().

My preference is to leave that function as-is, especially keep the
behaviour of the caller in revision.c that handles --show-notes=
(and --notes= that is its synonym) the same as before.

All the other callers are only reachable from the codepath that
originates from cmd_notes(), if I am reading the code correctly, and
that can be enhanced without breaking the existing users.  One
obvious way to do so would be to make "--ref" to keep the call to
expand_notes_ref(), and add another "--notes-rawref" or whatever
option that does not restrict it to "refs/notes", but there may be
other ways.
