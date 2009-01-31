From: Sam Vilain <sam@vilain.net>
Subject: Re: What's cooking in git.git (Jan 2009, #05; Wed, 21)
Date: Sat, 31 Jan 2009 19:45:54 +1300
Message-ID: <1233384354.10045.170.camel@maia.lan>
References: <7vab9kataf.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.00.0901220606040.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 31 07:47:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT9dd-0006pZ-TI
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 07:47:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbZAaGqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 01:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbZAaGqH
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 01:46:07 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:56319 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751380AbZAaGqG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 01:46:06 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 71480C401F; Sat, 31 Jan 2009 19:45:56 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id A786D21C873;
	Sat, 31 Jan 2009 19:45:51 +1300 (NZDT)
In-Reply-To: <alpine.DEB.1.00.0901220606040.3586@pacific.mpi-cbg.de>
X-Mailer: Evolution 2.24.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107905>

On Thu, 2009-01-22 at 06:13 +0100, Johannes Schindelin wrote:
> > It would be nice to hear a real world success story using the notes
> > mechanism before casting this design in stone.
> 
> I'd like to have some profiling done before that.  For example, I am still 
> a bit unsure how the things would perform with a 50-deep delta chain for 
> a notes tree having 50,000+ notes in it (which I think will not be all 
> that unreasonable for a medium-sized project that stores bug-tracking 
> information in the notes).

Is there any reason why the split has to be cast in stone at all?

ie, the code could just scan the root tree of the branch, and
progressively descend into sub-trees based on a partial match of the
object for which the note is to be found.  If you find a partial name
then you expect that it is a tree and descend into it and scan for the
rest.  If you find a complete name then you expect that it is a blob and
open it.  If it turns out to be a tree then there are multiple notes for
that commit.  Then I think you get the best of both worlds; you can
start with a simple flat structure and then later someone can come along
and make it split it when there are more than N entries in the root tree
(where N is determined from profiling etc).

There are two practical applications I could use this for straight away
for perl.git, and I think that they would be important use cases.

One would be to allow grafts to be noted.  These might want to live in a
different place to refs/notes/commits, like refs/notes/grafts, to avoid
performance issues and to recognise they are a different type of data.
A second would be for commit header information - particularly the
author field and commit description - to be amended.  I think this all
belongs under refs/notes/commits.  These are in essence, historical
corrections that don't need to alter the tree.

The idea of making it allow a union merge seems relatively workable, I
think for simplicity and flexibility that the contents of the note
should be considered to be format-patch output (except without the diff
of course).  So union-ish, more like a RFC822-aware merge of mail
messages.

eg, say the contents of the note are:

  Some text

=> appends "Some text" to the note as currently implemented

  Subject: Blah blah

  Blah blah blah

=> _replaces_ commit message and body, as if it had been committed
   with the above message

  From: Sam Vilain <sam@vilain.net>
  Date: Thu, 22 Jan 2009 06:13:01 +1300

  Blah blah blah

=> replaces 'author' line in commit.  "Blah blah blah" appended to
   commit body.

Sound sane?

Sam.
