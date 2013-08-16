From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [Bug] git stash generates a different diff then other commands
 (diff, add, etc) resulting in merge conflicts!
Date: Thu, 15 Aug 2013 20:05:17 -0400
Message-ID: <CABURp0qFnvW4X9MLhB=Q45S6xmV1HJ1-8NGRD7UyOLrLVxapvQ@mail.gmail.com>
References: <CAP+CFTZWzoAg=ni6t1aif-85y6W4-2JUT4wooapTvD0oGH+HRw@mail.gmail.com>
 <CABURp0oATJ58POmgYLjSmy-y84LTjkP0PTh4=3M-vc04_AoMdg@mail.gmail.com>
 <520872CC.3040507@gmail.com> <CABURp0rWMAs9vT791vp4BEYS-Y9Jmzjmt4bbuB+po8=vkiqUWQ@mail.gmail.com>
 <5209C4CD.8040607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Luke San Antonio <lukesanantonio@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 16 02:05:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA7Xz-0005O3-ED
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 02:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581Ab3HPAFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 20:05:39 -0400
Received: from mail-vb0-f51.google.com ([209.85.212.51]:48270 "EHLO
	mail-vb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540Ab3HPAFi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 20:05:38 -0400
Received: by mail-vb0-f51.google.com with SMTP id x16so1144698vbf.24
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 17:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QBa2ShuMj7965o7z4qp1Byf5mMB2ShmlUdp0j39XHP4=;
        b=Tej3JS9n2HJu9Bqe0Yyj9JbAd/jVlhX6iIuTNWc0BStNV3E+LyKhL7ahum/RVQb9YF
         QLBD1s+T9DIOA0nW8h2A+BfZzMBLezWt+oQSV+h+NVJTPFH7QH0fguB5PnYgwjWdIcQU
         PSfmjrEADRA9rYmxazeBVf0E7sarFXkY7K7keyc1EMSwC1p0maskyb4CtOcqvZps7U+b
         FTIVEL6v7vShf9xf5cBFKwKgF7n25NERWnRrJikfN1UQI4FGUyxN6EsX7Wum5sZb9aUH
         vC7qpN17r/6FLp2GVTAI90ZdFbIe1d1o0ByusQfOpB09ojDxDaqeycPzUG2LQskm2uo7
         PiqA==
X-Received: by 10.52.34.74 with SMTP id x10mr14041823vdi.13.1376611537388;
 Thu, 15 Aug 2013 17:05:37 -0700 (PDT)
Received: by 10.58.49.197 with HTTP; Thu, 15 Aug 2013 17:05:17 -0700 (PDT)
In-Reply-To: <5209C4CD.8040607@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232388>

On Tue, Aug 13, 2013 at 1:31 AM, Luke San Antonio
<lukesanantonio@gmail.com> wrote:
>
> So I found an isolated case, it's very strange...
>
> Here's a script!
>
>
<deleted>

Thanks for that.  It was hard to read, but it demonstrates the problem well.


> ... Copy and paste that into a terminal and you should have a recreated
> version of my repository there! Now that the file is partly stashed and
> partly in the index, check out the difference in diffs:
>
> try:
>   git diff --staged
> then try:
>   git stash show -p

This one is pretty sneaky.  It is not limited to git-stash.  I can
demonstrate the problem now using 'git merge-file'.

But I can only make this problem show itself when:
   1. The collisions are separated by just one line of common code, and
   2. One of the lines of common code is duplicated in one of the
collisions, and
   3. The first two lines of the file are duplicated, and
   4. One of the first two lines is deleted on one side but not the other.

I have managed to boil the test down to this script:

    #-----------------------------
    cat >base <<base
        1 duplicate
        1 duplicate
        3 unchanged
        4 will change
        5 gets deleted
        7 duplicated
        8 will change
base

    cat >left <<left
        1 duplicate
        1 duplicate
        3 unchanged
        4 changed
        7 duplicated
        6 new line
        7 duplicated
        8 changed
left

    sed -e 1d left > right

    git merge-file -p left base right

    #-----------------------------


The result looks like this, showing the duplicate "collision":

  1 duplicate
  3 unchanged
  4 changed
  <<<<<<< left
  7 duplicated
  6 new line
  7 duplicated
  =======
  7 duplicated
  6 new line
  7 duplicated
  >>>>>>> right
  8 changed


But it should look like this instead:

  1 duplicate
  3 unchanged
  4 changed
  7 duplicated
  6 new line
  7 duplicated
  8 changed


A similar (but different) stupidity shows up if you remove line "3"
from all three files.

I tested this in 1.6.5 and the same thing occurs there, so this is NOT
recent regression.

Phil
