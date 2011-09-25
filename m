From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [PATCH/RFC 0/2] Teach receive-pack not to run update hook for
 corrupt/non existent ref
Date: Sun, 25 Sep 2011 17:35:03 +0530
Message-ID: <CAMK1S_h3ufrK29_ajpcSSW7HV6ZA8z8ZVHvhHr2bx5Cga5FAKQ@mail.gmail.com>
References: <1316927182-14212-1-git-send-email-pangyanhan@gmail.com>
	<CAMK1S_hadzaqixaW3Fx81pf=hVsvAMpVvVGqVtZ8ncfUsie_9w@mail.gmail.com>
	<20110925094822.GA1702@myhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Pang Yan Han <pangyanhan@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King
X-From: git-owner@vger.kernel.org Sun Sep 25 14:05:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7nSW-0007Cc-Mq
	for gcvg-git-2@lo.gmane.org; Sun, 25 Sep 2011 14:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449Ab1IYMFG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Sep 2011 08:05:06 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35655 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278Ab1IYMFE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Sep 2011 08:05:04 -0400
Received: by vws1 with SMTP id 1so5095199vws.19
        for <git@vger.kernel.org>; Sun, 25 Sep 2011 05:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=L3Ofz/Yu9K/izS1XrvkwwFQNZ3gtxyv3YEIOsE1j0K4=;
        b=X/zm/2Xdowbqix2d4yzuqr+BLDOmfA3XCVjx4ZHlP/1PLTYm3oFwfYrwBIKiaeMuM5
         2XZljxvEnsPdWrcLkQNdMoRaY6yhbrxP0MpH/L47lUMrzlytfOa7PHbvLew7PtFdICCa
         4EnG8ORfZ3a6hw54K+qtHdtXjTx/o8ssJCzDg=
Received: by 10.52.70.180 with SMTP id n20mr5565753vdu.134.1316952303596; Sun,
 25 Sep 2011 05:05:03 -0700 (PDT)
Received: by 10.52.160.161 with HTTP; Sun, 25 Sep 2011 05:05:03 -0700 (PDT)
In-Reply-To: <20110925094822.GA1702@myhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182065>

On Sun, Sep 25, 2011 at 3:18 PM, Pang Yan Han <pangyanhan@gmail.com> wr=
ote:
> On Sun, Sep 25, 2011 at 01:28:31PM +0530, Sitaram Chamarty wrote:

[snip]

>> It doesn't make sense to disable only the update hook. =C2=A0And alt=
hough I
>> did not come right out and say it, it is the post-update that I care
>> about. =C2=A0If that still runs, my "issue" still exists.

> Um I'm rather new to Git and the reason why I didn't reply this initi=
ally was
> because I didn't know what to reply. Sorry but you sound rather aggre=
ssive and
> I was really taken aback by this.

Sorry if I sounded aggressive; I was going to brevity, and levity suffe=
red :-)

[snip lots of stuff about new approach]

> What do you think of this approach (if it's even correct)?

I'm sorry again but it's been almost 2 decades since I did any serious
C and I've never dug into git internals, so I can't tell you if you're
even on the right track.  You should wait for one of the other folks
you cc-d to weigh in with their opinions.

Personally, anytime someone says "disable the update hook" I get very
worried -- I've got a heck of a lot invested in update hooks ;-)

I wasn't even *asking* about disabling that; I was asking about
*post*-update, which you didn't even address in your code.

=46rom a philosophical point of view, update and pre-receive *check*
things to make sure everything is OK.  IMO they should be allowed to
run even if the ref being deleted doesn't exist -- that could well be
an error condition that the guy who owns the repo wants to trap and
alert himself to in some special way.  I would *not* like them
disabled.

Post-{update,receive} are for *after* a successful push.  My
suggestion would be to make sure the inputs supplied to those hooks
(via STDIN for post-receive, and as arguments in case of post-update)
reflect this -- only successfully updated refs are sent in as args.

This might mean that in the case of 'git push origin
:refs/heads/non-existent-ref' the post-receive hook would run but
STDIN would be empty, and post-update would run but have no arguments.

That is, IMO, the correct way to deal with this.
