From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 08/10] tag.c: use 'ref-filter' APIs
Date: Tue, 14 Jul 2015 02:04:46 +0530
Message-ID: <CAOLa=ZQjYi=PAddDnFNd-Q3+C43O9ELDqXgynF0kya9SJbPagg@mail.gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
 <1436437671-25600-1-git-send-email-karthik.188@gmail.com> <559E53DC.2040804@gmail.com>
 <CACsJy8AEEDEUE=nBvWVv426MWYzEmRSFFR1xF-cKKD2Lid9n4w@mail.gmail.com>
 <CAOLa=ZSR+QPnE36F=kX5w7q_ANobso+MM2q9-SKBARYghoJvrA@mail.gmail.com> <CACsJy8DRYGSoiyPRi3hCD54NA1TF2mr5+9xwReX333ppdoAg+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 13 22:35:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEkRi-0007N2-Vd
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jul 2015 22:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753230AbbGMUfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2015 16:35:19 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:33872 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753166AbbGMUfQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2015 16:35:16 -0400
Received: by obre1 with SMTP id e1so8486476obr.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2015 13:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=HyetOvr96hl8tgdVWugfUcHWzAYTWEFVqFVE5O5xTF8=;
        b=cW3XAzbdXtGdrANTecAsVJeAUhkUNkazqFbEOrwvCAg9v0nCaXSrgkKO52Z3x9o8z7
         8ji0ShCQ/uQsqJiIqxY/KejvFFEeXSuSq2KFVSmNEJ3yLDCU0g/LEK5Xzd/EapidePvD
         QU4ebSZrrgicEMWNjzQe+tLQvcAYNw/LanPPDVmR3JKWhQ4Hf9EA6V+C1+G31OlSQX91
         4J12F7iNN0BiY6t+9kkA5ta1QdPf9+SZair0r9Gfugdc+3OsYvCkM3u0CbuYyAut2IGI
         7oeJpMqe9Qpz7UumIGdwuy9+92G7Gfric3UNLguvpgTkzr1C2WOK5IBLreVo7BaSY7Js
         3/Og==
X-Received: by 10.182.153.161 with SMTP id vh1mr31539610obb.34.1436819715980;
 Mon, 13 Jul 2015 13:35:15 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Mon, 13 Jul 2015 13:34:46 -0700 (PDT)
In-Reply-To: <CACsJy8DRYGSoiyPRi3hCD54NA1TF2mr5+9xwReX333ppdoAg+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273925>

On Mon, Jul 13, 2015 at 4:16 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Mon, Jul 13, 2015 at 2:36 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> What I was thinking of was getting rid of the whole "align" feature where
>> you provide a value to which it would align.
>>
>> Something like:  --format="%(item:modifieralign)" which would use something
>> on the lines of what the max-width calculator in branch -l uses, to get the max
>> alignment size. But the problem is that ref-filter goes through the refs using
>> a function which has no connections with the atoms used. So a more practical
>> solution would be --format="%(item:modifieralign=X)" where we could provide a
>> means of calculating X via ref-filter. Something like this in tag.c:
>>
>> int max_width = get_max_width("<item to get max_width of>");
>> use this max_width to then do a
>> --format="%(item:modifieralign=X)", where X = max_width
>>
>> What do you think?
>
> This is where separate "alignment atoms" (instead of alignment
> modifiers) make sense. Suppose you introduce another function, let's
> say print_all() for now, to wrap the "for (i < maxcount)" loop at the
> end of for-each-ref, you would have total control over display and
> formatting. populate_value() generates empty strings for these
> alignment atoms (because they don't really have true values). Those
> alignment atoms are recognized in print_all() and
> show_ref_array_item(). In print_all(), if it sees max width needs to
> be calculated (because the user does not specify the width), it can
> call populate_value() for an atom for all rows. show_ref_array_item()
> does the padding and even truncating if needed. This pattern is
> similar to how print_columns() works, first we collect data of the
> whole "table", then we place them line by line.
>
> It sounds good to me. But it may not be the best option, I don't know.
> And it may create unnecessary work. So you and your mentors decide.
> --
> Duy

Sounds good, but what you're saying goes on the lines of interdependence of
atoms, since we would have separate atoms. Not sure we want to do that right
now.

-- 
Regards,
Karthik Nayak
