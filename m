From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Tue, 27 Sep 2005 11:36:24 -0700
Message-ID: <7v64sm1hp3.fsf@assigned-by-dhcp.cox.net>
References: <7virwna2oi.fsf@assigned-by-dhcp.cox.net>
	<7v3bnra20z.fsf@assigned-by-dhcp.cox.net> <43348086.2040006@zytor.com>
	<20050924011833.GJ10255@pasky.or.cz>
	<20050926212536.GF26340@pasky.or.cz>
	<7virwna2oi.fsf@assigned-by-dhcp.cox.net>
	<20050926222944.GG26340@pasky.or.cz>
	<7vr7bb5d8w.fsf@assigned-by-dhcp.cox.net>
	<8764snyufn.fsf@ualberta.net>
	<7v4q875bbj.fsf@assigned-by-dhcp.cox.net>
	<20050927094029.GA30889@pasky.or.cz>
	<7v64sm30dh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509271020530.3308@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Tom Prince <tom.prince@ualberta.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 20:37:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKKJf-0004ru-5M
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 20:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbVI0Sg1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 14:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbVI0Sg1
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 14:36:27 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:3525 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S965036AbVI0Sg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 14:36:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050927183624.ZJWQ16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Sep 2005 14:36:24 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9413>

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 27 Sep 2005, Junio C Hamano wrote:
>> 
>> This is a bit hard and needs some thinking to do cleanly,
>> because what is in info/refs is what is sent from the publisher
>> side over git-native protocol at the beginning of the handshake,
>> and it is not easy to add that to git-native protocol cleanly
>> and backward-compatibly (I think I know how without breaking
>> existing clients, but it is not clean).
>
> Argh.
>
> "git-upload-pack" very much on purpose never sends partial object stores: 
> it really doesn't want to send a tag-object for you to even _look_ at 
> unless it also sends all the objects that you are missing that the tag 
> refers to.
>
> I'd really be much happier with the tag fetching being separate.

What Pasky wants to do, which I misunderstood first and gave
essentially the same response to, is to help this senario:

    User tracks git.git#master and nothing else, i.e. she pulls
    from my master branch from time to time.  The tool notices
    that I tagged a commit on the master branch (not necessarily
    the tip at the time of pulling) with v0.99.8 tag, which she
    has not have, and fetches v0.99.8 tag and stores it under
    .git/refs/.  Currently Cogito does not let her specify
    where on the receiving end to place that tag and always
    places it in .git/refs/tags/v0.99.8, but that can be fixed
    later.

The current ls-remote (or underlying fetch-pack protocol) does
not help this because the SHA1 given to Cogito is the object
name of the tag, and without fetching the tag object and looking
at what it refers to, Pasky cannot say "Oh, this new v0.99.8 tag
is the commit on the branch being tracked".

The protocol extension I had in mind, which I said is not clean,
is from upload_pack(), in addition to the existing send_ref()
call which sends "object-name refname" list like this:

4899334e96a076bb8780968c5075b214aa80fab9	HEAD
d5bc7eecbbb0b9f6122708bf5cd62f78ebdaafd8	refs/heads/maint
3cc35e29ec252d0dca1139106fbaa70cb9ad6ef1	refs/heads/master
4899334e96a076bb8780968c5075b214aa80fab9	refs/heads/pu
348c4c66dacb1810a9bcd592e72f98a465233488	refs/heads/rc
0918385dbd9656cab0d1d81ba7453d49bbc16250	refs/tags/junio-gpg-pub
d6602ec5194c87b0fc87103ca4d67251c76f233a	refs/tags/v0.99
f25a265a342aed6041ab0cc484224d9ca54b6f41	refs/tags/v0.99.1
...

we could send phony entries like this:

b92c9c07fe2d0d89c4f692573583c4753b5355d2	deref/tags/junio-gpg-pub
a3eb250f996bf5e12376ec88622c4ccaabf20ea8	deref/tags/v0.99
78d9d414123ad6f4f522ffecbcd9e4a7562948fd	deref/tags/v0.99.1

These phony entries tell the receiver what the tags eventually
resolve to.  Pasky could use this to see if he has the named
object from the usual fetch path, and if he finds matches,
ask git-fetch-pack to get them.

We would need to teach git-clone and git-fetch to ignore deref/
if they do not already do so.
