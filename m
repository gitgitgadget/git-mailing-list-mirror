From: Junio C Hamano <gitster@pobox.com>
Subject: Re: coding style: #ifdef blocks and real C blocks
Date: Sun, 01 Mar 2009 01:10:16 -0800
Message-ID: <7vbpsl8v7r.fsf@gitster.siamese.dyndns.org>
References: <be6fef0d0903010052t50551f3w74352b69afdee620@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 01 10:11:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LdhiG-0007x9-HL
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 10:11:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbZCAJKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Mar 2009 04:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbZCAJKY
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Mar 2009 04:10:24 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60619 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751266AbZCAJKX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Mar 2009 04:10:23 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8223D2C58;
	Sun,  1 Mar 2009 04:10:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C993E2C57; Sun, 
 1 Mar 2009 04:10:17 -0500 (EST)
In-Reply-To: <be6fef0d0903010052t50551f3w74352b69afdee620@mail.gmail.com>
 (Tay Ray Chuan's message of "Sun, 1 Mar 2009 16:52:49 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CAA5E2F4-0640-11DE-B485-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111830>

Tay Ray Chuan <rctay89@gmail.com> writes:

> #ifdef USE_CURL_MULTI
> 	slot = get_active_multi_slot();
> #else
> 	slot = get_active_slot();
> #endif
> 	slot->callback_func = process_response;
> 	slot->callback_data = request;
> 	request->slot = slot;

How about doing something like this:

    #ifdef USE_CURL_MULTI
    #define active_slot_get get_active_multi_slot
    #else
    #define active_slot_get get_active_slot
    #endif

so that the code itself would not have to have any #ifdef?

    slot = active_slot_get()
    slot->callback_func = process_response;
    slot->callback_data = request;
    request->slot = slot;
    
> #ifdef USE_CURL_MULTI
> 	if (!persistent_connection)
> 		slot = get_active_multi_slot();
> 	else
> 		slot = get_active_slot();
> #else
> 	slot = get_active_slot();
> #endif

Similarly, with something like this:

    #ifdef USE_CURL_MULTI
    slot active_persistent_slot() {
            return persistent_connection ? get_active_slot() : get_active_multi_slot();
    }
    #else
    slot active_persistent_slot() {
            return get_active_slot();
    }
    #endif

the call site can be #ifdef free, no?
