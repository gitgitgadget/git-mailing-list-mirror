From: Colin Walters <walters@verbum.org>
Subject: Re: weaning distributions off tarballs: extended verification of git
 tags
Date: Mon, 02 Mar 2015 12:09:57 -0500
Message-ID: <1425316197.895196.234425829.536E6C06@webmail.messagingengine.com>
References: <1425134885.3150003.233627665.2E48E28B@webmail.messagingengine.com>
 <CANv4PNmF9sTh8od9xT5tYTOF1Cv0Mev2Muf-qxQDS_6kE7EnOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing List <git@vger.kernel.org>
To: Morten Welinder <mwelinder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 02 18:10:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YSTr6-0007CS-N1
	for gcvg-git-2@plane.gmane.org; Mon, 02 Mar 2015 18:10:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754502AbbCBRKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2015 12:10:01 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54235 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753865AbbCBRKA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Mar 2015 12:10:00 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 941C1202B4
	for <git@vger.kernel.org>; Mon,  2 Mar 2015 12:09:56 -0500 (EST)
Received: from web4 ([10.202.2.214])
  by compute6.internal (MEProxy); Mon, 02 Mar 2015 12:09:57 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:x-sasl-enc:from:to:cc
	:mime-version:content-transfer-encoding:content-type:in-reply-to
	:references:subject:date; s=smtpout; bh=ElFBU3pxA0yBShT6U8tWu0pa
	gGs=; b=eeD0L9GDi8kd4PQQo2BBGkOYgus99ujO31pt5C60a/yjRkWGdgArll6w
	eYDSHL5iJ8qdHm4myEDGe5vxk348tQrMgJV8YS33cJm/o76rdM+JGjLea10pD8hh
	pHXkXqlcUYHS+g5Y3O4BzIsiTKp3NEaYxbZgHnh0h/MyoGjphrg=
Received: by web4.nyi.internal (Postfix, from userid 99)
	id 3818710BC92; Mon,  2 Mar 2015 12:09:57 -0500 (EST)
X-Sasl-Enc: tj5Ez4jUtB/V46sjEiWA73KZrZUKMQcnn7PKScvNokw6 1425316197
X-Mailer: MessagingEngine.com Webmail Interface - ajax-4ba7306c
In-Reply-To: <CANv4PNmF9sTh8od9xT5tYTOF1Cv0Mev2Muf-qxQDS_6kE7EnOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264605>

On Sat, Feb 28, 2015, at 03:34 PM, Morten Welinder wrote:
> Is there a point to including a different checksum inside
> a git tag?  If someone can break the SHA-1 checksum
> in the repository then the recorded SHA-256 checksum can
> be changed.  In other words, wouldn't you be just as well
> off handing someone a SHA-1 commit id?

The issue is more about what the checksum covers, as
well as its strength.  Git uses a hash tree, which means
that an attacker only has to find a collision for *one* of
the objects, and the signature is still valid.  And that collision
is valid for *every* commit that contains that object.

This topic has been covered elsewhere pretty extensively,
here's a link:
https://www.whonix.org/forum/index.php/topic,538.msg4278.html#msg4278

Now I think rough consensus is still that git is "secure" or
"secure enough" - but with this proposal I'm just trying
to overcome the remaining conservatism.  (Also, while those
discussions were focusing on corrupting an existing repository,
the attack model of MITM also exists, and there
you don't have to worry about deltas, particularly if the
attacker's goal is to get a downstream to do a build
and thus execute their hostile code inside the downstream
network).

It's really not that expensive to do once per release,
basically free for small repositories, and for a large one like
the Linux kernel:

$ cd ~/src/linux
$ git describe
v3.19-7478-g796e1c5
$ time /bin/sh -c 'git archive --format=tar HEAD|sha256sum'
4a5c5826cea188abd52fa50c663d17ebe1dfe531109fed4ddbd765a856f1966e  -

real	0m3.772s
user	0m6.132s
sys	0m0.279s
$

With this proposal, the checksum
covers an entire stream of objects for a given commit at once;
making it significantly harder to find a collision.  At least as good as 
checksummed tarballs, and arguably better since it's
pre-compression.

So to implement this, perhaps something like:

$ git archive --format=raw

as a base primitive, and:

$ git tag --archive-raw-checksum=SHA256 -s -m "..."

?

"git fsck" could also learn to optionally use this.
