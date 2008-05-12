From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/5] git-submodule.sh: Add Custom argument input
 support to git submodule recurse subcommand
Date: Mon, 12 May 2008 15:43:34 -0700
Message-ID: <7v7idzxhwp.fsf@gitster.siamese.dyndns.org>
References: <1209978582-5785-1-git-send-email-imyousuf@gmail.com>
 <1209978582-5785-2-git-send-email-imyousuf@gmail.com>
 <1209978582-5785-3-git-send-email-imyousuf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Imran M Yousuf <imyousuf@smartitengineering.com>
To: imyousuf@gmail.com
X-From: git-owner@vger.kernel.org Tue May 13 00:44:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvgl3-00076u-0f
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 00:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700AbYELWns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 18:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755477AbYELWns
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 18:43:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33543 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755453AbYELWnn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 18:43:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 68AE5345A;
	Mon, 12 May 2008 18:43:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 8B8293458; Mon, 12 May 2008 18:43:38 -0400 (EDT)
In-Reply-To: <1209978582-5785-3-git-send-email-imyousuf@gmail.com>
 (imyousuf@gmail.com's message of "Mon, 5 May 2008 15:09:40 +0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DF3662B4-2074-11DD-81DB-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81961>

imyousuf@gmail.com writes:

> From: Imran M Yousuf <imyousuf@smartitengineering.com>
>
> There is a scenario which has been put forward several times in
> discussion over the recurse subcommand and it is that commands chould have
> different arguments for different modules.
>
> For example, one module could want to checkout 'master', while another might want
> to checkout 'work'. The [-a|--customized-argument] argument provides platform
> just for that. Consider the following command and its followup for further info:
>
> 	git submodule recurse -a checkout
>
> 	Submodule b is not initialized and skipped
> 	git submodule recurse a checkout
> 	Please provide an argument: master
> 	Press y to provide another arg...
> 	git checkout master
> 	Already on branch "master"
> 	Submodule d is not initialized and skipped
> 	git submodule recurse . checkout
> 	Please provide an argument: master
> 	Press y to provide another arg...
> 	git checkout master
> 	Already on branch "master"

Is it only me who finds this UI (and the one 4/5 further introduces)
somewhat clumsy and extremely ugly?

I am almost tempted to suggest going to the extreme and spawn interactive
shell in each repository directory, like this:

    toplevel$ git submodule recurse -a
    (info) Submodule b is not initialized and skipped
    (info) git submodule recurse 'a'
    (info) we now give you a shell in that directory.  Do whatever you
    (info) like and type cntl-D (or "exit") once you are done.
    toplevel/a$ git checkout
    toplevel/a$ exit
    (info) Submodule d is not initialized and skipped
    (info) git submodule recurse '.'
    (info) we now give you a shell in that directory.  Do whatever you
    (info) like and type cntl-D (or "exit") once you are done.
    toplevel/.$ git checkout
    toplevel/.$ exit
    (info) git submodule recurse recursion ended.
    toplevel$

so that the users can do whatever they want there.

If we want a useful and flexible "recurse", perhaps the only thing we need
to do is a command that lists a submodule directory path, one path at a
time, in optionally different traversal order and depth cutoff, so that
the user can feed it to xargs and do whatever they want to run in there.
