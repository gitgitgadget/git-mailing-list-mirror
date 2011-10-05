From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-cherry-pick and git-commit --amend in version 1.7.6.4
Date: Wed, 05 Oct 2011 15:32:48 -0700
Message-ID: <7vhb3n5asv.fsf@alter.siamese.dyndns.org>
References: <4E8C6F2F.1070306@6wind.com>
 <7v8voz8hgq.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dyn3kk7SfNZzxjoD-hK9jBQr2igmOqJojeYNHLubtSY=w@mail.gmail.com>
 <7vpqib5ciw.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dysix9fOCuvm5+aU7-AC4wmsxH4-MOX+yhaHEqzeN1cPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	nicolas.dichtel@6wind.com
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 06 00:32:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBa1I-0000u9-7L
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 00:32:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935460Ab1JEWcv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 18:32:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60539 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932231Ab1JEWcu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 18:32:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 480F76EF4;
	Wed,  5 Oct 2011 18:32:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LZIKY7LEAqZy6+kH0+unStEcLZ8=; b=QSzbJq
	y+cPOaslj86MXIyB1J9zd4s7EkGE2NOCH9X3zHrAO8Qyw1nC/idDrbwvSjcnjLOS
	LeT398YZgiJW9+ov6Ej4cHuq/5FbcyI44pNkchPdw8jbg3u1Kkk1je3XLVJx9T6r
	VP3Cck3o2xaqAZIKqkMXktYWB6rp5RNC49oVU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pJYkjvCm9r2Sg26MZC3cAhfneA+lJ+MJ
	UPtgvtw53lfUl0KZ/CdPpaegLMtK0q1jGvStLSuORZkfIaTeKqTltVY62eB4+jh4
	hr7/auTWoRSZfGh+T/7ULvjnK3dsVzaAfayZf4QSAKYR5bifROPKJhvaX51CWL19
	yLnqjBIJYJI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B20D6EE5;
	Wed,  5 Oct 2011 18:32:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 979146EE3; Wed,  5 Oct 2011
 18:32:49 -0400 (EDT)
In-Reply-To: <CAG+J_Dysix9fOCuvm5+aU7-AC4wmsxH4-MOX+yhaHEqzeN1cPg@mail.gmail.com> (Jay
 Soffian's message of "Wed, 5 Oct 2011 18:23:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F4C6F2E2-EFA1-11E0-8F29-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182897>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Wed, Oct 5, 2011 at 5:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I think the sequencer state needs to be removed when the command aborts.
>
> Or written later in do_pick_commit().
>
>> This needs to be fixed before 1.7.7.1.
>
> Something like this?

Does it also refrain from creating sequencer state directory?

> diff --git i/builtin/revert.c w/builtin/revert.c
> index 3117776c2c..f7fcc88871 100644
> --- i/builtin/revert.c
> +++ w/builtin/revert.c
> @@ -384,6 +384,7 @@ static int do_pick_commit(void)
>  	char *defmsg = NULL;
>  	struct strbuf msgbuf = STRBUF_INIT;
>  	int res;
> +	int record_cherry_pick_head = 0;
>
>  	if (no_commit) {
>  		/*
> @@ -477,7 +478,7 @@ static int do_pick_commit(void)
>  			strbuf_addstr(&msgbuf, ")\n");
>  		}
>  		if (!no_commit)
> -			write_cherry_pick_head();
> +			record_cherry_pick_head = 1;
>  	}
>
>  	if (!strategy || !strcmp(strategy, "recursive") || action == REVERT) {
> @@ -514,6 +515,9 @@ static int do_pick_commit(void)
>  	free_message(&msg);
>  	free(defmsg);
>
> +	if (record_cherry_pick_head)
> +		write_cherry_pick_head();
> +
>  	return res;
>  }
