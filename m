From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] make verify_one_pack() a bit less wrong wrt
 packed_git structure
Date: Fri, 29 Feb 2008 21:59:12 -0800
Message-ID: <7vk5kn7znz.fsf@gitster.siamese.dyndns.org>
References: <1204176320-31358-1-git-send-email-nico@cam.org>
 <1204176320-31358-2-git-send-email-nico@cam.org>
 <1204176320-31358-3-git-send-email-nico@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Mar 01 07:00:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVKlL-0002Iv-Fe
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 06:59:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249AbYCAF7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 00:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752149AbYCAF7X
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 00:59:23 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50865 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751441AbYCAF7W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 00:59:22 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CC1BA2311;
	Sat,  1 Mar 2008 00:59:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 27FB72310; Sat,  1 Mar 2008 00:59:16 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75621>

Nicolas Pitre <nico@cam.org> writes:

> ..., but it is still
> a bit more "correct" to leak it implicitly rather than explicitly.

I do not follow this logic to debate which incorrectness is more
correct, but I do not mind the removal of free() there.

I am not sure about the install_packed_git() piece, though.

This part of the code predates Shawn's windowed mmap and all
other recent code improvements, but the original motivation of
not installing the pack was to make sure that codepaths outside
verify_packfile() would not see the objects from the pack being
verified at all.  IOW, the omission originally was intentional.

I just quickly looked at verify_packfile() after applying your
series, and it seems that nothing tries to access objects with
only their SHA-1 names without explicitly telling which pack to
read from, so it should still be safe even if we did not install
the packed git (iow, the normal codepath would not try to pick
up objects from the suspect pack that is being validated).

But it made me feel a bit worried.


