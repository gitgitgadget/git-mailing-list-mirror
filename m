From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2 1/4] rev-parse: fix some options when executed from
 subpath of main tree
Date: Fri, 06 May 2016 16:13:12 +0200
Message-ID: <20160506161312.Horde.7i8_sE5ISIqccneOIfinvCX@webmail.informatik.kit.edu>
References: <1461361992-91918-2-git-send-email-rappazzo@gmail.com>
 <20160429135051.15492-1-szeder@ira.uka.de>
 <CANoM8SWBzFiHGc3zAwndyx+GUkWQGDoaewVVQtH-06jazAn8uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?utf-8?b?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 06 16:13:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aygVV-0006Cu-SL
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 16:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757983AbcEFONV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2016 10:13:21 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:40450 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757073AbcEFONU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 6 May 2016 10:13:20 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1aygVG-000502-8n; Fri, 06 May 2016 16:13:14 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.84_2)
	(envelope-from <szeder@ira.uka.de>)
	id 1aygVE-0006aD-QS; Fri, 06 May 2016 16:13:12 +0200
Received: from x4db02b4a.dyn.telefonica.de (x4db02b4a.dyn.telefonica.de
 [77.176.43.74]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Fri, 06 May 2016 16:13:12 +0200
In-Reply-To: <CANoM8SWBzFiHGc3zAwndyx+GUkWQGDoaewVVQtH-06jazAn8uQ@mail.gmail.com>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1462543994.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293783>


Quoting Mike Rappazzo <rappazzo@gmail.com>:

> On Fri, Apr 29, 2016 at 9:50 AM, SZEDER G=C3=A1bor <szeder@ira.uka.de=
> wrote:
>>> Executing `git-rev-parse` with `--git-common-dir`, `--git-path <pat=
h>`,
>>> or `--shared-index-path` from the root of the main worktree results=
 in
>>> a relative path to the git dir.
>>>
>>> When executed from a subdirectory of the main tree, however, it inc=
orrectly
>>> returns a path which starts 'sub/path/.git'.
>>
>> This is not completely true, because '--git-path ...' returns a
>> relative path starting with '.git':
>>
>>  $ git -C t/ rev-parse --git-dir --git-path objects --git-common-dir
>>  /home/szeder/src/git/.git
>>  .git/objects
>>  t/.git
>>
>> It's still wrong, of course.
>
> I'll try to reword this to make it indicate that the value isn't
> always incorrect.

Not sure I understand your intention about rewording, in particular tha=
t
"isn't always incorrect" part.  Just to make sure there is no
misunderstanding let's have a look at the two broken cases:

    $ git -C t/ rev-parse --git-common-dir
    t/.git

Obviously wrong.
This is what you correctly described in the commit message as
"incorrectly returns a path which starts 'sub/path/.git'.

    $ git -C t/ rev-parse --git-path objects
    .git/objects

Wrong as well.  It would be correct if we were at the top of the workin=
g
tree, but we are not.  It must be relative to the directory where '-C t=
/'
brought us.
Your description in the commit message implies that '--git-path <path>'
is wrong in the same way as '--git-common-dir' is, i.e. in this case
would also return the relative path starting with the subdirectory.
That is apparently not the case.

My point in the previous email was that both are wrong when executed in
a subdir of the working tree, but they are wrong in different ways.  An=
d
they are always wrong when executed from a subdir of the working tree.
I would have described the current wrong behavior as:

    When executed from a subdirectory of the working tree, however,
    '--git-common-dir' incorrectly returns a path which starts
    'sub/path/.git', while '--git-path <path>' incorrectly returns a pa=
th
    relative to the top of the working tree.

(Still hasn't looked at shared index...)

>>> Change this to return the
>>> proper relative path to the git directory.
>>
>> I think returning absolute paths would be better.  It is consistent
>> with the already properly working '--git-dir' option, which returns =
an
>> absolute path in this case.  Furthermore, both '--git-path ...' and
>> '--git-common-dir' already return absolute paths when run from a
>> subdirectory of the .git directory:
>>
>>  $ git -C .git/refs rev-parse --git-dir --git-path objects --git-com=
mon-dir
>>  /home/szeder/src/git/.git
>>  /home/szeder/src/git/.git/objects
>>  /home/szeder/src/git/.git
>>
>
> I agree with this, but at one point Junio suggested that it should
> return the relative path[1],

I wasn't aware of Junio's suggestion.

It shouldn't really matter in practice, because both the absolute and
relative paths will ultimately lead to the same place.  However, I
still think that for consistency's sake absolute paths would be better
when executed in a subdir of the working tree.
