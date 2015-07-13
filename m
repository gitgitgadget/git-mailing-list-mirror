From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 08/10] tag.c: use 'ref-filter' APIs
Date: Mon, 13 Jul 2015 17:46:11 +0700
Message-ID: <CACsJy8DRYGSoiyPRi3hCD54NA1TF2mr5+9xwReX333ppdoAg+A@mail.gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
 <1436437671-25600-1-git-send-email-karthik.188@gmail.com> <559E53DC.2040804@gmail.com>
 <CACsJy8AEEDEUE=nBvWVv426MWYzEmRSFFR1xF-cKKD2Lid9n4w@mail.gmail.com> <CAOLa=ZSR+QPnE36F=kX5w7q_ANobso+MM2q9-SKBARYghoJvrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 13 12:46:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEbG3-0007gS-0I
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jul 2015 12:46:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbbGMKqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2015 06:46:42 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:35276 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbbGMKqm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2015 06:46:42 -0400
Received: by iecuq6 with SMTP id uq6so232121384iec.2
        for <git@vger.kernel.org>; Mon, 13 Jul 2015 03:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=88KS9XMTY9qvzMl/ZQ6bZ/UWCk6NyhwVb0U2aSl6i54=;
        b=dYUcrlXLTocXWZbZQF9QOpQqSHMIEnqVjoSKZ3Gt9iPTBq0VBjG4ozomEXLo2QmMiU
         lY/Fo493OsQnUXMeOUQsAiCAe2CotnyHPWTKbEQBY4VcD1jEYt+qvwmOm7qziSKQrNDS
         wffOlp/Td/gIAdwPLsojKI7TRFSWXCnIZYvsUf3NPjdPqdtq8d4vOJsX1oxqYBlNqMaC
         SWelUoRhf/QRR8DcP+++go5467Ss2W+PJMshU9UFJG2qON2YiONs+59gcLziVtB2wxFs
         BMYZfquFmQCE0ft5SAeKJNYzF6zypBauDEj1n696vc+0T63K7q5WoXnqsQL/j9xn8dgc
         PqHA==
X-Received: by 10.50.97.33 with SMTP id dx1mr10782276igb.1.1436784401195; Mon,
 13 Jul 2015 03:46:41 -0700 (PDT)
Received: by 10.107.16.15 with HTTP; Mon, 13 Jul 2015 03:46:11 -0700 (PDT)
In-Reply-To: <CAOLa=ZSR+QPnE36F=kX5w7q_ANobso+MM2q9-SKBARYghoJvrA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273911>

On Mon, Jul 13, 2015 at 2:36 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> What I was thinking of was getting rid of the whole "align" feature where
> you provide a value to which it would align.
>
> Something like:  --format="%(item:modifieralign)" which would use something
> on the lines of what the max-width calculator in branch -l uses, to get the max
> alignment size. But the problem is that ref-filter goes through the refs using
> a function which has no connections with the atoms used. So a more practical
> solution would be --format="%(item:modifieralign=X)" where we could provide a
> means of calculating X via ref-filter. Something like this in tag.c:
>
> int max_width = get_max_width("<item to get max_width of>");
> use this max_width to then do a
> --format="%(item:modifieralign=X)", where X = max_width
>
> What do you think?

This is where separate "alignment atoms" (instead of alignment
modifiers) make sense. Suppose you introduce another function, let's
say print_all() for now, to wrap the "for (i < maxcount)" loop at the
end of for-each-ref, you would have total control over display and
formatting. populate_value() generates empty strings for these
alignment atoms (because they don't really have true values). Those
alignment atoms are recognized in print_all() and
show_ref_array_item(). In print_all(), if it sees max width needs to
be calculated (because the user does not specify the width), it can
call populate_value() for an atom for all rows. show_ref_array_item()
does the padding and even truncating if needed. This pattern is
similar to how print_columns() works, first we collect data of the
whole "table", then we place them line by line.

It sounds good to me. But it may not be the best option, I don't know.
And it may create unnecessary work. So you and your mentors decide.
-- 
Duy
