From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Commit cache to speed up rev-list and merge
Date: Thu, 27 Sep 2012 10:45:32 -0700
Message-ID: <CAJo=hJtus46UGyTcnfTDArp=RkK-P24wO8pjhEY7qAmssyxgVA@mail.gmail.com>
References: <CAJo=hJtoqYEL5YiKawCt_SsSUqfCeYEQzY8Ntyb91cNfNS1w_Q@mail.gmail.com>
 <20120927173932.GE1547@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>, Colby Ranger <cranger@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 27 19:46:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THI9z-0000ZA-KO
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 19:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753600Ab2I0Rpy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 13:45:54 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:42721 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343Ab2I0Rpx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 13:45:53 -0400
Received: by qadc26 with SMTP id c26so4063782qad.19
        for <git@vger.kernel.org>; Thu, 27 Sep 2012 10:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1FJpYOs5JF7c6N8BnDrRPVdO6ebYKdiDmFL7AdYyDPI=;
        b=XIyDqMMohzUWummENQuFSw4tp+tWlO32zMllpvdLsfo3lGYnPxaOBWLSceDWzrWEE7
         h48atLBAd7sZGzM1qrR8Ej28RoLDlV2DEXj1xopJl5KXpVwTZDkN/Ymg7Eb9rgjWGROe
         PRkiQHw34hI8m1wpOB0NpY4xQKnfeIGL+mJGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=1FJpYOs5JF7c6N8BnDrRPVdO6ebYKdiDmFL7AdYyDPI=;
        b=TPPpUT+/U+c3TtEv+UkFDoHfDn83Z9CXqas8COZwOR1YBFpkl6Wk8XuRLVDmIxv/0l
         NmHrmbPkHfDRQP0pBQyOr/gpKkS39ELI71d45OLUk64hH0ZVvUtvsPZj51xslyUg4wt5
         c7y1PI3gz3V1BCzBkgzcwqHrTD8zgm7e9FP84GIoATFA8WrJf/fOs/LvesHKk+DJK0dq
         u5FhToQYtLW0uZminkWANurMd7fPgyoKqPXgmTX/Mk1cs8y/V2xqYqb+owSrp4lvzO1n
         qQUBritR4g4rZRmbl3BEUiSNKl4wIP7AiMtFu7mAowR0Qq75T/ArnIrBnby70g3Oo8iC
         kXMw==
Received: by 10.224.175.204 with SMTP id bb12mr11171211qab.14.1348767952340;
 Thu, 27 Sep 2012 10:45:52 -0700 (PDT)
Received: by 10.49.35.75 with HTTP; Thu, 27 Sep 2012 10:45:32 -0700 (PDT)
In-Reply-To: <20120927173932.GE1547@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQm6Noho8zzZymjekyNfE3pYN2qDUGKSxYSu8KL8C2KGWuOhBCz1c9YxnUnLc7IHgUnBe2hK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206498>

On Thu, Sep 27, 2012 at 10:39 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Sep 27, 2012 at 08:51:51AM -0700, Shawn O. Pearce wrote:
>> On Thu, Sep 27, 2012 at 5:17 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> > I'd like to see some sort of extension mechanism like in
>> > $GIT_DIR/index, so that we don't have to increase pack index version
>> > often. What I have in mind is optional commit cache to speed up
>> > rev-list and merge, which could be stored in pack index too.
>>
>> Can you share some of your ideas?
>
> Some of it is here:
>
>   http://article.gmane.org/gmane.comp.version-control.git/203308

Quoting from that patch:

On  2012-08-12 Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Long term we might gain slight lookup speedup if we know object type
> as search region is made smaller. But for that to happen, we need to
> propagate object type hint down to find_pack_entry_one() and friends.
> Possible thing to do, I think.

I'm not sure reclustering the index by object type is going to make a
worthwhile difference. Of 2.2m objects in the Linux tree, 320k are
commits. The difference between doing the binary search through all
objects vs. just commits is only 2 iterations more of binary search if
we assume the per-type ranges have their own fan-out tables.

> The main reason to group objects by type is to make it possible to
> create another sha1->something mapping for a particular object type,
> without wasting space for storing sha-1 keys again. For example, we
> can store commit caches, tree caches... at the end of the index as
> extensions.

Using ordinal position in the pack also works, and doesn't require
clustering objects by type.
