From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC memory leak?] Minor memory leak fix
Date: Tue, 11 Mar 2014 12:42:38 -0700
Message-ID: <xmqqmwgwpln5.fsf@gitster.dls.corp.google.com>
References: <1394534706-28987-1-git-send-email-iveqy@iveqy.com>
	<CACsJy8Bp6rpe4hLg0eMBCjPjL5uDwXj-7ZVmZtUZvR26unAuoQ@mail.gmail.com>
	<20140311124009.GI14327@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 20:42:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNSZb-0004MP-7j
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 20:42:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755516AbaCKTmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 15:42:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60002 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755286AbaCKTmm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 15:42:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC26074F92;
	Tue, 11 Mar 2014 15:42:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=miY8CAilRK/X7oRCKKdkj/blekY=; b=kmcJJP
	4HI3o0bsdkykMKi+95SLtTk3hFgYX4As43Dil1SVMJq/cS8nDirLpvEwkBnasTgx
	jfFY5QpErWTsQJsD5oBN3pozADsBmNMCQWGD083b71Y424zMo77d0JrIC3y0hFAN
	nq8tCfIPiYQLl1ERrZ3qo4g5mCiaT+//P3HaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DDMPuXg7LKjHU88uX0MePDZETnL4+P5L
	H5xo1q5/z0tMBz+jPyeJ0vrlODBH8xr1NdNMVJBjtU3JZR7JGVV1K7O1B9c7L5BH
	7L/XqkJZLQYIllsi5M73/WCeMnRHA1hlRsMTiAiEbAhvYayD0bF/G4vTRx1ZJMYG
	Hmv5KFVeIDU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96FAB74F91;
	Tue, 11 Mar 2014 15:42:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C164D74F8F;
	Tue, 11 Mar 2014 15:42:40 -0400 (EDT)
In-Reply-To: <20140311124009.GI14327@paksenarrion.iveqy.com> (Fredrik
	Gustafsson's message of "Tue, 11 Mar 2014 13:40:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4EA53E3A-A955-11E3-A92E-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243885>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> On Tue, Mar 11, 2014 at 06:58:11PM +0700, Duy Nguyen wrote:
>> On Tue, Mar 11, 2014 at 5:45 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
>> > Strbuf needs to be released even if it's locally declared.
>> 
>> "path" is declared static. So yes it's a leak but the leak is minimum.
>> Your patch would make more sense if "static" is gone and it's leaked
>> after every write_archive_entry call.
>
> That's one of the reasons of the RFC. I know Junio thinks that minor
> things shouldn't be fixed by themselfes because it takes up review
> bandwidth, so it's better to fix them once you touch that part of the
> code anyway. (At least that's how I've understood him).

Yes, but I at the same time think this "static struct strbuf" is a
clear statement by the original author that this is not a leak
per-se.  The trade-off, if I am reading the code right, is between
keeping a piece of memory that is large enough to hold the longest
pathname until exit() vs saving repeated allocations and frees for
each of the thousands of paths in the resulting archive.

I tend to think the original strikes a better balance between the
two.
