From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: git-p4 edit_template() and P4EDITOR w/options
Date: Mon, 04 May 2015 15:38:34 -0700
Message-ID: <xmqqzj5knf2t.fsf@gitster.dls.corp.google.com>
References: <5D2E2EAF-FFE7-437F-A716-E152E865E634@pixar.com>
	<xmqqh9rsovd4.fsf@gitster.dls.corp.google.com>
	<xmqq4mnsottj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Chris Lasell <chrisl@pixar.com>
X-From: git-owner@vger.kernel.org Tue May 05 00:38:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpP0b-0001jQ-8g
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 00:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbbEDWii (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 18:38:38 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57723 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751258AbbEDWig (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 18:38:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BCF044F286;
	Mon,  4 May 2015 18:38:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uAfuuxnsWjiwGA9q1hzPLWuVV5g=; b=KWuZxB
	T8oFQJvy99KZExVDf/7hEMUDxrvqnruLce8wssR/exXxQI5xpKcUR2UgMzVhNKM2
	oDMUVELg0xseiQ16F9XVC8bdz3PXdVtxGbTqkgp2WQ8I26GY7ESe3GBcHT0yu/+a
	VXf0d6rlXSdu/e2wEzL1H8CoYxF4MwNd/C9Ms=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WYyrQGoHbMvbQE1z+4XYLGiY8Z9WccZD
	jz+iRcRvDpKgbc3W7YHK6LmcbFkIG7ch3iawpS68Z+iyYu4z4RlI02FOCQSXhxAs
	uFnG0TZ/JY5aiyeIzdjOe/k1/6ai6ZsAHsealOwtWTAn8ebYZeGFVRFKAhbLYN47
	XHAmEUDtfrk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B5A5B4F285;
	Mon,  4 May 2015 18:38:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3D72A4F283;
	Mon,  4 May 2015 18:38:35 -0400 (EDT)
In-Reply-To: <xmqq4mnsottj.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 04 May 2015 15:34:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4CADAEDE-F2AE-11E4-B71A-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268368>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> The relevant part of git-p4 is this:
>>
>>         # invoke the editor
>>         if os.environ.has_key("P4EDITOR") and (os.environ.get("P4EDITOR") != ""):
>>             editor = os.environ.get("P4EDITOR")
>>         else:
>>             editor = read_pipe("git var GIT_EDITOR").strip()
>>         system([editor, template_file])
>>
>> It grabs $EDITOR (or $GIT_EDITOR) and treats it as the path to the
>> editor executable, without letting shell to split that into words at
>> whitespace boundaries, so that you can say things like
>>
>> 	EDITOR="/User/me/My Programs/nano"
>>
>> The way we spawn EDITOR in our core codepaths matches what git-p4
>> does, too:
>>
>> 	const char *args[] = { editor, real_path(path), NULL };
>> 	struct child_process p = CHILD_PROCESS_INIT;
>> 	int ret, sig;
>>
>> 	p.argv = args;
>> 	p.env = env;
>> 	p.use_shell = 1;
>> 	if (start_command(&p) < 0)
>> 		return error("unable to start editor '%s'", editor);
>> 	...
>>
>> So...
>
> Well, I'll take that back.  I misread p.use_shell line.

So, use_shell==true codepath grabs that array with "editor", "path"
and turns it into an equivalent to

	sh -c "$EDITOR" "$path"

when $EDITOR has a "magic" character (including whitespace) in it.
So what git-p4 does is *not* in line with how we use the environment
variable.

Perhaps a single-liner patch like this would work?

-	system([editor, template_file])
+	system(["sh", "-c", editor, template_file])
