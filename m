From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] clone: respect the settings in $HOME/.gitconfig and
 /etc/gitconfig
Date: Sun, 29 Jun 2008 18:20:03 -0700
Message-ID: <7vabh390sc.fsf@gitster.siamese.dyndns.org>
References: <27C25D70-0BFC-4362-A771-C7CAD89BC198@ai.rug.nl>
 <alpine.DEB.1.00.0806271353350.9925@racer>
 <alpine.LNX.1.00.0806271149580.19665@iabervon.org>
 <7vvdzuo61b.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0806291359330.19665@iabervon.org>
 <alpine.DEB.1.00.0806292248160.9925@racer>
 <alpine.LNX.1.00.0806291821520.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jun 30 03:21:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD84y-0000gA-9b
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 03:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753678AbYF3BUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 21:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753585AbYF3BUU
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 21:20:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61618 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbYF3BUT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 21:20:19 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B33D910106;
	Sun, 29 Jun 2008 21:20:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D2E4D10104; Sun, 29 Jun 2008 21:20:11 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0806291821520.19665@iabervon.org> (Daniel
 Barkalow's message of "Sun, 29 Jun 2008 18:47:33 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B27B719E-4642-11DD-B3D7-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86855>

Daniel Barkalow <barkalow@iabervon.org> writes:

> ... In any case, I don't think "git clone" is at 
> all special with respect to GIT_CONFIG.

I think "git init" and "git clone" are very special with respect to
GIT_CONFIG.

 * When "init" is run to create a new repository and initialize it, the
   user would want the initial set of configuration populated in the
   configuration file _for that repository_.  There however may be some
   customization that affects the way how "init" operates, which might be
   taken from $HOME/.gitconfig.  The meaning of GIT_CONFIG can get fuzzy
   here.  Possibilities:

   (1) Instead of $HOME/.gitconfig (or /etc/gitconfig), the user might
       want such customizations to be read from the file specified by
       GIT_CONFIG.  But the user wants to make the resulting new
       repository usable without any custom GIT_CONFIG set (i.e. its
       $GIT_DIR/config will be the place the configuration is written).

   (2) The user may want to create a new repository that cannot be used
       with GIT_CONFIG (for some strange reason), i.e. no $GIT_DIR/config
       for the repository, and GIT_CONFIG is used to specify where that
       separate configuration file for the new repository is.  The way
       "init" operates does not come from that configuration file that is
       to be created but from elsewhere.

 * When "clone" is run, the same confusion as initializing "init" applies.
   In addition, custom GIT_CONFIG to read customizations for behaviour of
   "init" and "fetch" that is done internally by "clone" would play larger
   role.

 * When "init" is run to reinitialize an existing repository, it is not
   special in any way with respect to GIT_CONFIG, compared to other
   commands.  The GIT_CONFIG names the configuration for that existing
   repository, so we read from it and write to it.

I personally think the case (2) is a very narrow special case that I do
not think of any sane reason to even wanting to do so.  IOW, "you _could_
interpret the presense of GIT_CONFIG that the user may want to do so, but
why?"  (1) is also probably not very sensible but it makes more sense.

I think Dscho's original patch would support the semantics (1) and it is
probably much saner than (2) which is your version does (if I am reading
the two patches correctly).
