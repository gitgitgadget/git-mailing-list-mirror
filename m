From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] help git-upload-pack find git
Date: Mon, 15 Sep 2008 22:22:19 +0200
Message-ID: <48CEC3FB.5070101@drmicha.warpmail.net>
References: <d3a045300809150130w6f78edd8xf599d1c7f639b77d@mail.gmail.com> <d3a045300809150130w6f78edd8xf599d1c7f639b77d@mail.gmail.com> <1221495891-12600-1-git-send-email-git@drmicha.warpmail.net> <7vzlm9b3v4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 22:23:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfKbc-0003Q2-BP
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 22:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754170AbYIOUWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 16:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754166AbYIOUWZ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 16:22:25 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35397 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754087AbYIOUWY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Sep 2008 16:22:24 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 99E6F16212A;
	Mon, 15 Sep 2008 16:22:23 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 15 Sep 2008 16:22:23 -0400
X-Sasl-enc: /0Y8xg+2YFGUuSkX6KN4o19Yx2g1SVn9izLZyaRKj0Lj 1221510143
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 158F12C490;
	Mon, 15 Sep 2008 16:22:22 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.16 (X11/20080707)
In-Reply-To: <7vzlm9b3v4.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95938>

Junio C Hamano venit, vidit, dixit 15.09.2008 21:34:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> The corresponding bug was reported by Paul Johnston who wondered why
>> "git clone" failed when specifying --upload-pack for an out-of-$PATH
>> installation of git.  I'm not sure whether we should encourage this, but
>> the --upload-pack option clearly gives the impression that
>> git-upload-pack is all that is needed.
> 
> Another possibility would be to teach exec_cmd.c:setup_path() to add the
> directory specified by $(bindir) to PATH after we add GIT_EXEC_PATH to
> it.  That should cover the case David Miller reported, shouldn't it?

Probably. I read that thread only after submitting my patch for
upload-pack but suspected that other server side incarnations may suffer
from the same problem.

I was actually surprised that setup_path() uses argv0_path without
setting it, same as with argv_exec_path. I assumed this is for a good
reason, I'm lacking the code base overview to judge this myself.

In any case, git.c sets argv0_path early, messes a bit with argv[0] and
calls setup_path afterwards anyways. So adding the path in setup_path()
should not hurt any "git foo" command.

One could construe situations where even that wouldn't help, because
git-upload-pack can't pass --exec-dir to git and they can be in
different locations - but I think that's crazy.

git.c, upload-pack.c, receive.pack.c and shell.c are the only callers.
setup_path() needs to get a parameter. If shell.c should profit from the
change then it needs to be taught how to pass an absolute path to
do_{generic,cvs}_cmd().

So, I guess the general approach (change setup() path and have every
caller profit) is OK. OK with you?

Michael
