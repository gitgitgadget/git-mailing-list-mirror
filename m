From: Jaime Soriano Pastor <jsorianopastor@gmail.com>
Subject: Re: [PATCH 0/4] Handling unmerged files with merged entries
Date: Thu, 21 Aug 2014 15:42:46 +0200
Message-ID: <CAPuZ2NEksZzt29XpAaszK8oc4iXH4OTGzRSsHUrtwgrv6bU_0Q@mail.gmail.com>
References: <CAPuZ2NFqR67LA=eeDQVJsm_vGAHHGBy2hVNugrovzCS_kzXtMg@mail.gmail.com>
	<cover.1408533065.git.jsorianopastor@gmail.com>
	<xmqqr40ast2g.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 15:42:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKSdg-0005uC-0t
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 15:42:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573AbaHUNms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 09:42:48 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:61229 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754291AbaHUNmr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 09:42:47 -0400
Received: by mail-pd0-f176.google.com with SMTP id y10so13679645pdj.35
        for <git@vger.kernel.org>; Thu, 21 Aug 2014 06:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uxpw7Y292DFwjX/DXB/rlu1Ciu8vlaPki9jhUJQlAvQ=;
        b=s6fo22cIIowp2rvNXpgPbtsrDQMEuqEDZm2ua7LxfVYJVrkPgi+HnKaYCCIGg/o5Hw
         Th3alyuHOs/VXZOSUuglm+KS/llIgkShreVD2HhHvdxBAHJDAYfQJi2vE9dzYIsZUGZX
         A2aJj6kY/dT5e18zkggV+w7FqbS3xB857eNPrPhWwFZk0GP2nu2Z4iyWn4eyWNp68bDm
         XXehvNrLjeshK+G8q53LGnFGR6Uoyxdxgf/nTTu9XMzxUfqoO/V75tKWXFYSF8Y5kh02
         2q2Su/u5aBL+6ttJ6W78RfELqhD184/zUXLqLwrYmBl2KUikIBte6AnfXPe2jHUeVqEs
         cTSQ==
X-Received: by 10.68.87.65 with SMTP id v1mr61476354pbz.118.1408628566576;
 Thu, 21 Aug 2014 06:42:46 -0700 (PDT)
Received: by 10.70.37.2 with HTTP; Thu, 21 Aug 2014 06:42:46 -0700 (PDT)
In-Reply-To: <xmqqr40ast2g.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255611>

Good points.

On Thu, Aug 21, 2014 at 12:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> After looking at what you did in 1/4, I started to wonder if we can
> solve this in add_index_entry_with_check() in a less intrusive way.
> When we call the function with a stage #0 entry, we are telling the
> index that any entry in higher stage for the same path must
> disappear.  Since the current implementation of the function assumes
> that the index is not corrupt in this particular way to have both
> merged and unmerged entries for the same path, it fails to remove
> the higher stage entries.  If we fix the function, wouldn't it make
> your 1/4 unnecessary?  Read-only operations such as "ls-files -s"
> would not call add_index_entry() so diagnostic tools would not be
> affected even with such a fix.
>
Another thing that is done in 1/4 is to get rid of the call to
index_name_pos, that can lead to infinite loops depending on what the
previous add_index_entry call does as we have seen, and I wonder why
is it really needed, specially if we guarantee the order in the index.

> ... which may look something like the one attached at the end.
>
And it would be more in the line of my first patch.

> But then it made me wonder even more.
>
> There are other ways a piece of software can leave a corrupt index
> for us to read from.  Your fix, or the simpler one I suggested for
> that matter, would still assume that the index entries are in the
> sorted order, and a corrupt index that does not sort its entries
> correctly will cause us to behave in an undefined way.  At some
> point we should draw a line and say "Your index is hopelessly
> corrupt.", send it back to whatever broken software that originally
> wrote such a mess and have the user use that software to fix the
> corrupt index up before talking to us.
>
True.

> For that, we need to catch an index whose entries are not sorted and
> error out, perhaps when read_index_from() iterates over the mmapped
> index entries.  We can even draw that "hopelessly corrupt" line
> above the breakage you are addressing and add a check to make sure
> no path has both merged and unmerged entries to the same check to
> make it error out.
>
> I suspect that such a "detect and error out" may be sufficient and
> also may be more robust than the approach that assumes that a
> breakage is only to have both merged and unmerged entries for the
> same path, the entries are still correctly sorted.
>
Agree. I have prepared an initial patch for this to discuss, but
adding checks in read_index_from() can add a small(?) penalization to
all git operations, specially with big indexes.
And it wouldn't probably allow the user to fix the repository using
git commands (unless we only warn instead of die depending on the
thing that is broken).
