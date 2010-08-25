From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fix 'git log' early pager startup error case
Date: Wed, 25 Aug 2010 12:16:15 -0700
Message-ID: <7vtymiqz9c.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.1008241029530.1046@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Aug 25 21:16:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoLSY-0000sK-5c
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 21:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771Ab0HYTQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 15:16:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40879 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498Ab0HYTQX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 15:16:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 33E4BD07BC;
	Wed, 25 Aug 2010 15:16:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mtBj2enHdOtLm93gZS56BgEVSY4=; b=dUPukO
	oshM5mBzRQP+SckhF3iHUtBsWZAOgV5NJzkt7CniI7YMK3HvOIcZchr474+LsR7N
	TtPMVLIZjoNca9GpPW7jQQ6U81IJSkgmAWR7rdKBJU+uNFeR/BiPURlj9T8eiWRX
	aDrxcuWMLSy8+V3lkGBD9g8b/YVjReqY/a6T0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MkReTiEPuqM6yHOnt6XktkVnmamqqdmu
	yxwd2QaZ+S8dUy+7ucdcHrI2RxeEHqlMFWtBeM0T9l4TrtfIezhkIG2rV2zI2WVt
	Yd0OuhBSz0dxYzyVlI6vey4iLp2C4WafeGNxuNkoV1QoWhAWKyjosCamMPAFb+Dy
	pIYbCS7kAOk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EB05ED07B4;
	Wed, 25 Aug 2010 15:16:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 222ABD07B3; Wed, 25 Aug
 2010 15:16:16 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.1008241029530.1046@i5.linux-foundation.org>
 (Linus Torvalds's message of "Tue\, 24 Aug 2010 10\:33\:59 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3DD60E1A-B07D-11DF-83FC-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154463>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> We start the pager too early for several git commands, which results in 
> the errors sometimes going to the pager rather than show up as errors.

Hmm...

  $ LESS=-S git log --prettty; echo $?
  ... less shows the message and then the message is lost from the screen
  128
  $ git --no-pager log --prettty; echo $?
  fatal: unrecognized argument: --prettty
  128
  $ LESS=-S git log --prettty 2>err; echo $?; cat err
  ... less shows empty and then screen snaps back
  128
  fatal: unrecognized argument: --prettty
  $ git --no-pager log --prettty 2>err; echo $?; cat err
  128
  fatal: unrecognized argument: --prettty

In all cases when the user wants to see the error message s/he sees it,
when the user wants to capture it to a file, it is captured, and the
correct error status is returned to the calling shell.

The only difference is that after the user dismisses the pager, the error
message is lost.  I am not sure if that is a problem, though.

Ah, there actually is another difference.  This is broken:

  $ PAGER=no-such-pager git log --prettty; echo $?
  ... nothing is shown here ...
  128

and with yours:

  $ PAGER=no-such-pager ./git log --prettty; echo $?
  fatal: unrecognized argument: --prettty
  128

Thanks.
