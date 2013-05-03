From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 4/5] index-pack, unpack-objects: add --not-so-strict
 for connectivity check
Date: Fri, 3 May 2013 12:29:06 +1000
Message-ID: <CACsJy8AXe-5o7EyEp_aFB=+Ny8GoqrObxzwbAhGD4w9h7Jhmog@mail.gmail.com>
References: <1364728148-7537-1-git-send-email-pclouds@gmail.com>
 <1367405974-22190-1-git-send-email-pclouds@gmail.com> <1367405974-22190-5-git-send-email-pclouds@gmail.com>
 <7vvc722s0h.fsf@alter.siamese.dyndns.org> <CACsJy8A2dYssdV7JHutYKgo-nZswBAuedXoJ=aygrVSR=JeTrw@mail.gmail.com>
 <7vvc711h4m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 03 04:29:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UY5kj-0005J2-OS
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 04:29:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762183Ab3ECC3h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 22:29:37 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:61489 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754950Ab3ECC3h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 22:29:37 -0400
Received: by mail-oa0-f44.google.com with SMTP id h1so1225275oag.31
        for <git@vger.kernel.org>; Thu, 02 May 2013 19:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=LVHucPw63H/cmHHcpabRL4mVWSkBq/DM+TbhMxuoB+c=;
        b=jb+LeiQj8s/zWR4gKHtkFd43hlZqaK/IHDwkUeeGBHCPZJcfuEHxSpsw7NYatJ+b5p
         wgX1gDcn9Sz7fA7zJihEUqdXR6nMtsr7o4EgqLcDPQGfZ/heQ5chm3qAP822yGm4hlT2
         skQHAFVhHDMc5f+B92nOCKfPzvxV/nLrH143sxHvovinJKKQJU37s83NGFh+/IWFMI0Y
         cTAzscHCTThQ2sdM8cjmnFKQ6pNX17OHytTnPx7IBqR76oWCBOwHL0k+DQ7fDj1Z2+Wa
         laMNba6ZSd4flelLxLA9PWDDbhqVDj+hUjyCgkCZU9jDa5AhbantlDxcDQPk0UEgnEVl
         9xsQ==
X-Received: by 10.60.83.103 with SMTP id p7mr966139oey.130.1367548176586; Thu,
 02 May 2013 19:29:36 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Thu, 2 May 2013 19:29:06 -0700 (PDT)
In-Reply-To: <7vvc711h4m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223268>

On Fri, May 3, 2013 at 2:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Object islands (in the new pack) by definition are not connected to
>> the main DAG and so invisible to/unreachable from rev-list. index-pack
>> examines all objects in the pack and checks links of each object. With
>> this approach, islands are no different than reachable objects.
>
> OK, so if you are fetching an updated tip of the main history, and a
> new tip of a history that is disjoint. If we imagine that my public
> repository just added the 'todo' branch and you are fecting them for
> the first time. The history of 'todo' branch is an island that is
> not connected anywhere from your refs namespace yet. In order to
> ensure that updating the tip of fetched 'todo' is safe, you would
> need to verify the island is free of dangling pointers and the only
> thing you need to be sure is the tip of 'todo' is _in_ that island.

Why tip must be in that island or any other islands? There is no way
we know which island (or the main DAG) should be connected to any
tips. It should be enough that the tip in question exists and do not
contain any dangling pointers.

>>> I am guessing that the code assumes that we are updating our refs to
>>> objects that are in the pack that we are looking at, and I can see
>>> how the new check in sha1_object() may detect an object that points
>>> at another object that is missing.  But that assumption (which I
>>> think is correct) is probably the most important thing to say in the
>>> log message.
>>
>> Yes, we need to make sure the new value of our refs are existing
>> objects. But it does not need to be in the new pack.
>
> It is a bit more tricky than that.  A malicious (or simply buggy)
> other side can send a subset of my 'todo' branch, which is an island
> that is free of dangling pointers (think: 'rev-list --objects
> todo~8').  Further imagine that you earlier attempted a fetch of the
> same history from me over a commit walker and you happen to have
> partial history near the tip of 'todo' but not connected to the
> island.  sha1_object() will find it, but that does not say anything
> useful.  The tip _must_ appear in the island for your check to yield
> a usable result, no?

What do you mean by "partial history"? Do we have dangling pointers
after doing that commit walker?

> The existing "everything connected" was designed to protect against
> that kind of breakage as well.
>
> I might be reading your change incorrectly, but I am not sure how
> the new code protects against such a breakage.
>
>> After index-pack
>> is run, we're guaranteed that all objects in repo are connected and
>> any of them could be new ref. This is also why I add has_sha1_file()
>> in clone.c.
-- 
Duy
