From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] push: honor branch.*.push
Date: Mon, 24 Jun 2013 01:17:47 -0700
Message-ID: <7vhagndis4.fsf@alter.siamese.dyndns.org>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
	<1372048388-16742-7-git-send-email-gitster@pobox.com>
	<CALkWK0=aDkCMB3ROSuH1crTmQKjCFyCmvJfvOTiQnBo4+NckBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 10:17:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur1yE-0006LH-Lm
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 10:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015Ab3FXIRv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 04:17:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54362 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752951Ab3FXIRu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 04:17:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D44E82806A;
	Mon, 24 Jun 2013 08:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OhuoUbEnyB8lI2LVo1JH79CPk6c=; b=nnoTIV
	kKyakicx1elN+W0HPFB2EDcl1yZiD6g1DulHYlUK58P3hgXh2f2OdKQ9JTSthY6w
	Ld+3U39fEPubqdQrx5+KDBEENmgdlkQqcSfYwcsdN3nxqM9efDc0GBMJThfs4YDj
	52ozPMzYyctBRHG+3lpPEmGiKcLehH+/rq2GY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qF4i017rtP6/xv+vv3kWTOAiguPbAUGV
	d3eLUPwabHLp08PyUx6nn8Nr6fAulTkNlEgroXF/o26tnl6h5nQyIucfj1YrVqMS
	oazxDkIajayD9lMam/Is+ey3mD02heYf87YJbyOL1kcuzHt/KLSzxhj1kZddOaQ8
	fv9qlELroqg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CADF528069;
	Mon, 24 Jun 2013 08:17:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4FFB428065;
	Mon, 24 Jun 2013 08:17:49 +0000 (UTC)
In-Reply-To: <CALkWK0=aDkCMB3ROSuH1crTmQKjCFyCmvJfvOTiQnBo4+NckBA@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 24 Jun 2013 13:28:09 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8ED27396-DCA6-11E2-B56E-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228794>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> @@ -194,7 +203,14 @@ static int is_workflow_triagular(struct remote *remote)
>>  static void setup_default_push_refspecs(struct remote *remote)
>>  {
>>         struct branch *branch = branch_get(NULL);
>> -       int triangular = is_workflow_triagular(remote);
>> +       int triangular;
>> +
>> +       if (branch->push_name) {
>> +               setup_per_branch_push(branch);
>> +               return;
>> +       }
>
> The most obvious question comes first: what result can I expect when
> this interacts with remote.<name>.push?

Now you bring it up, the branch.*.push may want to be more specific
(when I am on _this_ branch, do this) than remote.*.push (when I am
pushing to that remote, I want this to happen in general), but this
default codepath would not be exercised when you have remote.*.push,
so the logic may need to be moved higher up in the foodchain.

> Also, you managed to throw out all safety out the window.  What
> happens when the user does:
>
>   # on branch master, derived from origin
>   $ git push ram
>
> And branch.master.push is set to next?  Will you let her shoot herself
> in the foot like this?

It is not shooting in the foot, if branch.master.push is explicitly
set to update next.  I do not see any issue in that part.

But the relative strength betweenh branch.*.push and remote.*.push
may need to be thought out.  I haven't.
