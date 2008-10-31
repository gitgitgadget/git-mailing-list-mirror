From: Junio C Hamano <gitster@pobox.com>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 16:14:44 -0700
Message-ID: <7viqr873x7.fsf@gitster.siamese.dyndns.org>
References: <20081031170704.GU14786@spearce.org>
 <20081031174745.GA4058@artemis.corp>
 <alpine.LFD.2.00.0810311558540.13034@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Nov 01 00:16:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw3EW-0005mr-RT
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 00:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbYJaXPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 19:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbYJaXPE
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 19:15:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39397 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbYJaXPC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 19:15:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 4EDB8776EA;
	Fri, 31 Oct 2008 19:15:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6C566776E9; Fri, 31 Oct 2008 19:14:51 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0810311558540.13034@xanadu.home> (Nicolas
 Pitre's message of "Fri, 31 Oct 2008 16:24:14 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BE2BC3CA-A7A1-11DD-8DA8-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99671>

Nicolas Pitre <nico@cam.org> writes:

> Depends.  Sure, I gave permission to copy some of my code for JGIT 
> because 1) JGIT is Java code in which I have little interest, 2) the 
> different license was justified by the nature of the JGIT project, and 
> 3) although no license convey this I asked for the C version of git to 
> remain the authoritative reference and that any improvements done to JGIT 
> first be usable in the C version under the GPL.

This reminds me that Shawn earlier in an unrelated thread asked me if I
can relicense builtin-blame.c for JGIT; your reasoning fully matches that
of mine regarding that part of the code.

> My favorite license for a library is the GPL with the gcc exception,
> i.e. what libraries coming with gcc are using.  They're GPL but with an 
> exception allowing them to be linked with anything.

Although I'd be Ok with either GPL + gcc exception on whatever core-ish
(i.e. what will be necessary for libgit2; "blame" would not count) pieces
I have in C-git codebase, "can be linked with anything" allows a gaping
hole to the library, which I'm a bit hesitant to swallow without thinking.

E.g.  our read_object() may look like this:

         void *read_object(const object_name_t sha1,
                           enum object_type *type,
                           size_t *size)
         {
                 ...
         }


but an extension a closed-source person may sell you back may do:

        +typedef void *read_object_fn(const object_name_t,
        +                             enum object_type *,
        +                             size_t *);
        +read_object_fn read_object_custom = NULL;
         void *read_object(const object_name_t sha1,
                           enum object_type *type,
                           size_t *size)
         {
        +       if (read_object_custom != NULL)
        +               return read_object_custom(sha1, type, size);
                ...
         }

I.e. use the supplied custom function to do proprietary magic, such as
reading the object lazily from elsewhere over the network.  And we will
never get that magic bit back.

Although no license asks this, my wish is that if somebody built on top of
what I wrote to make the world a better place, I'd like the same access to
that additional code so that I too can enjoy the improved world.  Because
almost all of my code in git.git are under GPLv2, in reality I do not have
any access to your software as long as you do not distribute your
additional code that made the world a better place, which is a bit sad.
