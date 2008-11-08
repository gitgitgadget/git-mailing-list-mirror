From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Init on push
Date: Sat, 08 Nov 2008 11:26:27 -0800
Message-ID: <7viqqyc93w.fsf@gitster.siamese.dyndns.org>
References: <200811081708.45672.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 20:28:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KytTV-00059b-4v
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 20:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbYKHT0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 14:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbYKHT0q
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 14:26:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56979 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbYKHT0q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 14:26:46 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id CAD1894E31;
	Sat,  8 Nov 2008 14:26:44 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E2ECF94E30; Sat, 
 8 Nov 2008 14:26:31 -0500 (EST)
In-Reply-To: <200811081708.45672.robin.rosenberg.lists@dewire.com> (Robin
 Rosenberg's message of "Sat, 8 Nov 2008 17:08:45 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2DBAF542-ADCB-11DD-985A-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100416>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> git remote add someremote someurl
> git push --init someremote/someurl
>
> The implementation would invoke receive pack on the receiving side with
> an --init option. On the server side the repository would be created and
> initialized just as one had executed and mkdir and git init --bare.

We saw this quite a number of times.  I think it's about time we did
something about it.

But I do not think it is a reasonable design to give receive-pack such an
option.

An easy alternative would be to issue the usual "mkdir && git init" shell
script before spawning receive-pack.  This will limit the feature to
pushing over the ssh transport, and pushing over the git protocol against
a loose git-daemon will not be able to support it.  Also I suspect this
will break sites managed by gitosis, where all repositories are held under
the same UNIX user identity, differenciated only via an environment it
sets based on the ssh key used to make the connection.

I wonder if you can take a middle ground alternative:

 - Make "git push --init [--shared] $site:$there" and "git push --init
   [--shared] git://$site/$there" run "git init -D [--shared] $there"
   followed by "git receive-pack $there";

 - Teach "-D $there" option to "git init", which does an "mkdir -p $it &&
   chdird $it" before it does its work.
 
 - Teach "git daemon" about the "init" service, which is disabled by
   default, and can be enabled just like you can enable receive-pack
   there.

If sites like repo.or.cz, github, or managed with gitosis want to use
this, I think you might further need to give "git init -D $there" a hook
to control who can create new repositories at which location (gitosis is
the most interesting case, as described above).
