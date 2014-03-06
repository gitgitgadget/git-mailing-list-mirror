From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC GSoc Idea: blame: do not overly favor earlier parents
Date: Thu, 06 Mar 2014 12:24:51 -0800
Message-ID: <xmqq4n3bxegc.fsf@gitster.dls.corp.google.com>
References: <xmqq8usnxfi1.fsf@gitster.dls.corp.google.com>
	<87siqvcc30.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Mar 06 21:25:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLeqk-00056u-E6
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 21:25:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbaCFUY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 15:24:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38500 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbaCFUY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 15:24:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CA85C7139D;
	Thu,  6 Mar 2014 15:24:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VTvGMagEj6jSL3ekpbPwZuOkzj4=; b=ICfpW/
	yA+SV4/4WXuoIY6BSlrGBZruIwxgADUtHHTrmS17Pc7gMah+rr74kagIOfm7jhi0
	ZjDKSnNu1nBTknIwH78m2JLqE6ihaQNW4M/7gPo+2uz4kaapTPvlcT23805nd/PC
	1PMk0WmGMyFJukv3w+eKCFh6hZkyIQwbUkeqE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iJr003qj/EKYFNzugzQONgintRjDIz8u
	5i1aauiHSahwRiU+8cdwknFi/G8UitxmQIKDL2sln/tT0Y75ClN0kS3YQQRO8l9t
	Of8W1X/3VdBUbKjjh+t9j0lCLeg0elfSU+Dh4aL6wS0ZYMhNWtv3gEZEysclRv2d
	g0yCM/6Xph0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B11397139C;
	Thu,  6 Mar 2014 15:24:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D72E47139B;
	Thu,  6 Mar 2014 15:24:55 -0500 (EST)
In-Reply-To: <87siqvcc30.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Thu, 06 Mar 2014 21:21:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 619C4B78-A56D-11E3-B566-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243548>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> When looking at a merge, "git blame" inspects the blob object names
>> of all parents and if one of them exactly match the merge result,
>> pass the entire blame down to that parent.  This is very much in
>> line with the history simplification done with "git log" when
>> traversing a history with merges.
>
> [...]
>
>> Now, imagine if you amend M to create N, to add a single line at the
>> end of path.  M:path != N:path but there is very small difference
>> between the two.  That means B:path != N:path but the difference
>> between this merged result and the second parent is very small.
>
> That sounds very much like
>
> commit d5df1593f27bfceab807242a538cb3fa01256efd
> Merge: 7144168 0b4e246
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Fri Feb 28 13:51:19 2014 -0800
>
>     Merge branch 'bl/blame-full-history' into pu

That one was an attempt to solve the right issue in a wrong way,
made things worse by breaking the consistency with the history
simplification of "git log".

The "Idea" is to solve it in the way that is still consistent with
the usual history simplification.
