From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: Add support for SSL and SMTP-AUTH
Date: Sun, 02 Sep 2007 00:55:39 -0700
Message-ID: <7vveatpklg.fsf@gitster.siamese.dyndns.org>
References: <11887028854022-git-send-email-doug@11011.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Douglas Stockwell <doug@11011.net>
To: Douglas Stockwell <douglas.stockwell@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 09:56:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRkJa-0000gA-Ho
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 09:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933115AbXIBHzs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 03:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932929AbXIBHzr
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 03:55:47 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:34177 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932627AbXIBHzq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 03:55:46 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 2793412CD0E;
	Sun,  2 Sep 2007 03:56:03 -0400 (EDT)
In-Reply-To: <11887028854022-git-send-email-doug@11011.net> (Douglas
	Stockwell's message of "Sun, 2 Sep 2007 12:14:45 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57303>

Thanks for the patch.  I think SMTP-AUTH is a worthy addition.

I however have a bit of reservation about making the password
itself a configuration variable.  I understand this is good
enough for the simplest case that you have only single e-mail
identity and mailserver to talk to.

By defining the two "default" variables, you are encouraging
users who want to use different identity per project to define
the smtpauthuser and smtpauthpass variables in .git/config of
each repository.  I see two issues with this.

 (1) Suppose I interact with under one mail identity with
     projects A and B and under another mail identity with
     project C and D.  I need to have duplicate variable
     settings in .git/config of A and B for one and another
     duplicated sets in C and D.

 (2) Although the recommended BCP is not to allow other people
     to interact with your private working repository (iow, you
     keep a separate "bare" repository you use solely for
     publishing, you push from your private working repository
     to that publishing repository, and have others look at only
     the publishing repository), people often do not follow this
     BCP and expose their private working repository to their
     colleages for fetching (or even pushing).  We currently do
     not allow reading remote repository's configuration over
     the git protocol, but there were some cases in the past
     that the ability to do so might lead to their solutions
     discussed on the list.  We might not keep .git/config in
     the repository that is accessed by fetch clients private in
     the future.

So it might be better to split the configuration variables in this
way:

 (1) in ~/.gitconfig (that is hopefully readable only by the
     user):

	[sendemail "default"]
        	server = mail.isp.com
                user = junkio
                pass = junkio-password-for-mail-isp-com

	[sendemail "git"]
        	server = mail.git.xz
                user = gitster
                pass = gitster-password-for-mail-git.xz

     This defines two "mail identities" I could use, depending
     on which project's repository I run send-email.

 (2) in project/.git/config:

	[sendemail]
        	identity = git

     This defines which "mail identity" I want to use for this
     particular project.

This way, you can maintain more than one identity by having
multiple [sendemail "$identity"] sections in ~/.gitconfig, and
avoid having to expose and duplicate user/pass in various
project's .git/config.

The look-up rules by send-email program would be:

 * if anything is given explicitly from the command line, use
   that; otherwise

 * if sendemail.identity does not exist, pretend
   "sendemail.identity = default" was given (let's call that
   identity nickname $identity in the following);

   * if sendemail.$identity.server.exists, use that as the smtp
     server to contact; otherwise sendemail.smtpserver is used;

   * for user/pass information, use sendemail.$identity.user and
     sendemail.$identity.pass.

Hmm?
