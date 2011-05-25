From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH v3 3/3] Add documentation for virtual repositories
Date: Wed, 25 May 2011 10:01:20 -0700
Message-ID: <BANLkTikwxiBTVdqnQtdvr-VTCm2hSOcRjw@mail.gmail.com>
References: <1306284392-12034-1-git-send-email-jamey@minilop.net>
 <1306284392-12034-3-git-send-email-jamey@minilop.net> <20110525160708.GE8795@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jamey Sharp <jamey@minilop.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Triplett <josh@joshtriplett.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 25 19:01:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPHT1-0004qA-0h
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 19:01:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755316Ab1EYRBm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2011 13:01:42 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:51568 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755289Ab1EYRBk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2011 13:01:40 -0400
Received: by vxi39 with SMTP id 39so5911860vxi.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 10:01:40 -0700 (PDT)
Received: by 10.52.109.36 with SMTP id hp4mr7339776vdb.97.1306342900070; Wed,
 25 May 2011 10:01:40 -0700 (PDT)
Received: by 10.52.167.228 with HTTP; Wed, 25 May 2011 10:01:20 -0700 (PDT)
In-Reply-To: <20110525160708.GE8795@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174429>

On Wed, May 25, 2011 at 09:07, Jeff King <peff@peff.net> wrote:
>
> Thinking on the whole idea a bit more, is there a reason to restrict
> this to upload-pack and receive-pack? Sure, they are the most obvious
> places to use it for hosting, but might I not want to be able to do:

No, there isn't. I had the same impression reading this series... that
doing it in upload-pack receive-pack was wrong, but I couldn't put my
finger on why. I think you did (below), so thank you.

> =A0cd /path/to/mega-repository.git
> =A0git --ref-prefix=3Dvirtual/repo1 log master
>
> to do server-side scripting inside the virtual repos (or more likely,
> setting GIT_REF_PREFIX at the top of your script).
>
>> +The --ref-prefix and --head options provide quite a bit of flexibil=
ity
=2E..
> I'm curious if you have a use for this much flexibility. In particula=
r,
> why do the HEAD and refs prefixes need the ability to be separate? Al=
so,
> what about other non-HEAD top-level refs? IOW, a true "virtual
> repository" to me would just be:
>
> =A0GIT_REF_PREFIX=3Drefs/virtual/repo1
>
> and then _every_ ref resolution would just prefix that, whether it wa=
s
> in refs/ or not. So you would have:
>
> =A0.git/refs/virtual/repo1/HEAD
> =A0.git/refs/virtual/repo1/refs/heads/master
> =A0.git/refs/virtual/repo1/refs/tags/v1.0
>
> and so on. And this fits in with the idea of it not just being an
> upload-pack and receive-pack thing. I could do:
>
> =A0GIT_REF_PREFIX=3Drefs/virtual/repo1; export GIT_REF_PREFIX
> =A0git fetch some-remote

+1 * 1000. This should be a single environment variable / top level
option. HEAD should also use the GIT_REF_PREFIX, like any other ref.

=46ETCH_HEAD and MERGE_HEAD probably should as well if GIT_REF_PREFIX i=
s
set, however these are going to be a bit harder to move. Not all tools
that read them are GIT_REF_PREFIX aware, or go through C code that can
be modified to be GIT_REF_PREFIX aware. (git-gui and EGit, I'm talking
about you here!)  They can obviously be fixed, but until then using a
working directory with GIT_REF_PREFIX set will be slightly
interesting.

> So the virtual repository is basically just a "chroot" of the ref
> namespace. And it's dirt simple to implement, because you do the
> translation at the refs.c layer.

Yes, exactly.

--=20
Shawn.
