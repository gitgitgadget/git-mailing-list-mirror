From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] completion: fix completion of certain aliases
Date: Mon, 14 Apr 2014 13:20:29 -0700
Message-ID: <xmqqmwfnoe7m.fsf@gitster.dls.corp.google.com>
References: <E1WZEWT-0002R7-1d@iramx2.ira.uni-karlsruhe.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: =?utf-8?Q?G=C3=A1bor?= Szeder <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Apr 14 22:20:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZnMt-0007xY-1V
	for gcvg-git-2@plane.gmane.org; Mon, 14 Apr 2014 22:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300AbaDNUUe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Apr 2014 16:20:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36611 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750958AbaDNUUd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Apr 2014 16:20:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4FCD7D5AA;
	Mon, 14 Apr 2014 16:20:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/iqX3qFlRt5u
	qiay7H1gR/iE6qQ=; b=SuXSYhhvRRVqMrNNdrbIOZxiCbxBl+YZ6V7jr+fVGLSh
	2v6fpXmbL6oEPdFsu17VPsf63WwbMI97Hv03J8uquZGL6a9cMf0YaQYttt0Vby33
	3CoVgpYbCBgEx+WRU5YlKCnkXpJhzunFptT36TkoxEqK4wK2Do9GtHU2OnJ/RtA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=yV7uuO
	ousBlqxW8fN5LidO9aPztk18C8LGU4b09+x9Sj96c1T5OOtQU3ZAHbf2jyf8Flib
	gfOpv8uhFW3EnV3Zd3FAA2Tl/9VNOW40WhnCG6y58VbBFl2AxJbgjERomqMg4ByZ
	KVdf87dWfWcZLBD4EHAdprDK73jspRF+rpahQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C3FB07D5A9;
	Mon, 14 Apr 2014 16:20:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DAC967D5A3;
	Mon, 14 Apr 2014 16:20:30 -0400 (EDT)
In-Reply-To: <E1WZEWT-0002R7-1d@iramx2.ira.uni-karlsruhe.de>
 (=?utf-8?Q?=22G=C3=A1bor?= Szeder"'s
	message of "Sun, 13 Apr 2014 11:38:23 +0430")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 39C9C3E6-C412-11E3-96AD-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246260>

G=C3=A1bor Szeder <szeder@ira.uka.de> writes:

> words[] is just fine, we never modify it after it is filled by
> _get_comp_words_by_ref() at the very beginning.

Hmph.  I would have understood if the latter were "we never look at
it (to decide what to do)".  "we never modify it" does not sound
like an enough justification behind "words[] is just fine"---maybe I
am not reading you correctly.

> The root of the problem is that the expected position of the name
> of the git command in __git_complete_remote_or_refspec() is
> hardcoded as words[1], but that is not the case when:
>
>   1) it's an alias, as in Felipe's example: git p ori<TAB>,
>   because while the index is ok, the content is not.
>
>   2) in presence of options of the main git command: git -c
>   foo=3Dbar push ori<TAB>, because the index is off.
>
>   3) the command is a shell alias for which the user explicitly
>   set the completion function with __git_complete() (at his own
>   risk): alias gp=3D"git push"; __git_complete gp _git_push; gp
>   ori<TAB> Neither the index nor the content are ok.
>
> Fixing the hard-coded indexing would only solve 2) but not 1) and
> 3), as it obviously couldn't turn the git or shell alias into a
> git command on its own.
>
> Felipe's patch only deals with 1), as it only kicks in in case of
> a git alias.

Yeah, do completions for commands (not just for the ones that use
remote-or-refspec Felipe's patch addresses) have trouble with the
latter two in general?  If that is the case,...

> Communicating the name of the git command to
> __git_complete_remote_or_refspec() by its callers via a new
> variable as suggested by Junio, or perhaps by an additional
> parameter to the function is IMHO the right thing to do, because,
> unless I'm missing something, it would make all three cases work.

=2E.. while the above analysis may be correct, taking Felipe's patch
to address only (1) and leaving a solution to the more general
words[1] problem for other patches on top might not be too bad an
approach.

Unless

 (A) remote-or-refspec thing is the primary offender, and other
     commands do not suffer from the words[1] problem, in which case
     I tend to agree that an additional parameter would be the way
     to go (there are only a few callers of the function); or

 (B) even if words[1] problem is more widespread, such a more
     general solution to all three issues can be coded cleanly and
     quickly, without having to have Felipe's patch as a stop-gap
     measure.

that is.

I'll keep Felipe's patch in the meantime to 'pu'.

Thanks.
