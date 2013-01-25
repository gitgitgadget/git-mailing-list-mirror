From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] sha1_file: keep track of where an SHA-1 object comes
 from
Date: Thu, 24 Jan 2013 19:58:03 -0800
Message-ID: <7v4ni59ano.fsf@alter.siamese.dyndns.org>
References: <1359016940-18849-1-git-send-email-pclouds@gmail.com>
 <7va9rycw4t.fsf@alter.siamese.dyndns.org>
 <CACsJy8Ag6v7wUnupRwGid26AUzgZ=WbdA5F-MpjUv5ktaj5Asg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 04:58:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyaR1-0002ZE-Br
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 04:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755560Ab3AYD6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 22:58:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56111 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755540Ab3AYD6G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 22:58:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5347EC351;
	Thu, 24 Jan 2013 22:58:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mHQLXbFXP1nMf6aerDBEzLopJJI=; b=WX3kNB
	IIEVsSvUEq1KAk02ysQQXUwngV8626TSQtyYx7UrzWEqiwrp0P8Je4mN1SFtmXeX
	MlWSgewkpculaiTp/k3kadhWWzI2EJdEVPNhMSCPWVZ+9EGuwweFSuCw+eQUXZj7
	+HyaiGXTp1ExvP3Q+Mo6T2p653MOH8hW84w1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BQ97SQjXfl8xzvjVPI4e1IXm9WFNg6o5
	ei1wnDm2uUuL4h89VmVCrUMFYLAHMhVQigvpl7wtTmd0Pt+UGqqcmLLFiv1EfNKd
	OGIwH1mFRpk64bXq+hKUcY58PgakDrB5IKxiSMhcUIgigyf8pInJkh2xU6qEwyLt
	DXaq3u2oDbE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 48A24C34F;
	Thu, 24 Jan 2013 22:58:05 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D1132C34E; Thu, 24 Jan 2013
 22:58:04 -0500 (EST)
In-Reply-To: <CACsJy8Ag6v7wUnupRwGid26AUzgZ=WbdA5F-MpjUv5ktaj5Asg@mail.gmail.com> (Duy
 Nguyen's message of "Fri, 25 Jan 2013 08:38:38 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6BCA0284-66A3-11E2-A376-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214483>

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Jan 25, 2013 at 12:45 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>  How about this way instead: we keep track of where objects come from
>>>  so we can verify object source when we create or update something
>>>  that contains SHA-1.
>>
>> The overall approach taken by this series may be worth considering, but
>> I do not think the check implemented here is correct.
>>
>> An object may be found in an alternate odb but we may also have our
>> own copy of the same object.  You need to prove that a suspicious
>> object is visible to us *ONLY* through add_submodule_odb().
>
> The way alt odbs are linked (new odbs area always at the end), if we
> have the same copy, their copy will never be read (we check out alt
> odbs from head to tail). So those duplicate suspicious objects are
> actually invisible to us.

The way I read find_pack_entry() is that our heuristics to start
our search by looking at the pack in which we found an object the
last time will invalidate your assumption above.  Am I mistaken?
