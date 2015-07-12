From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 08/10] tag.c: use 'ref-filter' APIs
Date: Mon, 13 Jul 2015 01:06:10 +0530
Message-ID: <CAOLa=ZSR+QPnE36F=kX5w7q_ANobso+MM2q9-SKBARYghoJvrA@mail.gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
 <1436437671-25600-1-git-send-email-karthik.188@gmail.com> <559E53DC.2040804@gmail.com>
 <CACsJy8AEEDEUE=nBvWVv426MWYzEmRSFFR1xF-cKKD2Lid9n4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 12 21:36:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZEN3W-0003xP-01
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jul 2015 21:36:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbbGLTgl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jul 2015 15:36:41 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:35638 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbbGLTgk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jul 2015 15:36:40 -0400
Received: by obbop1 with SMTP id op1so218096354obb.2
        for <git@vger.kernel.org>; Sun, 12 Jul 2015 12:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=75SnwWknlSfLl8ECsZFDV6nNkW13r9JDXjNefiM+mqA=;
        b=MDffpiSTyy1qWYRweiyFusQfcYP3Vc+/br5KzsoBw/QWWqlHYmRwL8grOAoK3qLy4Z
         6MGBPF+5IIbme5TFl5ZMqEETEThU6wkrCh6WMEoi/87lmzUxuzOZMz+Ji95oQUM3Zh+O
         +2rjb/MYxdUP5ayl92bZDsXBkbMj9F+kJUPPdYj5SpB/GLoxcQjtUTuvefPfTLfcy74X
         8H0Hwfbm7aG7uicvltdwrNziVFxQPfWJw35hySpSD6pwd5MBo3mQVvKhEUYaCcF05nwE
         3MB9CowooFfbgrNv6z92hcUhdViEZZE0c3Bs0Ku+fw3bjS7q1vB91wroroFf/6YnlY5z
         EMOA==
X-Received: by 10.202.92.6 with SMTP id q6mr26378492oib.11.1436729800269; Sun,
 12 Jul 2015 12:36:40 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Sun, 12 Jul 2015 12:36:10 -0700 (PDT)
In-Reply-To: <CACsJy8AEEDEUE=nBvWVv426MWYzEmRSFFR1xF-cKKD2Lid9n4w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273902>

On Sun, Jul 12, 2015 at 3:15 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Jul 9, 2015 at 5:58 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> -static int show_reference(const char *refname, const struct object_id *oid,
>> -                         int flag, void *cb_data)
>> -{
> ...
>> -
>> -       if (match_pattern(filter->name_patterns, refname)) {
> ....
>> -               printf("%-15s ", refname);
>> -               show_tag_lines(oid, filter->lines);
>> -               putchar('\n');
>> -       }
>> -
>> -       return 0;
>> -}
> ...
>> +       if (filter->lines)
>> +               format = "%(refname:shortalign=16)";
>> +       else
>> +               format = "%(refname:short)";
>
> I can see this is a faithful conversion, but this looks line an
> opportunity to avoid this special limit 15/16. Even on git.git "git
> tag -l -n1" already breaks alignment with *.msysgit.* tags (ok maybe
> msysgit, not purely git.git) When you get to "branch -l", it
> calculates the max-width automatically so you probably need
> "%(refname:shortalign)" any way. "shortalign" (i.e. create the "align"
> version for every modifier) does not look good because it could double
> the number of modifiers and let's not thinking about truncation
> options or right alignment..

What I was thinking of was getting rid of the whole "align" feature where
you provide a value to which it would align.

Something like:  --format="%(item:modifieralign)" which would use something
on the lines of what the max-width calculator in branch -l uses, to get the max
alignment size. But the problem is that ref-filter goes through the refs using
a function which has no connections with the atoms used. So a more practical
solution would be --format="%(item:modifieralign=X)" where we could provide a
means of calculating X via ref-filter. Something like this in tag.c:

int max_width = get_max_width("<item to get max_width of>");
use this max_width to then do a
--format="%(item:modifieralign=X)", where X = max_width

What do you think?

-- 
Regards,
Karthik Nayak
