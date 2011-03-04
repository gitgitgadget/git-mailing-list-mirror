From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-am silently applying patches incorrectly
Date: Fri, 04 Mar 2011 09:49:55 -0800
Message-ID: <7vr5am7p30.fsf@alter.siamese.dyndns.org>
References: <4D70EBC3.3010400@colin.guthr.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Colin Guthrie <gmane@colin.guthr.ie>
X-From: git-owner@vger.kernel.org Fri Mar 04 18:50:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvZ8p-0003I5-79
	for gcvg-git-2@lo.gmane.org; Fri, 04 Mar 2011 18:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759843Ab1CDRuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Mar 2011 12:50:07 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33908 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759425Ab1CDRuG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Mar 2011 12:50:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 445B744F5;
	Fri,  4 Mar 2011 12:51:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BXw3s3JKBYhF5GrnqMvdpqq2IBU=; b=SzWbyo
	cK21Fp3xJM5k5SppmCtelh8elNNjLxmCpudwJ6vqDaE89MZ55+GqCLDqqcq25jT2
	kEz95d2y0IQaT0vZ5oqFMbxiE2F+YeaUUmSVs+8OiuH2Kn6DegkHcQO5LlZ/LB7h
	2oDjYHsGdyzB2KfbvE9z5TxZfEgrRBUo+YZzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dt2h0odWzX8frtgICiAtIU7QMO4InK9A
	+EDRhlWwtDkVcVXOpsoA+U30jH3O/YRew1ekD3dn/qc51XCU3HOTxLVbxJ2g9a1E
	fuUWiw5CtU6CQQKyNb4AHIPGu+YBKBqkZbEHA0rBsos6yMTYiYnJiKDDSCKfGt8P
	QsCOKIigE50=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 217FC44F3;
	Fri,  4 Mar 2011 12:51:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2327944F1; Fri,  4 Mar 2011
 12:51:21 -0500 (EST)
In-Reply-To: <4D70EBC3.3010400@colin.guthr.ie> (Colin Guthrie's message of
 "Fri\, 04 Mar 2011 13\:40\:19 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 05FBA6D4-4688-11E0-ABF2-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168453>

Colin Guthrie <gmane@colin.guthr.ie> writes:

> It seems that it mis-applied a patch and did so silently without
> generating any warnings. It is reproducible and has been confirmed on
> different distros.

The patch text instructs to move the check you have at around ll.1190-1199
to around ll.1224-1230.  Here are the relevant parts.

@@ -1190,9 +1222,6 @@ static int element_probe(pa_alsa_element *e, snd_mixer_t *m) {
 
     }
 
-    if (check_required(e, me) < 0)
-        return -1;
-
     if (e->switch_use == PA_ALSA_SWITCH_SELECT) {
         pa_alsa_option *o;
 
@@ -1224,6 +1253,9 @@ static int element_probe(pa_alsa_element *e, snd_mixer_t *m) {
         }
     }
 
+    if (check_required(e, me) < 0)
+        return -1;
+
     return 0;
 }

Thanks for a report.
 
We find the match for the first hunk (there is only a single callsite) and
correctly remove it, but there are many places that match the preimage of
the second hunk (two blocks closed, blank line and then return 0 from the
function).  We chose to add it to at line 1156, instead of patch's choice
of line 1359, presumably because we thought that is closer to the place
the patch tells us to (i.e. ll.1224-1230).

I haven't looked at the offset logic in git-apply for a long time since
Linus wrote its original version (I don't think the logic has changed very
much since then), but I thought we are taking accumulated offsets into
account when we decide where the patch target should roughly correspond
to.  When we attempt to apply the second hunk, we have already found that
the line the patch says should be at l.1190 is actually at l.1296 (iow,
there are about 100 lines of new material above that the patch didn't
expect), so instead of trying to find the lines that matches the preimage
of the second hunk at around l.1224, we _should_ be trying to find that at
around l.1224+100---perhaps we are not doing that.
