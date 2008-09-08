From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Use GIT_COMMITTER_IDENT instead of hardcoded values in
 import-tars.perl
Date: Mon, 08 Sep 2008 13:40:20 -0700
Message-ID: <7vzlmie5hn.fsf@gitster.siamese.dyndns.org>
References: <7v3arixm8h.fsf@gitster.siamese.dyndns.org>
 <1220777531-28934-1-git-send-email-mh@glandium.org>
 <alpine.DEB.1.00.0809081649040.13830@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 08 22:41:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcnYH-0008KC-IO
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 22:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753676AbYIHUka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 16:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753543AbYIHUka
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 16:40:30 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58336 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250AbYIHUka (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 16:40:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 08A5F79FE7;
	Mon,  8 Sep 2008 16:40:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 67B6D79FE3; Mon,  8 Sep 2008 16:40:22 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0809081649040.13830@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Mon, 8 Sep 2008 16:51:45 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5F90B4C2-7DE6-11DD-9E74-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95298>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 7 Sep 2008, Mike Hommey wrote:
>
>> -my $committer_name = 'T Ar Creator';
>> -my $committer_email = 'tar@example.com';
>> +chomp(my $committer_ident = `git var GIT_COMMITTER_IDENT`);
>> +die 'You need to set user name and email'
>> +	unless ($committer_ident =~ s/(.+ <[^>]+>).*/\1/);
>
> I have at least one script that will be broken by this change in behavior.
>
> To me, the issue is just like git-cvsimport, which sets the committer not 
> to the actual committer, so that two people can end up with identical 
> commit names, even if they cvsimported independently.  I'd like the same 
> behavior for import-tars.  I actually use it that way.

I sense there are conflicting goals here.

cvsimport has partial information about the author (only short account
name and nothing else), and by replicating them without taking them
literally you can achieve reproducibility.  On the other extreme is to use
the authorname mapping file to sacrifice reproducibility with other people
that do not have the identical author mapping file to obtain more readable
resulting history with real names.  You can do both.

With the hardcoded 'T Ar Creator', you do not have any choice but strict
reproducibility without readable names.  With Mike's original patch to
make it in line with git-import.{sh,perl}, you cannot still have both,
because setting GIT_COMMITTER_NAME does not affect what user.name
configuration says.  But with "git var GIT_COMMITTER_IDENT", you could.

This makes me wonder if it might be a better design to:

 * Make fast-import feeders to preserve as much information from the
   source material but not from the environment.  This is half-similar in
   spirit to what cvsimport does---it does not know the timezone so it
   always uses GMT, and it uses the short account name because it is the
   only thing available, but it does not use hardcoded "cvs", and the
   environment can affect it further by setting up an author mapping
   file.  Here I am saying a fast-import feeder shouldn't (and does not
   have to) take the environment into account, if it does not have good
   data in the source material.

   In the context of importing tarballs, zipfiles and an existing directory
   which is a tarball extract, there is not much authorship information in
   the source material (each entry in a tarball may have the owner
   information, but what if your tarball have more than one files, with
   different owners?).

 * Invent a fast-import stream filter that allows you to munge authorship
   and committer information selectively.  Splice that in to the pipeline
   between the feeder and the fast-import, if you want the resulting
   history more readable if desired (e.g. use author mapping file).

   Or you can choose not to use such a filter, and get a reproducible
   result.

If the "filter" turns out to be simple enough, it might even make sense to
make it part of the fast-import itself, but that is an implementation
detail.
