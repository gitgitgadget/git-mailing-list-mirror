From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv9 4/4] pathspec: allow querying for attributes
Date: Thu, 19 May 2016 16:32:13 -0700
Message-ID: <xmqqbn41hbeq.fsf@gitster.mtv.corp.google.com>
References: <20160519232323.12775-1-sbeller@google.com>
	<20160519232323.12775-5-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 20 01:32:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3XQg-0002fZ-Jx
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 01:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754904AbcESXcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 19:32:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60680 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753942AbcESXcR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 19:32:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7BD231C7A6;
	Thu, 19 May 2016 19:32:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f74Vd4YVUb3F3HqxcyeF10CQzgI=; b=UvsVAL
	hFlBixvz+UO6+Lmg5yjz9tyZ5BsS474mwIFlHBLPEa2+nHyV1wAtudnWCkhiiHkR
	lLwB7rPJsMJzJHfRQK3JCBjMIWDbYiHDdiR+u6GVVTsQsSVQ70Nrb9gxIJtxmuUt
	5PcjbS8Se0UCPz+HMdieGjaXm7tqUhd88vBj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qXyYkp7YYiwFB7I5e7TFobj20eAWuHRk
	/yQ3DdYWhS0rwJh1rq82K8vvUePgCpOdwLCHDWGCEB5cuTFk+NkfGno7Ul+m6hRH
	mO9J80JZoB+/N/99OTd/HYmxRCVmTyugJDJxgyky4OZHN4y1whKW0Lbf8OpiiVlM
	34QfKflvcoc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 719F81C7A4;
	Thu, 19 May 2016 19:32:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D89C21C7A3;
	Thu, 19 May 2016 19:32:15 -0400 (EDT)
In-Reply-To: <20160519232323.12775-5-sbeller@google.com> (Stefan Beller's
	message of "Thu, 19 May 2016 16:23:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EBB6AD72-1E19-11E6-A15E-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295134>

Stefan Beller <sbeller@google.com> writes:

> +attr;;
> +After `attr:` comes a space separated list of "attribute
> +...
> ++

The text looks OK, but does it format well?

> +		attr_len = strcspn(attr, "=");

Scanning for '=' here retains the same bug from the previous
iteration where you take !VAR=VAL and silently ignore =VAL part
without diagnosing the error, doesn't it?

Perhaps strlen(attr) here, and...

> +		switch (*attr) {
> +		case '!':
> +			am->match_mode = MATCH_UNSPECIFIED;
> +			attr++;
> +			attr_len--;
> +			break;
> +		case '-':
> +			am->match_mode = MATCH_UNSET;
> +			attr++;
> +			attr_len--;
> +			break;
> +		default:
> +			if (attr[attr_len] != '=')
> +				am->match_mode = MATCH_SET;
> +			else {
> +				am->match_mode = MATCH_VALUE;
> +				am->value = xstrdup(&attr[attr_len + 1]);
> +				if (strchr(am->value, '\\'))
> +					die(_("attr spec values must not contain backslashes"));
> +			}
> +			break;
> +		}

... doing strcspn() only in default: part would be a quick fix.
