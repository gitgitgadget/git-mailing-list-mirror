From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 0/9] Removing deprecated parsing macros
Date: Tue, 06 Aug 2013 10:20:33 -0700
Message-ID: <7viozihh26.fsf@alter.siamese.dyndns.org>
References: <1375530686-2309-1-git-send-email-stefanbeller@googlemail.com>
	<7v4nb3iaqb.fsf@alter.siamese.dyndns.org>
	<5200F3D6.5040004@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Aug 06 19:20:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6kw7-0000Zd-CH
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 19:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756278Ab3HFRUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 13:20:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56673 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756067Ab3HFRUi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 13:20:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E26A936050;
	Tue,  6 Aug 2013 17:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9PjpdPostpqYlpnym2s2pHYRGwI=; b=BIDsWf
	UaY6I6FEF64t7rCIf8o1I423ArCfZThlrrp6NRECX44cV+14guTNdvUU7zivlupr
	ou5axXvPiPlyeoII7IA/N3PrtaVcqh9mduQWbMyaF8B4XUMJIykCxLuq0owQk0Qc
	hP1JJjCNI0VcFL0Tq5p5gVifwCZM3hQwIkZcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FaJEqWJ0jBCOnwMJB/Vkj2hQbHErWhBt
	FoRuIzwTyAemGMgVho9C/NfgDs2OmBZIlDRx3sZNDiDQHSCoOG++9jfdIC50bsFz
	8SPjDK9GPcaZje4nln2X3Ca/0ti8oi3GAbPUM2nKIYSCi6+Buj+D0wz85htl8EIa
	ZLdGJdWhvro=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0DF43604F;
	Tue,  6 Aug 2013 17:20:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 13A3D3604E;
	Tue,  6 Aug 2013 17:20:34 +0000 (UTC)
In-Reply-To: <5200F3D6.5040004@googlemail.com> (Stefan Beller's message of
	"Tue, 06 Aug 2013 15:02:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 81494EB0-FEBC-11E2-BC4E-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231763>

Stefan Beller <stefanbeller@googlemail.com> writes:

> On 08/06/2013 08:39 AM, Junio C Hamano wrote:
>> Thanks.  Queued this at the tip of 'pu'.  There seem to be some
>> fallouts found in the test suite, though.
>> 
>
> Thanks. I am sorry for forgetting 'make test' before sending patches.
> And the test suite is correct.
>
> e35ea450 (branch, commit, name-rev: ease up boolean conditions)
> is faulty. In builtin/branch.c the variables 'delete' and 'rename' 
> are not used as a true boolean but I assumed so. 
> These are parsed in via OPT_BIT and depending if you pass -d or -D 
> for deletion you have value 1 or 2 in delete.

Likewise for 'rename' that becomes 2 when -M is given.

> Hence this change is incorrect:
> -	if (!!delete + !!rename + !!force_create + !!list + !!new_upstream + !!unset_upstream > 1)
> +	if (delete + rename + force_create + list + unset_upstream +
> +	    !!new_upstream > 1)

As a follow-up to this series, we may want to think about the
following as well:

 - OPT__VERBOSE() is defined in terms of OPT_BOOLEAN().  I think we
   use it to represent increasing levels of verbosity, so we cannot
   turn this into OPT_BOOL().  Its implementation has to become
   OPT_COUNTUP().

 - OPT__QUIET() is defined in terms of OPT_BOOLEAN().  I offhand do
   not know if we have increasing levels of quietness.  The users
   need auditing before we can decide to turn this into either
   OPT_COUNTUP() or OPT_BOOL().

 - OPT__DRY_RUN() should probably become OPT_BOOL().

 - OPT_FORCE(); do we have levels of forcefulness?  If so
   OPT_COUNTUP(), otherwise OPT_BOOL().
