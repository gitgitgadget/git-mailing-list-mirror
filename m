From: Junio C Hamano <gitster@pobox.com>
Subject: Re: update-index --assume-unchanged doesn't make things go fast
Date: Fri, 27 Jun 2008 19:03:49 -0700
Message-ID: <7vd4m2l3i2.fsf@gitster.siamese.dyndns.org>
References: <32541b130806250944x717cf609x7aa520c77a7c6911@mail.gmail.com>
 <20080626112233.GA17625@cuci.nl>
 <32541b130806271001t35eb97d2gb841e194b54f214@mail.gmail.com>
 <m3lk0qiy2i.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Avery Pennarun" <apenwarr@gmail.com>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	"Git Mailing List" <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 04:05:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCPoE-0003Mz-F8
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 04:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbYF1CEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 22:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbYF1CEE
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 22:04:04 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56498 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338AbYF1CEB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 22:04:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3CE7510028;
	Fri, 27 Jun 2008 22:03:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7BC9B10025; Fri, 27 Jun 2008 22:03:52 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 78CC2480-44B6-11DD-A63D-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86691>

Jakub Narebski <jnareb@gmail.com> writes:

> By the way, from time to time there on this mailing list is idea
> to add entries for directories in the index.  This could help situation
> like yours, tracking emty directories, faster operations when some trees
> are unchanged, subtree <-> subproject changes.

Tracking empty directories might be helped by having an explicit entry in
the index (even though it may not be the only possible implementation).  I
however suspect you are overvaluing it for "some trees are unchanged"
case:

        $ mkdir -p a/b
        $ stat a | grep Modify
        Modify: 2008-06-27 11:38:13.000000000 -0700
        $ >a/b/c
        $ stat a | grep Modify
        Modify: 2008-06-27 11:38:13.000000000 -0700
        $ >a/d
        $ stat a | grep Modify
        Modify: 2008-06-27 11:38:32.000000000 -0700

You have to descend into the leaf level anyway and directory mtime does
not allow you to check that much.
