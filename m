From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What about allowing multiple hooks?
Date: Sun, 04 Jan 2009 02:01:33 -0800
Message-ID: <7vd4f3z8xu.fsf@gitster.siamese.dyndns.org>
References: <20081121133828.GB5912@gmx.de> <20090103233252.GA12095@myhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Weber <marco-oweber@gmx.de>, git@vger.kernel.org,
	Rogan Dawes <lists@dawes.za.net>,
	martin f krafft <madduck@madduck.net>
To: Alexander Potashev <aspotashev@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 04 11:03:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJPpA-0001V7-Ke
	for gcvg-git-2@gmane.org; Sun, 04 Jan 2009 11:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbZADKBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 05:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbZADKBr
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 05:01:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64413 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbZADKBq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 05:01:46 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E116C1BBF3;
	Sun,  4 Jan 2009 05:01:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D07B31BBE6; Sun, 
 4 Jan 2009 05:01:35 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B02A093A-DA46-11DD-9C84-EB51113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104501>

Alexander Potashev <aspotashev@gmail.com> writes:

>> Thoughts?

I deliberately omitted support for multiple scripts in core git Porcelains
to avoid this exact issue.  It is a huge can of worms and it is dubious if
you can have a coherent and generic enough semantics.

In the meantime, you can have a single .git/hooks/pre-commit script that
defines your own convention.  Maybe it uses .git/hooks/pre-commit.d/
directory, full of scripts, and implements the semantics you want,
including:

 (1) the execution order and the naming convention of the scripts (e.g.
     they all live in pre-commit.d/ directory, and executed in ASCII byte
     value order of their names);

 (2) how their exit status combine together.  For example, maybe a failure
     from one of the scripts prevents none of the later scripts to even
     run and make the whole hook return a failure; maybe a failure will be
     remembered, but the other scripts may still want to be run to learn
     about the fact that the commit was attempted, and the whole hook
     returns a failure if any of them fail.

     In a hook that is run primarily for its side effects and not for
     validation, it may even be desireble if the whole hook returns a
     failure only when all of them fail, iow, for such a hook the status
     is not ANDed but ORed together.

Once you have such a framework and get help from others to widely try it
in the field, it may prove generic enough to include it as the sample hook
script to be installed everywhere.
