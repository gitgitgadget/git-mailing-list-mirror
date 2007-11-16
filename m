From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix t7004 which fails with retarded sed
Date: Fri, 16 Nov 2007 10:26:58 -0800
Message-ID: <7vpryaxczx.fsf@gitster.siamese.dyndns.org>
References: <20071116165944.GB29272@glandium.org>
	<1195233971-12288-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Nov 16 19:27:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1It5uc-0005I7-I3
	for gcvg-git-2@gmane.org; Fri, 16 Nov 2007 19:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762194AbXKPS1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2007 13:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761992AbXKPS1M
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Nov 2007 13:27:12 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:56200 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760345AbXKPS1K (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2007 13:27:10 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 7315E2F0;
	Fri, 16 Nov 2007 13:27:26 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id E3C9596689;
	Fri, 16 Nov 2007 13:27:23 -0500 (EST)
In-Reply-To: <1195233971-12288-1-git-send-email-mh@glandium.org> (Mike
	Hommey's message of "Fri, 16 Nov 2007 18:26:11 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65238>

Mike Hommey <mh@glandium.org> writes:

> Brown paper bag fix to avoid test failure with retarded sed. The test
> by itself didn't catch what it was supposed to, anyways.

I'd rather not to say "retarded sed".  It is not fair to blame
the implementation when the script we feed to it is not
portable.

>  test_expect_success \
>  	'message in editor has initial comment' '
>  	GIT_EDITOR=cat git tag -a initial-comment > actual || true &&
> -	test $(sed -n "/^\(#\|\$\)/p" actual | wc -l) -gt 0
> +	grep -e "^$" actual > /dev/null 2>&1 &&
> +	grep -e "^#" actual > /dev/null 2>&1 &&
> +	! grep -e "^[^#]" actual > /dev/null 2>&1

The test simulates a case where

	$ git tag -a initial-comment

is run and the user exits the editor without editing the file to
add any text to annotate the tag.  The behaviour we want from
such an invocation is (1) the user sees a sensible template in
the editor, and (2) the command to error out, saying "Hey, you
did not leave any message for us to use".

So the earlier part of the test

	GIT_EDITOR=cat git tag -a initial-comment > actual || true &&

is already bogus with respect to the latter point.  It will
happily continue if "git tag" erroneously returns success, and
the above does not catch it.

	if GIT_EDITOR=cat git tag -a initial-comment >actual
        then
        	echo >&2 oops we should have errored out
                false
	else
        	: happy -- anything else we want to check?
	fi

The "actual" file contains what the user saw in the editor and
returned to the "git tag" command.

The template we give to the user begins with a blank line,
followed by a brief instruction "write a tag message" as
comments to be stripped.  The test is trying to make sure that
is what was given to the user.  As you already discussed in the
thread, the exact wording may change in the future and we would
not want to adjust the test every time.

I think the important points about this template are:

 * It begins with a single blank line, where the invoked editor
   would typically place the editing curser at so that the user
   can immediately start typing;

 * It has some instruction but that comes after that initial
   blank line, all lines prefixed with "#".  I do not think we
   would want to check the wording of this instruction.

 * And it has nothing else, as the expected behaviour is "Hey
   you did not leave any message".
