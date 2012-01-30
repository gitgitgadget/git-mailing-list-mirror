From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] completion: simplify __git_remotes
Date: Mon, 30 Jan 2012 10:27:30 -0800
Message-ID: <7v8vkpcagd.fsf@alter.siamese.dyndns.org>
References: <1327944197-6379-1-git-send-email-felipec@infradead.org>
 <1327944197-6379-2-git-send-email-felipec@infradead.org>
 <20120130173446.GF10618@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Felipe Contreras <felipe.contreras@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
To: Felipe Contreras <felipec@infradead.org>
X-From: git-owner@vger.kernel.org Mon Jan 30 19:27:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrvx3-0004QE-U4
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 19:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426Ab2A3S1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 13:27:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56896 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753184Ab2A3S1c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 13:27:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A1826965;
	Mon, 30 Jan 2012 13:27:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oz2UlmL0nEPwcAXWdP06Kp2FhA0=; b=LXUibe
	37rFHbAaN05bI0aOQVwa++hFBNd658x00qdXRm89JQ4j+JsgyS9dT4idQGVzxzdu
	FM8CBEILp/fFom+R7ZMKBXCoT6SHwuytlqnikaePUgzXTcb6+c5/nyefKR8X5dB7
	WByJd6bKangsi/ZugHi0JmTlSQAKQjMnFx65Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fEcI1AgrxT7YD3u1A/Zw8TyTo4VbnMb6
	KyiEmvITfjsPihMUgxTT12vktVR4Pe5nnHHsBOLYsp+JV8bZV/o/lRactT41Cg0P
	z3nZiXVMP6SjGXbOPUCCr1PIDdOx2zxFJKm+9wfEO1S5cCeUoJyGIKfoUiegDKj6
	kgTnxQHAh2k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 520AF6964;
	Mon, 30 Jan 2012 13:27:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90E896961; Mon, 30 Jan 2012
 13:27:31 -0500 (EST)
In-Reply-To: <20120130173446.GF10618@burratino> (Jonathan Nieder's message of
 "Mon, 30 Jan 2012 11:34:46 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 127CC7E2-4B70-11E1-80D5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189393>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Felipe Contreras wrote:
>
>> From: Felipe Contreras <felipe.contreras@gmail.com>
>>
>> There's no need for all that complicated code that requires nullglob,
>> and the complexities related to such option.
>>
>> As an advantage, this would allow us to get rid of __git_shopt, which is
>> used only in this fuction to enable 'nullglob' in zsh.
>
> That is all a longwinded way to say "zsh doesn't support the same
> interface as bash for setting the nullglob option, so let's avoid
> it and use 'ls' which is simpler", right?

;-)

>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index 1496c6d..086e38d 100755
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -644,12 +644,7 @@ __git_refs_remotes ()
>>  __git_remotes ()
>>  {
>>  	local i ngoff IFS=$'\n' d="$(__gitdir)"
>> -	__git_shopt -q nullglob || ngoff=1
>> -	__git_shopt -s nullglob
>> -	for i in "$d/remotes"/*; do
>> -		echo ${i#$d/remotes/}
>> -	done
>> -	[ "$ngoff" ] && __git_shopt -u nullglob
>> +	test -d "$d/remotes" && ls -1 "$d/remotes"

Yeah, very nice reduction of unnecessary code.

The original loop might have been justifiable if it were doing something
more meaningful inside (e.g. making sure the file really describes a
remote), but as far as I can tell, it merely is a poor-man's emulation of
"ls -1".

You updated it to make the code say what it wanted to say in the way it
should have said from day one ;-).
