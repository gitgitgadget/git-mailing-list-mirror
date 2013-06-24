From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] push: honor branch.*.push
Date: Mon, 24 Jun 2013 00:47:05 -0700
Message-ID: <7vy5a0c5mu.fsf@alter.siamese.dyndns.org>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
	<1372048388-16742-7-git-send-email-gitster@pobox.com>
	<CALKQrgebusbcDOTR+bFccoT4qzDJ8E=2LULutL0egEN9YY1v_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jun 24 09:47:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur1UX-0007LF-On
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 09:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752920Ab3FXHrJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 03:47:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52543 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752904Ab3FXHrH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 03:47:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21A2A27219;
	Mon, 24 Jun 2013 07:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UXP+6K8zIiguABLPvI3w7k44dTs=; b=Fd68pj
	OZwceKvs+TjQngoh/aWWG7q+j5AZxkFVAVb2JM8p1Vmejhn8wJtVDHBu1DbWquy6
	p7cvRj2zxxgTWh4l74mFEeT/HUCUusUCV660Dl8gmozZ/GIp3Ai76knnm+ygl1Xq
	YIrBXF0/soIvRu8BiMh6yx3TyFMh8+DxHWBMk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YHxu2WcGBshP/xNyjqyqp0VYUVAsSrnY
	R3UX46rvYlA5AkqLIhotEaiUkPUz3eFr5Fkqtqfzpz4CqRzAE29e68U6NAofSLg2
	3Gu0szkb9v0tEGKqdp6SxoAAZ4nQniQ3xsiHzSIoaXzjqXloDm9ahrn2p5K+Q+7v
	S7KAhbzXKGE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1598B27218;
	Mon, 24 Jun 2013 07:47:07 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 74F7F27217;
	Mon, 24 Jun 2013 07:47:06 +0000 (UTC)
In-Reply-To: <CALKQrgebusbcDOTR+bFccoT4qzDJ8E=2LULutL0egEN9YY1v_g@mail.gmail.com>
	(Johan Herland's message of "Mon, 24 Jun 2013 08:58:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 44663058-DCA2-11E2-8028-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228785>

Johan Herland <johan@herland.net> writes:

>> +static void setup_per_branch_push(struct branch *branch)
>> +{
>> +       struct strbuf refspec = STRBUF_INIT;
>> +
>> +       strbuf_addf(&refspec, "%s:%s",
>> +                   branch->name, branch->push_name);
>> +       add_refspec(refspec.buf);
>
> This goes back to the question I raised in 3/6: If this code path adds
> refspec "foo:bar", and - say - setup_push_current() has already added
> refspec "foo:foo" (or simply "foo"), then do we end up pushing into
> "foo" or "bar"?

I think you answered your own question below with the "return".

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
>
> I guess this return ensures that branch.*.push overrides push.default,
> but might there be other sources of add_refspec() that would
> complicate things?

The default-push-refspecs is meant to be used only when there is no
other stronger clue given by the user (e.g. refspec on the command
line, e.g. "git push there master", pushing with configured refspecs
on remote.$name.push), so I think it is a bug if somebody calls this
function when there is other source.
