X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: multi-project repos (was Re: Cleaning up git user-interface
 warts)
Date: Thu, 16 Nov 2006 10:21:37 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611160958170.3349@woody.osdl.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
 <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
 <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
 <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
 <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
 <455C412D.1030408@xs4all.nl> <Pine.LNX.4.64.0611160814560.3349@woody.osdl.org>
 <455C94FA.3050903@xs4all.nl> <Pine.LNX.4.64.0611160904010.3349@woody.osdl.org>
 <455CA2A8.5010700@xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 16 Nov 2006 18:22:04 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <455CA2A8.5010700@xs4all.nl>
X-MIMEDefang-Filter: osdl$Revision: 1.156 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31610>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkls4-0003rx-1N for gcvg-git@gmane.org; Thu, 16 Nov
 2006 19:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162073AbWKPSVw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 13:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162068AbWKPSVw
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 13:21:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39917 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1162073AbWKPSVv (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 13:21:51 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAGILcoZ019537
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 16
 Nov 2006 10:21:39 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAGILbtU000883; Thu, 16 Nov
 2006 10:21:37 -0800
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
Sender: git-owner@vger.kernel.org



On Thu, 16 Nov 2006, Han-Wen Nienhuys wrote:
> 
> You're misunderstanding me: the multi-repo is at git.sv.gnu.org is the
> remote one. The example I gave was about locally creating a single
> project repo from a remote multiproject repo. 

Ahh.

Ok, try the patch I just sent out, and see if it works for you. It 
_should_ allow you to do exactly that

	mkdir new-repo
	cd new-repo
	git init-db
	git pull <remote> <onehead>

and now your "master" branch should be initialized to "onehead".

Oh, except I just realized that I forgot to do a "git checkout" in my 
patch, so you'd need to add that (or do it by hand, but you really 
shouldn't need to, since the checkout is implied by the "pull").

The downside with this is that it does NOT populate your "remotes" 
information (like "git clone" would have done), so either we'd need to 
teach "git pull" to do that too, or you just have to do it by hand (so 
that you then can do the shorthand "git pull" to update in the future).

> On a tangent: why is there no reverse-clone?  I have no shell access
> to the machine, so when I created the remote repo, I had to push, and
> ended up putting 1.2 Gb data on the server.

Yeah, you're supposed to "init-db" and "push". Right now, that tends to 
unpack everything (which is bad), although that is hopefully getting fixed 
(ie the receiving end shouldn't unpack any more if it is recent. Junio?)

> <looks at manpage>
> 
> is this send-pack?

"git push" uses send-pack internally, you shouldn't ever need to use it 
yourself.

> From UI perspective it would be nice if this could also be done with clone,
> 
>   git clone . ssh+git://....

The creation of a new archive tends to need special rights (with _real_ 
ssh access and a shell you could do it, but "ssh+git" really means "git 
protocol over a connection that was opened with ssh, but doesn't 
necessarily have a real shell at the other end").

So for most protocols, you simply cannot (and shouldn't) do it. Think 
about services like the one that Pasky has set up, that allow you to set 
up a new git repo - the setup phase really _has_ to be separate (because 
you need to set up your keys etc).

So I think the above syntax is actually not a good one, because it cannot 
work in the general case. It's much better to get used to setting up a 
repo first, and then pushing into it, and just accepting that it's a 
two-phase thing.

Also, from a bandwidth standpoint, you can often (although obviously not 
always) make the setup start with something that is _closer_ to what you 
want to do. So, for example, you'd often do something like:

 (a) ssh to central repository
 (b) create the new repository by cloning it _locally_ at the central 
     place from some other repository that is related
 (c) then, from your local (non-central) repository, do a "git push --force"
     to force your changes (which now only needs the _incremental_ thing).

An example of this is again the "forking" thing that he repos at  at 
http://git.or.cz/ already supports. 


> >And that "git pull" semantic actually means that if you want a _bare_ 
> >repository, I think "git --bare init-db" + "git --bare fetch" actually
> 
> yes, this works. Two remarks:
> 
> * it needs
> 
>   website/master:master
> 
> otherwise you still don't have a branch.

Right. In fact, you should probably do

	website/master:refs/heads/master

just to make it really explicit.

> * why are objects downloaded twice?  If I do
> 
>   git --bare fetch git://git.sv.gnu.org/lilypond.git web/master
> 
> it downloads stuff, but I don't get a branch.

A "fetch" by default won't actually generate a local branch unless you 
told it to. It just squirrels the end result into the magic FETCH_HEAD 
name, so that you can do

	# do the fetch
	git fetch git://git.sv.gnu.org/lilypond.git web/master

	# look at changes
	gitk ..FETCH_HEAD

	# If you're happy with them, merge them in
	git merge "merge new code" HEAD FETCH_HEAD

and you never actually created a real local branch at all.

If you want "git fetch" to fetch _into_ a branch, you need to tell it so, 
by using the full "src:dest" format. Otherwise it doesn't know what branch 
to fetch it into.

(And, of course, you can define that branch relationship in your remote 
configuration, so you don't actually have to say it explicitly every time)

> If I then do 
> 
>   git --bare fetch git://git.sv.gnu.org/lilypond.git web/master:master
> 
> it downloads the same stuff again. 

Right. So you can either

 (a) do it that way to begin with (because you now told it to put the 
     results in "master", so you never needed to do the second fetch in 
     the first place)

or

 (b) after you did the first fetch (into FETCH_HEAD), you could also have 
     just decided to do 

	git update-ref HEAD FETCH_HEAD ""

     (where that "" at the end is really not technically necessary, but it 
     tells "update-ref" that you _only_ want to do this if the old HEAD 
     was empty/undefined. Without it, "git update-ref" will just 
     overwrite HEAD without caring what it contained before, so it can be 
     a dangerous operation!)

See?

