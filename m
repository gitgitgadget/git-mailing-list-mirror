From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [GSoC] Designing a faster index format - Progress report
Date: Sun, 27 May 2012 19:23:07 +0700
Message-ID: <CACsJy8D+WgEr4i2H-1oiBLY5oLurM0aNxGovbVEZDvr7OGgknw@mail.gmail.com>
References: <20120523122135.GA58204@tgummerer.unibz.it> <CACsJy8As2SQwEi2vHAQA+OeH+TjoCzzcknFbQ2tGXaWX7zsHVA@mail.gmail.com>
 <20120525201547.GB86874@tgummerer> <CACsJy8BRWmqz+2_A5_=1S9_sxOQa9GXnPQ7J1Y6id0_vh2-=+Q@mail.gmail.com>
 <20120527090407.GD86874@tgummerer> <7vbolaotwj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	trast@student.ethz.ch, mhagger@alum.mit.edu
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 27 14:24:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYcWC-0002xC-O2
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 14:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793Ab2E0MXm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 May 2012 08:23:42 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:61054 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587Ab2E0MXm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 May 2012 08:23:42 -0400
Received: by weyu7 with SMTP id u7so1437129wey.19
        for <git@vger.kernel.org>; Sun, 27 May 2012 05:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=1eZDAjWdSaO9s4suRVzm5nfe0m1f8KoftpwxwqRMWho=;
        b=0yRvioUpc9BZrcmZD8GKdWFyjJFEh/XUP9JtmjQb/N4O/GPrrsCHedfTfHHXvsjO1v
         mtDXM6ryFsUHo9KHW+fcml1Fg/pagWRfXHUfKOK6VUeJytnI5VzxDXR21qMKivgivkWX
         5d0BVrn960eUsj9wRp8DC53JsgIDs4n1Js8gTsmJbb3y2LC/w6/QYFJR3vRzVmzznGRG
         +Cxm0IFVFDH+Q/Qkrit3pUMJSQkC2FDylEWDfqmsSiMROTpXJlhdcEpULqnZ5zcHQaSz
         t4JBtPlTcN/E7hvJbYIKhMyDJR0kyAo1redbbYsf6ppYGBPI3K3/jMYiX823HRAFVwK4
         7zqQ==
Received: by 10.180.79.71 with SMTP id h7mr8722764wix.19.1338121418321; Sun,
 27 May 2012 05:23:38 -0700 (PDT)
Received: by 10.223.64.208 with HTTP; Sun, 27 May 2012 05:23:07 -0700 (PDT)
In-Reply-To: <7vbolaotwj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198586>

On Sun, May 27, 2012 at 4:27 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
>>> No, read_index_from would go through the normal tree->list conversi=
on.
>>> What I'd like to see is what it looks like when a command accesses
>>> index v5 directly in tree form, taking all advantages that tree-for=
m
>>> provides, and how we should deal with old index versions while stil=
l
>>> supporting index v5 (without losing tree advantages)
>>
>> Ah ok, thanks for the clarification, I understand what you meant now=
=2E
>> I think however, that it's not very beneficial to do this conversion
>> now. git ls-files needs the whole index file anyway, so it's probabl=
y
>> not a very good test.
>
> Think about "git ls-files t/" and "git ls-files -u".

Or harder things like "ls-files -- 't/*.sh'"

> The former obviously does *not* have to look at the whole thing, even
> though the current code assumes the in-core data structure that has t=
he
> whole thing in a flat array. =C2=A0IIRC, you had unmerged entries tuc=
ked at the
> end outside the main index data, so the latter is also an interesting
> demonstration of how wonderful the new data format could be.

and "ls-files -uc" can show how you combine unmerged entries back.
There's also entry existence check deep in "ls-files -o" that you can
show how good bsearch on trees is, though that might be going too far
for an experiment because the call chain is really deep, way outside
ls-files.c:

show_files (builtin/ls-files.c)
 fill_directory (dir.c)
  read_directory
   read_directory_recursive
    treat_path
     treat_one_path
      treat_directory
       directory_exists_in_index
        cache_pos_name (read-cache.c)

I just want to make sure that by exercising the new format with some
real problems, we are certain we don't overlook anything in designing
the format (or else could be fixed before finalizing it).
--=20
Duy
