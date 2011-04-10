From: "Steven E. Harris" <seh@panix.com>
Subject: Re: Confused over packfile and index design
Date: Sun, 10 Apr 2011 16:10:46 -0400
Organization: SEH Labs
Message-ID: <m24o657tq1.fsf@Spindle.sehlabs.com>
References: <m2d3kw70su.fsf@Spindle.sehlabs.com>
	<alpine.LFD.2.00.1104092147520.28032@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 10 22:11:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q90yh-0005Mu-2Y
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 22:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752748Ab1DJULF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Apr 2011 16:11:05 -0400
Received: from lo.gmane.org ([80.91.229.12]:58462 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751914Ab1DJULC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 16:11:02 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Q90yK-0005CU-ER
	for git@vger.kernel.org; Sun, 10 Apr 2011 22:11:00 +0200
Received: from 75-144-0-121-busname-pa.hfc.comcastbusiness.net ([75.144.0.121])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 22:11:00 +0200
Received: from seh by 75-144-0-121-busname-pa.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 22:11:00 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 75-144-0-121-busname-pa.hfc.comcastbusiness.net
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.50 (darwin)
Cancel-Lock: sha1:8ooTH2yUu6iHaCvAvABzUkYfqYQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171285>

Nicolas Pitre <nico@fluxnic.net> writes:

> So the idea is to do that once to construct the pack index and allow
> for random access once the index is available.  Accessing a particula=
r
> object without the pack index would be extremely costly otherwise,
> especially if it is towards the end of the pack.

Thanks for the explanation. It's clear now.

> The reason for storing only the expanded data size is to have the
> exact buffer size allocated for the inflated data.  The zlib stream
> that follows is encoded to consume only the needed data to produce th=
e
> inflated object.  When the output buffer is all used, the zlib librar=
y
> should flag the end of the deflated stream.  If not then there is an
> error in the pack data.

That provides some error checking, then, as we trust zlib to know when
it's had enough input, and we have to trust its assessment on how much
is enough, given the lack of delimiting or framing in the packfile
format.

By the way, I looked over the zlib manual=C2=B9, and I see that many of=
 the
inflating/decompressing functions require the caller to specify the
number of input bytes available. There is inflateBack() that uses
callback functions to request more data upon underflow. The higher-leve=
l
inflate() function also looks like it can be called in a loop, refillin=
g
the input buffer upon underflow. Is Git using one of these two function=
s
here?

[...]

> When in doubt, the code is always the ultimate source of information.

Yes, I need to learn my way around in there to find the call sites
relevant to this discussion.


=46ootnotes:=20
=C2=B9 http://www.zlib.net/manual.html

--=20
Steven E. Harris
