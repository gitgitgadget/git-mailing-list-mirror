From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] * remote.c (valid_fetch_refspec): remove useless
 if-before-free test
Date: Wed, 20 Aug 2008 19:42:30 -0700
Message-ID: <7vpro3ks15.fsf@gitster.siamese.dyndns.org>
References: <87k5ecx2pl.fsf@rho.meyering.net>
 <pI8EXbuWhkm4pM0AaaTAPQQYBeFSffOSzCiM4NfNHKomivEcfUfShA@cipher.nrlssc.navy.mil> <7vr68jmdd2.fsf@gitster.siamese.dyndns.org> <aS-Yl0OfC9_Ks79Dz2qAKZMrGX1F6_mTNtSFuB45LyarCC5Zmb8agA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <meyering@redhat.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Aug 21 04:43:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW09G-0001Es-3g
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 04:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780AbYHUCmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 22:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752770AbYHUCmi
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 22:42:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37129 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752744AbYHUCmh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 22:42:37 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9D7CF58462;
	Wed, 20 Aug 2008 22:42:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id C89B658460; Wed, 20 Aug 2008 22:42:32 -0400 (EDT)
In-Reply-To: <aS-Yl0OfC9_Ks79Dz2qAKZMrGX1F6_mTNtSFuB45LyarCC5Zmb8agA@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Wed, 20 Aug 2008 19:33:11 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D056F880-6F2A-11DD-B317-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93090>

Brandon Casey <casey@nrlssc.navy.mil> writes:

>> Are you sure all the codepaths that stuff refspec[].{src,dst} give
>> freeable pointer?
>
> remote.c:parse_refspec_internal() always does. This function is the
> producer of the refspec that is being passed to free_refspecs() in the two
> places where the patch called it.
>
> The code paths for each additionally use of free_refspecs would have to
> check that it is safe. Perhaps a comment is in order.
>
> If you don't think we're ready for free_refspecs we can still call free()
> manually in the two places I called free_refspecs.

Thanks.

A generic helper like this is preferable, as long as (1) you made sure
existing callsites are safe, and (2) the helper is clearly commented
against misuse by future callsites.

I personally do not think it would be a bad idea to even make a rule that
refspec[].{src,dst} _must_ be freeable pointers.  After all, we may have
to deal with repositories with insane number of refs (not in millions but
certainly in thousands), but it would be insane to have a remote with
insane number of refspecs (even in hundreds).
