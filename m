From: Richard Maw <richard.maw@codethink.co.uk>
Subject: Re: Some issues when trying to set up a shallow git mirror server
Date: Wed, 13 Jan 2016 11:37:43 +0000
Message-ID: <20160113113743.GF3397@logi.codethink.co.uk>
References: <20160107165417.GB3397@logi.codethink.co.uk>
 <xmqq4mep5kyg.fsf@gitster.mtv.corp.google.com>
 <xmqqd1tb21oh.fsf@gitster.mtv.corp.google.com>
 <20160111155153.GE3397@logi.codethink.co.uk>
 <xmqqy4butzw8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 12:37:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJJkQ-0004hA-Bi
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 12:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755512AbcAMLhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 06:37:50 -0500
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:43959 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbcAMLht (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 06:37:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 7BD8B462681;
	Wed, 13 Jan 2016 11:37:47 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
	by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PmLfFdu0lwm3; Wed, 13 Jan 2016 11:37:45 +0000 (GMT)
Received: from logi.codethink.co.uk (logi.dyn.ducie.codethink.co.uk [10.24.1.141])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 701F54623F5;
	Wed, 13 Jan 2016 11:37:45 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <xmqqy4butzw8.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283899>

On Tue, Jan 12, 2016 at 10:29:27AM -0800, Junio C Hamano wrote:
> I left the detail as vague ;-).
> 
> The new request does not have to piggyback on existing "want"
> message.  And thinking about it again, it probably is cleaner if it
> didn't.  After the use of the protocol extension "ancestry-check" is
> negotiated the usual way between the sender and the receiver, the
> receiver would send "check-ff N O" and "check-ff N P" after it sends
> all of its "want" messages but before it sends the "flush" to go
> into the "have"/"ack" common ancestry discovery.
> 
> I do not have a strong opinion on where the sender should reply with
> "not-ff N O" in the protocol.  Immediately after the receiver says
> "I've done with my 'want's (and now 'check-ff's)" by flushing may be
> a good place to do so.

In that case, I can think of two other useful times to do it:

1.  Before any "want" requests.

    This would also let you extend ls-remote to let it display ancestry.

    This is complicated by the fact that normally the client responds
    with which features it supports in the first "want",
    so the sender would have to support "check-ff N O <FEATURES>"
    if it advertised "ancestry-check".

2.  After the pack is transferred.

    Then the receiver can check ancestry with the objects,
    and only request ancestry if it's missing history.

    I'm not sure whether there's any value in not requesting it,
    since while it would reduce the amount of work the sender needs to do,
    it still means the sender has to wait for the client to do the check,
    rather than hanging up and allowing it to process another connection.
