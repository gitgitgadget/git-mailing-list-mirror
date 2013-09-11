From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git tag output order is incorrect (IMHO)
Date: Wed, 11 Sep 2013 10:54:01 -0700
Message-ID: <xmqqioy7tfba.fsf@gitster.dls.corp.google.com>
References: <840FACA0-7E13-41DB-A0F8-124FAB53BFBD@rtcamp.com>
	<CAMP44s3p_DRTvBhKbM0ejKgea9hauSCzahPux4jCWL7JP4nxKw@mail.gmail.com>
	<CABURp0o5tOswiv_avfAQOZwGREpX3v7MwcdVzt7dkubY2Y0O6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 19:54:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJocP-0004f3-VG
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 19:54:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755513Ab3IKRyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 13:54:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48154 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755363Ab3IKRyR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 13:54:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D6D8441E03;
	Wed, 11 Sep 2013 17:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xgB09/kZITXbl8mbUWP+cLhXuew=; b=wFKd9O
	ZXdAXf/5iCGWjhJUQvrL7bsjBLFps/Oa32q1yOJuaeuhxSYlwZW9xx6+nUlyTWhI
	w213hvgmY4htb/1knnVjC/U1w5jz6nRpSYikAKqdAJfvMrwXZjsiF14cPE1fyx4y
	uPN6i8EceXa0FaTPphVcWcb+ESGN0Mnwh5bGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YYd5yqlASLlv2n1idCclJ7Mw3vTXi9OP
	+RuNBd844aZFbFIVSo28bJ4mGjRPYydFlZvsayABPekV2O37dOOgnEvPzTC4j/Ra
	OJooKkWdviwAn09s+ffn+8Uy/NQ1t3YaEyXywDnYhFcCloXBtfY3xwjD2sF3WlfR
	LVbW/3+Flds=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFDBD41E01;
	Wed, 11 Sep 2013 17:54:13 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5600441DEE;
	Wed, 11 Sep 2013 17:54:10 +0000 (UTC)
In-Reply-To: <CABURp0o5tOswiv_avfAQOZwGREpX3v7MwcdVzt7dkubY2Y0O6g@mail.gmail.com>
	(Phil Hord's message of "Wed, 11 Sep 2013 09:42:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 29EF6A62-1B0B-11E3-809E-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234587>

Phil Hord <phil.hord@gmail.com> writes:

> Someone at $work asked me this week how to find the current and
> previous tags on his branch so he could generate release notes.  I
> just need "last two tags on head in topo-order". I was surprised by
> how complicated this turned out to be. I ended up with this:
>
>   git log --decorate=full --pretty=format:'%d' HEAD |
>     sed -n -e 's-^.* refs/tags/\(.*\)[ )].*$-\1-p' |
>     head -2
>
> Surely there's a cleaner way, right?

That looks clean enough (I would have used "head -n 2" though) and
in line with the way how you can exercise the flexibility of the
system, at least to me ;-).

Joking aside, I agree that a "--merged X" primitive, i.e. "what refs
can be reachable from commit X?", in the listing mode of "git tag"
or "git for-each-ref" would have helped.  As the sorting and
formatting primitives are already there in for-each-ref, it would
have been

	git for-each-ref \
            --format='%(refname:short)' \
            --sort='-*committerdate' \
            --count=2 \
            --merged my-branch \
            refs/tags/

or something like that.
