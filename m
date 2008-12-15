From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH] modify/delete conflict resolution overwrites untracked file
Date: Mon, 15 Dec 2008 10:50:37 +0000
Message-ID: <e2b179460812150250t6e028330xf0e0ff626c1b6b3c@mail.gmail.com>
References: <20081210201259.GA12928@localhost>
	 <20081215004651.GA16205@localhost>
	 <7v63lm1c76.fsf@gitster.siamese.dyndns.org>
	 <7vmyeyyuuh.fsf@gitster.siamese.dyndns.org>
	 <20081215095949.GA7403@localhost>
	 <7vskopwxej.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Clemens Buchacher" <drizzd@aon.at>, git@vger.kernel.org,
	johannes.schindelin@gmx.de, raa.lkml@gmail.com
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 11:52:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCB3N-0002wN-S7
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 11:51:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265AbYLOKuj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 05:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753323AbYLOKuj
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 05:50:39 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:51172 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009AbYLOKuj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 05:50:39 -0500
Received: by qyk4 with SMTP id 4so2573435qyk.13
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 02:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=WWkhdYbaGQj+KAnwAR2clnVGXLz0WdKOHhN2wyq0J5U=;
        b=BK4O5ciDM80RyuC+8p9eXX/422prH0tlrNCvOmT+R3TgZPwHlootrdB6afzJsNdjs9
         dgQ4dDpXk84m/V2F6zv9dXeIS49X1/xT95DUcvFr55XXQV5z/Ijzm4fGu/CaeAcYf9Tp
         jogpLM+ytvFZ8gMbVWldSuwVvrhYE/D4mgfBE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=tNYb4UZhV9qpt8d9IKsp331oxEvAk11e5xAkJWOvLQkaHlVfHBVAbK3WgAn+KCBgeb
         hdBZ/pvrnETlcv6prxdAGp/NAMiOFL+cAEQ6BI9uUWHRPFt9ULkNAK55NM1LmQacbFXl
         vPAyqhTYocL7dJm1OHKbbS/TaSV7G6l0XAbsg=
Received: by 10.214.81.5 with SMTP id e5mr7328603qab.305.1229338237619;
        Mon, 15 Dec 2008 02:50:37 -0800 (PST)
Received: by 10.214.150.9 with HTTP; Mon, 15 Dec 2008 02:50:37 -0800 (PST)
In-Reply-To: <7vskopwxej.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103154>

2008/12/15 Junio C Hamano <gitster@pobox.com>:
> Clemens Buchacher <drizzd@aon.at> writes:
>
>> On Sun, Dec 14, 2008 at 07:34:46PM -0800, Junio C Hamano wrote:
>>> merge-recursive: do not clobber untracked working tree garbage
>>>
>>> When merge-recursive wanted to create a new file in the work tree (either
>>> as the final result, or a hint for reference purposes while delete/modify
>>> conflicts), it unconditionally overwrote an untracked file in the working
>>> tree.  Be careful not to lose whatever the user has that is not tracked.
>>
>> This leaves the index in an unmerged state, however, so that a subsequent
>> git reset --hard still kills the file. And I just realized that the same
>> goes for merge-resolve. So I'd prefer to abort the merge, leave everything
>> unchanged and tell the user to clean up first.
>
> That is unfortunately asking for a moon, I am afraid.
>
> It needs a major restructuring of the code so that the recursive works
> more like the way resolve works, namely, changing the final "writeout"
> into two phase thing (the first phase making sure nothing is clobbered in
> the work tree, and then the second phase actually touching the work tree).

I wonder if another approach is workable... to read 'vulnerable'
untracked working tree files into a new (temporary, uncommittable)
stage in the index, perform whatever merging is required, then
reinstate all entries from the new stage.

Thus the merge should normally succeed under the covers, and the
previously untracked file(s) would now show up as modified against the
tracked content.

Two problems I foresee - potential loss of untracked metadata, and
ensuring we reinstate the untracked contents in all possible paths the
user can use to abort or resolve the merge.

Mike
