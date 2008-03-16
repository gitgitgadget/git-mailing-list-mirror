From: Junio C Hamano <gitster@pobox.com>
Subject: On fetch refspecs and wildcards
Date: Sun, 16 Mar 2008 15:24:34 -0700
Message-ID: <7v8x0igvdp.fsf_-_@gitster.siamese.dyndns.org>
References: <1205499956.7589.4.camel@gentoo-jocke.transmode.se>
 <1205604534.7589.20.camel@gentoo-jocke.transmode.se>
 <7v1w6bj7f9.fsf_-_@gitster.siamese.dyndns.org>
 <200803161921.49274.tlikonen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org,
	Teemu Likonen <tlikonen@iki.fi>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 16 23:25:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jb1IC-0002Jq-Tg
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 23:25:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752524AbYCPWYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 18:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752534AbYCPWYp
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 18:24:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55636 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353AbYCPWYo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 18:24:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2B38022A1;
	Sun, 16 Mar 2008 18:24:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id A921E22A0; Sun, 16 Mar 2008 18:24:37 -0400 (EDT)
In-Reply-To: <200803161921.49274.tlikonen@iki.fi> (Teemu Likonen's message of
 "Sun, 16 Mar 2008 19:21:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77393>

I was looking at t5505 tests and noticed something funny.

This is a design level question, so I am cc'ing Daniel whose remote.c is
heavily involved in the new implementation.

What should this config do:

    [remote "origin"]
        url = ../one/.git
        fetch = +refs/heads/*:refs/remotes/origin/*
        fetch = refs/heads/master:refs/heads/upstream

when the other repository (../one/.git) has branches "master" and "side2"?

I am not sure if the original implementation used to copy master to both
refs/remotes/origin/master and refs/heads/upstream, but I think that is
what the users would expect.  

I think the current one excludes any source that has an explicit
destination from the wildcard matches.  It is probably Ok as long as we
reject if the same source has more than one destinations (or matches more
than one wildcards, for that matter) like this as a configuration error:

    [remote "origin"]
        url = ../one/.git
        fetch = refs/heads/master:refs/heads/upstream
        fetch = refs/heads/master:refs/heads/another

If it doesn't, it does feel somewhat inconsistent.

Fortunately or unfortunately, Documentation/pull-fetch-param.txt does not
talk about wildcard refspecs (not even the syntax, let alone the
semantics), so we can define whatever we want right now, and I think both

    (1) allow duplicated destinations, including wildcard matches; and

    (2) refuse duplicated destinations for explicit ones, and more than
        one wildcard patterns that match the same ref, but omit explicitly
        specified ones from wildcard matches;

are viable options.  I suspect the current code does not do either.  We
should pick one semantics, make sure the implementation matches that, and
document it.

Another topic is what the semantics should be for mirroring configuration,
like this:

    [remote "origin"]
        url = ../one/.git
        fetch = refs/*:refs/*

or

    [remote "origin"]
        url = ../one/.git
        fetch = refs/*:refs/remotes/one/*

The issues are:

 (1) get_fetch_map() currently insists on refname to be check_ref_format()
     clean; it even rejects CHECK_REF_FORMAT_ONELEVEL, which means that
     refs/stash would not be considered Ok and the code will die().

 (2) "git remote prune" seems to cull refs/remotes/one/HEAD if exists.

Currently we do not have a way to determine where HEAD at the remote
points at at the protocol level (I've sent a patch to the list earlier for
the necessary protocol extension on the upload-pack side, but receiver
side never got implemented in remotes.c).  So we cannot propagate
refs/HEAD information correctly right now, but when we accept the protocol
extension to do so, issue (1) will matter also for HEAD.

I think there is no design level question on this one.  I think both are
bugs we currently have (and they may probably not be regressions).
