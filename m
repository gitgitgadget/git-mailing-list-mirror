From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Change set based shallow clone
Date: Fri, 08 Sep 2006 00:40:47 +0200
Organization: At home
Message-ID: <edq74k$cuu$1@sea.gmane.org>
References: <9e4733910609071252ree73effwb06358e9a22ba965@mail.gmail.com> <7vpse7tjp0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Sep 08 00:41:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLSYc-0007H7-Qq
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 00:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422690AbWIGWlE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 7 Sep 2006 18:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422695AbWIGWlE
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 18:41:04 -0400
Received: from main.gmane.org ([80.91.229.2]:24730 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1422690AbWIGWlA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Sep 2006 18:41:00 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GLSXw-0007AW-Fj
	for git@vger.kernel.org; Fri, 08 Sep 2006 00:40:32 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Sep 2006 00:40:32 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Sep 2006 00:40:32 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26663>

Junio C Hamano wrote:

> One way to do so is to send grafts information from downloader
> to uploader. =A0If the uploader _knows_ that the altered history
> ends at the leftmost '*' commit on the mainline, then it can=20
> take it into account the fact that the downloader does not have
> commit 'F'. =A0That, however, introduces another problem. =A0Where
> should it stop? =A0Obviously X needs to be sent, so is X^, but
> how do we know which 'x' commit to stop at? =A0Do we record the
> initial cut-off criteria (remember, we started the clone with
> 5-commit cutoff) somewhere in the downloader's repository and
> send that to the uploader so that the uploader can apply the
> same rule to include only 5 commits from the new side branch?
> What happens if there are less than 5 commits on that new side
> branch? =A0Would we end up including 'F', which the downloader
> specifically did not want when making this shallow clone
> initially?
>=20
> I won't go into the details, but when you think about what needs
> to happen when fetching _from_ a shallow clone (i.e. the
> uploader side is incomplete), your head will explode ;-). =A0It is
> solvable in the same sense that you can solve the previous
> "fetching to update" problem by trying to define a reasonable
> semantics to the operation by answering the questions I posed in
> the above paragraph (which obviously is no way an exhaustive
> set), but the result will be quite complex. =A0It would involve
> sending graft information both from uploader and downloader
> (after all the downloader side can also be shallow but with
> different cut-off points from the uploader) and somehow coming
> up with the intersection of both to arrive at a shared view of
> altered history before starting the traversal to find what to
> send.

The proposed solution was to send graft information and cutoff from
downloader to uploader, coming up with the effective graft points which
would be intersection of downloader and uploader grafts[*1*], and then =
use
this intersection as graft information when calculating what to send.

With sparse clone we would have:

 #---o---#---o---o---*---*---*---*---*
          \      ^              /    ^=20
           \   HEAD~5          /    HEAD
            \                 /
             o---o---*---*---*
                 ^           ^
             HEAD^^2~3     HEAD^^2

where # and * are the commit which the downloader has (# are additional
commits for sparse rather thatn shallow clone).

                 x---x---x---x---x---x
                /                     \
               /                       \
              /                         \
 #---o---#---F---o---*---*---*---*---H---x---X
          \                     /
           \                   /
            \                 /
             o---o---*---*---*

Now, when we are shallow fetching, we should have remembered somewhere =
the
cutoff used (or use the same cutoff). So we sould get then


                 x---*---*---*---*---*
                /                     \
               /                       \
              /                         \
 #---o---#---#---o---*---*---*---*---*---*---*
          \                     /
           \                   /
            \                 /
             o---o---*---*---*


=46ootnotes:
[*1*] It would be some kind of graph intersection. Note that the reposi=
tory
we clone from might be shallow clone, shallower in parts than our
repository, or might be repository with historic repository grafted on
(grafts adding history, not simplyfying it).

[*2*] I agree that shallow/sparse clone is hard. Lazy clone (or remote
alternatives) is also hard: when we do download objects, do we
download-ahead, do we cache downloaded object or move them to local
repository, how often we clean cache etc.
--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
