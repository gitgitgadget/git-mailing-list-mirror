From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/17] revert: Inline add_message_to_msg function
Date: Tue, 19 Jul 2011 09:52:52 -0700
Message-ID: <7vfwm29pqz.fsf@alter.siamese.dyndns.org>
References: <1310396048-24925-1-git-send-email-artagnon@gmail.com>
 <1310396048-24925-3-git-send-email-artagnon@gmail.com>
 <20110712165302.GA13578@elie>
 <CALkWK0kHutr41aH7OrmW3REV+YBUeHSryA9n62yxyF0qRd1FEw@mail.gmail.com>
 <20110713064240.GC31003@elie>
 <CALkWK0mmPeYawqF-Dd3Sv_0qYjfYA-36POengYupfjwNBRDj-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 19 18:53:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjDXZ-00080D-0K
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jul 2011 18:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607Ab1GSQw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jul 2011 12:52:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55246 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400Ab1GSQwz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jul 2011 12:52:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CEB904607;
	Tue, 19 Jul 2011 12:52:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=paKHQMEuO32GbtPsba9mm6LYd3Y=; b=MrDnnf
	r02Tf1jwf8nkpEEfvO6TifkAFJ/S2ps7E7uRtcR5NMgS/Lcmhe5p2IEd834E81K2
	YSSIZPUtMo/c4H/MGRtCxsHRWDzWSEi+hhyGta7XVx4pIJkDtpRs+MKnFDWtqhQg
	LWsjRjEnsvUtq8xxRaylSCTQypzetfhMs8GDw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gIWqLfnBNG94SrHy9lJAHT2dKs2/8abX
	Gl84xFXpfaBe5W3A1RdlBXY2YBFJj+ra6mI5q7cDZlLVDowlPnd4pEIStaJKWJF1
	fa7sx5fmfJShfjjhG0WsOitotNIWE/17VKx3FD1dYahV0doBRGXHarKECmZvDfPA
	mlzXi1iKROE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C61AC4605;
	Tue, 19 Jul 2011 12:52:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4DE0F4602; Tue, 19 Jul 2011
 12:52:54 -0400 (EDT)
In-Reply-To: <CALkWK0mmPeYawqF-Dd3Sv_0qYjfYA-36POengYupfjwNBRDj-g@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Tue, 19 Jul 2011 22:06:15 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8BFE927C-B227-11E0-95EF-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177462>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> The strstr(msg.message, "\n\n") actually stops after the 0 in the
> committer line.  It's trying to find out where the commit message
> actually begins.  I even created a commit using commit-tree (not using
> porcelain), but it's impossible to find a msg.message that doesn't
> have a "\n\n" -- even one with an empty commit message looks like:
> ...

... with current git, sure, but I think the code to check for "just in
case we didn't find \n\n" is there because prehistoric versions of git
could write such a commit object.

Hence...

> @@ -462,11 +449,22 @@ static int do_pick_commit(void)
>                 }
>                 strbuf_addstr(&msgbuf, ".\n");
>         } else {
> +               const char *p;
> +
>                 base = parent;
>                 base_label = msg.parent_label;
>                 next = commit;
>                 next_label = msg.label;
> +
> +               /*
> +                * Append the commit log message to msgbuf; it starts
> +                * after the tree, parent, author, committer
> +                * information followed by "\n\n".
> +                */
> +               p = strstr(msg.message, "\n\n");

I would prefer to have if (p) { ... } around the two lines below.

> +               p += 2;
> +               strbuf_addstr(&msgbuf, p);
> +
>                 if (no_replay) {
>                         strbuf_addstr(&msgbuf, "(cherry picked from commit ");
>                         strbuf_addstr(&msgbuf,
> sha1_to_hex(commit->object.sha1));
