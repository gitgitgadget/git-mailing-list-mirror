From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 4/4] reset: add test cases for "--merge-dirty" option
Date: Tue, 15 Sep 2009 06:32:46 +0200
Message-ID: <200909150632.46444.chriscool@tuxfamily.org>
References: <20090910200334.3722.20140.chriscool@tuxfamily.org> <200909110705.35083.chriscool@tuxfamily.org> <alpine.LNX.2.00.0909110120520.28290@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Sep 15 06:31:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnPhW-00014O-Hf
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 06:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbZIOEbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2009 00:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbZIOEbY
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Sep 2009 00:31:24 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:40988 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247AbZIOEbY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2009 00:31:24 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 5D1C081802F;
	Tue, 15 Sep 2009 06:31:18 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D780B8180BA;
	Tue, 15 Sep 2009 06:31:15 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.LNX.2.00.0909110120520.28290@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128507>

On Friday 11 September 2009, Daniel Barkalow wrote:
> On Fri, 11 Sep 2009, Christian Couder wrote:
> > On Friday 11 September 2009, Daniel Barkalow wrote:
> > > On Thu, 10 Sep 2009, Christian Couder wrote:
> > >
> > >     This shows that with the "--merge-dirty" option,
> > >
> > >   changes that are both in the work tree and the index are kept
> > >
> > >     in the work tree after the reset (but discarded in the index). As
> > > with the "--merge" option,
> > >
> > >   changes that are in both the work tree and the index are discarded
> > >
> > >     after the reset.
> > >
> > > I'm lost here.
> > >
> > > If you have:
> > >
> > >          working index HEAD target
> > > version     B      B     A     A
> > >
> > > You get:
> > >
> > >          working index HEAD target
> > > --m-d       B      A     A     A
> > > --merge     A      A     A     A
> > >
> > > ?
> >
> > Yes, files that are not different between HEAD and target are changed
> > like that. Thanks for explaining it better than I could!
>
> I worked on the rules for merging way back when, so I've looked at tables
> of cases like that. If there are more cases to cover, it might work
> better to have a table like:
>
> working index HEAD target         working index HEAD
>    B      B     A     A   --m-d      B      A     A
>                           --merge    A      A     A
>    B      B     A     C   --m-d       (disallowed)
>                           --merge    C      C     C
>
> Are there other differences?

Yes, I found that I messed up the last test in patch 4/4. I forgot to 
replace some --merge with --merge-dirty :-(

In fact while "reset --merge" fails when there are changes in files that are 
changed between HEAD and target, "reset --merge-dirty" will not fail and 
discard these changes. So it is not really safe in this case and I am 
working on trying to make it safer in this case.

> > > > ---
> > > >  t/t7110-reset-merge.sh |   54
> > > > +++++++++++++++++++++++++++++++++++++++++++---- 1 files changed, 49
> > > > insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
> > > > index 45714ae..1e6d634 100755
> > > > --- a/t/t7110-reset-merge.sh
> > > > +++ b/t/t7110-reset-merge.sh
> > > > @@ -19,7 +19,7 @@ test_expect_success 'creating initial files' '
> > > >       git commit -m "Initial commit"
> > > >  '
> > > >
> > > > -test_expect_success 'ok with changes in file not changed by reset'
> > > > ' +test_expect_success '--merge: ok if changes in file not touched
> > > > by reset' '
> > >
> > > Should probably have the "--merge: " from the beginning, since you're
> > > adding the test in this series anyway. That would make the diff come
> > > out clearer.
> >
> > Yeah, but I am not sure that patches 3/4 and 4/4 will get merged in the
> > end. If they are not merged it will be better if there is no "--merge:
> > ".
>
> Maybe write those lines to mention "reset --merge" naturally? Like:
>
> 'ok with changes in file not changed by reset --merge'
>
> 'reset --merge discards changes added to index 1'

Ok I will do that.

Thanks,
Christian.
