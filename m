From: =?ISO-8859-1?Q?Bj=F6rn_Engelmann?= <BjEngelmann@gmx.de>
Subject: Re: [PATCH 0/2] tagsize < 8kb restriction
Date: Tue, 23 May 2006 22:40:51 +0200
Message-ID: <44737353.20904@gmx.de>
References: <4471CF23.1070807@gmx.de> <7vac99c1hv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 23 22:40:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FidgU-0005kx-Aa
	for gcvg-git@gmane.org; Tue, 23 May 2006 22:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWEWUkv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 16:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWEWUkv
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 16:40:51 -0400
Received: from mail.gmx.de ([213.165.64.20]:43696 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932188AbWEWUku (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 16:40:50 -0400
Received: (qmail invoked by alias); 23 May 2006 20:40:49 -0000
Received: from unknown (EHLO [10.79.42.1]) [62.206.42.234]
  by mail.gmx.net (mp017) with SMTP; 23 May 2006 22:40:49 +0200
X-Authenticated: #916101
User-Agent: Mail/News 1.5 (X11/20060228)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vac99c1hv.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20634>

Hi,

I hope this time I got it right. Is there some kind of style-guide I can
refer to in future ?


> Another question is if the QA data expected to be amended or
> annotated later, after it is created.
>
> If the answer is yes, then you probably would not want tags --
> you can create a new tag that points at the same commit to
> update the data, but then you have no structural relationships
> given by git between such tags that point at the same commit.
> You could infer their order by timestamp but that is about it.
> I think you are better off creating a separate QA project that
> adds one new file per commit on the main project, and have the
> file identify the commit object on the main project (either
> start your text file format for QA data with the commit object
> name, or name each such QA data file after the commit object
> name).  Then your automated procedure could scan and add a new
> file to the QA project every time a new commit is made to the
> main project, and the data in the QA project can be amended or
> annotated and the changes will be version controlled.
>   

Great idea ! Thanks a lot. Originally it was not planned to alter the
results once committet, but this way it would even be possible to rescan
a commit with a different tool and merge the results. Git would also be
able to use delta-encoding when packing what can be considered extremly
efficient since most probably most scan-results won't differ much.

I am currently wondering where to store the reference to such a
sub-repository. It certainly is a head, but I would like to avoid anyone
commiting code into this "branch". Maybe I will create a new directory
.git/refs/annotations.

When thinking about this very elegant way to handle meta-data, I got
another idea:
The quality assurance system also works distributed. For scalability
reasons there are multiple scanners, each scanning one commit at a time.
Do you think git could also be used to handle "locking" ? The scanners
would then push a commit with an empty result-file into the
annotations-repository so all other scanners who are looking for
currently unscanned commits would ignore it in future. When finished the
result can be inserted by pushing a subsequent commit. This way one
avoids the need for a seperate job-server / protocol.
I am not sure how git would perform in such an environment. Do you think
the "git-push"-implementation is sufficiently "thread-save" for this ?
Or could simultaniously pushing into the same branch f.e. break  the
repository ?

Hmm.. 2 more things on my mind:
1.) Do you intend to add some more advanced metadata-functionality to
git in the future or should I send a patch with my implementation once
it is finished ? Will be just some scripts using similar commands to
what Linus sent me (thanks for that, btw)

2.) Searching for a way to add objects to the database I spent quite a
while to find the right command. Don't you think it would be much more
intuitive having an

    git-create-object [-t <type>] [-n] [-f] [-z] [--stdin] <file> [-r
<ref-name>]

command for creating any type of object (-t blob as default), optionally
omitting writing it to the database (-n = no-write) (like
git-hash-object), by default validating its input  (overriding with -f)
(like git-mktag, git-mktree) and maybe even able to add a reference to
it with -r (like git-tag).

Bj
