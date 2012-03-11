From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: reallocate the postimage buffer when needed
Date: Sun, 11 Mar 2012 13:54:10 -0700
Message-ID: <7vipiax3il.fsf@alter.siamese.dyndns.org>
References: <1331475857-15169-1-git-send-email-cmn@elego.de>
 <7v8vj7x9jr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 21:54:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6pmm-00018R-21
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 21:54:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342Ab2CKUyT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Mar 2012 16:54:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61954 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752043Ab2CKUyO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Mar 2012 16:54:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C5D877F5;
	Sun, 11 Mar 2012 16:54:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hmoRdGOg1YeG
	KWkOBfxdqsSDEq0=; b=fTb9OdivQ71vsHTh/cY9ezRyvXSr2a7DD/YT0S2NQP+E
	xasyahCJRAftOy4LI9baV2n3KyuI5/QwzVWYe3l46Lt+Mrdgc+jBPH/lBU9zimew
	2fatUzUlApi95c4OVC2Ds2CZZvu8iaqpjEV4pZcixXvPLPVLom2LEQTc9/2UqFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UjecjS
	qZTXJm7jkRcpaGZgB8y6VpCEJJ0Wg8DyU91OdYBVVV5TeBfdN8FgC92rUBELbUSc
	GoZwqRySOSyUzrQUDRZfZR7a5AxkBiOnFwz0m+ChhUP8wKWKXxu7Fm2tYaa5IaOT
	g/MqnWzE1HZOZsQoTksnpBdk93qs80H+R3dBo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23FD577F4;
	Sun, 11 Mar 2012 16:54:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8FD4677F3; Sun, 11 Mar 2012
 16:54:12 -0400 (EDT)
In-Reply-To: <7v8vj7x9jr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 11 Mar 2012 11:43:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B34462E-6BBC-11E1-BAEA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192828>

Junio C Hamano <gitster@pobox.com> writes:

> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>
>> Blame says Junio and Giuseppe were the last ones to touch this part =
of
>> the code, so there you go.
>
> Whatever you do in your fix, this comment block needs to be updated:
>
> 	/*
> 	 * Adjust the common context lines in postimage. This can be
> 	 * done in-place when we are just doing whitespace fixing,
> 	 * which does not make the string grow, but needs a new buffer
> 	 * when ignoring whitespace causes the update, since in this case
> 	 * we could have e.g. tabs converted to multiple spaces.
> 	 * We trust the caller to tell us if the update can be done
> 	 * in place (postlen=3D=3D0) or not.
> 	 */
>
> The second sentence used to be true for a long time (if you indented
> your line with too many spaces, we removed them and replaced with
> fewer number of tabs; if you had spaces before a tab, we removed
> them; if you added unnecessary whitespaces at the end, we removed
> them), but ceased to be so when Python style "indent must be spaces"
> was added.
>
> So I think this either always needs to re-allocate, or the caller
> has to tell it by other means than "!postlen" the need for
> reallocation.
>
> I wasn't involved in the "apply while ignoring whitespace
> differences", so Giuseppe may be able to notice other mode of
> beakages in this and fuzzy_matchlines() function.  The commit to be
> stared at is 86c91f9 (git apply: option to ignore whitespace
> differences, 2009-08-04).

Looking at the call site of update_pre_post_images() again, I think
the call made from this part may also need to be updated for "indent
must be spaces" that was added by 3e3ec2a (whitespace: add
tab-in-indent error class, 2010-04-03) and 4e35c51 (whitespace: add
tab-in-indent support for --whitespace=3Dfix, 2010-04-03):

	... code to look at preimage and img, checking if the lines
        ... match if the whitespace breakages in the preimage line
        ... were fixed is here.
	/*
	 * Yes, the preimage is based on an older version that still
	 * has whitespace breakages unfixed, and fixing them makes the
	 * hunk match.  Update the context lines in the postimage.
	 */
	fixed_buf =3D strbuf_detach(&fixed, &fixed_len);
	update_pre_post_images(preimage, postimage,
			       fixed_buf, fixed_len, 0);

The logic to match the preimage and img is correct and does not
overflow anything; the fixing of preimage and img is done with
ws_fix_copy() that uses strbuf.

But fixed_buf and fixed_len may be longer than the original length
of preimage buffer when "indent must be spaces" is in effect, and
that would mean context lines in the postimage may have to also
grow. The call to update_pre_post_images() must be telling how big
the postimage with fixed context lines will be, not passing 0 to say
"I know it will not grow", because that is no longer true these
days.
