From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use dashless git commands in setgitperms.perl
Date: Fri, 19 Sep 2008 18:27:20 -0700
Message-ID: <7v4p4b7gjr.fsf@gitster.siamese.dyndns.org>
References: <20080919234234.GL2939@inocybe.teonanacatl.org>
 <gb1ej9$bg2$1@ger.gmane.org> <20080920004814.GM2939@inocybe.teonanacatl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Todd Zullinger <tmz@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 20 03:28:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgrH1-00067Q-MR
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 03:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752642AbYITB12 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Sep 2008 21:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752539AbYITB11
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Sep 2008 21:27:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42642 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192AbYITB11 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Sep 2008 21:27:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 130C162A06;
	Fri, 19 Sep 2008 21:27:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 516E362A05; Fri, 19 Sep 2008 21:27:22 -0400 (EDT)
In-Reply-To: <20080920004814.GM2939@inocybe.teonanacatl.org> (Todd
 Zullinger's message of "Fri, 19 Sep 2008 20:48:14 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4843C2D4-86B3-11DD-A377-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96332>

Todd Zullinger <tmz@pobox.com> writes:

> Jakub Narebski wrote:
>> Todd Zullinger wrote:
>>=20
>>> =C2=A0# To save permissions/ownership data, place this script in yo=
ur .git/hooks
>>> =C2=A0# directory and enable a `pre-commit` hook with the following=
 lines:
>>> =C2=A0# =C2=A0 =C2=A0 =C2=A0#!/bin/sh
>>> -# =C2=A0 =C2=A0 SUBDIRECTORY_OK=3D1 . git-sh-setup
>>> +# =C2=A0 =C2=A0 SUBDIRECTORY_OK=3D1 . git sh-setup
>>> =C2=A0# =C2=A0 =C2=A0 $GIT_DIR/hooks/setgitperms.perl -r
>>> =C2=A0#
>>> =C2=A0# To restore permissions/ownership data, place this script in=
 your .git/hooks
>>> =C2=A0# directory and enable a `post-merge` and `post-checkout` hoo=
k with the
>>> =C2=A0# following lines:
>>> =C2=A0# =C2=A0 =C2=A0 =C2=A0#!/bin/sh
>>> -# =C2=A0 =C2=A0 SUBDIRECTORY_OK=3D1 . git-sh-setup
>>> +# =C2=A0 =C2=A0 SUBDIRECTORY_OK=3D1 . git sh-setup
>>> =C2=A0# =C2=A0 =C2=A0 $GIT_DIR/hooks/setgitperms.perl -w
>>> =C2=A0#
>>=20
>> The rest is probably O.K., but I don't think this change is good one=
=2E
>
> I don't see git-sh-setup in /usr/bin with a default install of git
> 1.6, so without this change, wouldn't the comments be suggesting a
> potentially broken hook configuration?

The patch is wrong on one point, and should be unnecessary.

=46irst of all, you do not understand what "."  does in shell ;-)  That=
 is
the "wrong" part.

About the "unnecessary" part, a hook should run under an environment wh=
ere
exec-path is already added to the $PATH, so it should be able to find
git-sh-setup just fine without your change.

But I think the politically correct way would be:

	#!/bin/sh
	PATH=3D$(git --exec-path):$PATH
        SUBDIRECTORY_OK=3D1 . git-sh-setup
	$GIT_DIR/hooks/setgitperms.perl -r

especially if we envision that somebody may run the script by itself, n=
ot
from the hook.

The change to the perl script should not be strictly necessary (because
this is expected to be run from a hook), but to set a better example, I
think it is a good idea to do these s/git-/git / substitutions.
