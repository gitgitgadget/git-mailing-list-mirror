From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Fix t7004 which fails with retarded sed
Date: Fri, 16 Nov 2007 20:17:15 +0100
Organization: glandium.org
Message-ID: <20071116191715.GB7624@glandium.org>
References: <20071116165944.GB29272@glandium.org> <1195233971-12288-1-git-send-email-mh@glandium.org> <7vpryaxczx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 16 20:18:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1It6hx-0000U0-IU
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 20:18:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753169AbXKPTSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 14:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752203AbXKPTSN
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 14:18:13 -0500
Received: from vawad.err.no ([85.19.200.177]:34147 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710AbXKPTSM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 14:18:12 -0500
Received: from aputeaux-153-1-42-198.w82-124.abo.wanadoo.fr ([82.124.6.198] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1It6hV-0007sJ-Sx; Fri, 16 Nov 2007 20:18:04 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1It6gl-00021s-IF; Fri, 16 Nov 2007 20:17:15 +0100
Content-Disposition: inline
In-Reply-To: <7vpryaxczx.fsf@gitster.siamese.dyndns.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: (score 5.0): Status=No hits=4.9 required=5.0 tests=RCVD_IN_DSBL,RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65243>

On Fri, Nov 16, 2007 at 10:26:58AM -0800, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > Brown paper bag fix to avoid test failure with retarded sed. The test
> > by itself didn't catch what it was supposed to, anyways.
> 
> I'd rather not to say "retarded sed".  It is not fair to blame
> the implementation when the script we feed to it is not
> portable.
> 
> >  test_expect_success \
> >  	'message in editor has initial comment' '
> >  	GIT_EDITOR=cat git tag -a initial-comment > actual || true &&
> > -	test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
> > +	grep -e "^$" actual > /dev/null 2>&1 &&
> > +	grep -e "^#" actual > /dev/null 2>&1 &&
> > +	! grep -e "^[^#]" actual > /dev/null 2>&1
> 
> The test simulates a case where
> 
> 	$ git tag -a initial-comment
> 
> is run and the user exits the editor without editing the file to
> add any text to annotate the tag.  The behaviour we want from
> such an invocation is (1) the user sees a sensible template in
> the editor, and (2) the command to error out, saying "Hey, you
> did not leave any message for us to use".
> 
> So the earlier part of the test
> 
> 	GIT_EDITOR=cat git tag -a initial-comment > actual || true &&
> 
> is already bogus with respect to the latter point.  It will
> happily continue if "git tag" erroneously returns success, and
> the above does not catch it.
> 
> 	if GIT_EDITOR=cat git tag -a initial-comment >actual
>         then
>         	echo >&2 oops we should have errored out
>                 false
> 	else
>         	: happy -- anything else we want to check?
> 	fi

This should probably be tested in another test block.

> The "actual" file contains what the user saw in the editor and
> returned to the "git tag" command.
> 
> The template we give to the user begins with a blank line,
> followed by a brief instruction "write a tag message" as
> comments to be stripped.  The test is trying to make sure that
> is what was given to the user.  As you already discussed in the
> thread, the exact wording may change in the future and we would
> not want to adjust the test every time.
> 
> I think the important points about this template are:
> 
>  * It begins with a single blank line, where the invoked editor
>    would typically place the editing curser at so that the user
>    can immediately start typing;
> 
>  * It has some instruction but that comes after that initial
>    blank line, all lines prefixed with "#".  I do not think we
>    would want to check the wording of this instruction.
> 
>  * And it has nothing else, as the expected behaviour is "Hey
>    you did not leave any message".

Which is roughly what my patch does, except it doesn't check for
ordering.

Mike
