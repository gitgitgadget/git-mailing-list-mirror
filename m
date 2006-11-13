X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Matthias Hopf <mhopf@suse.de>
Subject: Re: Getting new branches from remote repo.
Date: Mon, 13 Nov 2006 17:57:09 +0100
Message-ID: <20061113165709.GA21588@suse.de>
References: <6e1787fe0611122033p49671e13xf5b7f95beeba8b06@mail.gmail.com> <7v8xigar36.fsf@assigned-by-dhcp.cox.net> <20061113091736.GA31693@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 13 Nov 2006 17:02:48 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Mail-Followup-To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Junio C Hamano <junkio@cox.net>,
	Alexander Litvinov <litvinov2004@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20061113091736.GA31693@diana.vm.bytemark.co.uk>
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31302>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjfAy-00054w-Pq for gcvg-git@gmane.org; Mon, 13 Nov
 2006 18:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755219AbWKMQ5c convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006 11:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755155AbWKMQ5S
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 11:57:18 -0500
Received: from cantor.suse.de ([195.135.220.2]:663 "EHLO mx1.suse.de") by
 vger.kernel.org with ESMTP id S1755228AbWKMQ5Q (ORCPT
 <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 11:57:16 -0500
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8]) (using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by mx1.suse.de (Postfix) with ESMTP id C7F451201F; Mon, 13 Nov
 2006 17:57:14 +0100 (CET)
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Sender: git-owner@vger.kernel.org

On Nov 13, 06 10:17:36 +0100, Karl Hasselstr=F6m wrote:
> > > I have a trouble I don't know how to solve. When I am cloning
> > > remote repo I automatically get all it's branches stored at my
> > > repo (they are listed at .git/remotes/origin). When someone adds
> > > new branch(es) to remote repo git pull (git fetch) does not
> > > automatically add them to my repo. I have a tool to list all
> > > remote branches (git ls-remote --heads origin) but I can't find
> > > how to add interesting (or all) branches to by repo.
> >
> > After finding out $that_new_branch's name, add either
> >       Pull: refs/heads/$that_new_branch:refs/heads/$that_new_branch
> > or if you are in "separate remote" school, then perhaps
> >       Pull: refs/heads/$that_new_branch:refs/remotes/origin/$that_n=
ew_branch
> > to .git/remotes/origin and running git fetch would give you what yo=
u
> > want, I think.
>=20
> There really should be a flag to make git fetch do this job. And if w=
e
> use separate remotes, the flag should probably default to "on".

This was an issue I stumbled upon recently, which was discussed on
X.org's mailing list. I wanted to sumarize that here, but didn't have
time for that so far.

Right now I use the following UGLY script to do exactly that:

git-ls-remote -h origin | cut -f 2 | perl -e 'while (<>) { chomp;
$h{$_}=3D$_; } open F, ".git/remotes/origin" or die; while (<F>) { prin=
t;
if (/^Pull:\s+([^: ]*):/) { delete $h{$1}; } } foreach $f (keys %h) {
print "Pull:   ${f}:$f\n"; }' > newfile
mv newfile .git/remotes/origin

(modulo some safety tests), but that doesn't work right for origin file=
s
with multiple URL: statements (I very much assume they are possible).

I second that there should be a flag to make git fetch do that
automatically, and at least all "git for CVS users" tutorials should
include this flag, as this is exactly how CVS works (otherwise you
cannot check out another branch that happens to be added upstream).

Matthias

--=20
Matthias Hopf <mhopf@suse.de>       __        __   __
Maxfeldstr. 5 / 90409 Nuernberg    (_   | |  (_   |__         mat@mshop=
f.de
Phone +49-911-74053-715            __)  |_|  __)  |__  labs   www.mshop=
