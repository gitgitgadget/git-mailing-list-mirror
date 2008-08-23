From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-submodule: replace duplicated code with a
 module_list function
Date: Fri, 22 Aug 2008 18:01:40 -0700
Message-ID: <7vpro04k97.fsf@gitster.siamese.dyndns.org>
References: <edc9ece47ca86c3c3e4265e7f4222c8ea6917461.1219390139.git.davvid@gmail.com>
 <7vpro064qz.fsf@gitster.siamese.dyndns.org> <48AF533E.9020102@gmail.com>
 <7v8wuo619x.fsf@gitster.siamese.dyndns.org> <48AF5BA0.5050001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 03:02:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWhWl-0006vu-9N
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 03:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbYHWBBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 21:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbYHWBBr
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 21:01:47 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43805 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbYHWBBq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 21:01:46 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 06FF76991C;
	Fri, 22 Aug 2008 21:01:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 567C46991B; Fri, 22 Aug 2008 21:01:42 -0400 (EDT)
In-Reply-To: <48AF5BA0.5050001@gmail.com> (Mark Levedahl's message of "Fri,
 22 Aug 2008 20:36:48 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0EC1C084-70AF-11DD-829A-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93413>

Mark Levedahl <mlevedahl@gmail.com> writes:

> As the command is required, while pathspec is optional, the latter
> should require the option, not the former. How about...
>
>    $ git submodule foreach [-l pathspec] 'command'
>
> or
>
>    $ git submodule foreach [<pathspec> --] 'command'

Neither would fly well.  For all normal git command, pathspec comes after
the double dash.

And I think it is probably a mistake to think "the command is required" as
anything holy.  "submodule foreach" looks very much like an index aware
"find".  Perhaps we could even make the lack of 'command' to default to
"echo its name", just like "find ." and "find . -print" are equivalent (I
am not seriously suggesting this, though.  Read on).

Having said all that, I think you can have best of both worlds by doing
something like this:

 - If you do not have -c 'command' or any option, then everything is
   command and you cannot limit with pathspecs.  This is the original
   syntax.

 - If you do have options to "foreach", then -c 'command' string is the
   command, and perhaps the foreach subcommand will gain other options
   over time, including possible -- pathspec separator.  The remainder of
   the command line after options are processed are pathspecs that limit
   the ls-files.

I do not think it is a defect that we do not allow pathspec limited
foreach subcommand.  Teaching foreach to take pathspecs is an independent
topic if somebody has such an itch.

As a conclusion of this discussion, I think David's [1/2] is fine as-is.

Thanks.
