From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Patches for git-push --confirm and --show-subjects
Date: Sun, 13 Sep 2009 17:47:42 -0700
Message-ID: <7vpr9ugxn5.fsf@alter.siamese.dyndns.org>
References: <1252884685-9169-1-git-send-email-otaylor@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Owen Taylor <otaylor@redhat.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 02:49:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmzkZ-0006YY-8Z
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 02:48:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598AbZINArs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 20:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754574AbZINArr
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 20:47:47 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33120 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754558AbZINArq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 20:47:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 74AD8319F4;
	Sun, 13 Sep 2009 20:47:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Crfd4DRhWsoZTJozfKBa6Xh09LE=; b=a7BRxK
	WLNLx2OEDzxpDJtH1dcf6ZrwhNbJtsVXJVSKM/f5+Bo8oFFx4xNe3iWdbtXFjZqB
	7m0BEaHcVbrw0sTsZ0aDZ0Ghq3O5qg2FT2o/YZi0yko1hwDzHzgAc1vdbOsHDKQj
	tcRg+6bFkaXq/q0yVXs65+IvZXsfKkD4mAmEg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rU9Wey9i2FRDbiUBypW5bHpsYPgjgpZH
	KHNf+f7M6zxO3kBDx93U8yROla6A+G5PYQQfaTqz0sAD9xGe3nhMBrOc64eF8ZkZ
	wtPmWohBXPH+qfsw9C9+8MFsx3MItlSp4G+GAgjWCVnx+yHG/sEra53jERV1o47R
	/OYRAAMSBuk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 58954319F2;
	Sun, 13 Sep 2009 20:47:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B95C6319F1; Sun, 13 Sep
 2009 20:47:43 -0400 (EDT)
In-Reply-To: <1252884685-9169-1-git-send-email-otaylor@redhat.com> (Owen
 Taylor's message of "Sun\, 13 Sep 2009 19\:31\:21 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 38222C4E-A0C8-11DE-9CA7-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128433>

Without reading much of the code, my knee jerk reactions are:

 * This probably can (and from the longer term perspective, should) be
   done inside a pre-push hook that can decline pushing;

 * I do not think it should use two separate push_refs call into transport
   (first with dry-run and second with real).

   Immediately after match_refs() call in transport_push(), you know if
   the push is a non-fast-forward (in which case you do not know what you
   will be losing anyway because you haven't seen what you are missing
   from the other end) or exactly what your fast-forward push will be
   sending, so between that call and the actual transport->push_refs()
   would be the ideal place to call the hook, with a list of "ref old
   new", without running a dry-run.

for a few reasons.

 (1) When push.confirm is set, you do not want to interact with the user
     when the standard input is not a terminal.  But an automated script
     that runs git-push can still use an appropriate pre-push hook to make
     the decision to intervene without human presense.

 (2) As your --show-subjects patch shows, the likes and dislikes of the
     output format for confirmation would be highly personal.  A separate
     hook that is fed list of <ref, old, new> would make it easier to
     customize this to suite people's tastes.

 (3) I do not trust the use of the fmt_merge_message() code in this
     codepath.  That code, like all the major parts of git, relies on
     being able to use the object flag bits for its own purpose, and there
     is a chance that the way transports (present and future) optimizes
     (or may want to optimize in the future) the object transfer by
     implementing clever common ancestry discovery, similar to what is
     done for the fetch-pack side.

     If we force the actual confirmation process out to a separate process
     that runs a hook, I do not have to worry about that, which is a huge
     relief for maintainability of the system.

 (4) The same objects flag bits contamination issue makes me worried about
     your approach of running one transport_push() with dry-run and then
     another without.
