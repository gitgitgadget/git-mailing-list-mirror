From: Junio C Hamano <gitster@pobox.com>
Subject: RFC GSoc Idea: blame: do not overly favor earlier parents
Date: Thu, 06 Mar 2014 12:02:14 -0800
Message-ID: <xmqq8usnxfi1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 06 21:02:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLeUp-00073s-48
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 21:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbaCFUCS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 15:02:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46028 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750829AbaCFUCR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 15:02:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD18770B39;
	Thu,  6 Mar 2014 15:02:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=S
	0W+m5OLXObVEw8hW3bGuq4K+pY=; b=BVi/PmAI2DVDw+p5wP3rn0ayxpGk2VB7l
	Wku3OEj+0/FaQ2YOQD2xuFLkFFZ1jxdvhQEbtGaLis5hGOQhKItIM/zTygt9Zmg+
	a1buWHg/I1VM/a0YbhAbH7/dCivKuS8ZJJrZ71Mb2cjNBRiBEQPwpONSXmtYiIS2
	sSIwIR4lxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=vCZ
	j3fpAa5bh3G98JPjmKpD6/3zy979taIKheIUOozeaxAVuyPuu79HIzTjj96mYECd
	68xVY9ATZt0XvDHrUpec8DB070CZwSvZdYaisoZjj2kAaxHcs+6sIXQtNtaMlymu
	e/Hg4S3qr3v1RUfrplsXvu94ZUF9GX2/d3kdP+kU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA86870B37;
	Thu,  6 Mar 2014 15:02:16 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9467170B32;
	Thu,  6 Mar 2014 15:02:15 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 36D2EE72-A56A-11E3-9C0D-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243544>

When looking at a merge, "git blame" inspects the blob object names
of all parents and if one of them exactly match the merge result,
pass the entire blame down to that parent.  This is very much in
line with the history simplification done with "git log" when
traversing a history with merges.

On the other hand, when the blob object in the merge result and none
of the parents match exactly, we let each parent to take as much blame
as they can, starting from the earlier parent, and later parents get
a chance to take blame on the "leftover bits".

Combination of the above can lead to an unexpected results.

Let's say that M is a two-parent merge, M^1 == A and M^2 == B, and
that M:path == B:path != A:path (i.e. the merge result matches its
second parent exactly).  The entire contents of the path is blamed
to the history leading to B; the history leading to A but not
involved in B will not get any blame.

Now, imagine if you amend M to create N, to add a single line at the
end of path.  M:path != N:path but there is very small difference
between the two.  That means B:path != N:path but the difference
between this merged result and the second parent is very small.

Because we give the chance to get blamed for the whole thing to the
first parent, however, A will grab blame for all the lines that are
common between A:path and B:path.  For the lines that are the same
between M:path and N:path, ideally, we should get identical results,
but it results in a very inconsistent behaviour.

Update blame.c::pass_blame() and give an option to arrange the list
of "scapegoats" in the order that are similar to the end result, in
order to address this issue.  That way, when blaming N:path, we will
inspect B:path first and let it grab as much blame, as it would happen
when we started the blame for M:path.
